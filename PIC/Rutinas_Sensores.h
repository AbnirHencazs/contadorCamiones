//ESTADOS/
#define ESPERA                     0
#define ENTRANDO                   1
#define TRANSICION                 2
#define TRANSICIONS                8
#define TRANENT                    7
#define ENTRO                      3
#define SALIENDO                   4
#define TRANSAL                    5
#define SALIO                      6

//LIBRERIAS
#include "lcd_4x20.h"
#include "eepromi2cBrian_v2.h"

//Variables
char            auxS[12] = {0}, auxB[12] = {0}, auxP[12] = {0}, auxBloq[12] = {0};
short           debugEstado = 0, debugEstadoB = 0;
unsigned int    lecturaTablaS = 0, lecturaTablaB = 0, pVerdaderosMEntero = 0, pVerdaderosEEntero = 0, pasajerosTotalesL = 0, lecturaTablaPVerdaderos = 0;
unsigned int    pBajan = 0, pSuben = 0;
float           pasajerosVerdaderos = 0;
short           cuentaBloqueo = 0;

/************************************************************************************************************************/
/***************************************************CONJUNTO FUNCIONES***************************************************/
/************************************************************************************************************************/

void  sensorNoBloqueo();
short espera(short);
short entrando(short);
short transicionE(short);
short transicionEnt(short);
short entro(short);
short saliendo(short);
short transicionS(short);
short transicionSal(short);
short salio(short);

void  sensorBloqueo();
short esperaB(short);
short entrandoB(short);
short transicionEB(short);
short transicionEntB(short);
short entroB(short);
short saliendoB(short);
short transicionSB(short);
short transicionSalB(short);
short salioB(short);

void sensorBloqueoD();
short esperaBD(short);
short entrandoBD(short);
short transicionEBD(short);
short transicionEntBD(short);
short entroBD(short);
short saliendoBD(short);
short transicionSBD(short);
short transicionSalBD(short);
short salioBD(short);

void sensorBloqueoT();
short esperaBT(short);
short entrandoBT(short);
short transicionEBT(short);
short transicionEntBT(short);
short entroBT(short);
short saliendoBT(short);
short transicionSBT(short);
short transicionSalBT(short);
short salioBT(short);

void sensorBloqueoC();
short esperaBC(short);
short entrandoBC(short);
short transicionEBC(short);
short transicionEntBC(short);
short entroBC(short);
short saliendoBC(short);
short transicionSBC(short);
short transicionSalBC(short);
short salioBC(short);

void sensorBloqueoO();
short esperaBO(short);
short entrandoBO(short);
short transicionEBO(short);
short transicionEntBO(short);
short entroBO(short);
short saliendoBO(short);
short transicionSBO(short);
short transicionSalBO(short);
short salioBO(short);

void sensorBloqueoS();
short esperaBS(short);
short entrandoBS(short);
short transicionEBS(short);
short transicionEntBS(short);
short entroBS(short);
short saliendoBS(short);
short transicionSBS(short);
short transicionSalBS(short);
short salioBS(short);

void  sensorBloqueoPar1();
short esperaBP1(short);
short entrandoBP1(short);
short transicionEBP1(short);
short transicionEntBP1(short);
short entroBP1(short);
short saliendoBP1(short);
short transicionSBP1(short);
short transicionSalBP1(short);
short salioBP1(short);

void  sensorBloqueoPar2();
short esperaBP2(short);
short entrandoBP2(short);
short transicionEBP2(short);
short transicionEntBP2(short);
short entroBP2(short);
short saliendoBP2(short);
short transicionSBP2(short);
short transicionSalBP2(short);
short salioBP2(short);

void  sensorBloqueoPar3();
short esperaBP3(short);
short entrandoBP3(short);
short transicionEBP3(short);
short transicionEntBP3(short);
short entroBP3(short);
short saliendoBP3(short);
short transicionSBP3(short);
short transicionSalBP3(short);
short salioBP3(short);

void  sensorBloqueoPar4();
short esperaBP4(short);
short entrandoBP4(short);
short transicionEBP4(short);
short transicionEntBP4(short);
short entroBP4(short);
short saliendoBP4(short);
short transicionSBP4(short);
short transicionSalBP4(short);
short salioBP4(short);

