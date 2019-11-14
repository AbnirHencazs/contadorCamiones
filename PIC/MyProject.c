/*
Hecho por: Lic. Brian Sánchez Izquierdo para ACCESA.ME
                              version 2.0 con fecha 05/08/19
Contador para pasajeros de autobus. El codigo esta creado para que se utilize en dos pares de postes, uno delantero y uno trasero.
El poste delantero (MSTR), se elige cuando hay presencia de 5v en el puerto B bit 2. El esclavo se elige cuando no hay presencia de voltaje en dicho pin del PIC.
Respecto a la comunicacion Serial, cada 5 segundos MSTR envia una solicitud de cuenta "C." y el esclavo responde con 6 datos:
1.-Primer byte de su cuenta de pasajeros totales
2.-Segundo byte de su cuenta de pasajeros totales
3.-Cuenta de bloqueos
4.-Tiempo para realizar la comunicacion con el modulo GPRS (siempre es 0 a menos que el poste trasero reporte un Bloqueo, en dado caso el tiempo sera el necesario para realizar instantaneamente la comunicacion de datos; 90 segundos)
5.-CHECKSUM
6.-Caracter de respuesta del esclavo "C.", lo que afirma la conexion entre ambos postes

Con el objetivo de tener otro filtro para afirmar la conexion serial entre ambos postes, se hace uso de un CHECKSUM el cual toma en cuenta los primeros 3 datos enviados y lo compara con el cuarto.
La comunicacion serial tambien se utiliza con el objetivo de dar un RESET a la cuenta del poste trasero, en esta caso MSTR enviara una solicitud de RESET "R." y el esclavo hara lo respectivo para borrar las cuentas.
Si cualquiera de ambos filtros determina que la conexion no existe, se comunicara un "DESC" al GPRS en el lugar donde iria la cuenta del poste trasero, tambien se emitiran dos pitidos cortos para informar al conductor de la situacion.

Los bloqueos son reportados inmediatamente al GPRS, y el contador emitira un sonido constante a traves de la bocina lo cual no parara hasta resolverse la situacion de Bloqueo.

En este diseño especifico, hay capacitores que vuelven la señal modulada de los sensores IR en estados constantes y la logica de programación toma ventaja de esto.

IMPORTANTE:
1.-En este diseño es fundamental el uso de una memoria EEPROM para el guardado de datos.
2.-El modulo GPRS mantiene un voltaje constante en su linea de comunicacion serial, el programa reiniciara la cuenta de ambos postes cuando logre detectar un cambio en este voltaje,
por lo que se recomienda apagar el contador ANTES QUE EL GPRS
3.-El watchdog g esta configurado para que todo las instrucciones pertinentes se cumplan en menos de un minuto, si se tarda mas (lo que indicaria un fallo) se presentara un reinicio.*/

//DECLARACION SENSORES
 /*sbit SENSOR1                   at PORTD.B4;
 sbit SENSOR1D                  at TRISD.B4;
 sbit SENSOR2                   at PORTB.B4;
 sbit SENSOR2D                  at TRISB.B4;
 sbit SENSOR3                   at PORTB.B3;
 sbit SENSOR3D                  at TRISB.B3;
 sbit SENSOR4                   at PORTB.B2;
 sbit SENSOR4D                  at TRISB.B2;
 sbit SENSOR5                   at PORTB.B1;
 sbit SENSOR5D                  at TRISB.B1;
 sbit SENSOR6                   at PORTB.B0;
 sbit SENSOR6D                  at TRISB.B0; */

 sbit SENSOR1                   at PORTB.B4;
 sbit SENSOR1D                  at TRISB.B4;
 sbit SENSOR2                   at PORTD.B4;
 sbit SENSOR2D                  at TRISD.B4;
 sbit SENSOR3                   at PORTB.B2;
 sbit SENSOR3D                  at TRISB.B2;
 sbit SENSOR4                   at PORTB.B3;
 sbit SENSOR4D                  at TRISB.B3;
 sbit SENSOR5                   at PORTB.B0;
 sbit SENSOR5D                  at TRISB.B0;
 sbit SENSOR6                   at PORTB.B1;
 sbit SENSOR6D                  at TRISB.B1;
