#ifndef _TABLA_H
#define _TABLA_H

#include "eepromi2cBrian_v2.h"
#include "lcd_4x20.h"
#define BYTE                    1
#define DOSBYTE                 2
#define CUATROBYTE              4
#define MaximoNombreTabla       15
#define creacionExitosa         'S'
#define nombreDesbordado        1
#define nombreColumnaDesborda   2
#define espacioDesborda         3
#define nombreRepetido          'N'
#define tabla_NA                5

 struct baseDatos{
     char           nombreTabla[MaximoNombreTabla + 1];
     char           nombreColumna[MaximoNombreTabla +1];
     short          tablasTotales;
     short          columnasTotales;
     short          capacidadColumna;
     int            filasTotales;
     int            filasProgramadas;
     unsigned int   filaEscrituraLectura;
     unsigned int   direccionTabla;
     unsigned int   direccionDinamica;
     unsigned int   direccionColumna;
     unsigned int   capacidad;
     unsigned int   capacidadMaxima;
     
}objBaseDatos;

void baseDatosSoftReset(){
    
    int i;
    
    objBaseDatos.tablasTotales = 0x00;
    objBaseDatos.capacidad = 0x0003;
    objBaseDatos.direccionTabla = 0x0003;
    objBaseDatos.direccionDinamica = 0x0000;
    eepromEscribeNumero(objBaseDatos.direccionDinamica, objBaseDatos.tablasTotales, BYTE);
    eepromEscribeNumero(objBaseDatos.direccionDinamica + BYTE, objBaseDatos.capacidad, DOSBYTE);
}

void baseDatosHardReset(){
    
    long i;
    short reset=0x0000000000000000000000000000000000000000000000000000000000000000;
    char  resc[]="0000000000000000000000000000000000000000000000000000000000000000";
                  
    objBaseDatos.tablasTotales = 0x00;
    objBaseDatos.capacidad = 0x0003;
    objBaseDatos.direccionTabla = 0x0003;
    objBaseDatos.direccionDinamica = 0x0000;
    eepromEscribeNumero(objBaseDatos.direccionDinamica, objBaseDatos.tablasTotales, BYTE);
    eepromEscribeNumero(objBaseDatos.direccionDinamica + BYTE, objBaseDatos.capacidad, DOSBYTE);
    for(i = 0;i < 4000;i++){
        eepromEscribeChar(objBaseDatos.direccionTabla, resc, 64);
        objBaseDatos.direccionTabla += 64;
    }
    objBaseDatos.direccionTabla = 0x0003;
}

void iniciaBaseDatos(unsigned int capacidadMaxima){
    objBaseDatos.columnasTotales = 0;
    objBaseDatos.filasTotales = 0;
    objBaseDatos.filasProgramadas = 0;
    objBaseDatos.nombreTabla [0] = 0;
    objBaseDatos.nombreColumna [0] = 0;
    objBaseDatos.capacidadMaxima = capacidadMaxima;
    iniciaEeprom();
    objBaseDatos.tablasTotales = eepromLeeNumero(0x0000, BYTE);
    objBaseDatos.capacidad = eepromLeeNumero(0x0001, DOSBYTE);
}

bool busquedaBaseDatos(char *nombreBusqueda){
    
    unsigned short  aux, i;
    char            *aux2,*aux3;
    
    objBaseDatos.direccionTabla = 0x0003;
    objBaseDatos.direccionDinamica = 0x0003;
    objBaseDatos.nombreColumna[0] = 0;
    
    for(aux = 0;aux < objBaseDatos.tablasTotales;aux ++){

        eepromLeeChar(objBaseDatos.direccionTabla, objBaseDatos.nombreTabla, MaximoNombreTabla + BYTE);
        if(!strncmp(nombreBusqueda, objBaseDatos.nombreTabla, 14)){
            objBaseDatos.direccionDinamica = objBaseDatos.direccionTabla;
            objBaseDatos.direccionDinamica += MaximoNombreTabla + BYTE + DOSBYTE;
            objBaseDatos.filasProgramadas = eepromLeeNumero(objBaseDatos.direccionDinamica, DOSBYTE);
            objBaseDatos.filasTotales = eepromLeeNumero(objBaseDatos.direccionDinamica += DOSBYTE, DOSBYTE);
            objBaseDatos.columnasTotales = eepromLeeNumero(objBaseDatos.direccionDinamica += DOSBYTE, DOSBYTE);
            return true;
        }
        objBaseDatos.direccionTabla += eepromLeeNumero(objBaseDatos.direccionTabla + MaximoNombreTabla + BYTE, DOSBYTE); //->310+3=313;//->1040(0x0410)+3=1043(0x0413)
    }
    objBaseDatos.nombreTabla[0] = 0;
    return false;
}