void  sensorBloqueoPar6();
short esperaBP6(short);
short entrandoBP6(short);
short transicionEBP6(short);
short transicionEntBP6(short);
short entroBP6(short);
short saliendoBP6(short);
short transicionSBP6(short);
short transicionSalBP6(short);
short salioBP6(short);

void  sensorBloqueoPar7();
short esperaBP7(short);
short entrandoBP7(short);
short transicionEBP7(short);
short transicionEntBP7(short);
short entroBP7(short);
short saliendoBP7(short);
short transicionSBP7(short);
short transicionSalBP7(short);
short salioBP7(short);

void  sensorBloqueoPar9();
short esperaBP9(short);
short entrandoBP9(short);
short transicionEBP9(short);
short transicionEntBP9(short);
short entroBP9(short);
short saliendoBP9(short);
short transicionSBP9(short);
short transicionSalBP9(short);
short salioBP9(short);

/************************************************************************************************************************/
/***************************************************CONJUNTO NO BLOQUEO**************************************************/
/************************************************************************************************************************/

void sensorNoBloqueo(){
 espera(debugEstado);
  entrando(debugEstado);
  transicionE(debugEstado);
  transicionEnt(debugEstado);
  entro(debugEstado);
  saliendo(debugEstado);
  transicionS(debugEstado);
  transicionSal(debugEstado);
  salio(debugEstado);
 }
 
 /************************************************************************************************************************/
/***************************************************CONJUNTO BLOQUEO*****************************************************/
/************************************************************************************************************************/
/*
void sensorBloqueo(){
 if(!Bandera.Par1){
  esperaB(debugEstadoB);
  entrandoB(debugEstadoB);
  transicionEB(debugEstadoB);
  transicionEntB(debugEstadoB);
  entroB(debugEstadoB);
  saliendoB(debugEstadoB);
  transicionSB(debugEstadoB);
  transicionSalB(debugEstadoB);
  salioB(debugEstadoB);
  }
 }

void sensorBloqueoD(){
 if(!Bandera.Par1){
  esperaBD(debugEstadoB);
  entrandoBD(debugEstadoB);
  transicionEBD(debugEstadoB);
  transicionEntBD(debugEstadoB);
  entroBD(debugEstadoB);
  saliendoBD(debugEstadoB);
  transicionSBD(debugEstadoB);
  transicionSalBD(debugEstadoB);
  salioBD(debugEstadoB);
  }
 }

void sensorBloqueoT(){
 if(!Bandera.Par2){
  esperaBT(debugEstadoB);
  entrandoBT(debugEstadoB);
  transicionEBT(debugEstadoB);
  transicionEntBT(debugEstadoB);
  entroBT(debugEstadoB);
  saliendoBT(debugEstadoB);
  transicionSBT(debugEstadoB);
  transicionSalBT(debugEstadoB);
  salioBT(debugEstadoB);
  }
 }

void sensorBloqueoC(){
 if(!Bandera.Par2){
  esperaBC(debugEstadoB);
  entrandoBC(debugEstadoB);
  transicionEBC(debugEstadoB);
  transicionEntBC(debugEstadoB);
  entroBC(debugEstadoB);
  saliendoBC(debugEstadoB);
  transicionSBC(debugEstadoB);
  transicionSalBC(debugEstadoB);
  salioBC(debugEstadoB);
  }
 }

void sensorBloqueoO(){
 if(!Bandera.Par3){
  esperaBO(debugEstadoB);
  entrandoBO(debugEstadoB);
  transicionEBO(debugEstadoB);
  transicionEntBO(debugEstadoB);
  entroBO(debugEstadoB);
  saliendoBO(debugEstadoB);
  transicionSBO(debugEstadoB);
  transicionSalBO(debugEstadoB);
  salioBO(debugEstadoB);
  }
 }

void sensorBloqueoS(){
 if(!Bandera.Par3){
  esperaBS(debugEstadoB);
  entrandoBS(debugEstadoB);
  transicionEBS(debugEstadoB);
  transicionEntBS(debugEstadoB);
  entroBS(debugEstadoB);
  saliendoBS(debugEstadoB);
  transicionSBS(debugEstadoB);
  transicionSalBS(debugEstadoB);
  salioBS(debugEstadoB);
  }
 } */

