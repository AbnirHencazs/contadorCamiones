 /*
COMANDOS POR SMS
Nota: La respuesta de mesajeria se da cada 30 seg
SYSTEM RESET: Establece un reset al WioLte
RESET: Envia un reset para los contadores
RESET STOP: Deja de enviar el reset
RETRANSMITIR: Retransmite el ultimo dato por serial capturado si tiene contenido
WIOLTE: Realiza un saludo por SMS
GET SERIAL: Obtiene el contenido del serial y lo envia por SMS

APN: https://www.neostuff.net/apn-iusacell-telcel-movistar-y-otros/
*/

#include <WioLTEforArduino.h>
#include <stdio.h>


//TELCEL
#define APN               "internet.itelcel.com"
#define USERNAME          "webgprs"
#define PASSWORD          "webgprs2002"

/*
//AT&T
#define APN               "modem.nexteldata.com.mx"
#define USERNAME          ""
#define PASSWORD          ""
*/

/*
//Flash mobile, fallo chip
#define APN               "internet.flashmobile.mx"
#define USERNAME          ""
#define PASSWORD          ""
*/

//char WEBHOOK_URL2[] = "http://www.accesa.me/sibico/saveDataGPS/POSTGPS/uno.php";
//char WEBHOOK_URL2[] = "http://www.accesa.me/sibico/saveDataGPS/POSTGPS/datoswio.php";
//char WEBHOOK_URL2[] = "http://www.accesa.me/sibico/saveDataGPS/POSTGPS/registros.php";
char WEBHOOK_URL2[] = "https://www.sibive.com/sibico/saveDataGPS/POSTGPS";
//char WEBHOOK_URL2[] = "https://www.sibive.com/barras/uno.php";

//VARIABLES GLOBALES
WioLTE Wio;


//VARIABLES SERIAL 
char SerialData[200];
char SerialLength = 0;
char *datosSerial;    //PUNTERO DEL SERIAL
char envioGPS[300];   //ENVIO DE DATOS POR HTTP
char cad[60];
char tiempoRTC[30];

//Camiones
/*
char imei[20] = "861108031691081"; //Unidad x AU
char imei[20] = "861108032056532"; //Unidad 5
char imei[20] = "861108032050220"; //Unidad 23
char imei[20] = "861108032050154"; //Unidad 31 
char ruta[] = "45a";
char unidad[] = "5"; 
*/
char imei[20] = "867962041133144"; //Unidad x 
char ruta[] = "45a";
char unidad[] = "00"; 

//Clave
char key[] = "4FU0kEJd3"; //\x1A"

//Funciones prototipo
bool httpost(const char* url, const char* data, int* responseCode, long timeout);
int httget(const char* url, char* data, long timeout);
char* SerialRead();
char string_cpyn(char *destino, char *origen, char size);

//Bandera de reseteo
bool resetEnviado = false;
int horaReset = 6 + 5;  //Hora del reset: 3am compesar 6 horas deltantadas del sistema utc
//int horaReset = 5 + 8;  //PRUEBAS

//Nmero del message
char phoneNumber[] = "2212252966";  //+522212252966
char phoneMessage[20];
bool resetMessage = false;
char messageSMS[40];
byte phoneSize = 0;
char serialAux[45];

int conteoAnterior[4];
bool condicionInicial = true, error = false, reenvioSerial = true;