char baseDatosNueva(char *nombreTablaNueva, char *nombreColumnasNuevas, int filas){
    
    unsigned int    capacidadCalculada=0, acumulador = 0, aux3=0, capacidadColumnaBytes=0;
    short           i, columnasAescribir=0, aux;          //Para convertir el texto en entero
    char            capacidadColumna[]="0";
    objBaseDatos.nombreTabla[0] = 0;
        
    if(strlen(nombreTablaNueva) > MaximoNombreTabla){
        return nombreDesbordado;
    }
    
    /*Calcula el tamaño total de la tabla a crear*/
    if(!busquedaBaseDatos(nombreTablaNueva)){
        columnasAescribir = 0;
        capacidadCalculada = MaximoNombreTabla + BYTE + DOSBYTE + DOSBYTE + DOSBYTE + BYTE;       //NOMBRE TABLA + BYTE + CAPACIDAD TOTAL TABLA + FILA PERTINENTE + FILAS TOTALES + COLUMNAS TOTALES = 23
        aux = 0;
        aux3 = 0;
        while(nombreColumnasNuevas[aux3]){/*busca toda la cadena del nombre de la columna hasta encontrar &*/
            aux++;
            if(nombreColumnasNuevas[aux3++] == '&'){ 
                if(aux > MaximoNombreTabla + BYTE){
                    return nombreColumnaDesborda;
                }
                capacidadCalculada += MaximoNombreTabla + BYTE;                                     //ASIGNAMOS 16 BYTES PARA EL NOMBRE DE LA COLUMNA = 39
                capacidadCalculada += BYTE;                                                         //ASIGNAMOS 1 BYTE PARA GUADAR EL TAMAÑO DE COLUMNA = 40
                aux = 0;
                i = 0;
                while(nombreColumnasNuevas[aux3] != '\n' && nombreColumnasNuevas[aux3]){/*Buscamos por el caracter que nos indica el tamaño en bytes que tendran las filas de esta columna*/
                    capacidadColumna[i++] = nombreColumnasNuevas[aux3++];
                }/*Buscamos por el caracter que nos indica el tamaño en bytes que tendran las filas de esta columna*/
                columnasAescribir++;
                capacidadColumna[i] = 0;                                                            //FINAL DE CADENA
                capacidadCalculada += filas*atoi(capacidadColumna);                                 //CAPACIDAD TOTAL DE LA COLUMNA
            }
        }/*busca toda la cadena del nombre de la columna hasta encontrar &*/
    }else{
        return nombreRepetido;
    }/*Calcula el tamaño de la tabla a crear*/
    
    /*Escribe la Tabla si el tamaño total calculado sumado al espacio total ya ocupado no excede el tamaño Maximo asignado*/
    if(objBaseDatos.capacidad + capacidadCalculada < objBaseDatos.capacidadMaxima){
        
        aux = 0;
        //capacidadCalculada += objBaseDatos.capacidad;                                                    //APUNTAMOS AL FINAL DE TODAS LAS DEMAS TABLAS PARA ESCRIBIR LA NUEVA TABLA
        objBaseDatos.filasProgramadas = 0;
        
        eepromEscribeChar(objBaseDatos.capacidad, nombreTablaNueva, MaximoNombreTabla + BYTE);          //ESCRIBE NOMBRE TABLA
        objBaseDatos.capacidad += MaximoNombreTabla + BYTE;                                             //ASIGNA ESPACIO PARA NOMBRE DE TABLA
        eepromEscribeNumero(objBaseDatos.capacidad, capacidadCalculada, DOSBYTE);                       //ESCRIBE ESPACIO TOTAL DE TABLA
        objBaseDatos.capacidad += DOSBYTE;                                                              //ASIGNA ESPACIO DONDE SE GUARDA LA INFORMACION DEL TAMAÑO TOTAL DE TABLA
        eepromEscribeNumero(objBaseDatos.capacidad, objBaseDatos.filasProgramadas, DOSBYTE);            //ESCRIBE 0 EN FILA PERTINENTE
        objBaseDatos.capacidad += DOSBYTE;                                                              //ASIGNA ESPACIO QUE ALMACENA LA INFORMACION DE FILA PERTINENTE
        eepromEscribeNumero(objBaseDatos.capacidad, filas, DOSBYTE);                                    //ESCRIBE EL NUMERO DE FILAS TOTALES PARA TODAS LAS COLUMNAS
        objBaseDatos.capacidad += DOSBYTE;                                                              //ASIGNA ESPACIO QUE ALMACENA LA INFORMACION DE FILAS TOTALES
        eepromEscribeNumero(objBaseDatos.capacidad, columnasAescribir, BYTE);                           //ESCRIBE EL NUMERO DE COLUMNAS TOTALES A ESCRIBIR
        objBaseDatos.capacidad += BYTE;                                                                 //ASIGNA ESPACIO QUE ALCENA LA INFORMACION DE COLUMNAS TOTALES A ESCRIBIR
        
        aux3 = 0;
        capacidadCalculada = objBaseDatos.capacidad;
        while(nombreColumnasNuevas[aux3]){
            eepromEscribeChar(capacidadCalculada++, &nombreColumnasNuevas[aux3++], BYTE);       //APUNTAMOS A LA DIRECCION DESPUES DE LOS PARAMETROS Y ESCRIBIMOS NOMRBE DE COLUMNA BYTEXBYTE
            if(nombreColumnasNuevas[aux3] == '&'){/*Llegamos a la condicion tope*/
                aux3++;                                                                    //AUMENTAMOS CONTADOR PARA UBICARNOS EN LA POSICION DE LA CADENA QUE CONTIENE EL TAMAÑO DE LA COLUMNA EN BYTES
                eepromEscribeChar(capacidadCalculada++, aux, BYTE);                       //ESCRIBIMOS EL FINAL DE CADENA DE LA COLUMNA ESCRITA
                objBaseDatos.capacidad += MaximoNombreTabla + BYTE;                        //AÑADIMOS EL RESTANTE DE MEMORIA DE LA CADENA DE COLUMNA PARA QUE SEAN EXACTAMENTE 16 BYTES
                i = 0;
                while(nombreColumnasNuevas[aux3]){
                    capacidadColumna[i++] = nombreColumnasNuevas[aux3++];                                  //EXTRAEMOS DE LA CADENA EL NUMERO DE BYTES QUE TENDRA CADA CELDA
                    if(nombreColumnasNuevas[aux3] == '\n'){
                        aux3++;
                        break;
                    }
                }/*Obtenemos el numero de bytes que tendra cada celda*/
                capacidadColumna[i] = 0;                                                              //FINAL DE CADENA QUE CONTIENE EL TAMAÑO DE BYTES DE NUESTRA COLUMNA
                capacidadColumnaBytes = atoi(capacidadColumna);                                         //CONVERSION A ENTERO (SHORT)
                eepromEscribeNumero(objBaseDatos.capacidad, capacidadColumnaBytes, DOSBYTE);            //ESCRIBIMOS EL TAMAÑO QUE TENDRAN NUESTRAS CELDAS EN BYTES
                objBaseDatos.capacidad += BYTE;                                                         //ASIGNAMOS EL ESPACIO D MEMORIA DONDE SE GUARDARA LA INFORMACION ESCRITA ANTERIORMENTE
                acumulador += capacidadColumnaBytes*filas;                                              //ORIGINALMENTE ACUM+= PERO LE QUITE EL + PRQUE SUMABA ERRONEAMENTE, CORREGIR.
                capacidadCalculada = objBaseDatos.capacidad;                                            //ASIGNAMOS CUANTA MEMORIA OCUPAN NUESTROS REGISTROS DE INFORMACION/CONTROL
            }/*Llegamos a la condicion tope*/
        }/*Escribimos la cadena que nombra a la columna*/
        objBaseDatos.capacidad += acumulador ;                                                           //NUEVA CAPACIDAD TOTAL DE NUESTRA MEMORIA
        objBaseDatos.tablasTotales++;                                                                   //REGISTRAMOS LA CREACION DE LA NUEVA TABLA
        eepromEscribeNumero(0x0000, objBaseDatos.tablasTotales, BYTE);                                  //ESCRIBIMOS EL NUEVO TOTAL DE TABLAS EXISTENTES EN LA MEMORIA
        eepromEscribeNumero(0x0001, objBaseDatos.capacidad, DOSBYTE);                                   //ESCRIBIMOS LA NUEVA CAPACIDAD TOTAL DE NUESTRA MEMORIA
    }/*Escribe la Tabla si el tamaño total calculado sumado al espacio total ya ocupado no excede el tamaño Maximo asignado*/
    else{
        return espacioDesborda;
    }
    return creacionExitosa;
}

