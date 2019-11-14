#line 1 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
#line 42 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
 sbit SENSOR1 at PORTB.B4;
 sbit SENSOR1D at TRISB.B4;
 sbit SENSOR2 at PORTD.B4;
 sbit SENSOR2D at TRISD.B4;
 sbit SENSOR3 at PORTB.B2;
 sbit SENSOR3D at TRISB.B2;
 sbit SENSOR4 at PORTB.B3;
 sbit SENSOR4D at TRISB.B3;
 sbit SENSOR5 at PORTB.B0;
 sbit SENSOR5D at TRISB.B0;
 sbit SENSOR6 at PORTB.B1;
 sbit SENSOR6D at TRISB.B1;

sbit LCD_RS at PORTE.B2;
sbit LCD_RS_Direction at TRISE.B2;
sbit LCD_EN at PORTA.B3;
sbit LCD_EN_Direction at TRISA.B3;
sbit LCD_D4 at PORTA.B4;
sbit LCD_D4_Direction at TRISA.B4;
sbit LCD_D5 at PORTA.B2;
sbit LCD_D5_Direction at TRISA.B2;
sbit LCD_D6 at PORTA.B1;
sbit LCD_D6_Direction at TRISA.B1;
sbit LCD_D7 at PORTA.B0;
sbit LCD_D7_Direction at TRISA.B0;

sfr sbit I2C_SCL at PORTD.B7;
sfr sbit I2C_SCLD at TRISD.B7;
sfr sbit I2C_SDA at PORTD.B6;
sfr sbit I2C_SDAD at TRISD.B6;

sbit POLARIZACION at PORTC.B2;
sbit POLARIZACIOND at TRISC.B2;
sbit BLOQUEOACTIVO at PORTC.B3;
sbit BLOQUEOACTIVOD at TRISC.B3;
sbit SENSORESDEBUG at PORTC.B4;
sbit SENSORESDEBUGD at TRISC.B4;


sbit TX_PIC at PORTC.B6;
sbit TX_PICD at TRISC.B6;
sbit RX_PIC at PORTC.B7;
sbit RX_PICD at TRISC.B7;

sbit RESET_BOTON at PORTD.B1;
sbit RESET_BOTOND at TRISD.B1;

sbit MSTR at PORTD.B2;
sbit MSTRD at TRISD.B2;
#line 1 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/lcd_4x20.h"



extern sfr sbit LCD_D4;
extern sfr sbit LCD_D4_Direction;
extern sfr sbit LCD_D5;
extern sfr sbit LCD_D5_Direction;
extern sfr sbit LCD_D6;
extern sfr sbit LCD_D6_Direction;
extern sfr sbit LCD_D7;
extern sfr sbit LCD_D7_Direction;
extern sfr sbit LCD_RS;
extern sfr sbit LCD_RS_Direction;
extern sfr sbit LCD_EN;
extern sfr sbit LCD_EN_Direction;
#line 30 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/lcd_4x20.h"
void lcd_send_nibble(char nibble){
 LCD_D4 = nibble.B0;
 LCD_D5 = nibble.B1;
 LCD_D6 = nibble.B2;
 LCD_D7 = nibble.B3;
 asm nop;
 asm nop;
 LCD_EN = 1;
 delay_us(2);
 LCD_EN = 0;
}

void lcd_send_byte(char address, char enviar){
 LCD_RS = 0;
 delay_us(60);

 if(address)
 LCD_RS = 1;
 else
 LCD_RS = 0;
 asm nop;


 LCD_EN = 0;

 lcd_send_nibble(swap(enviar));
 lcd_send_nibble(enviar);
}

void lcd_init(){
 char i;


 LCD_D4_Direction = 0;
 LCD_D5_Direction = 0;
 LCD_D6_Direction = 0;
 LCD_D7_Direction = 0;
 LCD_RS_Direction = 0;
 LCD_EN_Direction = 0;


 LCD_RS = 0;
 LCD_EN = 0;

 delay_ms(15);

 for(i = 0; i < 3; i++){
 lcd_send_nibble(0x03);
 delay_ms(5);
 }

 lcd_send_nibble(0x02);

 lcd_send_byte(0, 0x28);
 delay_ms(5);
 lcd_send_byte(0, 0x0C);
 delay_ms(5);
 lcd_send_byte(0, 0x01);
 delay_ms(5);
 lcd_send_byte(0, 0x06);
 delay_ms(5);
}

void lcd_gotoxy(char fila, char col){
 if(fila == 1)
 fila =  0x00 ;
 else if(fila == 2)
 fila =  0x40 ;
 else if(fila == 3)
 fila =  0x14 ;
 else if(fila == 4)
 fila =  0x54 ;
 else
 fila =  0x00 ;

 fila += (col-1);
 fila |= 0x80;

 lcd_send_byte(0, fila);
}

void lcd_chr(char fila, char col, char c){
 lcd_gotoxy(fila, col);
 lcd_send_byte(1, c);
}

void lcd_out(char fila, char col, char *texto){
 char cont = 0;

 lcd_gotoxy(fila, col);
 while(texto[cont])
 lcd_send_byte(1, texto[cont++]);
}

void lcd_outConst(char fila, char col, const char *texto){
 char cont = 0;

 lcd_gotoxy(fila, col);
 while(texto[cont])
 lcd_send_byte(1, texto[cont++]);
}

void lcd_cmd(char comando){
 lcd_send_byte(0, comando);
 delay_ms(2);
}
#line 1 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/bloqueos_v1.h"





struct Bloqueo{
  char  Par1;
  char  Par2;
  char  Par3;
  char  Par4;
  char  Par5;
  char  Par6;
  char  par7;
  char  par8;
  char  par9;
  char  SensorU;
  char  SensorD;
  char  SensorT;
  char  SensorC;
  char  SensorO;
  char  SensorS;
 }Bandera;

struct bloqueoD{
 unsigned int Par1;
 unsigned int Par2;
 unsigned int Par3;
 unsigned int Par4;
 unsigned int Par5;
 unsigned int Par6;
 unsigned int par7;
 unsigned int par8;
 unsigned int par9;
 unsigned int SensorU;
 unsigned int SensorD;
 unsigned int SensorT;
 unsigned int SensorC;
 unsigned int SensorO;
 unsigned int SensorS;
 }Desborde;

unsigned int desbordoGPS = 0, desbordoGPS_SLV = 0;
 char  EnvioCuenta =  0 , cuenta =  0 ;