void sensorBloqueoPar1(){
 esperaBP1(debugEstadoB);
 entrandoBP1(debugEstadoB);
 transicionEBP1(debugEstadoB);
 transicionEntBP1(debugEstadoB);
 entroBP1(debugEstadoB);
 saliendoBP1(debugEstadoB);
 transicionSBP1(debugEstadoB);
 transicionSalBP1(debugEstadoB);
 salioBP1(debugEstadoB);
 }

void sensorBloqueoPar2(){
 esperaBP2(debugEstadoB);
 entrandoBP2(debugEstadoB);
 transicionEBP2(debugEstadoB);
 transicionEntBP2(debugEstadoB);
 entroBP2(debugEstadoB);
 saliendoBP2(debugEstadoB);
 transicionSBP2(debugEstadoB);
 transicionSalBP2(debugEstadoB);
 salioBP2(debugEstadoB);
 }

void sensorBloqueoPar3(){
 esperaBP3(debugEstadoB);
 entrandoBP3(debugEstadoB);
 transicionEBP3(debugEstadoB);
 transicionEntBP3(debugEstadoB);
 entroBP3(debugEstadoB);
 saliendoBP3(debugEstadoB);
 transicionSBP3(debugEstadoB);
 transicionSalBP3(debugEstadoB);
 salioBP3(debugEstadoB);
 }

void sensorBloqueoPar4(){
 esperaBP4(debugEstadoB);
 entrandoBP4(debugEstadoB);
 transicionEBP4(debugEstadoB);
 transicionEntBP4(debugEstadoB);
 entroBP4(debugEstadoB);
 saliendoBP4(debugEstadoB);
 transicionSBP4(debugEstadoB);
 transicionSalBP4(debugEstadoB);
 salioBP4(debugEstadoB);
 }

void sensorBloqueoPar6(){
 esperaBP6(debugEstadoB);
 entrandoBP6(debugEstadoB);
 transicionEBP6(debugEstadoB);
 transicionEntBP6(debugEstadoB);
 entroBP6(debugEstadoB);
 saliendoBP6(debugEstadoB);
 transicionSBP6(debugEstadoB);
 transicionSalBP6(debugEstadoB);
 salioBP6(debugEstadoB);
 }

void sensorBloqueoPar7(){
 esperaBP7(debugEstadoB);
 entrandoBP7(debugEstadoB);
 transicionEBP7(debugEstadoB);
 transicionEntBP7(debugEstadoB);
 entroBP7(debugEstadoB);
 saliendoBP7(debugEstadoB);
 transicionSBP7(debugEstadoB);
 transicionSalBP7(debugEstadoB);
 salioBP7(debugEstadoB);
 }

 void sensorBloqueoPar9(){
 esperaBP9(debugEstadoB);
 entrandoBP9(debugEstadoB);
 transicionEBP9(debugEstadoB);
 transicionEntBP9(debugEstadoB);
 entroBP9(debugEstadoB);
 saliendoBP9(debugEstadoB);
 transicionSBP9(debugEstadoB);
 transicionSalBP9(debugEstadoB);
 salioBP9(debugEstadoB);
 }
 
 /************************************************************************************************************************/
/***************************************************RUTINA SIN BLOQUEO***************************************************/
/************************************************************************************************************************/

short espera(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1, 16, auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2, 16, auxB);
  pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
  pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
  eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
  lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
  bytetostr(lecturaTablaPVerdaderos, auxP);
  lcd_out(4, 17, auxP);
  bytetostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 16, auxBloq);
  lcd_outConst(4, 10, "Pasaje:");
  lcd_outConst(1, 10, "SUBEN:");
  lcd_outConst(2, 10, "BAJAN:");
  LCD_OUTCONST(3, 1, "ESPERA");
  lcd_outConst(3, 10, "BLOCK:");
  if(!SENSOR1 | !SENSOR3 | !SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = ENTRANDO;
   }
  if(!SENSOR2 | !SENSOR4 | !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = SALIENDO;
   }
  }
 }

short entrando(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = ESPERA;
   }
  if(((!SENSOR2 & !SENSOR4) & (!SENSOR1 & !SENSOR3 & !SENSOR5)) | ((!SENSOR4 & !SENSOR6) & (!SENSOR1 & !SENSOR3 & !SENSOR5)) | ((!SENSOR2 & !SENSOR6) & (!SENSOR1 & !SENSOR3 & !SENSOR5))){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = TRANSICION;
   }
  }
 }