unsigned int encuentraDireccion(char *nombreTablaEscribir, char *nombreColumnaEscribir, int filaEscribir){
    
    short   i=0, aux=0, offsetVariasColumnas = 0;
    int     filaAuxiliar = 0;

    objBaseDatos.direccionDinamica = 0x03;
    objBaseDatos.tablasTotales = eepromLeeNumero(0x0000, BYTE);

    for(i = 0;i < objBaseDatos.tablasTotales;i++){
        
        eepromLeeChar(objBaseDatos.direccionDinamica, objBaseDatos.nombreTabla, MaximoNombreTabla + BYTE);
        if(!strncmp(nombreTablaEscribir, objBaseDatos.nombreTabla,strlen(nombreTablaEscribir))){
            objBaseDatos.direccionDinamica += CUATROBYTE + DOSBYTE + MaximoNombreTabla + BYTE;
            objBaseDatos.columnastotales = eepromLeeNumero(objBaseDatos.direccionDinamica, BYTE);
            objBaseDatos.direccionDinamica += BYTE;
            objBaseDatos.direccionColumna = objBaseDatos.direccionDinamica;
            for(aux = 0;aux < objBaseDatos.columnasTotales;aux++){
                eepromLeeChar(objBaseDatos.direccionColumna, objBaseDatos.nombreColumna, MaximoNombreTabla + BYTE);
                if(!strncmp(nombreColumnaEscribir, objBaseDatos.nombreColumna, strlen(nombreColumnaEscribir))){
                    offsetVariasColumnas = MaximoNombreTabla + DOSBYTE;
                    if(aux > 0){
                        offsetVariasColumnas = (objBaseDatos.columnasTotales - aux) * (MaximoNombreTabla + DOSBYTE);
                    }
                    objBaseDatos.capacidadColumna = eepromLeeNumero(objBaseDatos.direccionColumna + MaximoNombreTabla + BYTE, BYTE);
                    if(filaEscribir > 0){
                        filaAuxiliar = (filaEscribir * objBaseDatos.capacidadColumna) - objBaseDatos.capacidadColumna;
                    }
                    else{
                        return;
                    }
                    objBaseDatos.filaEscrituraLectura = objBaseDatos.direccionColumna + filaAuxiliar + offsetVariasColumnas;
                    return objBaseDatos.filaEscrituraLectura;
                }
                objBaseDatos.direccionColumna += eepromLeeNumero(objBaseDatos.direccionColumna + MaximoNombreTabla + DOSBYTE, DOSBYTE);
            }
        }
        objBaseDatos.direccionDinamica += eepromLeeNumero(objBaseDatos.direccionDinamica + MaximoNombreTabla + BYTE, DOSBYTE);
    }
}