void bloqueos( char  SENSOR1,  char  SENSOR2,  char  SENSOR3,  char  SENSOR4,  char  SENSOR5,  char  SENSOR6, short *cuentaBloqueo){
 char aux[12] = {0};

 if(!SENSOR1 & SENSOR2){
 Desborde.SensorU = Desborde.SensorU++;
 if(Desborde.SensorU >  8 ){
 if(!Bandera.SensorU & !Bandera.Par1){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.SensorU =  1 ;
 Desborde.SensorU = 0;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else{
 Bandera.SensorU =  0 ;
 Desborde.SensorU = 0;
 }

 if(!SENSOR2 & SENSOR1){
 Desborde.SensorD = Desborde.SensorD++;
 if(Desborde.SensorD >  8 ){
 if(!Bandera.SensorD & !Bandera.Par1){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.SensorD =  1 ;
 Desborde.SensorD = 0;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else{
 Bandera.SensorD =  0 ;
 Desborde.SensorD = 0;
 }

 if(!SENSOR3 & SENSOR4){
 Desborde.SensorT = Desborde.SensorT++;
 if(Desborde.SensorT >  8 ){
 if(!Bandera.SensorT & !Bandera.Par2){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.SensorT =  1 ;
 Desborde.SensorT = 0;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else{
 Bandera.SensorT =  0 ;
 Desborde.SensorT = 0;
 }

 if(!SENSOR4 & SENSOR3){
 Desborde.SensorC = Desborde.SensorC++;
 if(Desborde.SensorC >  8 ){
 if(!Bandera.SensorC & !Bandera.Par2){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.SensorC =  1 ;
 Desborde.SensorC = 0;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else{
 Bandera.SensorC =  0 ;
 Desborde.SensorC = 0;
 }

 if(!SENSOR5 & SENSOR6){
 Desborde.SensorO = Desborde.SensorO++;
 if(Desborde.SensorO >  8 ){
 if(!Bandera.SensorO & !Bandera.Par3){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.SensorO =  1 ;
 Desborde.SensorO = 0;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else{
 Bandera.SensorO =  0 ;
 Desborde.SensorO = 0;
 }

 if(!SENSOR6 & SENSOR5){
 Desborde.SensorS = Desborde.SensorS++;
 if(Desborde.SensorS >  8 ){
 if(!Bandera.SensorS & !Bandera.Par3){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.SensorS =  1 ;
 Desborde.SensorS = 0;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else{
 Bandera.SensorS =  0 ;
 Desborde.SensorS = 0;
 }

 if(!SENSOR1 & !SENSOR2){
 Desborde.Par1 = Desborde.Par1++;
 if(Desborde.Par1 >  8 ){
 if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 cuenta =  1 ;
 Bandera.Par1 =  1 ;
 Desborde.Par1 = 0;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else if((!SENSOR1 & SENSOR2) | (SENSOR1 & !SENSOR2) | (SENSOR1 & SENSOR2)){
 Bandera.Par1 =  0 ;
 Desborde.Par1 = 0;
 }

 if(!SENSOR3 & !SENSOR4){
 Desborde.Par2 = Desborde.Par2++;
 if(Desborde.Par2 >  8 ){
 if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.Par2 =  1 ;
 Desborde.Par2 = 0;
 cuenta =  1 ;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else if((!SENSOR3 & SENSOR4) | (SENSOR3 & !SENSOR4) | (SENSOR3 & SENSOR4)){
 Bandera.Par2 =  0 ;
 Desborde.Par2 = 0;

 }

 if(!SENSOR5 & !SENSOR6){
 Desborde.Par3 = Desborde.Par3++;
 if(Desborde.Par3 >  8 ){
 if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.Par3 =  1 ;
 Desborde.Par3 = 0;
 cuenta =  1 ;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else if((!SENSOR5 & SENSOR6) | (SENSOR5 & !SENSOR6) | (SENSOR5 & SENSOR6)){
 Bandera.Par3 =  0 ;
 Desborde.Par3 = 0;

 }

 if(!SENSOR1 & !SENSOR3){
 Desborde.Par4 = Desborde.Par4++;
 if(Desborde.Par4 >  8 ){
 if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.Par4 =  1 ;
 Desborde.Par4 = 0;
 cuenta =  1 ;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else if((!SENSOR1 & SENSOR3) | (SENSOR1 & !SENSOR3) | (SENSOR1 & SENSOR3)){
 Bandera.Par4 =  0 ;
 Desborde.Par4 = 0;

 }

 if(!SENSOR1 & !SENSOR5){
 Desborde.Par6 = Desborde.Par6++;
 if(Desborde.Par6 >  8 ){
 if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.Par6 =  1 ;
 Desborde.Par6 = 0;
 cuenta =  1 ;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else if((!SENSOR1 & SENSOR5) | (SENSOR1 & !SENSOR5) | (SENSOR1 & SENSOR5)){
 Bandera.Par6 =  0 ;
 Desborde.Par6 = 0;

 }

 if(!SENSOR2 & !SENSOR4){
 Desborde.Par7 = Desborde.Par7++;
 if(Desborde.Par7 >  8 ){
 if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 cuenta =  1 ;
 Bandera.Par7 =  1 ;
 Desborde.Par7 = 0;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else if((!SENSOR2 & SENSOR4) | (SENSOR2 & !SENSOR4) | (SENSOR2 & SENSOR4)){
 Bandera.Par7 =  0 ;
 Desborde.Par7 = 0;

 }

 if(!SENSOR4 & !SENSOR6){
 Desborde.Par9 = Desborde.Par9++;
 if(Desborde.Par9 >  8 ){
 if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
 Bandera.Par9 =  1 ;
 Desborde.Par9 = 0;
 cuenta =  1 ;
 desbordoGPS =  180  - 2;
 if(!MSTR){
 EnvioCuenta =  1 ;
 desbordoGPS_SLV =  180  - 2;
 }
 }
 }
 }
 else if((!SENSOR4 & SENSOR6) | (SENSOR4 & !SENSOR6) | (SENSOR4 & SENSOR6)){
 Bandera.Par9 =  0 ;
 Desborde.Par9 = 0;
 }

 if( (Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9) |
 (Bandera.Par2 & !Bandera.Par1 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9 ) |
 (Bandera.Par3 & !Bandera.Par2 & !Bandera.Par1 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9 ) |
 (Bandera.Par4 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par1 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9 ) |
 (Bandera.Par5 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par1 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9 ) |
 (Bandera.Par6 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par1 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9 ) |
 (Bandera.Par7 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par1 & !Bandera.Par8 & !Bandera.Par9 ) |
 (Bandera.Par8 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par1 & !Bandera.Par9 ) |
 (Bandera.Par9 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par1 ) |
 (Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
 (!Bandera.SensorU & Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
 (!Bandera.SensorU & !Bandera.SensorD & Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
 (!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
 (!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & Bandera.SensorO & !Bandera.SensorS) |
 (!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & Bandera.SensorS) ){
 BLOQUEOACTIVO =  1 ;


 }
 if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9 & !Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS){
 BLOQUEOACTIVO =  0 ;
 }
 }
#line 1 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
#line 1 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/lcd_4x20.h"
#line 1 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/eepromi2cbrian_v2.h"
#line 1 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/i2c_soft.h"
#line 10 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/i2c_soft.h"
extern sfr sbit I2C_SCL;
extern sfr sbit I2C_SCLD;
extern sfr sbit I2C_SDA;
extern sfr sbit I2C_SDAD;


void I2C_soft_init(){

 I2C_SCLD = 1;
 I2C_SDAD = 1;
}

void I2C_soft_start(){

 I2C_SDAD = 1;
 I2C_SCLD = 1;
 delay_us(2);

 I2C_SDAD = 0;
 I2C_SDA = 0;
 delay_us(2);

 I2C_SCLD = 0;
 I2C_SCL = 0;
}

void I2C_soft_stop(){
 I2C_SDAD = 0;
 I2C_SDA = 0;
 delay_us(2);
 I2C_SCLD = 1;
 delay_us(2);
 I2C_SDAD = 1;
}

 char  I2C_soft_write(char dato){
 char i;


 for(i = 0; i < 8; i++){
 I2C_SDA = dato.B7;
 I2C_SCL = 1;
 delay_us(2);
 dato <<= 1;
 I2C_SCL = 0;
 delay_us(2);
 }


 I2C_SDAD = 1;
 asm nop;
 I2C_SCL = 1;
 delay_us(2);
 i.B0 = I2C_SDA;
 I2C_SCL = 0;
 I2C_SDAD = 0;

 return i.B0;
}

char I2C_soft_read( char  ACK){
 char i, result = 0;


 I2C_SDAD = 1;

 for(i = 0; i < 8; i++){
 result <<= 1;
 I2C_SCL = 1;
 delay_us(2);

 if(I2C_SDA)
 result |= 0x01;
 I2C_SCL = 0;
 delay_us(2);
 }


 I2C_SDAD = 0;
 I2C_SDA = !ACK.B0;
 asm nop;
 I2C_SCL = 1;
 delay_us(2);
 I2C_SCL = 0;

 return result;
}
#line 5 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/eepromi2cbrian_v2.h"
extern sfr sbit I2C_SCL;
extern sfr sbit I2C_SCLD;
extern sfr sbit I2C_SDA;
extern sfr sbit I2C_SDAD;







short RW = 0;

const short EEPROM_DIR_24LC256 = 0xA0;



void iniciaEeprom(){
 I2C_soft_init();
}

void eepromEscribeNumero(unsigned int Registro, long Dato, short BYTES){
 long bufferLong[] = {0,0,0,0};
 short i = 0, aux = 0;
 RW =  0x00 ;

 bufferLong[0] = Dato & 0x000000FF;
 bufferLong[1] = (Dato & 0x0000FF00)>>8;
 bufferLong[2] = (Dato & 0x00FF0000)>>16;
 bufferLong[3] = (Dato & 0xFF000000)>>24;
 if(BYTES == 1){
 while(i < BYTES){
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256 | RW);
 I2C_soft_write((registro &  0xFF00 )>>8);
 I2C_soft_write(registro &  0x00FF );
 i++;
 I2C_soft_write(bufferLong[0]);
 I2C_soft_stop();
 while( 1 ){
 I2C_soft_start();
 if(!I2C_soft_write(EEPROM_DIR_24LC256))
 break;
 }
 I2C_soft_stop();
 }
 }

 if(BYTES == 2){
 while(i < BYTES){
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256 | RW);
 I2C_soft_write((registro &  0xFF00 )>>8);
 I2C_soft_write(registro &  0x00FF );
 for(;aux < BYTES;aux++){
 I2C_soft_write(bufferLong[aux]);
 i++;
 }
 I2C_soft_stop();
 while( 1 ){
 I2C_soft_start();
 if(!I2C_soft_write(EEPROM_DIR_24LC256))
 break;
 }
 I2C_soft_stop();
 }
 }
 if(BYTES == 4){
 while(i < BYTES){
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256 | RW);
 I2C_soft_write((registro &  0xFF00 )>>8);
 I2C_soft_write(registro &  0x00FF );
 for(;i < BYTES;i++){
 I2C_soft_write(bufferLong[i]);
 }
 I2C_soft_stop();
 while( 1 ){
 I2C_soft_start();
 if(!I2C_soft_write(EEPROM_DIR_24LC256))
 break;
 }
 I2C_soft_stop();
 }
 }
}

void eepromEscribeChar(unsigned int registro, char *dato, int bytes){
 short i = 0;
 RW =  0x00 ;

 while(i < bytes){
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256 | RW);
 I2C_soft_write((registro &  0xFF00 )>>8);
 I2C_soft_write(registro &  0x00FF );
 for(;i < bytes;i++){
 I2C_soft_write(dato[i]);
 if(++registro%64 == 0){
 i++;
 break;
 }
 }
 I2C_soft_stop();
 while( 1 ){
 I2C_soft_start();
 if(!I2C_soft_write(EEPROM_DIR_24LC256))
 break;
 }
 I2C_soft_stop();
 }
}





void eepromLeeChar(unsigned int registro, short *buffer, short bytes){
 short i;
 RW =  0x01 ;
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256);
 I2C_soft_write((registro &  0xFF00 )>>8);
 I2C_soft_write(registro &  0x00FF );
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256 | RW);
 for(i = 0;i < bytes;i++){
 if(i == bytes - 1){
 buffer[i] = I2C_soft_read( 0 );
 I2C_soft_stop();
 }
 else{
 buffer[i] = I2C_soft_read( 1 );
 }
 }
}

long eepromLeeNumero(unsigned int registro, short BYTES){
 short i;
 long bufferLong[4]={0,0,0,0}, lectura = 0;
 RW =  0x01 ;
 if(BYTES == 1){
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256);
 I2C_soft_write((registro &  0xFF00 )>>8);
 I2C_soft_write(registro &  0x00FF );
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256 | RW);
 bufferLong[0] = I2C_soft_read( 0 );
 I2C_soft_stop();

 return lectura = bufferLong[0];
 }

 if(BYTES == 2){
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256);
 I2C_soft_write((registro &  0xFF00 )>>8);
 I2C_soft_write(registro &  0x00FF );
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256 | RW);
 for(i = 0;i < 2;i++){
 if(i == 2 - 1){
 bufferLong[i] = I2C_soft_read( 0 );
 I2C_soft_stop();
 }
 else{
 bufferLong[i] = I2C_soft_read( 1 );
 }
 }
 lectura = bufferLong[0];
 return lectura |= bufferLong[1]<<8;
 }

 if(BYTES == 4){
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256);
 I2C_soft_write((registro &  0xFF00 )>>8);
 I2C_soft_write(registro &  0x00FF );
 I2C_soft_start();
 I2C_soft_write(EEPROM_DIR_24LC256 | RW);
 for(i = 0;i < 4;i++){
 if(i == 4 - 1){
 bufferLong[i] = I2C_soft_read( 0 );
 I2C_soft_stop();
 }
 else{
 bufferLong[i] = I2C_soft_read( 1 );
 }
 }
 for(i = 0;i < 4;i++){
 if(i==0){
 lectura = bufferLong[i];
 }
 else{
 lectura |= bufferLong[i] << 8*i;
 }
 }
 return lectura;
 }
}
#line 22 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
char auxS[12] = {0}, auxB[12] = {0}, auxP[12] = {0}, auxBloq[12] = {0}, auxT[12] = {0}, auxslv[12] = {0};
char *auxCuentaS, *auxCuentaB, *auxCuentaT;
short debugEstado = 0, debugEstadoB = 0;
unsigned int lecturaTablaS = 0, lecturaTablaB = 0, pVerdaderosMEntero = 0, pVerdaderosEEntero = 0, pasajerosTotalesL = 0, lecturaTablaPVerdaderos = 0, lecturaTablaPasajerosTotales = 0;
unsigned int pasajerosSubenM=0, pasajerosBajanM=0, pasajerosSubenE=0, pasajerosBajanE =0;
unsigned int pBajan = 0, pSuben = 0, lecturaTablaSubenAnterior = 0;
unsigned int envioSlvSuben = 0, envioSlvBajan = 0;
unsigned int guardadoSlvSuben = 0, recSlvSuben = 0;
unsigned int guardadoSlvBajan = 0, recSlvBajan = 0;
unsigned int lecturaTablaSubenE = 0, lecturaTablaBajanE = 0, totalCalculado = 0;
float pasajerosVerdaderos = 0;
short cuentaBloqueo = 0, lecturaBloqueo = 0;
short cuentaUSART = 0, cuentaAtasco = 0, cuentaReinicio = 0, comienzaContarAtasco = 0, cuentaE_S = 0;
 char  permanencia =  0 , empiezaEntrada =  0 , empiezaSalida =  0 ;






void muestraEstatus(){
 if(MSTR){
 lcd_out(3,8,"MST");
 lecturaTablaS = eepromLeenumero(0x0000,2);
 bytetostr(lecturaTablaS, auxS);
 lcd_out(1, 15, auxS);
 lecturaTablaSubenE = eepromLeeNumero(0x0900, 2);
 bytetostr(lecturaTablaSubenE, auxS);
 lcd_out(1, 18, auxS);
#line 54 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
 lecturaTablaB = eepromLeeNumero(0x0003,2);
 bytetostr(lecturaTablaB, auxB);
 lcd_out(2, 15, auxB);
 lecturaTablaBajanE = eepromLeeNumero(0x0700, 2);
 bytetostr(lecturaTablaBajanE, auxB);
 lcd_out(2, 18, auxB);
#line 63 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
 lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
 bytetostr(lecturaTablaPVerdaderos, auxP);
 lcd_out(4, 17, auxP);
#line 69 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
 lecturaBloqueo = eepromLeenumero(0x000B, 1) + eepromLeeNumero(0x000C, 1);
 bytetostr(lecturaBloqueo, auxBloq);
 lcd_out(3, 18, auxBloq);
#line 75 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
 }
 else if(!MSTR){
 lcd_out(3, 8, "SLV");
 lecturaTablaS = eepromLeeNumero(0x0000,2);
 bytetostr(lecturaTablaS, auxS);
 lcd_out(1, 16, auxS);
#line 84 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
 lecturaTablaB = eepromLeeNumero(0x0003,2);
 bytetostr(lecturaTablaB, auxB);
 lcd_out(2, 16, auxB);
#line 90 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
 lecturaTablaPasajerosTotales = eepromLeeNumero(0x0009, 2);
 bytetostr(lecturaTablaPasajerosTotales, auxT);
 lcd_out(4, 18, auxT);
#line 96 "c:/users/brian/desktop/accesa_cmpartida/embebidos/camion_cotadorv2/rutinasensores_v4(mstr-slv).h"
 lecturaBloqueo = eepromLeenumero(0x000B, 1);
 bytetostr(lecturaBloqueo, auxBloq);
 lcd_out(3, 18, auxBloq);
 }
 lcd_outConst(4, 11, "TOTAL:");
 lcd_outConst(1, 10, "SUBEN:");
 lcd_outConst(2, 10, "BAJAN:");
 LCD_OUTCONST(3, 1, "ESPERA");
 lcd_outConst(3, 12, "BLOCK:");
 }

void sensorNoBloqueo();
short espera(short);
short entrando(short);
short transicionE(short);
short transicionEnt(short);
short entro(short);
short saliendo(short);
short transicionS(short);
short transicionSal(short);
short salio(short);

void sensorBloqueo();
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

void sensorBloqueoPar1();
short esperaBP1(short);
short entrandoBP1(short);
short transicionEBP1(short);
short transicionEntBP1(short);
short entroBP1(short);
short saliendoBP1(short);
short transicionSBP1(short);
short transicionSalBP1(short);
short salioBP1(short);

void sensorBloqueoPar2();
short esperaBP2(short);
short entrandoBP2(short);
short transicionEBP2(short);
short transicionEntBP2(short);
short entroBP2(short);
short saliendoBP2(short);
short transicionSBP2(short);
short transicionSalBP2(short);
short salioBP2(short);

void sensorBloqueoPar3();
short esperaBP3(short);
short entrandoBP3(short);
short transicionEBP3(short);
short transicionEntBP3(short);
short entroBP3(short);
short saliendoBP3(short);
short transicionSBP3(short);
short transicionSalBP3(short);
short salioBP3(short);

void sensorBloqueoPar4();
short esperaBP4(short);
short entrandoBP4(short);
short transicionEBP4(short);
short transicionEntBP4(short);
short entroBP4(short);
short saliendoBP4(short);
short transicionSBP4(short);
short transicionSalBP4(short);
short salioBP4(short);

void sensorBloqueoPar6();
short esperaBP6(short);
short entrandoBP6(short);
short transicionEBP6(short);
short transicionEntBP6(short);
short entroBP6(short);
short saliendoBP6(short);
short transicionSBP6(short);
short transicionSalBP6(short);
short salioBP6(short);

void sensorBloqueoPar7();
short esperaBP7(short);
short entrandoBP7(short);
short transicionEBP7(short);
short transicionEntBP7(short);
short entroBP7(short);
short saliendoBP7(short);
short transicionSBP7(short);
short transicionSalBP7(short);
short salioBP7(short);

void sensorBloqueoPar9();
short esperaBP9(short);
short entrandoBP9(short);
short transicionEBP9(short);
short transicionEntBP9(short);
short entroBP9(short);
short saliendoBP9(short);
short transicionSBP9(short);
short transicionSalBP9(short);
short salioBP9(short);





void sensorNoBloqueo(){
 espera(debugEstado);
 if(permanencia){
 if(empiezaEntrada){
 entrando(debugEstado);
 transicionE(debugEstado);
 transicionEnt(debugEstado);
 entro(debugEstado);
 }
 else if(empiezaSalida){
 saliendo(debugEstado);
 transicionS(debugEstado);
 transicionSal(debugEstado);
 salio(debugEstado);
 }
 }

 }





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
 }

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





short espera(short estado){
 if(estado ==  0 ){

 muestraEstatus();

 if( (!SENSOR1 | !SENSOR3 | !SENSOR5) & ((SENSOR2 & SENSOR4) | (SENSOR4&SENSOR6) | (SENSOR2&SENSOR6))){

 cuentaUSART = 0;
 permanencia =  1 ;
 empiezaEntrada =  1 ;
 empiezaSalida =  0 ;
 return debugEstado =  1 ;
 }
 if( (!SENSOR2 | !SENSOR4 | !SENSOR6) &((SENSOR1 & SENSOR3) | (SENSOR3&SENSOR5) | (SENSOR1&SENSOR5)) ){

 cuentaUSART = 0;
 permanencia =  1 ;
 empiezaSalida =  1 ;
 empiezaEntrada =  0 ;
 return debugEstado =  4 ;
 }
 return  0 ;
 }
 }

short entrando(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");

 if((!SENSOR2 | !SENSOR4 | !SENSOR6)&((!SENSOR1 & !SENSOR3)|(!SENSOR3&!SENSOR5)|(!SENSOR1&!SENSOR5))){

 return debugEstado =  2 ;
 }
 if((SENSOR1&SENSOR3) | (SENSOR3&SENSOR5) | (SENSOR1&SENSOR5)){

 return debugEstado =  0 ;
 }
 }
 }

short transicionE(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICIONE");
 if((SENSOR1&SENSOR3) | (SENSOR3&SENSOR5) | (SENSOR1& SENSOR5)){
 return debugEstado =  7 ;
 }
 if((SENSOR2&SENSOR4) | (SENSOR4&SENSOR6) | (SENSOR2& SENSOR6)){
 return debugEstado =  1 ;
 }
 }
 }

short transicionEnt(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if(
 ((!SENSOR1&!SENSOR3) | (!SENSOR3&!SENSOR5) | (!SENSOR1& !SENSOR5))
 ){
 return debugEstado =  2 ;
 }
 if(SENSOR2 & SENSOR4 & SENSOR6){
 return debugEstado =  3 ;
 }
 }
 }

short entro(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");

 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }

 lcd_cmd( 0x01 );

 permanencia =  0 ;
 empiezaEntrada =  0 ;
 return debugEstado =  0 ;
 }
 }

short saliendo(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if( (!SENSOR1 | !SENSOR3 | !SENSOR5)&((!SENSOR2 & !SENSOR4)|(!SENSOR4&!SENSOR6)|(!SENSOR2&!SENSOR6))
 ){
 return debugEstado =  8 ;
 }
 if((SENSOR2&SENSOR4) | (SENSOR4&SENSOR6) | (SENSOR2&SENSOR6)){

 return debugEstado =  0 ;
 }
 }
 }

short transicionS(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION S");

 if(
 (SENSOR2&SENSOR4) | (SENSOR4&SENSOR6) | (SENSOR2& SENSOR6)
 ){

 return debugEstado =  5 ;
 }
 if(
 (SENSOR1&SENSOR3) | (SENSOR3&SENSOR5) | (SENSOR1& SENSOR5)
 ){

 return debugEstado =  4 ;
 }
 }
 }

short transicionSal(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 comienzaContarAtasco =  1 ;
 if( (!SENSOR2&!SENSOR4) | (!SENSOR4&!SENSOR6) | (!SENSOR2& !SENSOR6)

 ){
 return debugEstado = 8 ;
 }
 if(SENSOR1 & SENSOR3 & SENSOR5 ){

 return debugEstado =  6 ;
 }
 }
 }

short salio(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");

 pSuben = eepromLeeNumero(0x0000, 2);
 pBajan = eepromLeeNumero(0x0003, 2) + 1;
 eepromEscribeNumero(0x0003 ,pBajan, 2);
 pBajan = eepromLeeNumero(0x0003, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 permanencia =  0 ;
 empiezaSalida =  0 ;
 return debugEstado =  0 ;
 }
 }





 short esperaB(short estado){
 if(estado ==  0 ){

 muestraEstatus();

 if((!SENSOR3 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoB(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEB(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntB(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroB(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoB(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR3 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSB(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR3 & SENSOR5 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalB(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 & !SENSOR4 & !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioB(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000, 2);
 pBajan = eepromLeeNumero(0x0003, 2) + 1;
 eepromEscribeNumero(0x0003 ,pBajan, 2);
 pBajan = eepromLeeNumero(0x0003, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBD(short estado){
 if(estado ==  0 ){
 muestraEstatus();
 if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR4 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBD(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR1 & SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR4 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBD(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR4 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBD(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 & !SENSOR1 & !SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if( (SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBD(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBD(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBD(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if((SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBD(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR4 & !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBD(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000, 2);
 pBajan = eepromLeeNumero(0x0003, 2) + 1;
 eepromEscribeNumero(0x0003 ,pBajan, 2);
 pBajan = eepromLeeNumero(0x0003, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBT(short estado){
 if(estado ==  0 ){
 muestraEstatus();
 if((!SENSOR1 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBT(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBT(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBT(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR1 & !SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if( (SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBT(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBT(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBT(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR5 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBT(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 & !SENSOR4 & !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBT(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000, 2);
 pBajan = eepromLeeNumero(0x0003, 2) + 1;
 eepromEscribeNumero(0x0003 ,pBajan, 2);
 pBajan = eepromLeeNumero(0x0003, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBC(short estado){
 if(estado ==  0 ){
 muestraEstatus();
 if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBC(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR1 & SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBC(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBC(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 & !SENSOR1 & !SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if( (SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBC(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBC(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBC(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if((SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBC(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 & !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBC(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000, 2);
 pBajan = eepromLeeNumero(0x0003, 2) + 1;
 eepromEscribeNumero(0x0003 ,pBajan, 2);
 pBajan = eepromLeeNumero(0x0003, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBO(short estado){
 if(estado ==  0 ){
 muestraEstatus();
 if((!SENSOR1 | !SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBO(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR1 & SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBO(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR1 & SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBO(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 & !SENSOR1) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if( (SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBO(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBO(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBO(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR3 & !SENSOR2) | (SENSOR1 & SENSOR3 & !SENSOR4) | (SENSOR1 & SENSOR3 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBO(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 & !SENSOR4 & !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBO(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000, 2);
 pBajan = eepromLeeNumero(0x0003, 2) + 1;
 eepromEscribeNumero(0x0003 ,pBajan, 2);
 pBajan = eepromLeeNumero(0x0003, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBS(short estado){
 if(estado ==  0 ){
 muestraEstatus();
 if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBS(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO DEBUG");
 if((SENSOR1 & SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBS(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR4 & !SENSOR1) | (SENSOR2 & SENSOR4 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBS(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 & !SENSOR1 & !SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if( (SENSOR2 & SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBS(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBS(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBS(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION DEBUG");
 if((SENSOR2 & SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBS(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 & !SENSOR4){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBS(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000, 2);
 pBajan = eepromLeeNumero(0x0003, 2) + 1;
 eepromEscribeNumero(0x0003 ,pBajan, 2);
 pBajan = eepromLeeNumero(0x0003, 2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBP1(short estado){
 if(estado ==  0 ){
 muestraEstatus();

 if((!SENSOR3 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR4 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBP1(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR4 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBP1(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR4 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBP1(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 & !SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if( (SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBP1(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 delay_ms(350);
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBP1(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR3 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBP1(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if((SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR3 & SENSOR5 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBP1(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR4 & !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBP1(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000,2);
 pBajan = eepromLeeNumero(0x0003,2) + 1;
 eepromEscribeNumero(0x0003,pBajan,2);
 pBajan = eepromLeeNumero(0x0003,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBP2(short estado){
 if(estado ==  0 ){

 muestraEstatus();

 if((!SENSOR1 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBP2(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBP2(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBP2(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR1 & !SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if( (SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBP2(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 delay_ms(350);
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBP2(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBP2(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if((SENSOR2 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR5 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBP2(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 & !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBP2(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000,2);
 pBajan = eepromLeeNumero(0x0003,2) + 1;
 eepromEscribeNumero(0x0003,pBajan,2);
 pBajan = eepromLeeNumero(0x0003,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBP3(short estado){
 if(estado ==  0 ){
 muestraEstatus();

 if((!SENSOR1 | !SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBP3(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO DEBUG");
 if((SENSOR1 & SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBP3(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if((SENSOR1 & SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR4 & !SENSOR1) | (SENSOR2 & SENSOR4 & !SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBP3(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 & !SENSOR1) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if( (SENSOR2 & SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBP3(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 delay_ms(350);
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBP3(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBP3(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION DEBUG");
 if((SENSOR2 & SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR3 & !SENSOR2) | (SENSOR1 & SENSOR3 & !SENSOR4)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBP3(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 & !SENSOR4 ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR3)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBP3(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000,2);
 pBajan = eepromLeeNumero(0x0003,2) + 1;
 eepromEscribeNumero(0x0003,pBajan,2);
 pBajan = eepromLeeNumero(0x0003,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBP4(short estado){
 if(estado ==  0 ){
 muestraEstatus();
 if((!SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBP4(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBP4(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if(SENSOR5){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBP4(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if(SENSOR2 & SENSOR4 & SENSOR6 & SENSOR5){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBP4(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 delay_ms(350);
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBP4(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if(!SENSOR5){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBP4(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if(SENSOR2 & SENSOR4 & SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR5 & !SENSOR2) | (SENSOR5 & !SENSOR4) | (SENSOR5 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBP4(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 | !SENSOR4 | !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR5) & (SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBP4(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000,2);
 pBajan = eepromLeeNumero(0x0003,2) + 1;
 eepromEscribeNumero(0x0003,pBajan,2);
 pBajan = eepromLeeNumero(0x0003,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBP6(short estado){
 if(estado ==  0 ){
 muestraEstatus();

 if(!SENSOR1){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBP6(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR1)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBP6(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if(SENSOR1){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBP6(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR1) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if(SENSOR2 & SENSOR4 & SENSOR6 & SENSOR1){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBP6(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 delay_ms(350);
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBP6(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if(!SENSOR1){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBP6(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if(SENSOR2 & SENSOR4 & SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & !SENSOR2) | (SENSOR1 & !SENSOR4) | (SENSOR1 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBP6(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 | !SENSOR4 | !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1) & (SENSOR2 & SENSOR4 & SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBP6(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000,2);
 pBajan = eepromLeeNumero(0x0003,2) + 1;
 eepromEscribeNumero(0x0003,pBajan,2);
 pBajan = eepromLeeNumero(0x0003,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBP7(short estado){
 if(estado ==  0 ){
 muestraEstatus();

 if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBP7(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR1 & SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if(!SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBP7(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if(SENSOR1 & SENSOR3 & SENSOR5){
 lcd_cmd( 0x01 );
 return debugEstado =  7 ;
 }
 if((SENSOR6 & !SENSOR1) | (SENSOR6 & !SENSOR3) | (SENSOR6 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstado =  1 ;
 }
 }
 }

short transicionEntBP7(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 | !SENSOR1 | !SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if(SENSOR6 & SENSOR1 & SENSOR3 & SENSOR5){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBP7(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 delay_ms(350);
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBP7(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBP7(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if(SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBP7(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5) & (SENSOR6)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBP7(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000,2);
 pBajan = eepromLeeNumero(0x0003,2) + 1;
 eepromEscribeNumero(0x0003,pBajan,2);
 pBajan = eepromLeeNumero(0x0003,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }





short esperaBP9(short estado){
 if(estado ==  0 ){
 muestraEstatus();

 if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 if((!SENSOR2)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short entrandoBP9(short estado){
 if(estado ==  1 ){
 LCD_OUTCONST(3,1,"ENTRANDO");
 if((SENSOR1 & SENSOR3 & SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 if(!SENSOR2){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 }
 }

short transicionEBP9(short estado){
 if(estado ==  2 ){
 LCD_OUTCONST(3,1,"TRANSICION");
 if(SENSOR1 & SENSOR3 & SENSOR5){
 lcd_cmd( 0x01 );
 return debugEstadoB =  7 ;
 }
 if((SENSOR2 & !SENSOR1) | (SENSOR2 & !SENSOR3) | (SENSOR2 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  1 ;
 }
 }
 }

short transicionEntBP9(short estado){
 if(estado ==  7 ){
 LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
 if((!SENSOR3 | !SENSOR1 | !SENSOR5) ){
 lcd_cmd( 0x01 );
 return debugEstadoB =  2 ;
 }
 if(SENSOR2 & SENSOR1 & SENSOR3 & SENSOR5){
 lcd_cmd( 0x01 );
 return debugEstadoB =  3 ;
 }
 }
 }

short entroBP9(short estado){
 if(estado ==  3 ){
 LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
 delay_ms(350);
 pBajan = eepromLeeNumero(0x0003,2);
 pSuben = eepromLeeNumero(0x0000,2) + 1;
 eepromEscribeNumero(0x0000,pSuben,2);
 pSuben = eepromLeeNumero(0x0000,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }

short saliendoBP9(short estado){
 if(estado ==  4 ){
 lcd_outConst(3, 1, "SALIENDO");
 if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR2)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
 }

short transicionSBP9(short estado){
 if(estado ==  8 ){
 lcd_outConst(3, 1, "TRANSICION");
 if(SENSOR2){
 lcd_cmd( 0x01 );
 return debugEstadoB =  5 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  4 ;
 }
 }
 }

short transicionSalBP9(short estado){
 if(estado ==  5 ){
 LCD_OUTCONST(3,1,"TRANSICION SALIDA");
 if(!SENSOR2 | !SENSOR4 | !SENSOR6){
 lcd_cmd( 0x01 );
 return debugEstadoB =  8 ;
 }
 if((SENSOR1 & SENSOR3 & SENSOR5) & (SENSOR2)){
 lcd_cmd( 0x01 );
 return debugEstadoB =  6 ;
 }
 }
 }

short salioBP9(short estado){
 if(estado ==  6 ){
 LCD_OUTCONST(3,1,"GRACIAS!");
 pSuben = eepromLeeNumero(0x0000,2);
 pBajan = eepromLeeNumero(0x0003,2) + 1;
 eepromEscribeNumero(0x0003,pBajan,2);
 pBajan = eepromLeeNumero(0x0003,2);
 pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
 eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
 if(MSTR){
 pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
 pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
 pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
 lcd_cmd( 0x01 );
 return debugEstadoB =  0 ;
 }
 }
#line 114 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
char Aux1[12] = {0}, Aux2[12] = {0}, Aux3[12] = {0}, Aux4[12] = {0}, Aux5[12] = {0}, Aux6[12] = {0}, WioRX[2]={0};
char solicitudCuenta[] = "C.", solicitudReset[] = "R.", solicitudMaestro[8] = {0}, infoEsclavo[8] = {0}, confirmacionEsclavo[3] = {0};
char envioGPS[7] = {0}, auxEnvioGPS[5] = {0}, commAT[] = "ACC+01:", envioGPSshort[6] ={0}, respuestaReset[] = "RESET_OK";
char coma = 44, datoRxWioLTE[] ="Reset", error = 0, posteDesconectado[] = "DESC", conectado[] = "O", errorSoftUART, envioSerialGPS[45] = {0};
float pasajerosVerdaderosEsc = 0.0;
 char  estado1 =  1 , estado2 =  1 , estado3 =  1 , estado4 =  1 , estado5 =  1 , estado6 =  1 , banderaRx =  0 ;
 char  banderaReset =  0 , resetWioLTE =  0 , posteDesc =  0 , afterReset =  0 , conexionHabilitada =  0 ;
short auxCuentaBloqueo = 0, recBloq = 0, conexionPoste = 0;
short i = 0, j=0, k = 0, l = 0, m = 0, checksum[10] = {0};
short cuentaSoftRead = 0;
short bloqEsclavo = 0, bufferCuentaEnvioGPS = 0;
unsigned long recepcionLong = 0, recLong = 0;
unsigned int pSubenEsc = 0, pBajanEsc = 0, totalVerdadero = 0;
unsigned short bufferRecepcionEsclavo[10] = {0}, bufferEnvioEsclavo[10] = {0};



void MASTER();
short TX_MSTR();
void resetCuentas();
void UARTTX_WiolTE();
void serialTxWioLTE();



void SLV();
void TX_SLV();
void resetSLV();



void PicInit();
void bloqueos();
void indicadorSensores();
void desbordoTemporizadorCero();
void SENSADO();
void RX_PIC_PIC();
void escrituraBloqueos();



void interrupcionesAltoNivel() iv 0x0008 ics ICS_AUTO {

 if(PIR1.RCIF & PIE1.RCIE){
 RX_PIC_PIC();
 }

 if(PIR2.TMR3IF & PIE2.TMR3IE & MSTR){
 cuentaSoftRead++;
 if(cuentaSoftRead >=1){
 Soft_UART_Break();
 PIR2.TMR3IF =  0 ;
 }
 }
}

void interrupcionesBajoNivel() iv 0x0018 ics ICS_AUTO {
desbordoTemporizadorCero();
}







void main() {
 PicInit();

 while(1){

 bytetostr(posteDesc, Aux6);
 lcd_out(4,8,aux6);
 if(MSTR){
 WDTCON.SWDTEN = 1;
 T3CON.TMR3ON = 1;
 wioRX[0] = Soft_UART_Read(&errorSoftUART);
 if((!errorSoftUART) | errorSoftUART == 255){
 if(!errorSoftUART){
 if(wioRX[0] == 'r'){
 desbordoGPS =  180  - 1;
 lcd_chr(2,8,wioRX[0]);
 }
 else if(wioRX[0] == 'B'){
 resetWioLTE =  1 ;
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







void PicInit(){


 OSCCON = 0x40;

 ADCON1 = 0x0F;
 CMCON = 0x07;


 lcd_init();
 lcd_cmd( 0x0C );
 lcd_cmd( 0x01 );
 lcd_outConst(1,1,"INICILIZANDO...") ;



 SENSOR1D = 1;
 SENSOR2D = 1;
 SENSOR3D = 1;
 SENSOR4D = 1;
 SENSOR5D = 1;
 SENSOR6D = 1;
 RESET_BOTOND = 1;
 RX_PICD = 1;
 TRISC.B1 = 1;


 TX_PICD = 0;
 POLARIZACIOND = 0;
 BLOQUEOACTIVOD = 0;
 SENSORESDEBUGD = 0;


 SENSORESDEBUG = 0;
 BLOQUEOACTIVO = 0;


 PWM1_Init(44000);
 PWM1_Start();
 PWM1_Set_Duty(127);


 iniciaEeprom();


 T0CON.TMR0ON = 1;
 T0CON.T08BIT = 0;
 T0CON.T0CS = 0;
 T0CON.PSA = 0;
 T0CON.T0PS0 = 0;
 T0CON.T0PS1 = 1;
 T0CON.T0PS2 = 1;
#line 292 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
 TMR0L = 0x69;
 TMR0H = 0x67;


 if(MSTR){
 T1CON.RD16 = 0;
 T1CON.TMR1CS = 0;
 T1CON.T1CKPS0 = 1;
 T1CON.T1CKPS1 = 1;

 TMR1L = 0x8E;
 TMR1H = 0xFD;
 T1CON.TMR1ON = 1;



 T3CON.RD16 = 0;

 T3CON.TMR3CS = 0;
 T3CON.T1CKPS0 = 1;
 T3CON.T1CKPS1 = 1;

 TMR3L = 0x85;
 TMR3H = 0xFD;

 }

 RCON.IPEN = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;
 INTCON.TMR0IE = 1;
 INTCON2.TMR0IP = 0;
 INTCON3.TMR1IE = 1;
 IPR1.TMR1IP = 1;
 PIE2.TMR3IE = 1;
 IPR2.TMR3IP = 1;
#line 331 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
 PIE1.RCIE = 1;
 IPR1.RCIP = 1;


 UART1_Init( 9600 );
 delay_ms(100);

 Soft_UART_Init(&PORTC, 1, 0, 9600, 0);


 Bandera.SensorU =  0 , Bandera.SensorD =  0 , Bandera.SensorT =  0 , Bandera.SensorC =  0 , Bandera.SensorO =  0 , Bandera.SensorS =  0 ;
 Bandera.Par1 =  0 , Bandera.Par2 =  0 , Bandera.Par3 =  0 , Bandera.Par4 =  0 , Bandera.Par5 =  0 , Bandera.Par6 =  0 , Bandera.Par7 =  0 , Bandera.Par8 =  0 , Bandera.Par9 =  0 ;
 Desborde.SensorU = 0, Desborde.SensorD = 0, Desborde.SensorT = 0, Desborde.SensorC = 0, Desborde.SensorO = 0, Desborde.SensorS = 0;
 Desborde.Par1 = 0, Desborde.Par2 = 0, Desborde.Par3 = 0, Desborde.Par4 = 0, Desborde.Par5 = 0, Desborde.Par6 = 0, Desborde.Par7 = 0, Desborde.Par8 = 0, Desborde.Par9 = 0;

 BLOQUEOACTIVO = 1;
 delay_ms(200);
 BLOQUEOACTIVO = 0;

 lcd_cmd( 0x01 );
 }
#line 363 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
short TX_MSTR(){
 short m = 0;
 if(cuentaUSART ==  5 ){
 memset(confirmacionEsclavo, 0, sizeof(confirmacionEsclavo));
 if(UART1_Tx_Idle() ==  1 ){
 UART1_Write_Text(solicitudCuenta);
 if((bufferRecepcionEsclavo[4] != checksum[5]) & !conexionHabilitada){
 posteDesc =  1 ;
 afterReset =  1 ;
 checksum[0] = 1;
 checksum[1] = 2;
 checksum[2] = 3;
 conexionHabilitada =  0 ;
 }
 else{
 bufferRecepcionEsclavo[4] = 0;
 checksum[5] = 10;
 lcd_cmd( 0x01 );
 posteDesc =  0 ;
 conexionHabilitada =  0 ;
 if(afterReset){
 afterReset =  0 ;
 asm reset;
 }
 }
 cuentaUSART = 0;
 }
 }
 if(!posteDesc){
 if(banderaRx){
 lcd_cmd( 0x01 );
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

 totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
 if(totalCalculado != totalVerdadero){

 eepromEscribeNumero(0x0005, totalCalculado, 2);
 }
#line 431 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
 recBloq = eepromLeeNumero(0x000C, 1);
 if(bufferRecepcionEsclavo[2] != recBloq){
 eepromEscribeNumero(0x000C, bufferRecepcionEsclavo[2], 1);
 bloqEsclavo = eepromLeeNumero(0x000C, 1);
 }
 if(bufferRecepcionEsclavo[3]){
 desbordoGPS = bufferRecepcionEsclavo[3];
 }
 memset(bufferRecepcionEsclavo[3],0,sizeof(bufferRecepcionEsclavo));
 banderaRx =  0 ;
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
 if(UART1_Tx_Idle() ==  1 ){
 UART1_Write(bufferEnvioEsclavo[i]);
 delay_ms(5);
 }
 }
 if(UART1_Tx_Idle() ==  1 ){
 UART1_Write_Text("C.");
 }
 EnvioCuenta =  0 ;
 }
 }

void serialTxWioLTE(){

 if(desbordoGPS >=  180 ){


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

 strcpy(envioSerialGPS, commAT);

 memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
 inttostrwithzeros(lecturaTablaPVerdaderos, envioGPS);
 for(l=0 ; l<4 ; l++){
 auxEnvioGPS[l] = envioGPS[l+2];
 }
 strcat(envioSerialGPS, auxEnvioGPS);

 strcat(envioSerialGPS, ",");


 memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
 pasajerosSubenM = eepromLeeNumero(0x0000, 2);
 inttostrWithZeros(pasajerosSubenM, envioGPS);
 for(l=0 ; l<4 ; l++){
 auxEnvioGPS[l] = envioGPS[l+2];
 }
 strcat(envioSerialGPS, auxEnvioGPS);

 strcat(envioSerialGPS, ",");

 memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));

 pasajerosBajanM = eepromLeeNumero(0x0003, 2);

 inttostrWithZeros(pasajerosBajanM, envioGPS);
 for(l=0 ; l<4 ; l++){
 auxEnvioGPS[l] = envioGPS[l+2];
 }
 strcat(envioSerialGPS, auxEnvioGPS);

 strcat(envioSerialGPS, ",");

 memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
 if(posteDesc){
 strcat(envioSerialGPS, posteDesconectado);
 }
 else{


 pasajerosSubenE = eepromLeeNumero(0x0900, 2);
 inttostrWithZeros(pasajerosSubenE, envioGPS);
 for(l=0 ; l<4 ; l++){
 auxEnvioGPS[l] = envioGPS[l+2];
 }
 strcat(envioSerialGPS, auxEnvioGPS);
 }

 strcat(envioSerialGPS, ",");

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

 strcat(envioSerialGPS, ",");

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

 strcat(envioSerialGPS, ",");

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


 strcat(envioSerialGPS, ",");

 strcat(envioSerialGPS, "0,\r\n");
 for(l=0; l<strlen(envioSerialGPS); l++){
 Soft_UART_Write(envioSerialGPS[l]);
 }
 lcd_cmd( 0x01 );
 lcd_out(1,1,envioSerialGPS);

 lcd_cmd( 0x01 );
 memset(envioSerialGPS, 0, sizeof(envioSerialGPS));
 desbordoGPS = 0;
 }
 }





void RX_PIC_PIC(){
 if(MSTR){
 if(k < 10){
 if(k == 9){
 UART1_Read_Text(confirmacionEsclavo, ".", 2);
 if(!strcmp(confirmacionEsclavo, "C")){
 conexionHabilitada =  1 ;
 }
 else{
 conexionHabilitada =  0 ;
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
 banderaRx =  1 ;
 }
 }
 }
 if(!MSTR){
 UART1_Read_Text(solicitudMaestro, ".", 2);
 if(!strcmp(solicitudMaestro, "C")){
 EnvioCuenta =  1 ;
 }
 if(!strcmp(solicitudMaestro, "R")){
 banderaReset =  1 ;
 }
 }
 }








void SENSADO(){

 if(Bandera.SensorU & !Bandera.Par1){
 sensorBloqueo();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.SensorD & !Bandera.Par1){
 sensorBloqueoD();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.SensorT & !Bandera.par2){
 sensorBloqueoT();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.SensorC & !Bandera.Par2){
 sensorBloqueoC();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.SensorO & !Bandera.Par3){
 sensorBloqueoO();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.SensorS & !Bandera.Par3){
 sensorBloqueoS();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
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
 cuenta =  0 ;
 }
 }
 if(Bandera.Par2 & !Bandera.Par1 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 sensorBloqueoPar2();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.Par3 & !Bandera.Par2 & !Bandera.Par1 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 sensorBloqueoPar3();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.Par4 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par1 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 sensorBloqueoPar4();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.Par6& !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par1 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
 sensorBloqueoPar6();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.Par7 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par1 & !Bandera.Par8 & !Bandera.Par9){
 sensorBloqueoPar7();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 if(Bandera.Par9 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par1){
 sensorBloqueoPar9();
 if(cuenta){
 auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
 auxCuentaBloqueo++;
 eepromEscribeNumero(0x000B, AuxcuentaBloqueo, 1);
 cuenta =  0 ;
 }
 }
 }







void desbordoTemporizadorCero(){

 if(INTCON.TMR0IF && INTCON.TMR0IE){

 cuentaUSART = cuentaUSART++;
 desbordoGPS = desbordoGPS++;
 conexionPoste = conexionPoste++;
 if(comienzaContarAtasco){
 cuentaAtasco++;
 }
#line 793 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
 bloqueos(SENSOR1, SENSOR2, SENSOR3, SENSOR4, SENSOR5, SENSOR6, &cuentaBloqueo);

 INTCON.TMR0IF = 0;
#line 798 "C:/Users/Brian/Desktop/ACCESA_CMPARTIDA/Embebidos/CAMION_COTADORv2/MyProject.c"
 TMR0L = 0x69;
 TMR0H = 0x67;
 }
}








void resetCuentas(){

 short l = 0;

 if(RESET_BOTON | resetWioLTE){
 if(MSTR){
 if(UART1_Tx_Idle() ==  1 ){
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
 resetWioLTE =  0 ;
 }
 }

void resetSLV(){
 if(banderaReset){
 eepromEscribeNumero(0x0000, 0x0000, 2);
 eepromEscribeNumero(0x0003, 0x0000, 2);
 eepromEscribeNumero(0x0009, 0x0000, 2);
 eepromEscribeNumero(0x000B, 0x00, 1);
 banderaReset =  0 ;
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

 resetCuentas();


 SENSADO();


 TX_MSTR();


 indicadorSensores();



 serialTxWioLTE();

 }

void SLV(){
 resetSLV();
 SENSADO();
 TX_SLV();
 indicadorSensores();
 }
