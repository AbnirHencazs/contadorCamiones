//#include "eepromi2cBrian_v2.h"
#define PERIODOBLOQUEO  8

//ESTRUCTURAS
             //Banderas Bloqueo
struct Bloqueo{
       bool    Par1;               //sensor 1 y 2
       bool    Par2;               //sensor 3 y 4
       bool    Par3;               //sensor 5 y 6
       bool    Par4;               //sensor 1 y 3
       bool    Par5;               //sensor 1 y 5
       bool    Par6;               //sensor 3 y 5
       bool    par7;               //sensor 2 y 4
       bool    par8;               //sensor 2 y 6
       bool    par9;               //sensor 4 y 6
       bool    SensorU;            //SENSOR1
       bool    SensorD;            //SENSOR2
       bool    SensorT;            //SENSOR3
       bool    SensorC;            //SENSOR4
       bool    SensorO;            //SENSOR5
       bool    SensorS;            //SENSOR6
       }Bandera;
              //Desborde contadores para Bloqueo
struct bloqueoD{
       unsigned int    Par1;               //sensor 1 y 2
       unsigned int    Par2;               //sensor 3 y 4
       unsigned int    Par3;               //sensor 5 y 6
       unsigned int    Par4;               //sensor 1 y 3
       unsigned int    Par5;               //sensor 1 y 5
       unsigned int    Par6;               //sensor 3 y 5
       unsigned int    par7;               //sensor 2 y 4
       unsigned int    par8;               //sensor 2 y 6
       unsigned int    par9;               //sensor 4 y 6
       unsigned int    SensorU;            //SENSOR1
       unsigned int    SensorD;            //SENSOR2
       unsigned int    SensorT;            //SENSOR3
       unsigned int    SensorC;            //SENSOR4
       unsigned int    SensorO;            //SENSOR5
       unsigned int    SensorS;            //SENSOR6
       }Desborde;