short escribeBaseDatosNumero(char *nombreTablaEscribir, char *nombreColumnaEscribir, int filaEscribir, long Escritura, short bytes){
    if(!busquedaBaseDatos(nombreTablaEscribir)){
        
    }
    if(bytes == BYTE){
        eepromEscribeNumero(encuentraDireccion(nombreTablaEscribir, nombreColumnaEscribir, filaEscribir), Escritura, bytes);
    }
    
    if(bytes == DOSBYTE){
        eepromEscribeNumero(encuentraDireccion(nombreTablaEscribir, nombreColumnaEscribir, filaEscribir), Escritura, bytes);
    }
    
    if(bytes == CUATROBYTE){
        eepromEscribeNumero(encuentraDireccion(nombreTablaEscribir, nombreColumnaEscribir, filaEscribir), Escritura, bytes);
    }
    
    
}

long leeBaseDatosNumero(char *nombreTablaLeer, char *nombreColumnaLeer, int filaLeer, short bytes){
    
    long    Lectura;
    
    if(!busquedaBaseDatos(nombreTablaLeer)){
        
    }
    
    return Lectura = eepromLeeNumero(encuentraDireccion(nombreTablaLeer, nombreColumnaLeer, filaLeer), bytes);
}

void escribeBaseDatosChar(char *nombreTablaEscribir, char *nombreColumnaEscribir, int filaEscribir, char *datos, short bytes){
    if(!busquedaBaseDatos(nombreTablaEscribir)){
        
    }
    
    eepromEscribeChar(encuentraDireccion(nombreTablaEscribir, nombreColumnaEscribir, filaEscribir), datos, bytes);
}

void leeBaseDatosChar(char *nombreTablaLeer, char *nombreColumnaLeer, int filaLeer, char *datos, short bytes){
    if(!busquedaBaseDatos(nombreTablaLeer)){
        
    }
    
    eepromLeeChar(encuentraDireccion(nombreTablaLeer, nombreColumnaLeer, filaLeer), datos, bytes);
}
#endif