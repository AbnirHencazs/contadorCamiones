
#include "I2C_Soft.h"

//Conexiones Software I2C
extern sfr sbit I2C_SCL;
extern sfr sbit I2C_SCLD;
extern sfr sbit I2C_SDA;
extern sfr sbit I2C_SDAD;

#define ACK         1       //ACKNOWLEDGE
#define NACK        0       //NO ACKNOWLEDGE
#define BYTE_ALTO   0xFF00  //PARA OBTENER EL BYTE MAS ALTO DE LA DIRECCION DEL REGISTRO APUNTADO
#define BYTE_BAJO   0x00FF  //PARA OBTENER EL BYTE MAS BAJO DE LA DIRECCION DEL REGISTRO APUNTADO
#define ESCRIBE     0x00
#define LEE         0x01
short RW = 0;                  //BIT ESCRITURA/LECTURA

const short EEPROM_DIR_24LC256 = 0xA0;      //DIRECCION ESCLAVO EEPROM


//FUNCION PARA HABILITAR EL MODULO I2C POR SOFTWARE
void iniciaEeprom(){
    I2C_soft_init();
}

void eepromEscribeNumero(unsigned int Registro, long Dato, short BYTES){
    long    bufferLong[] = {0,0,0,0};
    short   i = 0, aux = 0;
    RW = ESCRIBE;
    
    bufferLong[0] = Dato & 0x000000FF;
    bufferLong[1] = (Dato & 0x0000FF00)>>8;
    bufferLong[2] = (Dato & 0x00FF0000)>>16;
    bufferLong[3] = (Dato & 0xFF000000)>>24;
    if(BYTES == 1){
        while(i < BYTES){
            I2C_soft_start();
            I2C_soft_write(EEPROM_DIR_24LC256 | RW);
            I2C_soft_write((registro & BYTE_ALTO)>>8);
            I2C_soft_write(registro & BYTE_BAJO);
            i++;
            I2C_soft_write(bufferLong[0]);
            I2C_soft_stop();
            while(true){
              I2C_soft_start();
              if(!I2C_soft_write(EEPROM_DIR_24LC256))
                break;
            }
            I2C_soft_stop();      // Issue stop signal
        }
    }
    
    if(BYTES == 2){
        while(i < BYTES){
            I2C_soft_start();
            I2C_soft_write(EEPROM_DIR_24LC256 | RW);
            I2C_soft_write((registro & BYTE_ALTO)>>8);
            I2C_soft_write(registro & BYTE_BAJO);
            for(;aux < BYTES;aux++){
                I2C_soft_write(bufferLong[aux]);
                i++;
            }
            I2C_soft_stop();
            while(true){
              I2C_soft_start();
              if(!I2C_soft_write(EEPROM_DIR_24LC256))
                break;
            }
            I2C_soft_stop();      // Issue stop signal
        }
    }
    if(BYTES == 4){
        while(i < BYTES){
            I2C_soft_start();
            I2C_soft_write(EEPROM_DIR_24LC256 | RW);
            I2C_soft_write((registro & BYTE_ALTO)>>8);
            I2C_soft_write(registro & BYTE_BAJO);
            for(;i < BYTES;i++){
                I2C_soft_write(bufferLong[i]);
            }
            I2C_soft_stop();
            while(true){
              I2C_soft_start();
              if(!I2C_soft_write(EEPROM_DIR_24LC256))
                break;
            }
            I2C_soft_stop();      // Issue stop signal
        }
    }
}

void eepromEscribeChar(unsigned int registro, char *dato, int bytes){
    short i = 0;
    RW = ESCRIBE;
    
    while(i < bytes){
        I2C_soft_start();
        I2C_soft_write(EEPROM_DIR_24LC256 | RW);
        I2C_soft_write((registro & BYTE_ALTO)>>8);
        I2C_soft_write(registro & BYTE_BAJO);
        for(;i < bytes;i++){
            I2C_soft_write(dato[i]);
            if(++registro%64 == 0){
                i++;
                break;
            }
        }
        I2C_soft_stop();
        while(true){
          I2C_soft_start();
          if(!I2C_soft_write(EEPROM_DIR_24LC256))
            break;
        }
        I2C_soft_stop();      // Issue stop signal
    }
}


//FUNCION LECTURA
/*Escribes la direccion esclavo->apuntas al registro->reinicias la lectura->direccion esclavo con bit de lectura alto*/

void eepromLeeChar(unsigned int registro, short *buffer, short bytes){
    short i;
    RW = LEE;
    I2C_soft_start();
    I2C_soft_write(EEPROM_DIR_24LC256);
    I2C_soft_write((registro & BYTE_ALTO)>>8);
    I2C_soft_write(registro & BYTE_BAJO);
    I2C_soft_start();
    I2C_soft_write(EEPROM_DIR_24LC256 | RW);
    for(i = 0;i < bytes;i++){
        if(i == bytes - 1){
            buffer[i] = I2C_soft_read(NACK);
            I2C_soft_stop();
        }
        else{
            buffer[i] = I2C_soft_read(ACK);
        }
    }
}

long eepromLeeNumero(unsigned int registro, short BYTES){
    short   i;
    long    bufferLong[4]={0,0,0,0}, lectura = 0;
    RW = LEE;
    if(BYTES == 1){
        I2C_soft_start();
        I2C_soft_write(EEPROM_DIR_24LC256);
        I2C_soft_write((registro & BYTE_ALTO)>>8);
        I2C_soft_write(registro & BYTE_BAJO);
        I2C_soft_start();
        I2C_soft_write(EEPROM_DIR_24LC256 | RW);
        bufferLong[0] = I2C_soft_read(NACK);
        I2C_soft_stop();

        return lectura = bufferLong[0];
    }
    
    if(BYTES == 2){
        I2C_soft_start();
        I2C_soft_write(EEPROM_DIR_24LC256);
        I2C_soft_write((registro & BYTE_ALTO)>>8);
        I2C_soft_write(registro & BYTE_BAJO);
        I2C_soft_start();
        I2C_soft_write(EEPROM_DIR_24LC256 | RW);
        for(i = 0;i < 2;i++){
            if(i == 2 - 1){
                bufferLong[i] = I2C_soft_read(NACK);
                I2C_soft_stop();
            }
            else{
                bufferLong[i] = I2C_soft_read(ACK);
            }
        }
        lectura = bufferLong[0];
        return lectura |= bufferLong[1]<<8;
    }
    
    if(BYTES == 4){
        I2C_soft_start();
        I2C_soft_write(EEPROM_DIR_24LC256);
        I2C_soft_write((registro & BYTE_ALTO)>>8);
        I2C_soft_write(registro & BYTE_BAJO);
        I2C_soft_start();
        I2C_soft_write(EEPROM_DIR_24LC256 | RW);
        for(i = 0;i < 4;i++){
            if(i == 4 - 1){
                bufferLong[i] = I2C_soft_read(NACK);
                I2C_soft_stop();
            }
            else{
                bufferLong[i] = I2C_soft_read(ACK);
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