//LCD
sbit LCD_RS                        at PORTE.B2;
sbit LCD_RS_Direction              at TRISE.B2;
sbit LCD_EN                        at PORTA.B3;
sbit LCD_EN_Direction              at TRISA.B3;
sbit LCD_D4                        at PORTA.B4;
sbit LCD_D4_Direction              at TRISA.B4;
sbit LCD_D5                        at PORTA.B2;
sbit LCD_D5_Direction              at TRISA.B2;
sbit LCD_D6                        at PORTA.B1;
sbit LCD_D6_Direction              at TRISA.B1;
sbit LCD_D7                        at PORTA.B0;
sbit LCD_D7_Direction              at TRISA.B0;
//MODULO EEPROM 32K
sfr sbit I2C_SCL                   at PORTD.B7;
sfr sbit I2C_SCLD                  at TRISD.B7;
sfr sbit I2C_SDA                   at PORTD.B6;
sfr sbit I2C_SDAD                  at TRISD.B6;
//POLARIZAR SENSORES
sbit POLARIZACION                  at PORTC.B2;
sbit POLARIZACIOND                 at TRISC.B2;
sbit BLOQUEOACTIVO                 at PORTC.B3;
sbit BLOQUEOACTIVOD                at TRISC.B3;
sbit SENSORESDEBUG                 at PORTC.B4;
sbit SENSORESDEBUGD                at TRISC.B4;

//RS232
sbit TX_PIC                        at PORTC.B6;
sbit TX_PICD                       at TRISC.B6;
sbit RX_PIC                        at PORTC.B7;
sbit RX_PICD                       at TRISC.B7;
//RESET
sbit RESET_BOTON                   at PORTD.B1;
sbit RESET_BOTOND                  at TRISD.B1;
//PUENTE MSTR-SLV
sbit MSTR                          at PORTD.B2;
sbit MSTRD                         at TRISD.B2;

#define bool  char
#define true  1
#define false 0
#define ESPERA                     0     /********************************************/
#define ENTRANDO                   1     /********************************************/
#define TRANSICION                 2     /********************************************/
#define TRANSICIONS                8     /*******************ESTADOS******************/
#define TRANENT                    7     /*********************DE*********************/
#define ENTRO                      3     /********************CRUCE*******************/
#define SALIENDO                   4     /********************************************/
#define TRANSAL                    5     /********************************************/
#define SALIO                      6     /********************************************/
#define BAUDIOS                    9600
#define periodoUSART               5    // 5 Segundos para la solicitud de cuenta del poste trasero
#define periodoEnvioGPS            180  //120 Segundos para envio de datos por serial emulado al modulo GPS

//LIBRERIAS
#include "lcd_4x20.h"
#include "bloqueos_v1.h"
#include "rutinaSensores_v4(MSTR-SLV).h"

//VARIABLES
char          Aux1[12] = {0}, Aux2[12] = {0}, Aux3[12] = {0}, Aux4[12] = {0}, Aux5[12] = {0}, Aux6[12] = {0}, WioRX[2]={0};
char          solicitudCuenta[] = "C.", solicitudReset[] = "R.", solicitudMaestro[8] = {0}, infoEsclavo[8] = {0}, confirmacionEsclavo[3] = {0};
char          envioGPS[7] = {0}, auxEnvioGPS[5] = {0}, commAT[] = "ACC+01:", envioGPSshort[6] ={0}, respuestaReset[] = "RESET_OK";
char          coma = 44, datoRxWioLTE[] ="Reset", error = 0, posteDesconectado[] = "DESC", conectado[] = "O", errorSoftUART, envioSerialGPS[45] = {0};
float         pasajerosVerdaderosEsc = 0.0;
bool          estado1 = true, estado2 = true, estado3 = true, estado4 = true, estado5 = true, estado6 = true, banderaRx = false;
bool          banderaReset = false, resetWioLTE = false, posteDesc = false, afterReset = false, conexionHabilitada = false;
short         auxCuentaBloqueo = 0, recBloq = 0, conexionPoste = 0;
short         i = 0, j=0, k = 0, l = 0, m = 0, checksum[10] = {0};
short         cuentaSoftRead = 0;
short         bloqEsclavo = 0, bufferCuentaEnvioGPS = 0;
unsigned long recepcionLong = 0, recLong = 0;
unsigned int  pSubenEsc = 0, pBajanEsc = 0, totalVerdadero = 0;
unsigned short bufferRecepcionEsclavo[10] = {0}, bufferEnvioEsclavo[10] = {0};


//DECLARACION DE FUNCIONES MAESTRO
void MASTER();
short TX_MSTR();
void resetCuentas();
void UARTTX_WiolTE();
void serialTxWioLTE();