short transicionE(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICIONE");
  if( ( (SENSOR1 & SENSOR3 & SENSOR5)& (!SENSOR2 & SENSOR4) ) | ( (SENSOR1 & SENSOR3 & SENSOR5)& (!SENSOR4 & SENSOR6) ) | ( (SENSOR1 & SENSOR3 & SENSOR5) & (!SENSOR2 & SENSOR6) ) ){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = TRANENT;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = ENTRANDO;
   }
  }
 }

short transicionEnt(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 | !SENSOR1 | !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = TRANSICION;
   }
  if(SENSOR2 & SENSOR4 & SENSOR6 & SENSOR1 & SENSOR3 & SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = ENTRO;
   }
  }
 }

short entro(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(300);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  pSuben = eepromLeeNumero(0x0000, 2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstado = ESPERA;
  }
 }

short saliendo(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if(((!SENSOR1 & !SENSOR3) & (!SENSOR2 & !SENSOR4 & !SENSOR6)) | ((!SENSOR3 & !SENSOR5) & (!SENSOR2 & !SENSOR4 & !SENSOR6)) | ((!SENSOR1 & !SENSOR5) & (!SENSOR2 & !SENSOR4 & !SENSOR6))){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = ESPERA;
   }
  }
 }

short transicionS(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION S");
  if( ( (SENSOR2 & SENSOR4 & SENSOR6)& (!SENSOR1 & SENSOR3) ) | ( (SENSOR2 & SENSOR4 & SENSOR6)& (!SENSOR3 & SENSOR5) ) | ( (SENSOR2 & SENSOR4 & SENSOR6) & (!SENSOR3 & SENSOR5) ) ){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = TRANSAL;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = SALIENDO;
   }
  }
 }

short transicionSal(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 | !SENSOR4 | !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = TRANSICIONS;
   }
  if(SENSOR1 & SENSOR3 & SENSOR5 & SENSOR2 & SENSOR4 & SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = SALIO;
   }
  }
 }

short salio(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000, 2);
  pBajan = eepromLeeNumero(0x0003, 2) + 1;
  eepromEscribeNumero(0x0003 ,pBajan, 2);
  pBajan = eepromLeeNumero(0x0003, 2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstado = ESPERA;
  }
 }