unsigned int   desbordoGPS = 0, desbordoGPS_SLV = 0;
bool    EnvioCuenta = false, cuenta = false;
//CONTANDOR DESBORDE BLOQUEOS
void bloqueos(bool SENSOR1, bool SENSOR2, bool SENSOR3, bool SENSOR4, bool SENSOR5, bool SENSOR6, short *cuentaBloqueo){
    char aux[12] = {0};
    
        if(!SENSOR1 & SENSOR2){
            Desborde.SensorU = Desborde.SensorU++;
            if(Desborde.SensorU > PERIODOBLOQUEO){
                if(!Bandera.SensorU & !Bandera.Par1){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.SensorU = true;
                    Desborde.SensorU = 0;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else{
            Bandera.SensorU = false;
            Desborde.SensorU = 0;
        }

        if(!SENSOR2 & SENSOR1){
            Desborde.SensorD = Desborde.SensorD++;
            if(Desborde.SensorD > PERIODOBLOQUEO){
                if(!Bandera.SensorD & !Bandera.Par1){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.SensorD = true;
                    Desborde.SensorD = 0;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else{
            Bandera.SensorD = false;
            Desborde.SensorD = 0;
        }

        if(!SENSOR3 & SENSOR4){
            Desborde.SensorT = Desborde.SensorT++;
            if(Desborde.SensorT > PERIODOBLOQUEO){
                if(!Bandera.SensorT & !Bandera.Par2){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.SensorT = true;
                    Desborde.SensorT = 0;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else{
            Bandera.SensorT = false;
            Desborde.SensorT = 0;
        }
       
        if(!SENSOR4 & SENSOR3){
            Desborde.SensorC = Desborde.SensorC++;
            if(Desborde.SensorC > PERIODOBLOQUEO){
                if(!Bandera.SensorC & !Bandera.Par2){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.SensorC = true;
                    Desborde.SensorC = 0;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else{
            Bandera.SensorC = false;
            Desborde.SensorC = 0;
        }
       
        if(!SENSOR5 & SENSOR6){
            Desborde.SensorO = Desborde.SensorO++;
            if(Desborde.SensorO > PERIODOBLOQUEO){
                if(!Bandera.SensorO & !Bandera.Par3){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.SensorO = true;
                    Desborde.SensorO = 0;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else{
            Bandera.SensorO = false;
            Desborde.SensorO = 0;
        }
       
        if(!SENSOR6 & SENSOR5){
            Desborde.SensorS = Desborde.SensorS++;
            if(Desborde.SensorS > PERIODOBLOQUEO){
                if(!Bandera.SensorS & !Bandera.Par3){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.SensorS = true;
                    Desborde.SensorS = 0;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else{
            Bandera.SensorS = false;
            Desborde.SensorS = 0;
        }

        if(!SENSOR1 & !SENSOR2){
            Desborde.Par1 = Desborde.Par1++;
            if(Desborde.Par1 > PERIODOBLOQUEO){
                if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    cuenta = true;
                    Bandera.Par1 = true;
                    Desborde.Par1 = 0;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else if((!SENSOR1 & SENSOR2) | (SENSOR1 & !SENSOR2) | (SENSOR1 & SENSOR2)){
            Bandera.Par1 = false;
            Desborde.Par1 = 0;
        }
        
        if(!SENSOR3 & !SENSOR4){
            Desborde.Par2 = Desborde.Par2++;
            if(Desborde.Par2 > PERIODOBLOQUEO){
                if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.Par2 = true;
                    Desborde.Par2 = 0;
                    cuenta = true;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else if((!SENSOR3 & SENSOR4) | (SENSOR3 & !SENSOR4) | (SENSOR3 & SENSOR4)){
            Bandera.Par2 = false;
            Desborde.Par2 = 0;
            
        }

        if(!SENSOR5 & !SENSOR6){
            Desborde.Par3 = Desborde.Par3++;
            if(Desborde.Par3 > PERIODOBLOQUEO){
                if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.Par3 = true;
                    Desborde.Par3 = 0;
                    cuenta = true;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else if((!SENSOR5 & SENSOR6) | (SENSOR5 & !SENSOR6) | (SENSOR5 & SENSOR6)){
            Bandera.Par3 = false;
            Desborde.Par3 = 0;
            
        }
        
        if(!SENSOR1 & !SENSOR3){
            Desborde.Par4 = Desborde.Par4++;
            if(Desborde.Par4 > PERIODOBLOQUEO){
                if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.Par4 = true;
                    Desborde.Par4 = 0;
                    cuenta = true;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else if((!SENSOR1 & SENSOR3) | (SENSOR1 & !SENSOR3) | (SENSOR1 & SENSOR3)){
            Bandera.Par4 = false;
            Desborde.Par4 = 0;
        
        }
        
        if(!SENSOR1 & !SENSOR5){
            Desborde.Par6 = Desborde.Par6++;
            if(Desborde.Par6 > PERIODOBLOQUEO){
                if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.Par6 = true;
                    Desborde.Par6 = 0;
                    cuenta = true;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else if((!SENSOR1 & SENSOR5) | (SENSOR1 & !SENSOR5) | (SENSOR1 & SENSOR5)){
            Bandera.Par6 = false;
            Desborde.Par6 = 0;
        
        }
        
        if(!SENSOR2 & !SENSOR4){
            Desborde.Par7 = Desborde.Par7++;
            if(Desborde.Par7 > PERIODOBLOQUEO){
                if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    cuenta = true;
                    Bandera.Par7 = true;
                    Desborde.Par7 = 0;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else if((!SENSOR2 & SENSOR4) | (SENSOR2 & !SENSOR4) | (SENSOR2 & SENSOR4)){
            Bandera.Par7 = false;
            Desborde.Par7 = 0;
    
        }
        
        if(!SENSOR4 & !SENSOR6){
            Desborde.Par9 = Desborde.Par9++;
            if(Desborde.Par9 > PERIODOBLOQUEO){
                if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
                    (*cuentaBloqueo) = (*cuentaBloqueo) + 1;
                    Bandera.Par9 = true;
                    Desborde.Par9 = 0;
                    cuenta = true;
                    desbordoGPS = periodoEnvioGPS - 2;
                    if(!MSTR){
                        EnvioCuenta = true;
                        desbordoGPS_SLV = periodoEnvioGPS - 2;
                    }
                }
            }
        }
        else if((!SENSOR4 & SENSOR6) | (SENSOR4 & !SENSOR6) | (SENSOR4 & SENSOR6)){
            Bandera.Par9 = false;
            Desborde.Par9 = 0;
        }
        
        if( (Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9) | 
        (Bandera.Par2 & !Bandera.Par1 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) | 
        (Bandera.Par3 & !Bandera.Par2 & !Bandera.Par1 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) | 
        (Bandera.Par4 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par1 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) | 
        (Bandera.Par5 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par1 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) | 
        (Bandera.Par6 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par1 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) | 
        (Bandera.Par7 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par1 & !Bandera.Par8 & !Bandera.Par9  ) | 
        (Bandera.Par8 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par1 & !Bandera.Par9  ) | 
        (Bandera.Par9 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par1  ) |
        (Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
        (!Bandera.SensorU & Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
        (!Bandera.SensorU & !Bandera.SensorD & Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
        (!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
        (!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & Bandera.SensorO & !Bandera.SensorS) |
        (!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & Bandera.SensorS) ){
            BLOQUEOACTIVO = true;
            //(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
            //cuenta = false;
        }
        if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9 & !Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS){
            BLOQUEOACTIVO = false;
        }
    }