//DECLARACION FUNCIONES ESCLAVO
void SLV();
void TX_SLV();
void resetSLV();


//FUNCIONES PARA AMBOS
void  PicInit();
void  bloqueos();
void  indicadorSensores();
void  desbordoTemporizadorCero();
void  SENSADO();
void  RX_PIC_PIC();
void  escrituraBloqueos();


//INTERRUPCIONES
void interrupcionesAltoNivel() iv 0x0008 ics ICS_AUTO {

 if(PIR1.RCIF & PIE1.RCIE){
  RX_PIC_PIC();
  }

 if(PIR2.TMR3IF & PIE2.TMR3IE & MSTR){
  cuentaSoftRead++;
  if(cuentaSoftRead >=1){
   Soft_UART_Break();
   PIR2.TMR3IF = false;
  }
 }
}

void interrupcionesBajoNivel() iv 0x0018 ics ICS_AUTO {
desbordoTemporizadorCero();
}

/***********************************************************************************************************************/
/******************************************                                 ********************************************/
/******************************************             MAIN                ********************************************/
/******************************************                                 ********************************************/
/***********************************************************************************************************************/

void main() {
 PicInit();

 while(1){

  bytetostr(posteDesc, Aux6);    //BANDERA DE DESCONEXION DE POSTE TRASERO; 0 = "CONECTADO" - 1 = "DESCONECTADO"
  lcd_out(4,8,aux6);
  if(MSTR){
   WDTCON.SWDTEN = 1;
   T3CON.TMR3ON = 1;
   wioRX[0] = Soft_UART_Read(&errorSoftUART);
   if((!errorSoftUART) | errorSoftUART == 255){
    if(!errorSoftUART){
     if(wioRX[0] == 'r'){
      desbordoGPS = periodoEnvioGPS - 1;
      lcd_chr(2,8,wioRX[0]);
      }
     else if(wioRX[0] == 'B'){
      resetWioLTE = true;
      lcd_chr(2,8,wioRX[0]);
      }
     }

    T3CON.TMR3ON = 0;
    TMR3L = 0x85;
    TMR3H = 0xFD;
    memset(wioRX, 0, sizeof(wioRX));
    cuentaSoftRead = 0;
    }
   WDTCON.SWDTEN = 0;
   WDTCON.SWDTEN = 1;
   MASTER();
   WDTCON.SWDTEN = 0;
   }

  else{

   SLV();

   }

  if(SENSOR1 & SENSOR2 & SENSOR3 & SENSOR4 & SENSOR5 & SENSOR6){
   SENSORESDEBUG = 1;
   }
  else{
   SENSORESDEBUG = 0;
   }
  }

 }

/***********************************************************************************************************************/
/*******************************************                            ************************************************/
/*******************************************         INICIALIZACION     ************************************************/
/*******************************************                            ************************************************/
/***********************************************************************************************************************/

