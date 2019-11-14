#ifndef _TABLA_H
#define _TABLA_H

#include "eeprom_i2c_soft_Brian.h"

#define BYTE                    1
#define DOSBYTE                 2
#define CUATROBYTE              4
#define MaximoNombreTabla       15
#define creacionExitosa         0
#define nombreDesbordado        1
#define nombreColumnaDesborda   2
#define espacioDesborda         3
#define nombreRepetido          4
#define tabla_NA                5

 struct baseDatos{
     char           nombreTabla[MaximoNombreTabla + 1];
     char           nombreColumna[MaximoNombreTabla +1];
     unsigned short tablasTotales;
     short          columnasTotales;
     int            filasTotales;
     int            filaPertinente;
     short          capacidadColumna;
     unsigned int   direccionTabla;
     unsigned int   direccionDinamica;
     unsigned int   direccionColumna;
     unsigned int   capacidad;
     unsigned int   capacidadMaxima;
     
}objBaseDatos;

void baseDatosSoftReset(){
    
    int i;
    
    objBaseDatos.tablasTotales = 0;
    objBaseDatos.capacidad = 3;
    objBaseDatos.direccionTabla = 0x0003;
    eepromEscribeChar(0x0000, (char*)&objBaseDatos.tablasTotales, BYTE);
    eepromEscribeChar(0x0001, (char*)&objBaseDatos.capacidad, DOSBYTE);
}

void baseDatosHardReset(){
    
    long i;
    short reset=0x0000000000000000000000000000000000000000000000000000000000000000;
    char  resc[]="0000000000000000000000000000000000000000000000000000000000000000";
                  
    objBaseDatos.tablasTotales = 0;
    objBaseDatos.capacidad = 3;
    objBaseDatos.direccionTabla = 0x0003;
    eepromEscribeChar(0x0000, (char*)&objBaseDatos.tablasTotales, BYTE);
    eepromEscribeChar(0x0001, (char*)&objBaseDatos.capacidad, DOSBYTE);
    for(i = 0;i < 4000;i++){
        eepromEscribeChar(objBaseDatos.direccionTabla, resc, 64);
        objBaseDatos.direccionTabla += 64;
    }
    objBaseDatos.direccionTabla = 0x0003;
}

void iniciaBaseDatos(unsigned int capacidadMaxima){
    objBaseDatos.columnasTotales = 0;
    objBaseDatos.filasTotales = 0;
    objBaseDatos.filaPertinente = 0;
    objBaseDatos.nombreTabla [0] = 0;
    objBaseDatos.nombreColumna [0] = 0;
    objBaseDatos.capacidadMaxima = capacidadMaxima;
    iniciaEeprom();
    eepromLeeChar(0x0000, (char*)&objBaseDatos.tablasTotales, BYTE);
    eepromLeeChar(0x0001, (char*)&objBaseDatos.capacidad, DOSBYTE);
}

bool busquedaBaseDatos(char *nombreBusqueda){
    
    unsigned short  aux  = 0;
    
    objBaseDatos.direccionTabla = 0x0003;
    objBaseDatos.nombreColumna[0] = 0;
    for(;aux < objBaseDatos.tablasTotales;aux ++){
        eepromLeeChar(objBaseDatos.direccionTabla, objBaseDatos.nombreTabla, MaximoNombreTabla + BYTE);
        if(!strcmp(nombreBusqueda, objBaseDatos.nombreTabla)){
            objBaseDatos.direccionDinamica = objBaseDatos.direccionTabla;
            objBaseDatos.direccionDinamica += MaximoNombreTabla + BYTE + DOSBYTE;
            eepromLeeShort(objBaseDatos.direccionDinamica, objBaseDatos.filaPertinente);
            eepromLeeint(objBaseDAtos.direccionDinamica += DOSBYTE, objBaseDatos.filasTotales);
            eepromLeeShort(objBaseDAtos.direccionDinamica += DOSBYTE, objBaseDatos.columnasTotales);
            return true;
        }
        eepromLeeChar(objBaseDatos.direccionTabla + MaximoNombreTabla + BYTE, (char*)&objBaseDatos.direccionTabla, DOSBYTE);
    }
    return false;
}