void callback(char* topic, byte* payload, unsigned int length) {
  SerialUSB.print("Subscribe:");
  for (int i = 0; i < length; i++) SerialUSB.print((char)payload[i]);
  SerialUSB.println("");
}
/*******************************************************************************************/
void setup() {
  delay(200);
  Serial.begin(9600);  //115200
  //Serial.println("Get Data Camion");
  
  SerialUSB.println("");
  SerialUSB.println("START WIO LTE");
  
  SerialUSB.println("### I/O Initialize.");
  Wio.Init();
  Wio.LedSetRGB(255, 255, 0);  //Amarillo
  
  SerialUSB.println("### Power supply ON.");
  Wio.PowerSupplyLTE(true);
  delay(500); 

  SerialUSB.println("### GPS Encendido");
  Wio.PowerSupplyGNSS(true);
  delay(500);
  
  SerialUSB.println("### Turn on or reset.");
  if (!Wio.TurnOnOrReset()) {
    SerialUSB.println("### ERROR TURN ON ###");
    Wio.SystemReset();
    return;
  }
  
  //MOSTRAR NUMERO TELEFONICO
  delay(3000);
  SerialUSB.println("### Get phone number.");
  char number[100];
  if (Wio.GetPhoneNumber(number, sizeof (number)) <= 0) {
    SerialUSB.println("### ERROR PHONENUMBER! ###");
  }
  SerialUSB.println(number);
  
  //MOSTRAR IMEI
  byte numIMEI = Wio.GetIMEI(imei, sizeof(imei));
  if(numIMEI == 15){
    SerialUSB.print("IMEI(");
    SerialUSB.print(numIMEI);
    SerialUSB.print("): ");
    SerialUSB.println(imei);
  }else{
    SerialUSB.print("IMEI WRONG ");   
    SerialUSB.print(numIMEI);
    SerialUSB.println(" bytes");
  }
  /*
  //Enviar un SMS prueba
  if (!Wio.SendSMS("2227943518", "Hello world!"))
    SerialUSB.println("### ERROR SMS! ###");
  else 
    SerialUSB.println("### SMS ENVIADO! ###");
  */
  SerialUSB.println("### Connecting to \""APN"\".");
  if (!Wio.Activate(APN, USERNAME, PASSWORD)) {
    SerialUSB.println("### ERROR RED ###");
    Wio.SystemReset();
    return;
  }
  if(Wio.SyncTime("time.google.com")){
    SerialUSB.println("Horario sincronizado");
  }else{
    SerialUSB.println("Horario NO sincronizado");  
  }

    SerialUSB.println("### Setup completed.");
  
  envioGPS[0] = 0;
  phoneMessage[0] = 0;
  serialAux[0] = 0;
  Wio.LedSetRGB(0, 255, 0);
}
/*******************************************************************************************/
void loop() {
  //Estatus
  static int status;  //ESTATUS DEL HTTP REQUEST
  //double alt,lat;   //DATOS DEL GPS
  //Variables de funcionamiento
  static byte maquineE = 0;   //Maquina de estados     
  static byte errores = 0, errPast = 0;
  static long temp = 20000;
  //Variables para esperar que se llene el buffer
  static int tempDelay = 0;
  static bool datoRecibido = false;
  //Reloj de tiempo
  static struct tm now;
  static bool ledToogle = false;
  //Mensajes por borrar 
  int errDelMess;
  //Pruebas
  static bool emular = false;
  char *pointerSMS;
  
  
  //Cada x tiempo pido datos por serial y lo envio
  delay(1);

  //Toogle led
  if(++tempDelay >= 1000){
    tempDelay = 0;
    ledToogle = !ledToogle;
    if(ledToogle){
      if(now.tm_hour == horaReset || resetMessage)
        Wio.LedSetRGB(0, 0, 255);  
      else
        Wio.LedSetRGB(0, 255, 0);  
    }else{
      Wio.LedSetRGB(0, 0, 0);  
    }
    if(reenvioSerial){
      for(byte i=0; i<5; i++){
        Serial.println("r");
        SerialUSB.println("SOLICITAR REENVIO SERIAL");
        Serial.println("r");
      }
    }
  }
  //Cada 5 segundos obtengo datos
  if(++temp >= 5000){
    temp = 0;
    if(Wio.GetTime(&now, cad)){
      SerialUSB.print("Hora obtenida: ");
      SerialUSB.println(cad);
      //Enviar reset si esta en la zona horaria del reset
      if(now.tm_hour == horaReset || resetMessage){
        Wio.LedSetRGB(0, 0, 255);
        if(!resetEnviado || resetMessage){
          Serial.println("BORRAR_ALL");
          Serial.println("BORRAR_ALL");
          SerialUSB.println("Resetear contador camion");
          Serial.println("BORRAR_ALL");
          Serial.println("BORRAR_ALL");
          for(byte i=0; i<3; i++){
            conteoAnterior[i] = 0;
          }
        }
      }else{
        resetEnviado = false; //Resetear bandera de reset   
      }
    }else{
      SerialUSB.print("### ERROR TIME: ");
      SerialUSB.println(cad);
    }
    //VERIFICAR MENSAJES
    int strLen = Wio.ReceiveSMS(messageSMS, sizeof (messageSMS)-1, phoneMessage, sizeof(phoneMessage)-1);
    if(strLen < 0){
      SerialUSB.print("### ERROR SMS WIO LTE! ### ");
      SerialUSB.println(strLen);
      if(strLen == -77){  //Message overflow
        //Eliminar menssage
        errDelMess = Wio.DeleteAllMessagesRead();
        if (!errDelMess){
          SerialUSB.print("### ERROR DELETE SMS! ###: ");
          SerialUSB.print(errDelMess);
        }else
          SerialUSB.println("MESSAGE DELETE FROM LIMIT SIZE!"); 
      }else if(strLen == -9){  //Message unset?
        
      }
    }else if(strLen > 0){
      Wio.LedSetRGB(102, 0, 204);  //Morado
      SerialUSB.print("Message SMS: ");
      SerialUSB.println(messageSMS);
      SerialUSB.print("Phone destinatario: ");
      SerialUSB.println(phoneMessage);
      phoneSize = strlen(phoneMessage);

      if(phoneSize == 10)
        pointerSMS = phoneMessage;
      else
        pointerSMS = &phoneMessage[2];
      //Eliminar menssage
      errDelMess = Wio.DeleteAllMessagesRead();
      errDelMess = Wio.DeleteReceivedSMS();
      if (!errDelMess){
        SerialUSB.print("### ERROR DELETE SMS! ###: ");
        SerialUSB.print(errDelMess);
      }else
        SerialUSB.println("DELETE MESSAGES READ");
      
      //Procesar message
      if(!strcmp(messageSMS, "RESET")){
        resetMessage = true;
      }else if(!strcmp(messageSMS, "RESET STOP")){
        resetMessage = false;
        Wio.LedSetRGB(0, 255, 0);  //Verde
        delay(300);
      }else if(!strcmp(messageSMS, "RETRANSMITIR")){
        if(strlen(envioGPS) == 0){
          //Enviar un SMS prueba
          if(!Wio.SendSMS(pointerSMS, "El buffer del serial esta vacio"))
            SerialUSB.println("### ERROR SMS! ###");
          else 
            SerialUSB.println("### SMS ENVIADO! ###");    
        }else
          datoRecibido = true;
      }else if(!strcmp(messageSMS, "WIOLTE")){
        //Enviar un SMS prueba
        
        if(!Wio.SendSMS(pointerSMS, "Hola Programador!"))
          SerialUSB.println("### ERROR SMS! ###");
        else 
          SerialUSB.println("### SMS ENVIADO! ###");     
      }else if(!strcmp(messageSMS, "GET SERIAL")){
        if(strlen(serialAux) == 0){
          if(!Wio.SendSMS(pointerSMS, "El buffer del serial esta vacio"))
            SerialUSB.println("### ERROR SMS! ###"); 
          else 
            SerialUSB.println("### SMS ENVIADO! ###");     
        }else{
          if(!Wio.SendSMS(pointerSMS, serialAux))
            SerialUSB.println("### ERROR SMS! ###"); 
          else{
            SerialUSB.println("### SMS ENVIADO! ###");
            SerialUSB.println(serialAux);}     
        }
      }else if(!strcmp(messageSMS, "SYSTEM RESET")){
        Wio.SystemReset();
      }else{
        SerialUSB.println("COMANDO DESCONOCIDO");     
      }
    }
  }

  //Leer datos por el serial
  datosSerial = SerialRead();
  if(emular){
    emular = false;
    strcpy(SerialData, "ACC+01:0500,0500,0500,300,300,1");  
    datosSerial = SerialData;
  }
  //Proceso el serial 
  if(datosSerial != NULL){
    SerialUSB.print("Dato recibido por serial: ");
    SerialUSB.println(datosSerial);
    //Valido los datos por serial para ver si mando la cadena por tcp
    //"ACC+01:%04Lu,%04Lu,%04Lu,%03Lu,%03Lu,%u,",pasajet,entran1,salen1,cta_bloqueo,temporal3,silenciado);
    int tamSerial = strlen(datosSerial);
    
    if(!strncmp(datosSerial,"ACC+01:", 7) && tamSerial >= (7+12+6+4+3)){ //Start+datos+comas+3 aux
      strcpy(serialAux, datosSerial);//Repaldar
      if(!Wio.GetTime(&now, cad)) {
        SerialUSB.println("### ERROR TIME! ###");
        errores++;
        return;
      }
      //Imprime la hora
      SerialUSB.print("UTC:");
      SerialUSB.println(cad);
      //SerialUSB.println(asctime(&now));
      //Obtiene la hora en el formato correcto
      sprintf(tiempoRTC, "20%02Lu-%02Lu-%02Lu", (now.tm_year%100), (now.tm_mon+1)%13, now.tm_mday%32);
      strcat(tiempoRTC, "%20");
      sprintf(cad, "%02Lu:%02Lu:%02Lu", now.tm_hour%24, now.tm_min%60, now.tm_sec%60);
      strcat(tiempoRTC, cad);
      SerialUSB.print("Formato: ");
      SerialUSB.println(tiempoRTC);
      
      //Crea cadena de envio
      datoRecibido = true;
      //Pasajeros totales
      strcpy(envioGPS, "pasajeros=");
      string_cpyn(cad, &datosSerial[7], 4);
      strcat(envioGPS, cad);
      //Pasajeros suben (Maestro)
      strcat(envioGPS, "&psuben=");
      string_cpyn(cad, &datosSerial[12], 4);
      strcat(envioGPS, cad);
      //Pasajeros bajan (Maestro)
      strcat(envioGPS, "&pbajan=");
      string_cpyn(cad, &datosSerial[17], 4);
      strcat(envioGPS, cad);
      //Bloqueos subida
      strcat(envioGPS, "&bloqueosub=");
      string_cpyn(cad, &datosSerial[32/*22*/], 3);
      strcat(envioGPS, cad);
      //Bloqueos bajada
      strcat(envioGPS, "&bloqueobaj=");
      string_cpyn(cad, &datosSerial[36/*26*/], 3);
      strcat(envioGPS, cad);
      /*
      //latitude
      strcat(envioGPS, "&latitude=");
      string_cpyn(cad, "0.000000", 3);
      strcat(envioGPS, cad);
      //longitude
      strcat(envioGPS, "&longitude=");
      string_cpyn(cad, "0.000000", 3);
      strcat(envioGPS, cad);
      */
      //Pasajeros Suben (Esclavo)
      strcat(envioGPS, "&latitude=");
      string_cpyn(cad, &datosSerial[22], 4);
      strcat(envioGPS, cad);
      //pasajeros Bajan (Esclavo)
      strcat  (envioGPS, "&longitude=");
      string_cpyn(cad, &datosSerial[27], 4);
      strcat(envioGPS, cad);
      //time
      strcat(envioGPS, "&time=");
      //sprintf(cad, "%lu", millis() / 1000);
      //strcpy(cad,"2019-03-21%2012:51:32");
      strcat(envioGPS, tiempoRTC);
      //satellites
      strcat(envioGPS, "&satellites=");
      string_cpyn(cad, "0.000000", 3);
      strcat(envioGPS, cad);
      
      //speedOTG
      strcat(envioGPS, "&speedOTG=");
      string_cpyn(cad, "0.000000", 3);
      strcat(envioGPS, cad);
      //course
      strcat(envioGPS, "&course=");
      string_cpyn(cad, "0.000000", 3);
      strcat(envioGPS, cad);
      //imei
      strcat(envioGPS, "&imei=");
      strcat(envioGPS, imei);
      //ruta
      strcat(envioGPS, "&ruta=");
      strcat(envioGPS, ruta);
      //unidad
      strcat(envioGPS, "&unidad=");
      strcat(envioGPS, unidad);
      //key
      strcat(envioGPS, "&key=");
      strcat(envioGPS, key);
    }else if(!strcmp(datosSerial,"RESET_OK")){
      resetMessage = false;
      resetEnviado = true;
      SerialUSB.println("Reset confirmado");
      Wio.LedSetRGB(0, 255, 200);  //Verde marino
      delay(300);
    }else if(!strcmp(datosSerial,"RESET_FLAG")){
      resetEnviado = false;
      SerialUSB.println("Reset flag clear");
    }else{
      SerialUSB.println("Formato incorrecto serial");
      errores++;
    }
  }
    
  //Realizar envio si esta disponible
  if(datoRecibido){
    SerialUSB.println("REALIZAR HTTP POST");
    //Realizar el envio por HTTP
    SerialUSB.print("Post:");
    SerialUSB.print(envioGPS);
    SerialUSB.println("");
    
    SerialUSB.print("Tamaño del buffer a enviar: ");
    SerialUSB.println(strlen(envioGPS));
    
    //status = httget(WEBHOOK_URL2, envioGPS, 30000);
    //if (!status){
    if (!httpost(WEBHOOK_URL2, envioGPS, &status, 20000)){
      SerialUSB.println("### ERROR HTTP! ###");
      errores++;
      Wio.LedSetRGB(255, 0, 0);
      delay(300);
    }else{
      SerialUSB.print("Status:");
      SerialUSB.println(status);
      reenvioSerial = false;
      //Si la consulta no fue 200 no guardo bien
      if(status != 200){
        errores++;  
        Wio.LedSetRGB(255, 0, 0);
        delay(300);
      }else{ 
        errores = 0;
        Wio.LedSetRGB(0, 204, 153); //Azul marino
        delay(300);
      }
    }
    datoRecibido = false;
  }
  //Mostrar errores actuales
  if(errPast != errores){
    errPast = errores;  
    //Mostrar los estados de la maquina 
    SerialUSB.println("ERRORES REPORTADOS"); 
    SerialUSB.print("Errores actuales: ");
    SerialUSB.println(errores); 
    //Reinicio el cpu
    if(errores >= 30)
      Wio.SystemReset();
  }
}
/*******************************************************************************************/
bool httpost(const char* url, const char* data, int* responseCode, long timeout){
  //Encabezados
  WioLTEHttpHeader header;
  header["Accept"] = "*/*";
  header["User-Agent"] = "QUECTEL_MODULE";
  header["Connection"] = "Keep-Alive";
  header["Content-Type"] = "application/x-www-form-urlencoded";

  return Wio.HttpPost(url, data, responseCode, header, timeout);
}
/*******************************************************************************************/
int httget(const char* url, char* data, long timeout){
  //Encabezados
  WioLTEHttpHeader header;
  header["Accept"] = "*/*";
  header["User-Agent"] = "QUECTEL_MODULE";
  header["Connection"] = "Keep-Alive";
  header["Content-Type"] = "application/x-www-form-urlencoded";
 
  return Wio.HttpGet(WEBHOOK_URL2, data, strlen(data), header, 30000);
}
/*******************************************************************************************/
char* SerialRead(){
  static char SerialOverflow[] = "Overflow";
  static char SerialBadPacket[] = "Error en el paquete";
  char vectorDeComprobacion[] = {'\r','\n',',','0','1','2','3','4','5','6','7','8','9','D','E','S','C', 'A', ':', '+','R','T','_','O','K'};
  char conteoActual[22];
  int conteoActualNumero[3];

  while (Serial.available()) {
    char data = Serial.read();

    if (data == '\r') continue;
    if (data == '\n') {
      SerialData[SerialLength] = '\0';
      SerialLength = 0;
      return SerialData;
    }
    
    if (SerialLength > sizeof (SerialData) - 1) { // Overflow
      SerialLength = 0;
      reenvioSerial = true;
      return SerialOverflow;
    }
    //SerialData[SerialLength++] = data;
    for(byte i=0; i<sizeof(vectorDeComprobacion);i++){
      if(data == vectorDeComprobacion[i]){
        error = false;
        break;
      }
      else{
        error = true;
      }
    }
    if(error){
      SerialLength = 0;
      Serial.println("r");
      reenvioSerial = true;
      return SerialBadPacket;
    }
    else{
      SerialData[SerialLength++] = data;
      /*conteoActual[SerialLength] = data;
      if(SerialLength == 20){
        conteoActual[21] = '\0';
        char conteoTotal[4], conteoDelantero[4], conteoTrasero[4];
        for(byte i=0;i<4;i++){
          conteoTotal[i] = conteoActual[7+i];
          conteoDelantero[i] = conteoActual[12+i];
          conteoTrasero[i] = conteoActual[17+i];
        }
        if(condicionInicial){
          conteoAnterior[0] = atoi(conteoTotal);
          conteoAnterior[1] = atoi(conteoDelantero);
          conteoAnterior[2] = atoi(conteoTrasero);
          condicionInicial = false;
        }
        conteoActualNumero[0] = atoi(conteoTotal);
        conteoActualNumero[1] = atoi(conteoDelantero);
        conteoActualNumero[2] = atoi(conteoTrasero);
        for(byte j=0; j<3; j++){
          if(conteoActualNumero[j] != conteoAnterior[j]){
            int delta = conteoActualNumero[j] - conteoAnterior[j];
            if(delta > 20){
              switch(j){
                case 0:
                  conteoActualNumero[j] = conteoActualNumero[j] - 10;
                  sprintf(conteoTotal, "%.4i", conteoActualNumero[j]);
                  for(byte h=0;h<4;h++){
                    SerialData[7+h] = conteoTotal[h];
                  }
                  break;
                case 1: 
                  conteoActualNumero[j] = conteoActualNumero[j] - 10;
                  sprintf(conteoDelantero, "%.4i", conteoActualNumero[j]);
                  for(byte h=0; h<4; h++){
                    SerialData[12+h] = conteoDelantero[h];
                  }
                  break;
                case 2:
                  conteoActualNumero[j] = conteoActualNumero[j] - 10;
                  sprintf(conteoTrasero, "%.4i", conteoActualNumero[j]);
                  for(byte h=0; h<4; h++){
                    SerialData[17+h] = conteoTrasero[h];
                  }
                  break;
                default:
                  break;
              }
            }
          }
          else{
            for(byte i=0; i<3; i++){
              conteoAnterior[i] = conteoActualNumero[i];
            }
          }
        }
      }*/
    }
  }

  return NULL;
}
/*******************************************************************************************/
char string_cpyn(char *destino, char *origen, char size){
  char cont;
  
  for(cont = 0; cont < size && origen[cont]; cont++)
    destino[cont] = origen[cont];
  destino[cont] = 0;              //Final de cadena
  
  return cont;
}
/*******************************************************************************************/
/*
        //Codigo gps
        if(Wio.GetLocation(&alt,&lat)){
          SerialUSB.println("DATOS LATITUD altitud");
          SerialUSB.print("Altitud: ");
          SerialUSB.println(alt);
          SerialUSB.print("Latitud");
          SerialUSB.println(lat);
        }else{
          SerialUSB.println("Fallo la lectura del GPRS");
        }

        //Mostrar la zona horaria
  /*
  if (Wio.writeGTM())
    SerialUSB.println("Cambio de zona");
  else
    SerialUSB.println("Fallo el cambio");
  
  if (Wio.getGTM(cad)){
    SerialUSB.print("Zona Horaria: ");
    SerialUSB.println(cad);
  }else
    SerialUSB.println("Fallo lectura GTM");
  */
  
  /*
  //Sincronizar hora con google
  if(Wio.SyncTime("time.google.com")){
    SerialUSB.println("Horario sincronizado");
  }else{
    SerialUSB.println("Horario NO sincronizado");  
  }
  /*
  //Obtener intencidad 
  int intensidad = Wio.GetReceivedSignalStrength(cad);
  SerialUSB.print("Intensidad de la señal: ");
  SerialUSB.println(cad);
  SerialUSB.println(intensidad);
  */