void PicInit(){
 //Configurar el reloj del pic

 OSCCON = 0x40;                   //Oscilador externo  20MHz
 //Configuar los pines analogicos
 ADCON1 = 0x0F;                  //Todos digitales
 CMCON = 0x07;                   //Apagar los comparadores

 //LCD
 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_outConst(1,1,"INICILIZANDO...")  ;
 //delay_ms(1000);

 //DECLARACION ENTRADAS
 SENSOR1D = 1;
 SENSOR2D = 1;
 SENSOR3D = 1;
 SENSOR4D = 1;
 SENSOR5D = 1;
 SENSOR6D = 1;
 RESET_BOTOND = 1;
 RX_PICD = 1;
 TRISC.B1 = 1;                        //Serial Rx WioLTE

 //DECLARACION DE SALIDAS
 TX_PICD = 0;
 POLARIZACIOND = 0;
 BLOQUEOACTIVOD = 0;
 SENSORESDEBUGD = 0;

 //condiciones iniciales
 SENSORESDEBUG = 0;
 BLOQUEOACTIVO = 0;

 //PWM
 PWM1_Init(44000);
 PWM1_Start();
 PWM1_Set_Duty(127);

 //CREACION DE TABLA
 iniciaEeprom();

 //REGISTROS TIMER0
 T0CON.TMR0ON = 1;                         //encendido timer0
 T0CON.T08BIT = 0;                         //contador de 16 bits
 T0CON.T0CS = 0;                           //SELECCIONA RELOJ INTERNO
 T0CON.PSA = 0;                            //Asigna el PREESCALADOR
 T0CON.T0PS0 = 0;                          //valor
 T0CON.T0PS1 = 1;                          //preescalador
 T0CON.T0PS2 = 1;                          //1:128
 /*TMR0L = 2^16-(TiempoRetardo*(FrecOscilador/(4*ValorPreescalador))-1) => TMR0L = 65536-(1s*(20MHz/(128*4)))-1 = 6.05 = 6*/
 /*TMR0L = 0xBD;                             //0.1 segundo para el desbordo del contador
 TMR0H = 0xF0;*/
 TMR0L = 0x69;                             //1 segundo para el desbordo del contador
 TMR0H = 0x67;

 //REGISTROS TIMER1
 if(MSTR){
 T1CON.RD16 = 0;                           //CONTADOR 16 BITS EN DOS REGISTROS DE 8
 T1CON.TMR1CS = 0;                         //OSCILADOR INTERNO (FOSC/4)
 T1CON.T1CKPS0 = 1;
 T1CON.T1CKPS1 = 1;                        //PREESCALADOR 1:1
 /*TMR1L = 2^16-(TiempoRetardo*(FrecOscilador/(4*ValorPreescalador))-1) => TMR0L = 65536-(0.1s*(20MHz/(8*4)))-1 = 3035 = 3035*/
 TMR1L = 0x8E;
 TMR1H = 0xFD;
 T1CON.TMR1ON = 1;

 //REGISTROS TIMER3

 T3CON.RD16 = 0;                           //CONTADOR 16 BITS EN DOS REGISTROS DE 8
 //T3CON.T3ECCP1 = 1;
 T3CON.TMR3CS = 0;                         //OSCILADOR INTERNO (FOSC/4)
 T3CON.T1CKPS0 = 1;
 T3CON.T1CKPS1 = 1;                        //PREESCALADOR 1:8
 /*TMR3 = 2^16-(TiempoRetardo*(FrecOscilador/(4*ValorPreescalador))-1) => TMR3 = 65536-(0.001s*(20MHz/(8*4)))-1 = 64910 = 64910*/
 TMR3L = 0x85;
 TMR3H = 0xFD;

 }
 //ACTIVAR INTERRUPCIONES
 RCON.IPEN = 1;                            //ACTIVAR NIVELES DE INTERRUPCION
 INTCON.PEIE = 1;                          //ACTIVAR INTERRUPCIONES PERIFERICAS
 INTCON.GIE = 1;                           //ACTIVAR INTERRUPCIONES GLOBALES
 INTCON.TMR0IE = 1;                        //ACTIVA INTERRUPCION POR DESBORDE
 INTCON2.TMR0IP = 0;                       //INTERRUPCION BAJA PRIORIDAD
 INTCON3.TMR1IE = 1;                       //HABILITA INTERRUPCION POR DESBORDE DEL TEMPORIZADOR 1
 IPR1.TMR1IP = 1;                          //INTERRUPCION DE ALTA PRIORIDAD
 PIE2.TMR3IE = 1;
 IPR2.TMR3IP = 1;

 /*PIE1.TXIE = 1;                            //HABILITA INTERRUPCIONES POR LLENAO DEL BUFFER TX
 IPR1.TXIP = 0;                            //INTERRUPCION DE BAJA PRIORIDAD */
 PIE1.RCIE = 1;                            //HABILITA INTECCUPCION POR RECEPCION DE USART
 IPR1.RCIP = 1;                            //INTERRUCION DE ALTA PRIORIDAD

 //UART RS232
 UART1_Init(BAUDIOS);                      //INICIA COMUNICAICON RS232 A 9600 BAUDIOS
 delay_ms(100);
 //UARTGPS
 Soft_UART_Init(&PORTC, 1, 0, 9600, 0);

 //INICIALIZAR MIEMBROS DE ESTRUCTURAS
 Bandera.SensorU = false, Bandera.SensorD = false, Bandera.SensorT = false, Bandera.SensorC = false, Bandera.SensorO = false, Bandera.SensorS = false;
 Bandera.Par1 = false, Bandera.Par2 = false, Bandera.Par3 = false, Bandera.Par4 = false, Bandera.Par5 = false, Bandera.Par6 = false, Bandera.Par7 = false, Bandera.Par8 = false, Bandera.Par9 = false;
 Desborde.SensorU = 0, Desborde.SensorD = 0, Desborde.SensorT = 0, Desborde.SensorC = 0, Desborde.SensorO = 0, Desborde.SensorS = 0;
 Desborde.Par1 = 0, Desborde.Par2 = 0, Desborde.Par3 = 0, Desborde.Par4 = 0, Desborde.Par5 = 0, Desborde.Par6 = 0, Desborde.Par7 = 0, Desborde.Par8 = 0, Desborde.Par9 = 0;

 BLOQUEOACTIVO = 1;
 delay_ms(200);
 BLOQUEOACTIVO = 0;

 lcd_cmd(_LCD_CLEAR);
 }