char baseDatosNueva(char *nombreTablaNueva, char *nombreColumnasNuevas, int filas){
    
    unsigned int    capacidadCalculada, acumulador, aux3;
    char           i, columnasAescribir, aux, capacidadColumnaBytes;          //Para convertir el texto en entero
    char            capacidadColumna[4];
        
    if(strlen(nombreTablaNueva) > MaximoNombreTabla){
        return nombreDesbordado;
    }
    
    /*Calcula el tamaño total de la tabla a crear*/
    if(!busquedaBaseDatos(nombreTablaNueva)){
        columnasAescribir = 0;
        capacidadCalculada = MaximoNombreTabla + BYTE + DOSBYTE + DOSBYTE + DOSBYTE + BYTE;                //NOMBRE TABLA + BYTE + CAPACIDAD TOTAL TABLA + FILA PERTINENTE + FILAS TOTALES + COLUMNAS TOTALES
        aux = 0;
        aux3 = 0;
        while(nombreColumnasNuevas[aux3]){
        //for(;aux < strlen(nombreColumnasNuevas);aux++){/*busca toda la cadena del nombre de la columna hasta encontrar &*/
            aux++;
            if(nombreColumnasNuevas[aux3++]=='&'){ 
                if(aux > MaximoNombreTabla + BYTE){
                    return nombreColumnaDesborda;
                }
                capacidadCalculada += MaximoNombreTabla + BYTE;                                     //ASIGNAMOS 16 BYTES PARA EL NOMBRE DE LA COLUMNA
                aux = 0;
                i = 0;
                while(nombreColumnasNuevas[aux3] != '\n' && nombreColumnasNuevas[aux3]){
                //for(;aux < strlen(nombreColumnasNuevas);aux++){/*Buscamos por el caracter que nos indica el tamaño en bytes que tendran las filas de esta columna*/
                    //if(nombreColumnasNuevas[aux] != '\n' && nombreColumnasNuevas[aux]){
                    capacidadColumna[i++] = nombreColumnasNuevas[aux3++];
                    //}
                }/*Buscamos por el caracter que nos indica el tamaño en bytes que tendran las filas de esta columna*/
                columnasAescribir++;
                capacidadColumna[i] = 0;                                                            //FINAL DE CADENA
                //capacidadCalculada += filas*atoi(capacidadColumna);                                 //CAPACIDAD TOTAL DE LA COLUMNA
                //capacidadCalculada = 310;
            }
        }/*busca toda la cadena del nombre de la columna hasta encontrar &*/
    }else{
        return nombreRepetido;
    }/*Calcula el tamaño de la tabla a crear*/
    
    /*Escribe la Tabla si el tamaño total calculado sumado al espacio total ya ocupado no excede el tamaño Maximo asignado*/
    if(objBaseDatos.capacidad + capacidadCalculada < objBaseDatos.capacidadMaxima){
        aux = 0;
        //capacidadCalculada += objBaseDatos.capacidad;
        //objBaseDatos.direccionDinamica = capacidadCalculada;                                                    //APUNTAMOS AL FINAL DE TODAS LAS DEMAS TABLAS PARA ESCRIBIR LA NUEVA TABLA
        objBaseDatos.filaPertinente = 0;
        eepromEscribeChar(objBaseDatos.capacidad, nombreTablaNueva, strlen(nombreTablaNueva) + BYTE);   //ESCRIBE NOMBRE TABLA
        objBaseDatos.capacidad += MaximoNombreTabla + BYTE;                                             //ASIGNA ESPACIO PARA NOMBRE DE TABLA
        capacidadCalculada = 310;
        eepromEscribeInt(objBaseDatos.capacidad, capacidadCalculada);                                //ESCRIBE ESPACIO TOTAL DE TABLA
        objBaseDatos.capacidad += DOSBYTE;                                                              //ASIGNA ESPACIO DONDE SE GUARDA LA INFORMACION DEL TAMAÑO TOTAL DE TABLA
        eepromEscribeChar(objBaseDatos.capacidad, (char*)&objBaseDatos.filaPertinente, DOSBYTE);      //ESCRIBE 0 EN FILA PERTINENTE
        objBaseDatos.capacidad += DOSBYTE;                                                              //ASIGNA ESPACIO QUE ALMACENA LA INFORMACION DE FILA PERTINENTE
        eepromEscribeChar(objBaseDatos.capacidad, (char*)&filas, DOSBYTE);                            //ESCRIBE EL NUMERO DE FILAS TOTALES PARA TODAS LAS COLUMNAS
        objBaseDatos.capacidad += DOSBYTE;                                                              //ASIGNA ESPACIO QUE ALMACENA LA INFORMACION DE FILAS TOTALES
        eepromEscribeChar(objBaseDatos.capacidad, &columnasAescribir, BYTE);                            //ESCRIBE EL NUMERO DE COLUMNAS TOTALES A ESCRIBIR
        objBaseDatos.capacidad += BYTE;                                                                 //ASIGNA ESPACIO QUE ALCENA LA INFORMACION DE COLUMNAS TOTALES A ESCRIBIR
        aux3 = 0;
        capacidadCalculada = objBaseDatos.capacidad;
        while(nombreColumnasNuevas[aux3]){
        //for(;aux < strlen(nombreColumnasNuevas);aux++){/*Escribimos la cadena que nombra a la columna*/
            eepromEscribeChar(capacidadCalculada++, &nombreColumnasNuevas[aux3++], BYTE);       //APUNTAMOS A LA DIRECCION DESPUES DE LOS PARAMETROS Y ESCRIBIMOS NOMRBE DE COLUMNA BYTEXBYTE
            if(nombreColumnasNuevas[aux3]=='&'){/*Llegamos a la condicion tope*/
                /*columnaAuxiliar = strtok(nombreColumnasNuevas, tope);
                eepromEscribeChar(objBaseDatos.direccionDinamica, columnaAuxiliar, strlen(columnaAuxiliar));*/
                aux3++;                                                                    //AUMENTAMOS CONTADOR PARA UBICARNOS EN LA POSICION DE LA CADENA QUE CONTIENE EL TAMAÑO DE LA COLUMNA EN BYTES
                eepromEscribeChar(capacidadCalculada++, &aux, BYTE);                       //ESCRIBIMOS EL FINAL DE CADENA DE LA COLUMNA ESCRITA
                objBaseDatos.capacidad += MaximoNombreTabla + BYTE;                //AÑADIMOS EL RESTANTE DE MEMORIA DE LA CADENA DE COLUMNA PARA QUE SEAN EXACTAMENTE 16 BYTES
                i = 0;
                while(nombreColumnasNuevas[aux3]){
                //for(;aux < strlen(nombreColumnasNuevas);aux++){/*Obtenemos el numero de bytes que tendra cada celda*/
                    capacidadColumna[i++] = nombreColumnasNuevas[aux3++];                                  //EXTRAEMOS DE LA CADENA EL NUMERO DE BYTES QUE TENDRA CADA CELDA
                    if(nombreColumnasNuevas[aux3] == '\n'){
                        aux3++;
                        break;
                    }
                }/*Obtenemos el numero de bytes que tendra cada celda*/
                capacidadColumna[i] = 0;                                                                //FINAL DE CADENA QUE CONTIENE EL TAMAÑO DE BYTES DE NUESTRA COLUMNA
                capacidadColumnaBytes = atoi(capacidadColumna);                                         //CONVERSION A ENTERO (SHORT)
                eepromEscribeChar(objBaseDatos.capacidad, &capacidadColumnaBytes, BYTE);        //ESCRIBIMOS EL TAMAÑO QUE TENDRAN NUESTRAS CELDAS EN BYTES
                objBaseDatos.capacidad += BYTE;                                                 //ASIGNAMOS EL ESPACIO D MEMORIA DONDE SE GUARDARA LA INFORMACION ESCRITA ANTERIORMENTE
                acumulador += capacidadColumnaBytes*filas;                                              //CREACION VERDADERA DE LA GRILLA
                capacidadCalculada = objBaseDatos.capacidad;                                    //ASIGNAMOS CUANTA MEMORIA OCUPAN NUESTROS REGISTROS DE INFORMACION/CONTROL
            }/*Llegamos a la condicion tope*/
        }/*Escribimos la cadena que nombra a la columna*/
        objBaseDatos.capacidad += acumulador;                                      //NUEVA CAPACIDAD TOTAL DE NUESTRA MEMORIA
        objBaseDatos.tablasTotales++;                                                                   //REGISTRAMOS LA CREACION DE LA NUEVA TABLA
        eepromEscribeChar(0x0000, &objBaseDatos.tablasTotales, BYTE);                                    //ESCRIBIMOS EL NUEVO TOTAL DE TABLAS EXISTENTES EN LA MEMORIA
        eepromEscribeChar(0x0001, (short*)&objBaseDatos.capacidad, DOSBYTE);                                     //ESCRIBIMOS LA NUEVA CAPACIDAD TOTAL DE NUESTRA MEMORIA
    }/*Escribe la Tabla si el tamaño total calculado sumado al espacio total ya ocupado no excede el tamaño Maximo asignado*/
    else{
        return espacioDesborda;
    }
    return creacionExitosa;
}