/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR UNO*******************************************/
/************************************************************************************************************************/

 short esperaB(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1,9,auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2,9,auxB);
  lcd_outConst(4,14,"Pasaje");
  lcd_outConst(1,15,"SUBEN");
  lcd_outConst(2,15,"BAJAN");
  LCD_OUTCONST(3,1,"ESPERA");
  lcd_outConst(3,15, "BLQS");
  floattostr(pasajerosVerdaderos, auxP);
  lcd_out(4,12,auxp);
  shorttostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 9, auxBloq);
  if((!SENSOR3 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoB(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEB(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntB(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroB(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

short saliendoB(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR3 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSB(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR3 & SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalB(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 & !SENSOR4 & !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioB(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR DOS*******************************************/
/************************************************************************************************************************/

short esperaBD(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1,9,auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2,9,auxB);
  lcd_outConst(4,14,"Pasaje");
  lcd_outConst(1,15,"SUBEN");
  lcd_outConst(2,15,"BAJAN");
  LCD_OUTCONST(3,1,"ESPERA");
  lcd_outConst(3,15, "BLQS");
  floattostr(pasajerosVerdaderos, auxP);
  lcd_out(4,12,auxp);
  shorttostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 9, auxBloq);
  if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR4 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBD(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR4 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBD(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR4 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBD(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 & !SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBD(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBD(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBD(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if((SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBD(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR4 & !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBD(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

 /***********************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR TRES******************************************/
/************************************************************************************************************************/

short esperaBT(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1,9,auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2,9,auxB);
  lcd_outConst(4,14,"Pasaje");
  lcd_outConst(1,15,"SUBEN");
  lcd_outConst(2,15,"BAJAN");
  LCD_OUTCONST(3,1,"ESPERA");
  lcd_outConst(3,15, "BLQS");
  floattostr(pasajerosVerdaderos, auxP);
  lcd_out(4,12,auxp);
  shorttostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 9, auxBloq);
  if((!SENSOR1 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBT(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBT(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBT(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBT(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBT(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBT(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBT(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 & !SENSOR4 & !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBT(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR CUATRO****************************************/
/************************************************************************************************************************/

short esperaBC(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1,9,auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2,9,auxB);
  lcd_outConst(4,14,"Pasaje");
  lcd_outConst(1,15,"SUBEN");
  lcd_outConst(2,15,"BAJAN");
  LCD_OUTCONST(3,1,"ESPERA");
  lcd_outConst(3,15, "BLQS");
  floattostr(pasajerosVerdaderos, auxP);
  lcd_out(4,12,auxp);
  shorttostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 9, auxBloq);
  if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBC(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBC(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBC(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 & !SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBC(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBC(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBC(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if((SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBC(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 & !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBC(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }
 
/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR CINCO*****************************************/
/************************************************************************************************************************/

short esperaBO(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1,9,auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2,9,auxB);
  lcd_outConst(4,14,"Pasaje");
  lcd_outConst(1,15,"SUBEN");
  lcd_outConst(2,15,"BAJAN");
  LCD_OUTCONST(3,1,"ESPERA");
  lcd_outConst(3,15, "BLQS");
  floattostr(pasajerosVerdaderos, auxP);
  lcd_out(4,12,auxp);
  shorttostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 9, auxBloq);
  if((!SENSOR1 | !SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBO(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1 & SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBO(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR1 & SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBO(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 & !SENSOR1)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBO(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBO(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBO(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR3 & !SENSOR2) | (SENSOR1 & SENSOR3 & !SENSOR4) | (SENSOR1 & SENSOR3 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBO(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 & !SENSOR4 & !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBO(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }
 
/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR SEIS******************************************/
/************************************************************************************************************************/

short esperaBS(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1,9,auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2,9,auxB);
  lcd_outConst(4,14,"Pasaje");
  lcd_outConst(1,15,"SUBEN");
  lcd_outConst(2,15,"BAJAN");
  LCD_OUTCONST(3,1,"ESPERA");
  lcd_outConst(3,15, "BLQS");
  floattostr(pasajerosVerdaderos, auxP);
  lcd_out(4,12,auxp);
  shorttostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 9, auxBloq);
  if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBS(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO DEBUG");
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBS(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR4 & !SENSOR1) | (SENSOR2 & SENSOR4 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBS(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 & !SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBS(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBS(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBS(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION DEBUG");
  if((SENSOR2 & SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBS(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 & !SENSOR4){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBS(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  lcd_cmd(_LCD_CLEAR);
  pasajerosVerdaderos = (pSuben + pBajan)/2;
  return debugEstadoB = ESPERA;
  }
 }

/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR PAR_UNO***************************************/
/************************************************************************************************************************/

short esperaBP1(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1, 16, auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2, 16, auxB);
  pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
  pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
  eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
  lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
  bytetostr(lecturaTablaPVerdaderos, auxP);
  lcd_out(4, 17, auxP);
  bytetostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 16, auxBloq);
  lcd_outConst(4, 10, "Pasaje:");
  lcd_outConst(1, 10, "SUBEN:");
  lcd_outConst(2, 10, "BAJAN:");
  LCD_OUTCONST(3, 10, "ESPERA");
  lcd_outConst(3, 10, "BLOCK:");
  if((!SENSOR3 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR4 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBP1(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR4 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBP1(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR4 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBP1(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBP1(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  pSuben = eepromLeeNumero(0x0000,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBP1(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR3 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBP1(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if((SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR3 & SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBP1(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR4 & !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBP1(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  pBajan = eepromLeeNumero(0x0003,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR PAR_DOS***************************************/
/************************************************************************************************************************/

short esperaBP2(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1, 16, auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2, 16, auxB);
  pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
  pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
  eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
  lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
  bytetostr(lecturaTablaPVerdaderos, auxP);
  lcd_out(4, 17, auxP);
  bytetostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 16, auxBloq);
  lcd_outConst(4, 10, "Pasaje:");
  lcd_outConst(1, 10, "SUBEN:");
  lcd_outConst(2, 10, "BAJAN:");
  LCD_OUTCONST(3, 10, "ESPERA");
  lcd_outConst(3, 10, "BLOCK:");
  if((!SENSOR1 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBP2(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBP2(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBP2(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBP2(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  pSuben = eepromLeeNumero(0x0000,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBP2(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBP2(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if((SENSOR2 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBP2(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 & !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBP2(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  pBajan = eepromLeeNumero(0x0003,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }
 
/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR PAR_TRES**************************************/
/************************************************************************************************************************/

short esperaBP3(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1, 16, auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2, 16, auxB);
  pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
  pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
  eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
  lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
  bytetostr(lecturaTablaPVerdaderos, auxP);
  lcd_out(4, 17, auxP);
  bytetostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 16, auxBloq);
  lcd_outConst(4, 10, "Pasaje:");
  lcd_outConst(1, 10, "SUBEN:");
  lcd_outConst(2, 10, "BAJAN:");
  LCD_OUTCONST(3, 10, "ESPERA");
  lcd_outConst(3, 10, "BLOCK:");
  if((!SENSOR1 | !SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBP3(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO DEBUG");
  if((SENSOR1 & SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBP3(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if((SENSOR1 & SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR4 & !SENSOR1) | (SENSOR2 & SENSOR4 & !SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBP3(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 & !SENSOR1)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBP3(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  pSuben = eepromLeeNumero(0x0000,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBP3(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBP3(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION DEBUG");
  if((SENSOR2 & SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR3 & !SENSOR2) | (SENSOR1 & SENSOR3 & !SENSOR4)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBP3(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 & !SENSOR4 ){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR3)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBP3(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  pBajan = eepromLeeNumero(0x0003,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR PAR_CUATRO************************************/
/************************************************************************************************************************/

short esperaBP4(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1, 16, auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2, 16, auxB);
  pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
  pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
  eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
  lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
  bytetostr(lecturaTablaPVerdaderos, auxP);
  lcd_out(4, 17, auxP);
  bytetostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 16, auxBloq);
  lcd_outConst(4, 10, "Pasaje:");
  lcd_outConst(1, 10, "SUBEN:");
  lcd_outConst(2, 10, "BAJAN:");
  LCD_OUTCONST(3, 10, "ESPERA");
  lcd_outConst(3, 10, "BLOCK:");
  if((!SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBP4(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBP4(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if(SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBP4(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(SENSOR2 & SENSOR4 & SENSOR6 & SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBP4(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  pSuben = eepromLeeNumero(0x0000,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBP4(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if(!SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBP4(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if(SENSOR2 & SENSOR4 & SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR5 & !SENSOR2) | (SENSOR5 & !SENSOR4) | (SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBP4(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 | !SENSOR4 | !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR5) & (SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBP4(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  pBajan = eepromLeeNumero(0x0003,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR PAR_SEIS**************************************/
/************************************************************************************************************************/

short esperaBP6(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1, 16, auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2, 16, auxB);
  pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
  pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
  eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
  lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
  bytetostr(lecturaTablaPVerdaderos, auxP);
  lcd_out(4, 17, auxP);
  bytetostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 16, auxBloq);
  lcd_outConst(4, 10, "Pasaje:");
  lcd_outConst(1, 10, "SUBEN:");
  lcd_outConst(2, 10, "BAJAN:");
  LCD_OUTCONST(3, 10, "ESPERA");
  lcd_outConst(3, 10, "BLOCK:");
  if(!SENSOR1){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBP6(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBP6(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if(SENSOR1){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBP6(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR1)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(SENSOR2 & SENSOR4 & SENSOR6 & SENSOR1){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBP6(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  pSuben = eepromLeeNumero(0x0000,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBP6(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if(!SENSOR1){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBP6(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if(SENSOR2 & SENSOR4 & SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & !SENSOR2) | (SENSOR1 & !SENSOR4) | (SENSOR1 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBP6(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 | !SENSOR4 | !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1) & (SENSOR2 & SENSOR4 & SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBP6(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  pBajan = eepromLeeNumero(0x0003,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }
 
/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR PAR_SIETE*************************************/
/************************************************************************************************************************/

short esperaBP7(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1, 16, auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2, 16, auxB);
  pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
  pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
  eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
  lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
  bytetostr(lecturaTablaPVerdaderos, auxP);
  lcd_out(4, 17, auxP);
  bytetostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 16, auxBloq);
  lcd_outConst(4, 10, "Pasaje:");
  lcd_outConst(1, 10, "SUBEN:");
  lcd_outConst(2, 10, "BAJAN:");
  LCD_OUTCONST(3, 10, "ESPERA");
  lcd_outConst(3, 10, "BLOCK:");
  if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBP7(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if(!SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBP7(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if(SENSOR1 & SENSOR3 & SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = TRANENT;
   }
  if((SENSOR6 & !SENSOR1) | (SENSOR6 & !SENSOR3) | (SENSOR6 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstado = ENTRANDO;
   }
  }
 }

short transicionEntBP7(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 | !SENSOR1 | !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(SENSOR6 & SENSOR1 & SENSOR3 & SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBP7(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  pSuben = eepromLeeNumero(0x0000,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBP7(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBP7(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if(SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBP7(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5) & (SENSOR6)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBP7(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  pBajan = eepromLeeNumero(0x0003,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }
 
/************************************************************************************************************************/
/***************************************************RUTINAS BLOQUEO SENSOR PAR_NUEVE*************************************/
/************************************************************************************************************************/

short esperaBP9(short estado){
 if(estado == ESPERA){
  lecturaTablaS = eepromLeeNumero(0x0000,2);
  bytetostr(lecturaTablaS, auxS);
  lcd_out(1, 16, auxS);
  lecturaTablaB = eepromLeeNumero(0x0003,2);
  bytetostr(lecturaTablaB, auxB);
  lcd_out(2, 16, auxB);
  pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
  pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
  pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
  eepromEscribeNumero(0x0005, pasajerosTotalesL, 2);
  lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
  bytetostr(lecturaTablaPVerdaderos, auxP);
  lcd_out(4, 17, auxP);
  bytetostr(cuentaBloqueo, auxBloq);
  lcd_out(3, 16, auxBloq);
  lcd_outConst(4, 10, "Pasaje:");
  lcd_outConst(1, 10, "SUBEN:");
  lcd_outConst(2, 10, "BAJAN:");
  LCD_OUTCONST(3, 10, "ESPERA");
  lcd_outConst(3, 10, "BLOCK:");
  if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  if((!SENSOR2)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short entrandoBP9(short estado){
 if(estado == ENTRANDO){
  LCD_OUTCONST(3,1,"ENTRANDO");
  if((SENSOR1 & SENSOR3 & SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  if(!SENSOR2){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  }
 }

short transicionEBP9(short estado){
 if(estado == TRANSICION){
  LCD_OUTCONST(3,1,"TRANSICION");
  if(SENSOR1 & SENSOR3 & SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANENT;
   }
  if((SENSOR2 & !SENSOR1) | (SENSOR2 & !SENSOR3) | (SENSOR2 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRANDO;
   }
  }
 }

short transicionEntBP9(short estado){
 if(estado == TRANENT){
  LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
  if((!SENSOR3 | !SENSOR1 | !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICION;
   }
  if(SENSOR2 & SENSOR1 & SENSOR3 & SENSOR5){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ENTRO;
   }
  }
 }

short entroBP9(short estado){
 if(estado == ENTRO){
  LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
  delay_ms(350);
  pBajan = eepromLeeNumero(0x0003,2);
  pSuben = eepromLeeNumero(0x0000,2) + 1;
  eepromEscribeNumero(0x0000,pSuben,2);
  pSuben = eepromLeeNumero(0x0000,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }

short saliendoBP9(short estado){
 if(estado == SALIENDO){
  lcd_outConst(3, 1, "SALIENDO");
  if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR2)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = ESPERA;
   }
  }
 }

short transicionSBP9(short estado){
 if(estado == TRANSICIONS){
  lcd_outConst(3, 1, "TRANSICION");
  if(SENSOR2){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSAL;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIENDO;
   }
  }
 }

short transicionSalBP9(short estado){
 if(estado == TRANSAL){
  LCD_OUTCONST(3,1,"TRANSICION SALIDA");
  if(!SENSOR2 | !SENSOR4 | !SENSOR6){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = TRANSICIONS;
   }
  if((SENSOR1 & SENSOR3 & SENSOR5) & (SENSOR2)){
   lcd_cmd(_LCD_CLEAR);
   return debugEstadoB = SALIO;
   }
  }
 }

short salioBP9(short estado){
 if(estado == SALIO){
  LCD_OUTCONST(3,1,"GRACIAS!");
  pSuben = eepromLeeNumero(0x0000,2);
  pBajan = eepromLeeNumero(0x0003,2) + 1;
  eepromEscribeNumero(0x0003,pBajan,2);
  pBajan = eepromLeeNumero(0x0003,2);
  pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
  eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
  lcd_cmd(_LCD_CLEAR);
  return debugEstadoB = ESPERA;
  }
 }