/************************************************************************************************************************/
/******************************************************                    **********************************************/
/******************************************************      TX-RX         **********************************************/
/******************************************************                    **********************************************/
/************************************************************************************************************************/

/************************************************************************************************************************/
/******************************************************          TX        **********************************************/
/************************************************************************************************************************/

short TX_MSTR(){
 short m = 0;
 if(cuentaUSART == periodoUSART){
  memset(confirmacionEsclavo, 0, sizeof(confirmacionEsclavo));
  if(UART1_Tx_Idle() == true){
   UART1_Write_Text(solicitudCuenta);
   if((bufferRecepcionEsclavo[4] != checksum[5]) & !conexionHabilitada){
    posteDesc = true;
    afterReset = true;
    checksum[0] = 1;
    checksum[1] = 2;
    checksum[2] = 3;
    conexionHabilitada = false;
    }
   else{
    bufferRecepcionEsclavo[4] = 0;
    checksum[5] = 10;
    lcd_cmd(_LCD_CLEAR);
    posteDesc = false;
    conexionHabilitada = false;
    if(afterReset){
     afterReset = false;
     asm reset;
     }
    }
   cuentaUSART = 0;
   }
  }
 if(!posteDesc){
  if(banderaRx){
   lcd_cmd(_LCD_CLEAR);
   guardadoSlvSuben = eepromLeeNumero(0x0900, 2);
   recSlvSuben = 0;
   recSlvsuben |= bufferRecepcionEsclavo[6] << 8;
   recSlvSuben |= bufferRecepcionEsclavo[5];
   if(recSlvSuben != guardadoSlvSuben){
    eepromEscribeNumero(0x0900, bufferRecepcionEsclavo[5], 1);
    eepromEscribeNumero(0x0901, bufferRecepcionEsclavo[6], 1);
    }
   guardadoSlvBajan = eepromLeeNumero(0x0700, 2);
   recSlvBajan = 0;
   recSlvBajan |= bufferRecepcionEsclavo[8] << 8;
   recSlvBajan |= bufferRecepcionEsclavo[7];
   if(recSlvBajan != guardadoSlvBajan){
    eepromEscribeNumero(0x0700, bufferRecepcionEsclavo[7], 1);
    eepromEscribeNumero(0x0701, bufferRecepcionEsclavo[8], 1);
    }
   totalVerdadero = eepromLeeNumero(0x0005, 2);
   //totalVerdadero = eepromLeeNumero(0x0020, 2);
   totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
   if(totalCalculado != totalVerdadero){
    //eepromEscribeNumero(0x0020, int(totalCalculado), 2);
    eepromEscribeNumero(0x0005, totalCalculado, 2);
    }
   /*
   recepcionLong = eepromLeeNumero(0x0007, 2);
   recLong = 0;
   recLong |= bufferRecepcionEsclavo[1] << 8;
   recLong |= bufferRecepcionEsclavo[0];
   if(recLong != recepcionLong){
    eepromEscribeNumero(0x0007, bufferRecepcionEsclavo[0], 1);
    eepromEscribeNumero(0x0008, bufferRecepcionEsclavo[1], 1);
    pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
    pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
    pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
    eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
    }
   */
   recBloq = eepromLeeNumero(0x000C, 1);
   if(bufferRecepcionEsclavo[2] != recBloq){
    eepromEscribeNumero(0x000C, bufferRecepcionEsclavo[2], 1);
    bloqEsclavo = eepromLeeNumero(0x000C, 1);
    }
   if(bufferRecepcionEsclavo[3]){
    desbordoGPS = bufferRecepcionEsclavo[3];
    }
   memset(bufferRecepcionEsclavo[3],0,sizeof(bufferRecepcionEsclavo));
   banderaRx = false;
   }
  }
 }