/*void agregaColumna(char *nombreColumnaNueva, short capacidadColumnaNueva){
    
}*/

int encuentraDireccion(char *nombreTablaEscribir, char *nombreColumnaEscribir, int filaEscribir){
    
    short i, aux, cp;
    objBaseDatos.direccionDinamica = 0x03;
    
    if(!busquedaBaseDatos(nombreTablaEscribir)){
        return tabla_NA;
    }
    for(i = 0;i < objBaseDatos.tablasTotales;i++){
        eepromLeeChar(objBaseDatos.direccionDinamica, objBaseDatos.nombreTabla, MaximoNombreTabla + BYTE);
        if(!strcmp(nombreTablaEscribir, objBaseDatos.nombreTabla)){
            objBaseDatos.direccionDinamica += CUATROBYTE + DOSBYTE;
            eepromLeeShort(objBaseDatos.direccionDinamica, objBaseDatos.columnasTotales);
            objBaseDatos.direccionDinamica += BYTE;
            for(aux = 0;aux < objBaseDatos.columnasTotales;aux++){
                eepromLeeChar(objBaseDatos.direccionDinamica, objBaseDatos.nombreColumna, MaximoNombreTabla + BYTE);
                if(!strcmp(nombreColumnaEscribir, objBaseDatos.nombreColumna)){
                    eepromLeeShort(objBaseDatos.direccionDinamica, objBaseDatos.capacidadColumna);
                    if(aux < objBaseDatos.columnasTotales){
                        for(;aux < objBaseDatos.columnasTotales;aux++){
                            objBaseDatos.direccionDinamica += MaximoNombreTabla + DOSBYTE;
                        }
                    }
                    return objBaseDatos.filaPertinente = objBaseDatos.direccionDinamica + (filaEscribir * objBaseDatos.capacidadColumna);
                }
                objBaseDatos.direccionColumna += objBaseDatos.direccionDinamica + MaximoNombreTabla + DOSBYTE;
                eepromLeeChar(objBaseDatos.direccionColumna, objBaseDatos.direccionDinamica, DOSBYTE);
            }
        }
        objBaseDatos.direccionTabla += objBaseDatos.direccionDinamica + MaximoNombreTabla + BYTE;
        eepromLeeInt(objBaseDatos.direccionTabla, objBaseDatos.direccionDinamica);
    }
}
/*
void escribeBaseDatosShort(char *nombreTablaEscribir, char *nombreColumnaEscribir, int filaEscribir, unsigned short *datos, short bytes){
    if(!busquedaBaseDatos(nombreTablaEscribir)){
      
    }
    
    eepromEscribeShort(encuentraDireccion(nombreTablaEscribir, nombreColumnaEscribir, filaEscribir), datos, bytes);
}

void leeBaseDatosShort(char *nombreTablaLeer, char *nombreColumnaLeer, int filaLeer, unsigned short *datos){
    if(!busquedaBaseDatos(nombreTablaLeer)){
        
    }
    
    eepromLeeShort(encuentraDireccion(nombreTablaLeer, nombreColumnaLeer, filaLeer), datos);
}

void escribeBaseDatosChar(char *nombreTablaEscribir, char *nombreColumnaEscribir, int filaEscribir, char *datos, short bytes){
    if(!busquedaBaseDatos(nombreTablaEscribir)){
        
    }
    
    eepromEscribeShort(encuentraDireccion(nombreTablaEscribir, nombreColumnaEscribir, filaEscribir), datos, bytes);
}

void leeBaseDatosChar(char *nombreTablaLeer, char *nombreColumnaLeer, int filaLeer, char *datos, short bytes){
    if(!busquedaBaseDatos(nombreTablaLeer)){
        
    }
    
    eepromLeeShort(encuentraDireccion(nombreTablaLeer, nombreColumnaLeer, filaLeer), datos);
}*/
#endif