void TX_SLV(){
 if(EnvioCuenta){
  short i=0;
  bufferEnvioEsclavo[0] = eepromLeeNumero(0x0009, 1);
  bufferEnvioEsclavo[1] = eepromLeeNumero(0x000A, 1);
  bufferEnvioEsclavo[2] = eepromLeeNumero(0x000B, 1);
  bufferEnvioEsclavo[3] = desbordoGPS_SLV;
  bufferEnvioEsclavo[4] = bufferEnvioEsclavo[0] + bufferEnvioEsclavo[1] + bufferEnvioEsclavo[2];
  bufferEnvioEsclavo[5] = eepromLeeNumero(0x0000, 1);
  bufferEnvioEsclavo[6] = eepromLeeNumero(0x0001, 1);
  bufferEnvioEsclavo[7] = eepromLeeNumero(0x0003, 1);
  bufferEnvioEsclavo[8] = eepromLeeNumero(0x0004, 1);
  desbordoGPS_SLV = 0;
  for( i=0 ; i<9; i++){
   if(UART1_Tx_Idle() == true){
    UART1_Write(bufferEnvioEsclavo[i]);
    delay_ms(5);
    }
   }
  if(UART1_Tx_Idle() == true){
   UART1_Write_Text("C.");
   }
  EnvioCuenta = false;
  }
 }

void serialTxWioLTE(){

 if(desbordoGPS >= periodoEnvioGPS){
  //cuentaUSART = 0;
  //T0CON.TMR0ON = 0;
  if(posteDesc){
   BLOQUEOACTIVO = 1;
   delay_ms(50);
   BLOQUEOACTIVO = 0;
   delay_ms(50);
   BLOQUEOACTIVO = 1;
   delay_ms(50);
   BLOQUEOACTIVO = 0;
   }
  memset(envioSerialGPS, 0, sizeof(envioSerialGPS));
  //COMANDO AT
  strcpy(envioSerialGPS, commAT);
  //CUENTA TOTAL
  memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
  inttostrwithzeros(lecturaTablaPVerdaderos, envioGPS);
  for(l=0 ; l<4 ; l++){
   auxEnvioGPS[l] = envioGPS[l+2];
   }
  strcat(envioSerialGPS, auxEnvioGPS);
  //COMA
  strcat(envioSerialGPS, ",");
  
  //CUENTA PASAJEROS POSTE DELANTERO   (SUBEN)
  memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
  pasajerosSubenM = eepromLeeNumero(0x0000, 2);
  inttostrWithZeros(pasajerosSubenM, envioGPS);
  for(l=0 ; l<4 ; l++){
   auxEnvioGPS[l] = envioGPS[l+2];
   }
  strcat(envioSerialGPS, auxEnvioGPS);
  //COMA
  strcat(envioSerialGPS, ",");
  //CUENTA PASAJEROS POSTE DELANTERO (BAJAN)
  memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
  //pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pasajerosBajanM = eepromLeeNumero(0x0003, 2);
  //inttostrWithZeros(pVerdaderosMEntero, envioGPS);
  inttostrWithZeros(pasajerosBajanM, envioGPS);
  for(l=0 ; l<4 ; l++){
   auxEnvioGPS[l] = envioGPS[l+2];
   }
  strcat(envioSerialGPS, auxEnvioGPS);
  //COMA
  strcat(envioSerialGPS, ",");
  //ENVIO PASAJEROS POSTE TRASERO  (SUBEN)
  memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
  if(posteDesc){
   strcat(envioSerialGPS, posteDesconectado);
   }
  else{
   //pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
   //pasajerosSubenE = eepromLeeNumero(0x0900, 2);
   pasajerosSubenE = eepromLeeNumero(0x0900, 2);
   inttostrWithZeros(pasajerosSubenE, envioGPS);
   for(l=0 ; l<4 ; l++){
    auxEnvioGPS[l] = envioGPS[l+2];
    }
   strcat(envioSerialGPS, auxEnvioGPS);
   }
  //COMA
  strcat(envioSerialGPS, ",");
  //ENVIO PASAJEROS POSTE TRASERO  (BAJAN)
  memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
  if(posteDesc){
   strcat(envioSerialGPS, posteDesconectado);
   }
  else{
   pasajerosBajanE = eepromLeeNumero(0x0700, 2);
   inttostrWithZeros(pasajerosbajanE, envioGPS);
   for(l=0 ; l<4 ; l++){
    auxEnvioGPS[l] = envioGPS[l+2];
    }
   strcat(envioSerialGPS, auxEnvioGPS);
   }
  //COMA
  strcat(envioSerialGPS, ",");
  //ENVIO BLOQUEOS POSTE DELANTERO
  memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
  auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
  if(cuentaBloqueo > auxCuentaBloqueo){
   wordtostrWithZeros(cuentaBloqueo, envioGPS);
   }
  else{
   wordtostrWithZeros(auxCuentaBloqueo, envioGPS);
   }
  wordtostrWithZeros(auxCuentaBloqueo, envioGPS);
  for(l=0 ; l<3 ; l++){
   auxEnvioGPS[l] = envioGPS[l+2];
   }
  strcat(envioSerialGPS, auxEnvioGPS);
  //COMA
  strcat(envioSerialGPS, ",");
  //ENVIO BLOQUEOS POSTE TRASERO
  memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
  bloqEsclavo = eepromLeeNumero(0x000C, 1);
  if(bufferRecepcionEsclavo[2] > bloqEsclavo){
   wordtostrWithZeros(bufferRecepcionEsclavo[2], envioGPS);
   }
  else{
   wordtostrWithZeros(bloqEsclavo, envioGPS);
   }
  for(l=0 ; l<3 ; l++){
   auxEnvioGPS[l] = envioGPS[l+2];
   }
  strcat(envioSerialGPS, auxEnvioGPS);
  memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));

  //COMA
  strcat(envioSerialGPS, ",");
  //CADENA DE SALIDA
  strcat(envioSerialGPS, "0,\r\n");
  for(l=0; l<strlen(envioSerialGPS); l++){
   Soft_UART_Write(envioSerialGPS[l]);
   }
  lcd_cmd(_LCD_CLEAR);
  lcd_out(1,1,envioSerialGPS);
  //delay_ms(2500);
  lcd_cmd(_LCD_CLEAR);
  memset(envioSerialGPS, 0, sizeof(envioSerialGPS));
  desbordoGPS = 0;
  }
 }

/************************************************************************************************************************/
/******************************************************          RX        **********************************************/
/************************************************************************************************************************/

void RX_PIC_PIC(){
 if(MSTR){
  if(k < 10){
   if(k == 9){
    UART1_Read_Text(confirmacionEsclavo, ".", 2);
    if(!strcmp(confirmacionEsclavo, "C")){
     conexionHabilitada = true;
     }
    else{
     conexionHabilitada = false;
     }
    }
   else{
    bufferRecepcionEsclavo[k] = UART1_Read();
    checksum[k] = bufferRecepcionEsclavo[k];
    }
   k = k++;
   if(k > 9){
    k = 0;
    checksum[5] = checksum[0] + checksum[1] + checksum[2];
    banderaRx = true;
    }
   }
  }
 if(!MSTR){
  UART1_Read_Text(solicitudMaestro, ".", 2);
  if(!strcmp(solicitudMaestro, "C")){
   EnvioCuenta = true;
   }
  if(!strcmp(solicitudMaestro, "R")){
   banderaReset =  true;
   }
  }
 }


/************************************************************************************************************************/
/*********************************************                      *****************************************************/
/*********************************************       SENSADO        *****************************************************/
/*********************************************                      *****************************************************/
/************************************************************************************************************************/

void SENSADO(){

  if(Bandera.SensorU & !Bandera.Par1){
   sensorBloqueo();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.SensorD & !Bandera.Par1){
   sensorBloqueoD();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.SensorT & !Bandera.par2){
   sensorBloqueoT();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.SensorC & !Bandera.Par2){
   sensorBloqueoC();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.SensorO & !Bandera.Par3){
   sensorBloqueoO();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.SensorS & !Bandera.Par3){
   sensorBloqueoS();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
   if(!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS & !Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par9){
   sensorNoBloqueo();
   return;
   }
  if(Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
   sensorBloqueoPar1();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.Par2 & !Bandera.Par1 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
   sensorBloqueoPar2();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.Par3 & !Bandera.Par2 & !Bandera.Par1 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
   sensorBloqueoPar3();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.Par4 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par1 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
   sensorBloqueoPar4();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.Par6& !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par1 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
   sensorBloqueoPar6();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.Par7 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par1 & !Bandera.Par8 & !Bandera.Par9){
   sensorBloqueoPar7();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
  if(Bandera.Par9 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par1){
   sensorBloqueoPar9();
   if(cuenta){
    auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
    auxCuentaBloqueo++;
    eepromEscribeNumero(0x000B, AuxcuentaBloqueo, 1);
    cuenta = false;
    }
   }
 }

/************************************************************************************************************************/
/******************************************                               ***********************************************/
/******************************************           TEMPORIZADOR0       ***********************************************/
/******************************************                               ***********************************************/
/************************************************************************************************************************/

void desbordoTemporizadorCero(){

 if(INTCON.TMR0IF && INTCON.TMR0IE){

 cuentaUSART = cuentaUSART++;
 desbordoGPS = desbordoGPS++;
 conexionPoste = conexionPoste++;
 if(comienzaContarAtasco){
  cuentaAtasco++;
  }
 /*if(empiezaEntrada & empiezaSalida){
  cuentaE_S++;
   if(cuentaE_S>=1){
    debugEstado = ESPERA;
    cuentaE_S = 0;
    }
  } */
 bloqueos(SENSOR1, SENSOR2, SENSOR3, SENSOR4, SENSOR5, SENSOR6, &cuentaBloqueo);

 INTCON.TMR0IF = 0;
 /*TMR0L = 0xBD;                             //0.1 segundo para el desbordo del contador
 TMR0H = 0xF0;*/
 TMR0L = 0x69;                             //1 segundo para el desbordo del contador
 TMR0H = 0x67;
 }
}


/************************************************************************************************************************/
/***********************************                                                        *****************************/
/***********************************              Reset, MSTR-SLV, indicadores              *****************************/
/***********************************                                                        *****************************/
/************************************************************************************************************************/

void resetCuentas(){

 short l = 0;

 if(RESET_BOTON | resetWioLTE){
  if(MSTR){
   if(UART1_Tx_Idle() == true){
    UART1_Write_Text(solicitudReset);
    }
   eepromEscribeNumero(0x0000, 0x0000, 2);
   eepromEscribeNumero(0x0003, 0x0000, 2);
   eepromEscribeNumero(0x0005, 0x0000, 2);
   eepromEscribeNumero(0x0007, 0x0000, 2);
   eepromEscribeNumero(0x0009, 0x0000, 2);
   eepromEscribeNumero(0x000B, 0x00, 1);
   eepromEscribeNumero(0x000C, 0x00, 1);
   }
  for(l = 0; l < 8; l++){
   Soft_UART_Write(respuestaReset[l]);
   }
  soft_UART_Write(0x0D);
  soft_UART_Write(0x0A);
  resetWioLTE = false;
  }
 }

void resetSLV(){
 if(banderaReset){
  eepromEscribeNumero(0x0000, 0x0000, 2);
  eepromEscribeNumero(0x0003, 0x0000, 2);
  eepromEscribeNumero(0x0009, 0x0000, 2);
  eepromEscribeNumero(0x000B, 0x00, 1);
  banderaReset = false;
  }
 }

void indicadorSensores(){
 estado1 = SENSOR1;
 estado2 = SENSOR2;
 estado3 = SENSOR3;
 estado4 = SENSOR4;
 estado5 = SENSOR5;
 estado6 = SENSOR6;

 bytetostr(estado1, aux1);
 bytetostr(estado2, aux2);
 bytetostr(estado3, aux3);
 bytetostr(estado4, aux4);
 bytetostr(estado5, aux5);
 bytetostr(estado6, aux6);

 lcd_out(1,5,aux1);
 lcd_outConst(1,5,"1:");
 lcd_out(1,1,aux2);
 lcd_outConst(1,1,"2:");
 lcd_out(2,5,aux3);
 lcd_outConst(2,5,"3:");
 lcd_out(2,1,aux4);
 lcd_outConst(2,1,"4:");
 lcd_out(4,5,aux5);
 lcd_outConst(4,5,"5:");
 lcd_out(4,1,aux6);
 lcd_outConst(4,1,"6:");
 }


void MASTER(){
 //WDTCON.SWDTEN = 1;
 resetCuentas();
 //WDTCON.SWDTEN = 0;
 //WDTCON.SWDTEN = 1;
 SENSADO();
 //WDTCON.SWDTEN = 0;
 //WDTCON.SWDTEN = 1;
 TX_MSTR();
 //WDTCON.SWDTEN = 0;
 //WDTCON.SWDTEN = 1;
 indicadorSensores();
 //WDTCON.SWDTEN = 0;
 //WDTCON.SWDTEN = 1;
 //UARTTX_WiolTE();
 serialTxWioLTE();
 //WDTCON.SWDTEN = 0;
 }

void SLV(){
 resetSLV();
 SENSADO();
 TX_SLV();
 indicadorSensores();
 }