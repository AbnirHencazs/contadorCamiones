
_lcd_send_nibble:

;lcd_4x20.h,30 :: 		void lcd_send_nibble(char nibble){
;lcd_4x20.h,31 :: 		LCD_D4 = nibble.B0;
	BTFSC       FARG_lcd_send_nibble_nibble+0, 0 
	GOTO        L__lcd_send_nibble666
	BCF         PORTA+0, 4 
	GOTO        L__lcd_send_nibble667
L__lcd_send_nibble666:
	BSF         PORTA+0, 4 
L__lcd_send_nibble667:
;lcd_4x20.h,32 :: 		LCD_D5 = nibble.B1;
	BTFSC       FARG_lcd_send_nibble_nibble+0, 1 
	GOTO        L__lcd_send_nibble668
	BCF         PORTA+0, 2 
	GOTO        L__lcd_send_nibble669
L__lcd_send_nibble668:
	BSF         PORTA+0, 2 
L__lcd_send_nibble669:
;lcd_4x20.h,33 :: 		LCD_D6 = nibble.B2;
	BTFSC       FARG_lcd_send_nibble_nibble+0, 2 
	GOTO        L__lcd_send_nibble670
	BCF         PORTA+0, 1 
	GOTO        L__lcd_send_nibble671
L__lcd_send_nibble670:
	BSF         PORTA+0, 1 
L__lcd_send_nibble671:
;lcd_4x20.h,34 :: 		LCD_D7 = nibble.B3;
	BTFSC       FARG_lcd_send_nibble_nibble+0, 3 
	GOTO        L__lcd_send_nibble672
	BCF         PORTA+0, 0 
	GOTO        L__lcd_send_nibble673
L__lcd_send_nibble672:
	BSF         PORTA+0, 0 
L__lcd_send_nibble673:
;lcd_4x20.h,35 :: 		asm nop;
	NOP
;lcd_4x20.h,36 :: 		asm nop;
	NOP
;lcd_4x20.h,37 :: 		LCD_EN = 1;
	BSF         PORTA+0, 3 
;lcd_4x20.h,38 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_lcd_send_nibble0:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_send_nibble0
;lcd_4x20.h,39 :: 		LCD_EN = 0;
	BCF         PORTA+0, 3 
;lcd_4x20.h,40 :: 		}
L_end_lcd_send_nibble:
	RETURN      0
; end of _lcd_send_nibble

_lcd_send_byte:

;lcd_4x20.h,42 :: 		void lcd_send_byte(char address, char enviar){
;lcd_4x20.h,43 :: 		LCD_RS = 0;
	BCF         PORTE+0, 2 
;lcd_4x20.h,44 :: 		delay_us(60);
	MOVLW       99
	MOVWF       R13, 0
L_lcd_send_byte1:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_send_byte1
	NOP
	NOP
;lcd_4x20.h,46 :: 		if(address)
	MOVF        FARG_lcd_send_byte_address+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_lcd_send_byte2
;lcd_4x20.h,47 :: 		LCD_RS = 1;
	BSF         PORTE+0, 2 
	GOTO        L_lcd_send_byte3
L_lcd_send_byte2:
;lcd_4x20.h,49 :: 		LCD_RS = 0;
	BCF         PORTE+0, 2 
L_lcd_send_byte3:
;lcd_4x20.h,50 :: 		asm nop;
	NOP
;lcd_4x20.h,53 :: 		LCD_EN = 0;
	BCF         PORTA+0, 3 
;lcd_4x20.h,55 :: 		lcd_send_nibble(swap(enviar));
	MOVF        FARG_lcd_send_byte_enviar+0, 0 
	MOVWF       FARG_Swap_input+0 
	CALL        _Swap+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_lcd_send_nibble_nibble+0 
	CALL        _lcd_send_nibble+0, 0
;lcd_4x20.h,56 :: 		lcd_send_nibble(enviar);
	MOVF        FARG_lcd_send_byte_enviar+0, 0 
	MOVWF       FARG_lcd_send_nibble_nibble+0 
	CALL        _lcd_send_nibble+0, 0
;lcd_4x20.h,57 :: 		}
L_end_lcd_send_byte:
	RETURN      0
; end of _lcd_send_byte

_lcd_init:

;lcd_4x20.h,59 :: 		void lcd_init(){
;lcd_4x20.h,63 :: 		LCD_D4_Direction = 0;
	BCF         TRISA+0, 4 
;lcd_4x20.h,64 :: 		LCD_D5_Direction = 0;
	BCF         TRISA+0, 2 
;lcd_4x20.h,65 :: 		LCD_D6_Direction = 0;
	BCF         TRISA+0, 1 
;lcd_4x20.h,66 :: 		LCD_D7_Direction = 0;
	BCF         TRISA+0, 0 
;lcd_4x20.h,67 :: 		LCD_RS_Direction = 0;
	BCF         TRISE+0, 2 
;lcd_4x20.h,68 :: 		LCD_EN_Direction = 0;
	BCF         TRISA+0, 3 
;lcd_4x20.h,71 :: 		LCD_RS = 0;
	BCF         PORTE+0, 2 
;lcd_4x20.h,72 :: 		LCD_EN = 0;
	BCF         PORTA+0, 3 
;lcd_4x20.h,74 :: 		delay_ms(15);
	MOVLW       98
	MOVWF       R12, 0
	MOVLW       101
	MOVWF       R13, 0
L_lcd_init4:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_init4
	DECFSZ      R12, 1, 1
	BRA         L_lcd_init4
	NOP
	NOP
;lcd_4x20.h,76 :: 		for(i = 0; i < 3; i++){
	CLRF        lcd_init_i_L0+0 
L_lcd_init5:
	MOVLW       3
	SUBWF       lcd_init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_lcd_init6
;lcd_4x20.h,77 :: 		lcd_send_nibble(0x03);
	MOVLW       3
	MOVWF       FARG_lcd_send_nibble_nibble+0 
	CALL        _lcd_send_nibble+0, 0
;lcd_4x20.h,78 :: 		delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_lcd_init8:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_init8
	DECFSZ      R12, 1, 1
	BRA         L_lcd_init8
	NOP
;lcd_4x20.h,76 :: 		for(i = 0; i < 3; i++){
	INCF        lcd_init_i_L0+0, 1 
;lcd_4x20.h,79 :: 		}
	GOTO        L_lcd_init5
L_lcd_init6:
;lcd_4x20.h,81 :: 		lcd_send_nibble(0x02);
	MOVLW       2
	MOVWF       FARG_lcd_send_nibble_nibble+0 
	CALL        _lcd_send_nibble+0, 0
;lcd_4x20.h,83 :: 		lcd_send_byte(0, 0x28);  //Set mode: 4-bit, 2+ lines, 5x8 dots
	CLRF        FARG_lcd_send_byte_address+0 
	MOVLW       40
	MOVWF       FARG_lcd_send_byte_enviar+0 
	CALL        _lcd_send_byte+0, 0
;lcd_4x20.h,84 :: 		delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_lcd_init9:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_init9
	DECFSZ      R12, 1, 1
	BRA         L_lcd_init9
	NOP
;lcd_4x20.h,85 :: 		lcd_send_byte(0, 0x0C);  //Display on
	CLRF        FARG_lcd_send_byte_address+0 
	MOVLW       12
	MOVWF       FARG_lcd_send_byte_enviar+0 
	CALL        _lcd_send_byte+0, 0
;lcd_4x20.h,86 :: 		delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_lcd_init10:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_init10
	DECFSZ      R12, 1, 1
	BRA         L_lcd_init10
	NOP
;lcd_4x20.h,87 :: 		lcd_send_byte(0, 0x01);  //Clear display
	CLRF        FARG_lcd_send_byte_address+0 
	MOVLW       1
	MOVWF       FARG_lcd_send_byte_enviar+0 
	CALL        _lcd_send_byte+0, 0
;lcd_4x20.h,88 :: 		delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_lcd_init11:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_init11
	DECFSZ      R12, 1, 1
	BRA         L_lcd_init11
	NOP
;lcd_4x20.h,89 :: 		lcd_send_byte(0, 0x06);  //Increment cursor
	CLRF        FARG_lcd_send_byte_address+0 
	MOVLW       6
	MOVWF       FARG_lcd_send_byte_enviar+0 
	CALL        _lcd_send_byte+0, 0
;lcd_4x20.h,90 :: 		delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_lcd_init12:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_init12
	DECFSZ      R12, 1, 1
	BRA         L_lcd_init12
	NOP
;lcd_4x20.h,91 :: 		}
L_end_lcd_init:
	RETURN      0
; end of _lcd_init

_lcd_gotoxy:

;lcd_4x20.h,93 :: 		void lcd_gotoxy(char fila, char col){
;lcd_4x20.h,94 :: 		if(fila == 1)
	MOVF        FARG_lcd_gotoxy_fila+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_lcd_gotoxy13
;lcd_4x20.h,95 :: 		fila = LCD_LINE_1_ADDRESS;
	CLRF        FARG_lcd_gotoxy_fila+0 
	GOTO        L_lcd_gotoxy14
L_lcd_gotoxy13:
;lcd_4x20.h,96 :: 		else if(fila == 2)
	MOVF        FARG_lcd_gotoxy_fila+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_lcd_gotoxy15
;lcd_4x20.h,97 :: 		fila = LCD_LINE_2_ADDRESS;
	MOVLW       64
	MOVWF       FARG_lcd_gotoxy_fila+0 
	GOTO        L_lcd_gotoxy16
L_lcd_gotoxy15:
;lcd_4x20.h,98 :: 		else if(fila == 3)
	MOVF        FARG_lcd_gotoxy_fila+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_lcd_gotoxy17
;lcd_4x20.h,99 :: 		fila = LCD_LINE_3_ADDRESS;
	MOVLW       20
	MOVWF       FARG_lcd_gotoxy_fila+0 
	GOTO        L_lcd_gotoxy18
L_lcd_gotoxy17:
;lcd_4x20.h,100 :: 		else if(fila == 4)
	MOVF        FARG_lcd_gotoxy_fila+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_lcd_gotoxy19
;lcd_4x20.h,101 :: 		fila = LCD_LINE_4_ADDRESS;
	MOVLW       84
	MOVWF       FARG_lcd_gotoxy_fila+0 
	GOTO        L_lcd_gotoxy20
L_lcd_gotoxy19:
;lcd_4x20.h,103 :: 		fila = LCD_LINE_1_ADDRESS;
	CLRF        FARG_lcd_gotoxy_fila+0 
L_lcd_gotoxy20:
L_lcd_gotoxy18:
L_lcd_gotoxy16:
L_lcd_gotoxy14:
;lcd_4x20.h,105 :: 		fila += (col-1);
	DECF        FARG_lcd_gotoxy_col+0, 0 
	MOVWF       R0 
	MOVF        FARG_lcd_gotoxy_fila+0, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       FARG_lcd_gotoxy_fila+0 
;lcd_4x20.h,106 :: 		fila |= 0x80;
	BSF         R0, 7 
	MOVF        R0, 0 
	MOVWF       FARG_lcd_gotoxy_fila+0 
;lcd_4x20.h,108 :: 		lcd_send_byte(0, fila);
	CLRF        FARG_lcd_send_byte_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_lcd_send_byte_enviar+0 
	CALL        _lcd_send_byte+0, 0
;lcd_4x20.h,109 :: 		}
L_end_lcd_gotoxy:
	RETURN      0
; end of _lcd_gotoxy

_lcd_chr:

;lcd_4x20.h,111 :: 		void lcd_chr(char fila, char col, char c){
;lcd_4x20.h,112 :: 		lcd_gotoxy(fila, col);
	MOVF        FARG_lcd_chr_fila+0, 0 
	MOVWF       FARG_lcd_gotoxy_fila+0 
	MOVF        FARG_lcd_chr_col+0, 0 
	MOVWF       FARG_lcd_gotoxy_col+0 
	CALL        _lcd_gotoxy+0, 0
;lcd_4x20.h,113 :: 		lcd_send_byte(1, c);
	MOVLW       1
	MOVWF       FARG_lcd_send_byte_address+0 
	MOVF        FARG_lcd_chr_c+0, 0 
	MOVWF       FARG_lcd_send_byte_enviar+0 
	CALL        _lcd_send_byte+0, 0
;lcd_4x20.h,114 :: 		}
L_end_lcd_chr:
	RETURN      0
; end of _lcd_chr

_lcd_out:

;lcd_4x20.h,116 :: 		void lcd_out(char fila, char col, char *texto){
;lcd_4x20.h,117 :: 		char cont = 0;
	CLRF        lcd_out_cont_L0+0 
;lcd_4x20.h,119 :: 		lcd_gotoxy(fila, col);
	MOVF        FARG_lcd_out_fila+0, 0 
	MOVWF       FARG_lcd_gotoxy_fila+0 
	MOVF        FARG_lcd_out_col+0, 0 
	MOVWF       FARG_lcd_gotoxy_col+0 
	CALL        _lcd_gotoxy+0, 0
;lcd_4x20.h,120 :: 		while(texto[cont])
L_lcd_out21:
	MOVF        lcd_out_cont_L0+0, 0 
	ADDWF       FARG_lcd_out_texto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_lcd_out_texto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_lcd_out22
;lcd_4x20.h,121 :: 		lcd_send_byte(1, texto[cont++]);
	MOVLW       1
	MOVWF       FARG_lcd_send_byte_address+0 
	MOVF        lcd_out_cont_L0+0, 0 
	ADDWF       FARG_lcd_out_texto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_lcd_out_texto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_lcd_send_byte_enviar+0 
	CALL        _lcd_send_byte+0, 0
	INCF        lcd_out_cont_L0+0, 1 
	GOTO        L_lcd_out21
L_lcd_out22:
;lcd_4x20.h,122 :: 		}
L_end_lcd_out:
	RETURN      0
; end of _lcd_out

_lcd_outConst:

;lcd_4x20.h,124 :: 		void lcd_outConst(char fila, char col, const char *texto){
;lcd_4x20.h,125 :: 		char cont = 0;
	CLRF        lcd_outConst_cont_L0+0 
;lcd_4x20.h,127 :: 		lcd_gotoxy(fila, col);
	MOVF        FARG_lcd_outConst_fila+0, 0 
	MOVWF       FARG_lcd_gotoxy_fila+0 
	MOVF        FARG_lcd_outConst_col+0, 0 
	MOVWF       FARG_lcd_gotoxy_col+0 
	CALL        _lcd_gotoxy+0, 0
;lcd_4x20.h,128 :: 		while(texto[cont])
L_lcd_outConst23:
	MOVF        lcd_outConst_cont_L0+0, 0 
	ADDWF       FARG_lcd_outConst_texto+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_lcd_outConst_texto+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_lcd_outConst_texto+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_lcd_outConst24
;lcd_4x20.h,129 :: 		lcd_send_byte(1, texto[cont++]);
	MOVLW       1
	MOVWF       FARG_lcd_send_byte_address+0 
	MOVF        lcd_outConst_cont_L0+0, 0 
	ADDWF       FARG_lcd_outConst_texto+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      FARG_lcd_outConst_texto+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      FARG_lcd_outConst_texto+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_lcd_send_byte_enviar+0
	CALL        _lcd_send_byte+0, 0
	INCF        lcd_outConst_cont_L0+0, 1 
	GOTO        L_lcd_outConst23
L_lcd_outConst24:
;lcd_4x20.h,130 :: 		}
L_end_lcd_outConst:
	RETURN      0
; end of _lcd_outConst

_lcd_cmd:

;lcd_4x20.h,132 :: 		void lcd_cmd(char comando){
;lcd_4x20.h,133 :: 		lcd_send_byte(0, comando);
	CLRF        FARG_lcd_send_byte_address+0 
	MOVF        FARG_lcd_cmd_comando+0, 0 
	MOVWF       FARG_lcd_send_byte_enviar+0 
	CALL        _lcd_send_byte+0, 0
;lcd_4x20.h,134 :: 		delay_ms(2);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_lcd_cmd25:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_cmd25
	DECFSZ      R12, 1, 1
	BRA         L_lcd_cmd25
	NOP
	NOP
;lcd_4x20.h,135 :: 		}
L_end_lcd_cmd:
	RETURN      0
; end of _lcd_cmd

_bloqueos:

;bloqueos_v1.h,45 :: 		void bloqueos(bool SENSOR1, bool SENSOR2, bool SENSOR3, bool SENSOR4, bool SENSOR5, bool SENSOR6, short *cuentaBloqueo){
;bloqueos_v1.h,46 :: 		char aux[12] = {0};
;bloqueos_v1.h,48 :: 		if(!SENSOR1 & SENSOR2){
	MOVF        FARG_bloqueos_SENSOR1+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR2+0, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos26
;bloqueos_v1.h,49 :: 		Desborde.SensorU = Desborde.SensorU++;
	MOVLW       1
	ADDWF       _Desborde+18, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+19, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+18 
	MOVF        R1, 0 
	MOVWF       _Desborde+19 
;bloqueos_v1.h,50 :: 		if(Desborde.SensorU > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+19, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos682
	MOVF        _Desborde+18, 0 
	SUBLW       8
L__bloqueos682:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos27
;bloqueos_v1.h,51 :: 		if(!Bandera.SensorU & !Bandera.Par1){
	MOVF        _Bandera+9, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos28
;bloqueos_v1.h,52 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,53 :: 		Bandera.SensorU = true;
	MOVLW       1
	MOVWF       _Bandera+9 
;bloqueos_v1.h,54 :: 		Desborde.SensorU = 0;
	CLRF        _Desborde+18 
	CLRF        _Desborde+19 
;bloqueos_v1.h,55 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,56 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos29
;bloqueos_v1.h,57 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,58 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,59 :: 		}
L_bloqueos29:
;bloqueos_v1.h,60 :: 		}
L_bloqueos28:
;bloqueos_v1.h,61 :: 		}
L_bloqueos27:
;bloqueos_v1.h,62 :: 		}
	GOTO        L_bloqueos30
L_bloqueos26:
;bloqueos_v1.h,64 :: 		Bandera.SensorU = false;
	CLRF        _Bandera+9 
;bloqueos_v1.h,65 :: 		Desborde.SensorU = 0;
	CLRF        _Desborde+18 
	CLRF        _Desborde+19 
;bloqueos_v1.h,66 :: 		}
L_bloqueos30:
;bloqueos_v1.h,68 :: 		if(!SENSOR2 & SENSOR1){
	MOVF        FARG_bloqueos_SENSOR2+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR1+0, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos31
;bloqueos_v1.h,69 :: 		Desborde.SensorD = Desborde.SensorD++;
	MOVLW       1
	ADDWF       _Desborde+20, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+21, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+20 
	MOVF        R1, 0 
	MOVWF       _Desborde+21 
;bloqueos_v1.h,70 :: 		if(Desborde.SensorD > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+21, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos683
	MOVF        _Desborde+20, 0 
	SUBLW       8
L__bloqueos683:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos32
;bloqueos_v1.h,71 :: 		if(!Bandera.SensorD & !Bandera.Par1){
	MOVF        _Bandera+10, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos33
;bloqueos_v1.h,72 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,73 :: 		Bandera.SensorD = true;
	MOVLW       1
	MOVWF       _Bandera+10 
;bloqueos_v1.h,74 :: 		Desborde.SensorD = 0;
	CLRF        _Desborde+20 
	CLRF        _Desborde+21 
;bloqueos_v1.h,75 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,76 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos34
;bloqueos_v1.h,77 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,78 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,79 :: 		}
L_bloqueos34:
;bloqueos_v1.h,80 :: 		}
L_bloqueos33:
;bloqueos_v1.h,81 :: 		}
L_bloqueos32:
;bloqueos_v1.h,82 :: 		}
	GOTO        L_bloqueos35
L_bloqueos31:
;bloqueos_v1.h,84 :: 		Bandera.SensorD = false;
	CLRF        _Bandera+10 
;bloqueos_v1.h,85 :: 		Desborde.SensorD = 0;
	CLRF        _Desborde+20 
	CLRF        _Desborde+21 
;bloqueos_v1.h,86 :: 		}
L_bloqueos35:
;bloqueos_v1.h,88 :: 		if(!SENSOR3 & SENSOR4){
	MOVF        FARG_bloqueos_SENSOR3+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR4+0, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos36
;bloqueos_v1.h,89 :: 		Desborde.SensorT = Desborde.SensorT++;
	MOVLW       1
	ADDWF       _Desborde+22, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+23, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+22 
	MOVF        R1, 0 
	MOVWF       _Desborde+23 
;bloqueos_v1.h,90 :: 		if(Desborde.SensorT > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+23, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos684
	MOVF        _Desborde+22, 0 
	SUBLW       8
L__bloqueos684:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos37
;bloqueos_v1.h,91 :: 		if(!Bandera.SensorT & !Bandera.Par2){
	MOVF        _Bandera+11, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos38
;bloqueos_v1.h,92 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,93 :: 		Bandera.SensorT = true;
	MOVLW       1
	MOVWF       _Bandera+11 
;bloqueos_v1.h,94 :: 		Desborde.SensorT = 0;
	CLRF        _Desborde+22 
	CLRF        _Desborde+23 
;bloqueos_v1.h,95 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,96 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos39
;bloqueos_v1.h,97 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,98 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,99 :: 		}
L_bloqueos39:
;bloqueos_v1.h,100 :: 		}
L_bloqueos38:
;bloqueos_v1.h,101 :: 		}
L_bloqueos37:
;bloqueos_v1.h,102 :: 		}
	GOTO        L_bloqueos40
L_bloqueos36:
;bloqueos_v1.h,104 :: 		Bandera.SensorT = false;
	CLRF        _Bandera+11 
;bloqueos_v1.h,105 :: 		Desborde.SensorT = 0;
	CLRF        _Desborde+22 
	CLRF        _Desborde+23 
;bloqueos_v1.h,106 :: 		}
L_bloqueos40:
;bloqueos_v1.h,108 :: 		if(!SENSOR4 & SENSOR3){
	MOVF        FARG_bloqueos_SENSOR4+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR3+0, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos41
;bloqueos_v1.h,109 :: 		Desborde.SensorC = Desborde.SensorC++;
	MOVLW       1
	ADDWF       _Desborde+24, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+25, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+24 
	MOVF        R1, 0 
	MOVWF       _Desborde+25 
;bloqueos_v1.h,110 :: 		if(Desborde.SensorC > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+25, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos685
	MOVF        _Desborde+24, 0 
	SUBLW       8
L__bloqueos685:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos42
;bloqueos_v1.h,111 :: 		if(!Bandera.SensorC & !Bandera.Par2){
	MOVF        _Bandera+12, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos43
;bloqueos_v1.h,112 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,113 :: 		Bandera.SensorC = true;
	MOVLW       1
	MOVWF       _Bandera+12 
;bloqueos_v1.h,114 :: 		Desborde.SensorC = 0;
	CLRF        _Desborde+24 
	CLRF        _Desborde+25 
;bloqueos_v1.h,115 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,116 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos44
;bloqueos_v1.h,117 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,118 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,119 :: 		}
L_bloqueos44:
;bloqueos_v1.h,120 :: 		}
L_bloqueos43:
;bloqueos_v1.h,121 :: 		}
L_bloqueos42:
;bloqueos_v1.h,122 :: 		}
	GOTO        L_bloqueos45
L_bloqueos41:
;bloqueos_v1.h,124 :: 		Bandera.SensorC = false;
	CLRF        _Bandera+12 
;bloqueos_v1.h,125 :: 		Desborde.SensorC = 0;
	CLRF        _Desborde+24 
	CLRF        _Desborde+25 
;bloqueos_v1.h,126 :: 		}
L_bloqueos45:
;bloqueos_v1.h,128 :: 		if(!SENSOR5 & SENSOR6){
	MOVF        FARG_bloqueos_SENSOR5+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR6+0, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos46
;bloqueos_v1.h,129 :: 		Desborde.SensorO = Desborde.SensorO++;
	MOVLW       1
	ADDWF       _Desborde+26, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+27, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+26 
	MOVF        R1, 0 
	MOVWF       _Desborde+27 
;bloqueos_v1.h,130 :: 		if(Desborde.SensorO > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+27, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos686
	MOVF        _Desborde+26, 0 
	SUBLW       8
L__bloqueos686:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos47
;bloqueos_v1.h,131 :: 		if(!Bandera.SensorO & !Bandera.Par3){
	MOVF        _Bandera+13, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos48
;bloqueos_v1.h,132 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,133 :: 		Bandera.SensorO = true;
	MOVLW       1
	MOVWF       _Bandera+13 
;bloqueos_v1.h,134 :: 		Desborde.SensorO = 0;
	CLRF        _Desborde+26 
	CLRF        _Desborde+27 
;bloqueos_v1.h,135 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,136 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos49
;bloqueos_v1.h,137 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,138 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,139 :: 		}
L_bloqueos49:
;bloqueos_v1.h,140 :: 		}
L_bloqueos48:
;bloqueos_v1.h,141 :: 		}
L_bloqueos47:
;bloqueos_v1.h,142 :: 		}
	GOTO        L_bloqueos50
L_bloqueos46:
;bloqueos_v1.h,144 :: 		Bandera.SensorO = false;
	CLRF        _Bandera+13 
;bloqueos_v1.h,145 :: 		Desborde.SensorO = 0;
	CLRF        _Desborde+26 
	CLRF        _Desborde+27 
;bloqueos_v1.h,146 :: 		}
L_bloqueos50:
;bloqueos_v1.h,148 :: 		if(!SENSOR6 & SENSOR5){
	MOVF        FARG_bloqueos_SENSOR6+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR5+0, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos51
;bloqueos_v1.h,149 :: 		Desborde.SensorS = Desborde.SensorS++;
	MOVLW       1
	ADDWF       _Desborde+28, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+29, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+28 
	MOVF        R1, 0 
	MOVWF       _Desborde+29 
;bloqueos_v1.h,150 :: 		if(Desborde.SensorS > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+29, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos687
	MOVF        _Desborde+28, 0 
	SUBLW       8
L__bloqueos687:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos52
;bloqueos_v1.h,151 :: 		if(!Bandera.SensorS & !Bandera.Par3){
	MOVF        _Bandera+14, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos53
;bloqueos_v1.h,152 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,153 :: 		Bandera.SensorS = true;
	MOVLW       1
	MOVWF       _Bandera+14 
;bloqueos_v1.h,154 :: 		Desborde.SensorS = 0;
	CLRF        _Desborde+28 
	CLRF        _Desborde+29 
;bloqueos_v1.h,155 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,156 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos54
;bloqueos_v1.h,157 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,158 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,159 :: 		}
L_bloqueos54:
;bloqueos_v1.h,160 :: 		}
L_bloqueos53:
;bloqueos_v1.h,161 :: 		}
L_bloqueos52:
;bloqueos_v1.h,162 :: 		}
	GOTO        L_bloqueos55
L_bloqueos51:
;bloqueos_v1.h,164 :: 		Bandera.SensorS = false;
	CLRF        _Bandera+14 
;bloqueos_v1.h,165 :: 		Desborde.SensorS = 0;
	CLRF        _Desborde+28 
	CLRF        _Desborde+29 
;bloqueos_v1.h,166 :: 		}
L_bloqueos55:
;bloqueos_v1.h,168 :: 		if(!SENSOR1 & !SENSOR2){
	MOVF        FARG_bloqueos_SENSOR1+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR2+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos56
;bloqueos_v1.h,169 :: 		Desborde.Par1 = Desborde.Par1++;
	MOVLW       1
	ADDWF       _Desborde+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+0 
	MOVF        R1, 0 
	MOVWF       _Desborde+1 
;bloqueos_v1.h,170 :: 		if(Desborde.Par1 > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos688
	MOVF        _Desborde+0, 0 
	SUBLW       8
L__bloqueos688:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos57
;bloqueos_v1.h,171 :: 		if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos58
;bloqueos_v1.h,172 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,173 :: 		cuenta = true;
	MOVLW       1
	MOVWF       _cuenta+0 
;bloqueos_v1.h,174 :: 		Bandera.Par1 = true;
	MOVLW       1
	MOVWF       _Bandera+0 
;bloqueos_v1.h,175 :: 		Desborde.Par1 = 0;
	CLRF        _Desborde+0 
	CLRF        _Desborde+1 
;bloqueos_v1.h,176 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,177 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos59
;bloqueos_v1.h,178 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,179 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,180 :: 		}
L_bloqueos59:
;bloqueos_v1.h,181 :: 		}
L_bloqueos58:
;bloqueos_v1.h,182 :: 		}
L_bloqueos57:
;bloqueos_v1.h,183 :: 		}
	GOTO        L_bloqueos60
L_bloqueos56:
;bloqueos_v1.h,184 :: 		else if((!SENSOR1 & SENSOR2) | (SENSOR1 & !SENSOR2) | (SENSOR1 & SENSOR2)){
	MOVF        FARG_bloqueos_SENSOR1+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR2+0, 0 
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR2+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR1+0, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVF        FARG_bloqueos_SENSOR2+0, 0 
	ANDWF       FARG_bloqueos_SENSOR1+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos61
;bloqueos_v1.h,185 :: 		Bandera.Par1 = false;
	CLRF        _Bandera+0 
;bloqueos_v1.h,186 :: 		Desborde.Par1 = 0;
	CLRF        _Desborde+0 
	CLRF        _Desborde+1 
;bloqueos_v1.h,187 :: 		}
L_bloqueos61:
L_bloqueos60:
;bloqueos_v1.h,189 :: 		if(!SENSOR3 & !SENSOR4){
	MOVF        FARG_bloqueos_SENSOR3+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR4+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos62
;bloqueos_v1.h,190 :: 		Desborde.Par2 = Desborde.Par2++;
	MOVLW       1
	ADDWF       _Desborde+2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+2 
	MOVF        R1, 0 
	MOVWF       _Desborde+3 
;bloqueos_v1.h,191 :: 		if(Desborde.Par2 > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos689
	MOVF        _Desborde+2, 0 
	SUBLW       8
L__bloqueos689:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos63
;bloqueos_v1.h,192 :: 		if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos64
;bloqueos_v1.h,193 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,194 :: 		Bandera.Par2 = true;
	MOVLW       1
	MOVWF       _Bandera+1 
;bloqueos_v1.h,195 :: 		Desborde.Par2 = 0;
	CLRF        _Desborde+2 
	CLRF        _Desborde+3 
;bloqueos_v1.h,196 :: 		cuenta = true;
	MOVLW       1
	MOVWF       _cuenta+0 
;bloqueos_v1.h,197 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,198 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos65
;bloqueos_v1.h,199 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,200 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,201 :: 		}
L_bloqueos65:
;bloqueos_v1.h,202 :: 		}
L_bloqueos64:
;bloqueos_v1.h,203 :: 		}
L_bloqueos63:
;bloqueos_v1.h,204 :: 		}
	GOTO        L_bloqueos66
L_bloqueos62:
;bloqueos_v1.h,205 :: 		else if((!SENSOR3 & SENSOR4) | (SENSOR3 & !SENSOR4) | (SENSOR3 & SENSOR4)){
	MOVF        FARG_bloqueos_SENSOR3+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR4+0, 0 
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR4+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR3+0, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVF        FARG_bloqueos_SENSOR4+0, 0 
	ANDWF       FARG_bloqueos_SENSOR3+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos67
;bloqueos_v1.h,206 :: 		Bandera.Par2 = false;
	CLRF        _Bandera+1 
;bloqueos_v1.h,207 :: 		Desborde.Par2 = 0;
	CLRF        _Desborde+2 
	CLRF        _Desborde+3 
;bloqueos_v1.h,209 :: 		}
L_bloqueos67:
L_bloqueos66:
;bloqueos_v1.h,211 :: 		if(!SENSOR5 & !SENSOR6){
	MOVF        FARG_bloqueos_SENSOR5+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR6+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos68
;bloqueos_v1.h,212 :: 		Desborde.Par3 = Desborde.Par3++;
	MOVLW       1
	ADDWF       _Desborde+4, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+5, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+4 
	MOVF        R1, 0 
	MOVWF       _Desborde+5 
;bloqueos_v1.h,213 :: 		if(Desborde.Par3 > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos690
	MOVF        _Desborde+4, 0 
	SUBLW       8
L__bloqueos690:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos69
;bloqueos_v1.h,214 :: 		if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos70
;bloqueos_v1.h,215 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,216 :: 		Bandera.Par3 = true;
	MOVLW       1
	MOVWF       _Bandera+2 
;bloqueos_v1.h,217 :: 		Desborde.Par3 = 0;
	CLRF        _Desborde+4 
	CLRF        _Desborde+5 
;bloqueos_v1.h,218 :: 		cuenta = true;
	MOVLW       1
	MOVWF       _cuenta+0 
;bloqueos_v1.h,219 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,220 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos71
;bloqueos_v1.h,221 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,222 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,223 :: 		}
L_bloqueos71:
;bloqueos_v1.h,224 :: 		}
L_bloqueos70:
;bloqueos_v1.h,225 :: 		}
L_bloqueos69:
;bloqueos_v1.h,226 :: 		}
	GOTO        L_bloqueos72
L_bloqueos68:
;bloqueos_v1.h,227 :: 		else if((!SENSOR5 & SENSOR6) | (SENSOR5 & !SENSOR6) | (SENSOR5 & SENSOR6)){
	MOVF        FARG_bloqueos_SENSOR5+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR6+0, 0 
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR6+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR5+0, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVF        FARG_bloqueos_SENSOR6+0, 0 
	ANDWF       FARG_bloqueos_SENSOR5+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos73
;bloqueos_v1.h,228 :: 		Bandera.Par3 = false;
	CLRF        _Bandera+2 
;bloqueos_v1.h,229 :: 		Desborde.Par3 = 0;
	CLRF        _Desborde+4 
	CLRF        _Desborde+5 
;bloqueos_v1.h,231 :: 		}
L_bloqueos73:
L_bloqueos72:
;bloqueos_v1.h,233 :: 		if(!SENSOR1 & !SENSOR3){
	MOVF        FARG_bloqueos_SENSOR1+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR3+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos74
;bloqueos_v1.h,234 :: 		Desborde.Par4 = Desborde.Par4++;
	MOVLW       1
	ADDWF       _Desborde+6, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+7, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+6 
	MOVF        R1, 0 
	MOVWF       _Desborde+7 
;bloqueos_v1.h,235 :: 		if(Desborde.Par4 > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos691
	MOVF        _Desborde+6, 0 
	SUBLW       8
L__bloqueos691:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos75
;bloqueos_v1.h,236 :: 		if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos76
;bloqueos_v1.h,237 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,238 :: 		Bandera.Par4 = true;
	MOVLW       1
	MOVWF       _Bandera+3 
;bloqueos_v1.h,239 :: 		Desborde.Par4 = 0;
	CLRF        _Desborde+6 
	CLRF        _Desborde+7 
;bloqueos_v1.h,240 :: 		cuenta = true;
	MOVLW       1
	MOVWF       _cuenta+0 
;bloqueos_v1.h,241 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,242 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos77
;bloqueos_v1.h,243 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,244 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,245 :: 		}
L_bloqueos77:
;bloqueos_v1.h,246 :: 		}
L_bloqueos76:
;bloqueos_v1.h,247 :: 		}
L_bloqueos75:
;bloqueos_v1.h,248 :: 		}
	GOTO        L_bloqueos78
L_bloqueos74:
;bloqueos_v1.h,249 :: 		else if((!SENSOR1 & SENSOR3) | (SENSOR1 & !SENSOR3) | (SENSOR1 & SENSOR3)){
	MOVF        FARG_bloqueos_SENSOR1+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR3+0, 0 
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR3+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR1+0, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVF        FARG_bloqueos_SENSOR3+0, 0 
	ANDWF       FARG_bloqueos_SENSOR1+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos79
;bloqueos_v1.h,250 :: 		Bandera.Par4 = false;
	CLRF        _Bandera+3 
;bloqueos_v1.h,251 :: 		Desborde.Par4 = 0;
	CLRF        _Desborde+6 
	CLRF        _Desborde+7 
;bloqueos_v1.h,253 :: 		}
L_bloqueos79:
L_bloqueos78:
;bloqueos_v1.h,255 :: 		if(!SENSOR1 & !SENSOR5){
	MOVF        FARG_bloqueos_SENSOR1+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR5+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos80
;bloqueos_v1.h,256 :: 		Desborde.Par6 = Desborde.Par6++;
	MOVLW       1
	ADDWF       _Desborde+10, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+11, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+10 
	MOVF        R1, 0 
	MOVWF       _Desborde+11 
;bloqueos_v1.h,257 :: 		if(Desborde.Par6 > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+11, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos692
	MOVF        _Desborde+10, 0 
	SUBLW       8
L__bloqueos692:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos81
;bloqueos_v1.h,258 :: 		if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos82
;bloqueos_v1.h,259 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,260 :: 		Bandera.Par6 = true;
	MOVLW       1
	MOVWF       _Bandera+5 
;bloqueos_v1.h,261 :: 		Desborde.Par6 = 0;
	CLRF        _Desborde+10 
	CLRF        _Desborde+11 
;bloqueos_v1.h,262 :: 		cuenta = true;
	MOVLW       1
	MOVWF       _cuenta+0 
;bloqueos_v1.h,263 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,264 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos83
;bloqueos_v1.h,265 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,266 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,267 :: 		}
L_bloqueos83:
;bloqueos_v1.h,268 :: 		}
L_bloqueos82:
;bloqueos_v1.h,269 :: 		}
L_bloqueos81:
;bloqueos_v1.h,270 :: 		}
	GOTO        L_bloqueos84
L_bloqueos80:
;bloqueos_v1.h,271 :: 		else if((!SENSOR1 & SENSOR5) | (SENSOR1 & !SENSOR5) | (SENSOR1 & SENSOR5)){
	MOVF        FARG_bloqueos_SENSOR1+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR5+0, 0 
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR5+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR1+0, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVF        FARG_bloqueos_SENSOR5+0, 0 
	ANDWF       FARG_bloqueos_SENSOR1+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos85
;bloqueos_v1.h,272 :: 		Bandera.Par6 = false;
	CLRF        _Bandera+5 
;bloqueos_v1.h,273 :: 		Desborde.Par6 = 0;
	CLRF        _Desborde+10 
	CLRF        _Desborde+11 
;bloqueos_v1.h,275 :: 		}
L_bloqueos85:
L_bloqueos84:
;bloqueos_v1.h,277 :: 		if(!SENSOR2 & !SENSOR4){
	MOVF        FARG_bloqueos_SENSOR2+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR4+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos86
;bloqueos_v1.h,278 :: 		Desborde.Par7 = Desborde.Par7++;
	MOVLW       1
	ADDWF       _Desborde+12, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+13, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+12 
	MOVF        R1, 0 
	MOVWF       _Desborde+13 
;bloqueos_v1.h,279 :: 		if(Desborde.Par7 > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+13, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos693
	MOVF        _Desborde+12, 0 
	SUBLW       8
L__bloqueos693:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos87
;bloqueos_v1.h,280 :: 		if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos88
;bloqueos_v1.h,281 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,282 :: 		cuenta = true;
	MOVLW       1
	MOVWF       _cuenta+0 
;bloqueos_v1.h,283 :: 		Bandera.Par7 = true;
	MOVLW       1
	MOVWF       _Bandera+6 
;bloqueos_v1.h,284 :: 		Desborde.Par7 = 0;
	CLRF        _Desborde+12 
	CLRF        _Desborde+13 
;bloqueos_v1.h,285 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,286 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos89
;bloqueos_v1.h,287 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,288 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,289 :: 		}
L_bloqueos89:
;bloqueos_v1.h,290 :: 		}
L_bloqueos88:
;bloqueos_v1.h,291 :: 		}
L_bloqueos87:
;bloqueos_v1.h,292 :: 		}
	GOTO        L_bloqueos90
L_bloqueos86:
;bloqueos_v1.h,293 :: 		else if((!SENSOR2 & SENSOR4) | (SENSOR2 & !SENSOR4) | (SENSOR2 & SENSOR4)){
	MOVF        FARG_bloqueos_SENSOR2+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR4+0, 0 
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR4+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR2+0, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVF        FARG_bloqueos_SENSOR4+0, 0 
	ANDWF       FARG_bloqueos_SENSOR2+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos91
;bloqueos_v1.h,294 :: 		Bandera.Par7 = false;
	CLRF        _Bandera+6 
;bloqueos_v1.h,295 :: 		Desborde.Par7 = 0;
	CLRF        _Desborde+12 
	CLRF        _Desborde+13 
;bloqueos_v1.h,297 :: 		}
L_bloqueos91:
L_bloqueos90:
;bloqueos_v1.h,299 :: 		if(!SENSOR4 & !SENSOR6){
	MOVF        FARG_bloqueos_SENSOR4+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR6+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos92
;bloqueos_v1.h,300 :: 		Desborde.Par9 = Desborde.Par9++;
	MOVLW       1
	ADDWF       _Desborde+16, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _Desborde+17, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _Desborde+16 
	MOVF        R1, 0 
	MOVWF       _Desborde+17 
;bloqueos_v1.h,301 :: 		if(Desborde.Par9 > PERIODOBLOQUEO){
	MOVLW       0
	MOVWF       R0 
	MOVF        _Desborde+17, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueos694
	MOVF        _Desborde+16, 0 
	SUBLW       8
L__bloqueos694:
	BTFSC       STATUS+0, 0 
	GOTO        L_bloqueos93
;bloqueos_v1.h,302 :: 		if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos94
;bloqueos_v1.h,303 :: 		(*cuentaBloqueo) = (*cuentaBloqueo) + 1;
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR0
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR0H
	MOVFF       FARG_bloqueos_cuentaBloqueo+0, FSR1
	MOVFF       FARG_bloqueos_cuentaBloqueo+1, FSR1H
	INCF        POSTINC1+0, 1 
;bloqueos_v1.h,304 :: 		Bandera.Par9 = true;
	MOVLW       1
	MOVWF       _Bandera+8 
;bloqueos_v1.h,305 :: 		Desborde.Par9 = 0;
	CLRF        _Desborde+16 
	CLRF        _Desborde+17 
;bloqueos_v1.h,306 :: 		cuenta = true;
	MOVLW       1
	MOVWF       _cuenta+0 
;bloqueos_v1.h,307 :: 		desbordoGPS = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;bloqueos_v1.h,308 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_bloqueos95
;bloqueos_v1.h,309 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;bloqueos_v1.h,310 :: 		desbordoGPS_SLV = periodoEnvioGPS - 2;
	MOVLW       178
	MOVWF       _desbordoGPS_SLV+0 
	MOVLW       0
	MOVWF       _desbordoGPS_SLV+1 
;bloqueos_v1.h,311 :: 		}
L_bloqueos95:
;bloqueos_v1.h,312 :: 		}
L_bloqueos94:
;bloqueos_v1.h,313 :: 		}
L_bloqueos93:
;bloqueos_v1.h,314 :: 		}
	GOTO        L_bloqueos96
L_bloqueos92:
;bloqueos_v1.h,315 :: 		else if((!SENSOR4 & SENSOR6) | (SENSOR4 & !SENSOR6) | (SENSOR4 & SENSOR6)){
	MOVF        FARG_bloqueos_SENSOR4+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR6+0, 0 
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        FARG_bloqueos_SENSOR6+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_bloqueos_SENSOR4+0, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
	MOVF        FARG_bloqueos_SENSOR6+0, 0 
	ANDWF       FARG_bloqueos_SENSOR4+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos97
;bloqueos_v1.h,316 :: 		Bandera.Par9 = false;
	CLRF        _Bandera+8 
;bloqueos_v1.h,317 :: 		Desborde.Par9 = 0;
	CLRF        _Desborde+16 
	CLRF        _Desborde+17 
;bloqueos_v1.h,318 :: 		}
L_bloqueos97:
L_bloqueos96:
;bloqueos_v1.h,320 :: 		if( (Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9) |
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R10 
	MOVF        R10, 0 
	ANDWF       _Bandera+0, 0 
	MOVWF       R0 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R9 
	MOVF        R9, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R8 
	MOVF        R8, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R7 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R6 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R5 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R4 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R3, 0 
	ANDWF       R0, 0 
	MOVWF       R1 
;bloqueos_v1.h,321 :: 		(Bandera.Par2 & !Bandera.Par1 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) |
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R2 
	MOVF        R2, 0 
	ANDWF       _Bandera+1, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	ANDWF       R0, 1 
	MOVF        R8, 0 
	ANDWF       R0, 1 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,322 :: 		(Bandera.Par3 & !Bandera.Par2 & !Bandera.Par1 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) |
	MOVF        R10, 0 
	ANDWF       _Bandera+2, 0 
	MOVWF       R0 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	MOVF        R8, 0 
	ANDWF       R0, 1 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,323 :: 		(Bandera.Par4 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par1 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) |
	MOVF        R10, 0 
	ANDWF       _Bandera+3, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	ANDWF       R0, 1 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,324 :: 		(Bandera.Par5 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par1 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) |
	MOVF        R10, 0 
	ANDWF       _Bandera+4, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	ANDWF       R0, 1 
	MOVF        R8, 0 
	ANDWF       R0, 1 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,325 :: 		(Bandera.Par6 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par1 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9  ) |
	MOVF        R10, 0 
	ANDWF       _Bandera+5, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	ANDWF       R0, 1 
	MOVF        R8, 0 
	ANDWF       R0, 1 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,326 :: 		(Bandera.Par7 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par1 & !Bandera.Par8 & !Bandera.Par9  ) |
	MOVF        R10, 0 
	ANDWF       _Bandera+6, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	ANDWF       R0, 1 
	MOVF        R8, 0 
	ANDWF       R0, 1 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,327 :: 		(Bandera.Par8 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par1 & !Bandera.Par9  ) |
	MOVF        R10, 0 
	ANDWF       _Bandera+7, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	ANDWF       R0, 1 
	MOVF        R8, 0 
	ANDWF       R0, 1 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,328 :: 		(Bandera.Par9 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par1  ) |
	MOVF        R10, 0 
	ANDWF       _Bandera+8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	ANDWF       R0, 1 
	MOVF        R8, 0 
	ANDWF       R0, 1 
	MOVF        R7, 0 
	ANDWF       R0, 1 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,329 :: 		(Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
	MOVF        _Bandera+10, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R7 
	MOVF        R7, 0 
	ANDWF       _Bandera+9, 0 
	MOVWF       R0 
	MOVF        _Bandera+11, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R6 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+12, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R5 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+13, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R4 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        _Bandera+14, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,330 :: 		(!Bandera.SensorU & Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
	MOVF        _Bandera+9, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R2 
	MOVF        _Bandera+10, 0 
	ANDWF       R2, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	ANDWF       R0, 1 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,331 :: 		(!Bandera.SensorU & !Bandera.SensorD & Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
	MOVF        R7, 0 
	ANDWF       R2, 1 
	MOVF        _Bandera+11, 0 
	ANDWF       R2, 0 
	MOVWF       R0 
	MOVF        R5, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,332 :: 		(!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS) |
	MOVF        R6, 0 
	ANDWF       R2, 1 
	MOVF        _Bandera+12, 0 
	ANDWF       R2, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,333 :: 		(!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & Bandera.SensorO & !Bandera.SensorS) |
	MOVF        R5, 0 
	ANDWF       R2, 1 
	MOVF        _Bandera+13, 0 
	ANDWF       R2, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       R1, 1 
;bloqueos_v1.h,334 :: 		(!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & Bandera.SensorS) ){
	MOVF        R4, 0 
	ANDWF       R2, 0 
	MOVWF       R0 
	MOVF        _Bandera+14, 0 
	ANDWF       R0, 1 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos98
;bloqueos_v1.h,335 :: 		BLOQUEOACTIVO = true;
	BSF         PORTC+0, 3 
;bloqueos_v1.h,338 :: 		}
L_bloqueos98:
;bloqueos_v1.h,339 :: 		if(!Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9 & !Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+9, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+10, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+11, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+12, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+13, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+14, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_bloqueos99
;bloqueos_v1.h,340 :: 		BLOQUEOACTIVO = false;
	BCF         PORTC+0, 3 
;bloqueos_v1.h,341 :: 		}
L_bloqueos99:
;bloqueos_v1.h,342 :: 		}
L_end_bloqueos:
	RETURN      0
; end of _bloqueos

_I2C_soft_init:

;i2c_soft.h,16 :: 		void I2C_soft_init(){
;i2c_soft.h,18 :: 		I2C_SCLD = 1;
	BSF         TRISD+0, 7 
;i2c_soft.h,19 :: 		I2C_SDAD = 1;
	BSF         TRISD+0, 6 
;i2c_soft.h,20 :: 		}
L_end_I2C_soft_init:
	RETURN      0
; end of _I2C_soft_init

_I2C_soft_start:

;i2c_soft.h,22 :: 		void I2C_soft_start(){
;i2c_soft.h,24 :: 		I2C_SDAD = 1;
	BSF         TRISD+0, 6 
;i2c_soft.h,25 :: 		I2C_SCLD = 1;
	BSF         TRISD+0, 7 
;i2c_soft.h,26 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_start100:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_start100
;i2c_soft.h,28 :: 		I2C_SDAD = 0;
	BCF         TRISD+0, 6 
;i2c_soft.h,29 :: 		I2C_SDA = 0;  //Señal en bajo
	BCF         PORTD+0, 6 
;i2c_soft.h,30 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_start101:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_start101
;i2c_soft.h,32 :: 		I2C_SCLD = 0;
	BCF         TRISD+0, 7 
;i2c_soft.h,33 :: 		I2C_SCL = 0;  //Señal en bajo
	BCF         PORTD+0, 7 
;i2c_soft.h,34 :: 		}
L_end_I2C_soft_start:
	RETURN      0
; end of _I2C_soft_start

_I2C_soft_stop:

;i2c_soft.h,36 :: 		void I2C_soft_stop(){
;i2c_soft.h,37 :: 		I2C_SDAD = 0;  //Configuro de salida por seguridad
	BCF         TRISD+0, 6 
;i2c_soft.h,38 :: 		I2C_SDA = 0;   //Mando cero por el protocolo
	BCF         PORTD+0, 6 
;i2c_soft.h,39 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_stop102:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_stop102
;i2c_soft.h,40 :: 		I2C_SCLD = 1;
	BSF         TRISD+0, 7 
;i2c_soft.h,41 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_stop103:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_stop103
;i2c_soft.h,42 :: 		I2C_SDAD = 1;
	BSF         TRISD+0, 6 
;i2c_soft.h,43 :: 		}
L_end_I2C_soft_stop:
	RETURN      0
; end of _I2C_soft_stop

_I2C_soft_write:

;i2c_soft.h,45 :: 		bool I2C_soft_write(char dato){
;i2c_soft.h,49 :: 		for(i = 0; i < 8; i++){
	CLRF        R1 
L_I2C_soft_write104:
	MOVLW       8
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_I2C_soft_write105
;i2c_soft.h,50 :: 		I2C_SDA = dato.B7;  //El valor del bit
	BTFSC       FARG_I2C_soft_write_dato+0, 7 
	GOTO        L__I2C_soft_write699
	BCF         PORTD+0, 6 
	GOTO        L__I2C_soft_write700
L__I2C_soft_write699:
	BSF         PORTD+0, 6 
L__I2C_soft_write700:
;i2c_soft.h,51 :: 		I2C_SCL = 1;        //Activar dato
	BSF         PORTD+0, 7 
;i2c_soft.h,52 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_write107:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_write107
;i2c_soft.h,53 :: 		dato <<= 1;         //Recorro hacia la izquierda
	RLCF        FARG_I2C_soft_write_dato+0, 1 
	BCF         FARG_I2C_soft_write_dato+0, 0 
;i2c_soft.h,54 :: 		I2C_SCL = 0;
	BCF         PORTD+0, 7 
;i2c_soft.h,55 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_write108:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_write108
;i2c_soft.h,49 :: 		for(i = 0; i < 8; i++){
	INCF        R1, 1 
;i2c_soft.h,56 :: 		}
	GOTO        L_I2C_soft_write104
L_I2C_soft_write105:
;i2c_soft.h,59 :: 		I2C_SDAD = 1;
	BSF         TRISD+0, 6 
;i2c_soft.h,60 :: 		asm nop;
	NOP
;i2c_soft.h,61 :: 		I2C_SCL = 1;     //Mandar el púlso para recibir el ACK
	BSF         PORTD+0, 7 
;i2c_soft.h,62 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_write109:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_write109
;i2c_soft.h,63 :: 		i.B0 = I2C_SDA;  //Guardo el valor del ACK
	BTFSC       PORTD+0, 6 
	GOTO        L__I2C_soft_write701
	BCF         R1, 0 
	GOTO        L__I2C_soft_write702
L__I2C_soft_write701:
	BSF         R1, 0 
L__I2C_soft_write702:
;i2c_soft.h,64 :: 		I2C_SCL = 0;
	BCF         PORTD+0, 7 
;i2c_soft.h,65 :: 		I2C_SDAD = 0;    //Configurar como salida el pin
	BCF         TRISD+0, 6 
;i2c_soft.h,67 :: 		return i.B0;
	MOVLW       0
	BTFSC       R1, 0 
	MOVLW       1
	MOVWF       R0 
;i2c_soft.h,68 :: 		}
L_end_I2C_soft_write:
	RETURN      0
; end of _I2C_soft_write

_I2C_soft_read:

;i2c_soft.h,70 :: 		char I2C_soft_read(bool ACK){
;i2c_soft.h,71 :: 		char i, result = 0;
	CLRF        I2C_soft_read_result_L0+0 
;i2c_soft.h,74 :: 		I2C_SDAD = 1;
	BSF         TRISD+0, 6 
;i2c_soft.h,76 :: 		for(i = 0; i < 8; i++){
	CLRF        R1 
L_I2C_soft_read110:
	MOVLW       8
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_I2C_soft_read111
;i2c_soft.h,77 :: 		result <<= 1;
	RLCF        I2C_soft_read_result_L0+0, 1 
	BCF         I2C_soft_read_result_L0+0, 0 
;i2c_soft.h,78 :: 		I2C_SCL = 1;
	BSF         PORTD+0, 7 
;i2c_soft.h,79 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_read113:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_read113
;i2c_soft.h,81 :: 		if(I2C_SDA)
	BTFSS       PORTD+0, 6 
	GOTO        L_I2C_soft_read114
;i2c_soft.h,82 :: 		result |= 0x01;
	BSF         I2C_soft_read_result_L0+0, 0 
L_I2C_soft_read114:
;i2c_soft.h,83 :: 		I2C_SCL = 0;
	BCF         PORTD+0, 7 
;i2c_soft.h,84 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_read115:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_read115
;i2c_soft.h,76 :: 		for(i = 0; i < 8; i++){
	INCF        R1, 1 
;i2c_soft.h,85 :: 		}
	GOTO        L_I2C_soft_read110
L_I2C_soft_read111:
;i2c_soft.h,88 :: 		I2C_SDAD = 0;
	BCF         TRISD+0, 6 
;i2c_soft.h,89 :: 		I2C_SDA = !ACK.B0;  //Señal negada
	BTFSC       FARG_I2C_soft_read_ACK+0, 0 
	GOTO        L__I2C_soft_read704
	BSF         PORTD+0, 6 
	GOTO        L__I2C_soft_read705
L__I2C_soft_read704:
	BCF         PORTD+0, 6 
L__I2C_soft_read705:
;i2c_soft.h,90 :: 		asm nop;
	NOP
;i2c_soft.h,91 :: 		I2C_SCL = 1;
	BSF         PORTD+0, 7 
;i2c_soft.h,92 :: 		delay_us(2);
	MOVLW       3
	MOVWF       R13, 0
L_I2C_soft_read116:
	DECFSZ      R13, 1, 1
	BRA         L_I2C_soft_read116
;i2c_soft.h,93 :: 		I2C_SCL = 0;
	BCF         PORTD+0, 7 
;i2c_soft.h,95 :: 		return result;
	MOVF        I2C_soft_read_result_L0+0, 0 
	MOVWF       R0 
;i2c_soft.h,96 :: 		}
L_end_I2C_soft_read:
	RETURN      0
; end of _I2C_soft_read

_iniciaEeprom:

;eepromi2cbrian_v2.h,22 :: 		void iniciaEeprom(){
;eepromi2cbrian_v2.h,23 :: 		I2C_soft_init();
	CALL        _I2C_soft_init+0, 0
;eepromi2cbrian_v2.h,24 :: 		}
L_end_iniciaEeprom:
	RETURN      0
; end of _iniciaEeprom

_eepromEscribeNumero:

;eepromi2cbrian_v2.h,26 :: 		void eepromEscribeNumero(unsigned int Registro, long Dato, short BYTES){
;eepromi2cbrian_v2.h,27 :: 		long    bufferLong[] = {0,0,0,0};
	CLRF        eepromEscribeNumero_bufferLong_L0+0 
	CLRF        eepromEscribeNumero_bufferLong_L0+1 
	CLRF        eepromEscribeNumero_bufferLong_L0+2 
	CLRF        eepromEscribeNumero_bufferLong_L0+3 
	CLRF        eepromEscribeNumero_bufferLong_L0+4 
	CLRF        eepromEscribeNumero_bufferLong_L0+5 
	CLRF        eepromEscribeNumero_bufferLong_L0+6 
	CLRF        eepromEscribeNumero_bufferLong_L0+7 
	CLRF        eepromEscribeNumero_bufferLong_L0+8 
	CLRF        eepromEscribeNumero_bufferLong_L0+9 
	CLRF        eepromEscribeNumero_bufferLong_L0+10 
	CLRF        eepromEscribeNumero_bufferLong_L0+11 
	CLRF        eepromEscribeNumero_bufferLong_L0+12 
	CLRF        eepromEscribeNumero_bufferLong_L0+13 
	CLRF        eepromEscribeNumero_bufferLong_L0+14 
	CLRF        eepromEscribeNumero_bufferLong_L0+15 
	CLRF        eepromEscribeNumero_i_L0+0 
	CLRF        eepromEscribeNumero_aux_L0+0 
;eepromi2cbrian_v2.h,29 :: 		RW = ESCRIBE;
	CLRF        _RW+0 
;eepromi2cbrian_v2.h,31 :: 		bufferLong[0] = Dato & 0x000000FF;
	MOVLW       255
	ANDWF       FARG_eepromEscribeNumero_Dato+0, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+0 
	MOVF        FARG_eepromEscribeNumero_Dato+1, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+1 
	MOVF        FARG_eepromEscribeNumero_Dato+2, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+2 
	MOVF        FARG_eepromEscribeNumero_Dato+3, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+3 
	MOVLW       0
	ANDWF       eepromEscribeNumero_bufferLong_L0+1, 1 
	ANDWF       eepromEscribeNumero_bufferLong_L0+2, 1 
	ANDWF       eepromEscribeNumero_bufferLong_L0+3, 1 
;eepromi2cbrian_v2.h,32 :: 		bufferLong[1] = (Dato & 0x0000FF00)>>8;
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Dato+0, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+4 
	MOVLW       255
	ANDWF       FARG_eepromEscribeNumero_Dato+1, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+5 
	MOVF        FARG_eepromEscribeNumero_Dato+2, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+6 
	MOVF        FARG_eepromEscribeNumero_Dato+3, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+7 
	MOVLW       0
	ANDWF       eepromEscribeNumero_bufferLong_L0+6, 1 
	ANDWF       eepromEscribeNumero_bufferLong_L0+7, 1 
	MOVF        eepromEscribeNumero_bufferLong_L0+5, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+4 
	MOVF        eepromEscribeNumero_bufferLong_L0+6, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+5 
	MOVF        eepromEscribeNumero_bufferLong_L0+7, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+6 
	MOVLW       0
	BTFSC       eepromEscribeNumero_bufferLong_L0+7, 7 
	MOVLW       255
	MOVWF       eepromEscribeNumero_bufferLong_L0+7 
;eepromi2cbrian_v2.h,33 :: 		bufferLong[2] = (Dato & 0x00FF0000)>>16;
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Dato+0, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+8 
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Dato+1, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+9 
	MOVLW       255
	ANDWF       FARG_eepromEscribeNumero_Dato+2, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+10 
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Dato+3, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+11 
	MOVF        eepromEscribeNumero_bufferLong_L0+10, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+8 
	MOVF        eepromEscribeNumero_bufferLong_L0+11, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+9 
	MOVLW       0
	BTFSC       eepromEscribeNumero_bufferLong_L0+11, 7 
	MOVLW       255
	MOVWF       eepromEscribeNumero_bufferLong_L0+11 
;eepromi2cbrian_v2.h,34 :: 		bufferLong[3] = (Dato & 0xFF000000)>>24;
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Dato+0, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+12 
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Dato+1, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+13 
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Dato+2, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+14 
	MOVLW       255
	ANDWF       FARG_eepromEscribeNumero_Dato+3, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+15 
	MOVF        eepromEscribeNumero_bufferLong_L0+15, 0 
	MOVWF       eepromEscribeNumero_bufferLong_L0+12 
	CLRF        eepromEscribeNumero_bufferLong_L0+13 
	CLRF        eepromEscribeNumero_bufferLong_L0+14 
	CLRF        eepromEscribeNumero_bufferLong_L0+15 
;eepromi2cbrian_v2.h,35 :: 		if(BYTES == 1){
	MOVF        FARG_eepromEscribeNumero_BYTES+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromEscribeNumero117
;eepromi2cbrian_v2.h,36 :: 		while(i < BYTES){
L_eepromEscribeNumero118:
	MOVLW       128
	XORWF       eepromEscribeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_eepromEscribeNumero_BYTES+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromEscribeNumero119
;eepromi2cbrian_v2.h,37 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,38 :: 		I2C_soft_write(EEPROM_DIR_24LC256 | RW);
	MOVLW       160
	IORWF       _RW+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,39 :: 		I2C_soft_write((registro & BYTE_ALTO)>>8);
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Registro+0, 0 
	MOVWF       R3 
	MOVF        FARG_eepromEscribeNumero_Registro+1, 0 
	ANDLW       255
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,40 :: 		I2C_soft_write(registro & BYTE_BAJO);
	MOVLW       255
	ANDWF       FARG_eepromEscribeNumero_Registro+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,41 :: 		i++;
	INCF        eepromEscribeNumero_i_L0+0, 1 
;eepromi2cbrian_v2.h,42 :: 		I2C_soft_write(bufferLong[0]);
	MOVF        eepromEscribeNumero_bufferLong_L0+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,43 :: 		I2C_soft_stop();
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,44 :: 		while(true){
L_eepromEscribeNumero120:
;eepromi2cbrian_v2.h,45 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,46 :: 		if(!I2C_soft_write(EEPROM_DIR_24LC256))
	MOVLW       160
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromEscribeNumero122
;eepromi2cbrian_v2.h,47 :: 		break;
	GOTO        L_eepromEscribeNumero121
L_eepromEscribeNumero122:
;eepromi2cbrian_v2.h,48 :: 		}
	GOTO        L_eepromEscribeNumero120
L_eepromEscribeNumero121:
;eepromi2cbrian_v2.h,49 :: 		I2C_soft_stop();      // Issue stop signal
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,50 :: 		}
	GOTO        L_eepromEscribeNumero118
L_eepromEscribeNumero119:
;eepromi2cbrian_v2.h,51 :: 		}
L_eepromEscribeNumero117:
;eepromi2cbrian_v2.h,53 :: 		if(BYTES == 2){
	MOVF        FARG_eepromEscribeNumero_BYTES+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromEscribeNumero123
;eepromi2cbrian_v2.h,54 :: 		while(i < BYTES){
L_eepromEscribeNumero124:
	MOVLW       128
	XORWF       eepromEscribeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_eepromEscribeNumero_BYTES+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromEscribeNumero125
;eepromi2cbrian_v2.h,55 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,56 :: 		I2C_soft_write(EEPROM_DIR_24LC256 | RW);
	MOVLW       160
	IORWF       _RW+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,57 :: 		I2C_soft_write((registro & BYTE_ALTO)>>8);
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Registro+0, 0 
	MOVWF       R3 
	MOVF        FARG_eepromEscribeNumero_Registro+1, 0 
	ANDLW       255
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,58 :: 		I2C_soft_write(registro & BYTE_BAJO);
	MOVLW       255
	ANDWF       FARG_eepromEscribeNumero_Registro+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,59 :: 		for(;aux < BYTES;aux++){
L_eepromEscribeNumero126:
	MOVLW       128
	XORWF       eepromEscribeNumero_aux_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_eepromEscribeNumero_BYTES+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromEscribeNumero127
;eepromi2cbrian_v2.h,60 :: 		I2C_soft_write(bufferLong[aux]);
	MOVF        eepromEscribeNumero_aux_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromEscribeNumero_aux_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       eepromEscribeNumero_bufferLong_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(eepromEscribeNumero_bufferLong_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,61 :: 		i++;
	INCF        eepromEscribeNumero_i_L0+0, 1 
;eepromi2cbrian_v2.h,59 :: 		for(;aux < BYTES;aux++){
	INCF        eepromEscribeNumero_aux_L0+0, 1 
;eepromi2cbrian_v2.h,62 :: 		}
	GOTO        L_eepromEscribeNumero126
L_eepromEscribeNumero127:
;eepromi2cbrian_v2.h,63 :: 		I2C_soft_stop();
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,64 :: 		while(true){
L_eepromEscribeNumero129:
;eepromi2cbrian_v2.h,65 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,66 :: 		if(!I2C_soft_write(EEPROM_DIR_24LC256))
	MOVLW       160
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromEscribeNumero131
;eepromi2cbrian_v2.h,67 :: 		break;
	GOTO        L_eepromEscribeNumero130
L_eepromEscribeNumero131:
;eepromi2cbrian_v2.h,68 :: 		}
	GOTO        L_eepromEscribeNumero129
L_eepromEscribeNumero130:
;eepromi2cbrian_v2.h,69 :: 		I2C_soft_stop();      // Issue stop signal
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,70 :: 		}
	GOTO        L_eepromEscribeNumero124
L_eepromEscribeNumero125:
;eepromi2cbrian_v2.h,71 :: 		}
L_eepromEscribeNumero123:
;eepromi2cbrian_v2.h,72 :: 		if(BYTES == 4){
	MOVF        FARG_eepromEscribeNumero_BYTES+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromEscribeNumero132
;eepromi2cbrian_v2.h,73 :: 		while(i < BYTES){
L_eepromEscribeNumero133:
	MOVLW       128
	XORWF       eepromEscribeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_eepromEscribeNumero_BYTES+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromEscribeNumero134
;eepromi2cbrian_v2.h,74 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,75 :: 		I2C_soft_write(EEPROM_DIR_24LC256 | RW);
	MOVLW       160
	IORWF       _RW+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,76 :: 		I2C_soft_write((registro & BYTE_ALTO)>>8);
	MOVLW       0
	ANDWF       FARG_eepromEscribeNumero_Registro+0, 0 
	MOVWF       R3 
	MOVF        FARG_eepromEscribeNumero_Registro+1, 0 
	ANDLW       255
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,77 :: 		I2C_soft_write(registro & BYTE_BAJO);
	MOVLW       255
	ANDWF       FARG_eepromEscribeNumero_Registro+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,78 :: 		for(;i < BYTES;i++){
L_eepromEscribeNumero135:
	MOVLW       128
	XORWF       eepromEscribeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_eepromEscribeNumero_BYTES+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromEscribeNumero136
;eepromi2cbrian_v2.h,79 :: 		I2C_soft_write(bufferLong[i]);
	MOVF        eepromEscribeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromEscribeNumero_i_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       eepromEscribeNumero_bufferLong_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(eepromEscribeNumero_bufferLong_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,78 :: 		for(;i < BYTES;i++){
	INCF        eepromEscribeNumero_i_L0+0, 1 
;eepromi2cbrian_v2.h,80 :: 		}
	GOTO        L_eepromEscribeNumero135
L_eepromEscribeNumero136:
;eepromi2cbrian_v2.h,81 :: 		I2C_soft_stop();
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,82 :: 		while(true){
L_eepromEscribeNumero138:
;eepromi2cbrian_v2.h,83 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,84 :: 		if(!I2C_soft_write(EEPROM_DIR_24LC256))
	MOVLW       160
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromEscribeNumero140
;eepromi2cbrian_v2.h,85 :: 		break;
	GOTO        L_eepromEscribeNumero139
L_eepromEscribeNumero140:
;eepromi2cbrian_v2.h,86 :: 		}
	GOTO        L_eepromEscribeNumero138
L_eepromEscribeNumero139:
;eepromi2cbrian_v2.h,87 :: 		I2C_soft_stop();      // Issue stop signal
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,88 :: 		}
	GOTO        L_eepromEscribeNumero133
L_eepromEscribeNumero134:
;eepromi2cbrian_v2.h,89 :: 		}
L_eepromEscribeNumero132:
;eepromi2cbrian_v2.h,90 :: 		}
L_end_eepromEscribeNumero:
	RETURN      0
; end of _eepromEscribeNumero

_eepromEscribeChar:

;eepromi2cbrian_v2.h,92 :: 		void eepromEscribeChar(unsigned int registro, char *dato, int bytes){
;eepromi2cbrian_v2.h,93 :: 		short i = 0;
	CLRF        eepromEscribeChar_i_L0+0 
;eepromi2cbrian_v2.h,94 :: 		RW = ESCRIBE;
	CLRF        _RW+0 
;eepromi2cbrian_v2.h,96 :: 		while(i < bytes){
L_eepromEscribeChar141:
	MOVLW       128
	BTFSC       eepromEscribeChar_i_L0+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_eepromEscribeChar_bytes+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__eepromEscribeChar709
	MOVF        FARG_eepromEscribeChar_bytes+0, 0 
	SUBWF       eepromEscribeChar_i_L0+0, 0 
L__eepromEscribeChar709:
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromEscribeChar142
;eepromi2cbrian_v2.h,97 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,98 :: 		I2C_soft_write(EEPROM_DIR_24LC256 | RW);
	MOVLW       160
	IORWF       _RW+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,99 :: 		I2C_soft_write((registro & BYTE_ALTO)>>8);
	MOVLW       0
	ANDWF       FARG_eepromEscribeChar_registro+0, 0 
	MOVWF       R3 
	MOVF        FARG_eepromEscribeChar_registro+1, 0 
	ANDLW       255
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,100 :: 		I2C_soft_write(registro & BYTE_BAJO);
	MOVLW       255
	ANDWF       FARG_eepromEscribeChar_registro+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,101 :: 		for(;i < bytes;i++){
L_eepromEscribeChar143:
	MOVLW       128
	BTFSC       eepromEscribeChar_i_L0+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_eepromEscribeChar_bytes+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__eepromEscribeChar710
	MOVF        FARG_eepromEscribeChar_bytes+0, 0 
	SUBWF       eepromEscribeChar_i_L0+0, 0 
L__eepromEscribeChar710:
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromEscribeChar144
;eepromi2cbrian_v2.h,102 :: 		I2C_soft_write(dato[i]);
	MOVF        eepromEscribeChar_i_L0+0, 0 
	ADDWF       FARG_eepromEscribeChar_dato+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	BTFSC       eepromEscribeChar_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FARG_eepromEscribeChar_dato+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,103 :: 		if(++registro%64 == 0){
	INFSNZ      FARG_eepromEscribeChar_registro+0, 1 
	INCF        FARG_eepromEscribeChar_registro+1, 1 
	MOVLW       63
	ANDWF       FARG_eepromEscribeChar_registro+0, 0 
	MOVWF       R1 
	MOVF        FARG_eepromEscribeChar_registro+1, 0 
	MOVWF       R2 
	MOVLW       0
	ANDWF       R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__eepromEscribeChar711
	MOVLW       0
	XORWF       R1, 0 
L__eepromEscribeChar711:
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromEscribeChar146
;eepromi2cbrian_v2.h,104 :: 		i++;
	INCF        eepromEscribeChar_i_L0+0, 1 
;eepromi2cbrian_v2.h,105 :: 		break;
	GOTO        L_eepromEscribeChar144
;eepromi2cbrian_v2.h,106 :: 		}
L_eepromEscribeChar146:
;eepromi2cbrian_v2.h,101 :: 		for(;i < bytes;i++){
	INCF        eepromEscribeChar_i_L0+0, 1 
;eepromi2cbrian_v2.h,107 :: 		}
	GOTO        L_eepromEscribeChar143
L_eepromEscribeChar144:
;eepromi2cbrian_v2.h,108 :: 		I2C_soft_stop();
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,109 :: 		while(true){
L_eepromEscribeChar147:
;eepromi2cbrian_v2.h,110 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,111 :: 		if(!I2C_soft_write(EEPROM_DIR_24LC256))
	MOVLW       160
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromEscribeChar149
;eepromi2cbrian_v2.h,112 :: 		break;
	GOTO        L_eepromEscribeChar148
L_eepromEscribeChar149:
;eepromi2cbrian_v2.h,113 :: 		}
	GOTO        L_eepromEscribeChar147
L_eepromEscribeChar148:
;eepromi2cbrian_v2.h,114 :: 		I2C_soft_stop();      // Issue stop signal
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,115 :: 		}
	GOTO        L_eepromEscribeChar141
L_eepromEscribeChar142:
;eepromi2cbrian_v2.h,116 :: 		}
L_end_eepromEscribeChar:
	RETURN      0
; end of _eepromEscribeChar

_eepromLeeChar:

;eepromi2cbrian_v2.h,122 :: 		void eepromLeeChar(unsigned int registro, short *buffer, short bytes){
;eepromi2cbrian_v2.h,124 :: 		RW = LEE;
	MOVLW       1
	MOVWF       _RW+0 
;eepromi2cbrian_v2.h,125 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,126 :: 		I2C_soft_write(EEPROM_DIR_24LC256);
	MOVLW       160
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,127 :: 		I2C_soft_write((registro & BYTE_ALTO)>>8);
	MOVLW       0
	ANDWF       FARG_eepromLeeChar_registro+0, 0 
	MOVWF       R3 
	MOVF        FARG_eepromLeeChar_registro+1, 0 
	ANDLW       255
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,128 :: 		I2C_soft_write(registro & BYTE_BAJO);
	MOVLW       255
	ANDWF       FARG_eepromLeeChar_registro+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,129 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,130 :: 		I2C_soft_write(EEPROM_DIR_24LC256 | RW);
	MOVLW       160
	IORWF       _RW+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,131 :: 		for(i = 0;i < bytes;i++){
	CLRF        eepromLeeChar_i_L0+0 
L_eepromLeeChar150:
	MOVLW       128
	XORWF       eepromLeeChar_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_eepromLeeChar_bytes+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromLeeChar151
;eepromi2cbrian_v2.h,132 :: 		if(i == bytes - 1){
	DECF        FARG_eepromLeeChar_bytes+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_eepromLeeChar_bytes+0, 7 
	MOVLW       255
	MOVWF       R2 
	MOVLW       0
	SUBWFB      R2, 1 
	MOVLW       0
	BTFSC       eepromLeeChar_i_L0+0, 7 
	MOVLW       255
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__eepromLeeChar713
	MOVF        R1, 0 
	XORWF       eepromLeeChar_i_L0+0, 0 
L__eepromLeeChar713:
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromLeeChar153
;eepromi2cbrian_v2.h,133 :: 		buffer[i] = I2C_soft_read(NACK);
	MOVF        eepromLeeChar_i_L0+0, 0 
	ADDWF       FARG_eepromLeeChar_buffer+0, 0 
	MOVWF       FLOC__eepromLeeChar+0 
	MOVLW       0
	BTFSC       eepromLeeChar_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FARG_eepromLeeChar_buffer+1, 0 
	MOVWF       FLOC__eepromLeeChar+1 
	CLRF        FARG_I2C_soft_read_ACK+0 
	CALL        _I2C_soft_read+0, 0
	MOVFF       FLOC__eepromLeeChar+0, FSR1
	MOVFF       FLOC__eepromLeeChar+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;eepromi2cbrian_v2.h,134 :: 		I2C_soft_stop();
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,135 :: 		}
	GOTO        L_eepromLeeChar154
L_eepromLeeChar153:
;eepromi2cbrian_v2.h,137 :: 		buffer[i] = I2C_soft_read(ACK);
	MOVF        eepromLeeChar_i_L0+0, 0 
	ADDWF       FARG_eepromLeeChar_buffer+0, 0 
	MOVWF       FLOC__eepromLeeChar+0 
	MOVLW       0
	BTFSC       eepromLeeChar_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FARG_eepromLeeChar_buffer+1, 0 
	MOVWF       FLOC__eepromLeeChar+1 
	MOVLW       1
	MOVWF       FARG_I2C_soft_read_ACK+0 
	CALL        _I2C_soft_read+0, 0
	MOVFF       FLOC__eepromLeeChar+0, FSR1
	MOVFF       FLOC__eepromLeeChar+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;eepromi2cbrian_v2.h,138 :: 		}
L_eepromLeeChar154:
;eepromi2cbrian_v2.h,131 :: 		for(i = 0;i < bytes;i++){
	INCF        eepromLeeChar_i_L0+0, 1 
;eepromi2cbrian_v2.h,139 :: 		}
	GOTO        L_eepromLeeChar150
L_eepromLeeChar151:
;eepromi2cbrian_v2.h,140 :: 		}
L_end_eepromLeeChar:
	RETURN      0
; end of _eepromLeeChar

_eepromLeeNumero:

;eepromi2cbrian_v2.h,142 :: 		long eepromLeeNumero(unsigned int registro, short BYTES){
;eepromi2cbrian_v2.h,144 :: 		long    bufferLong[4]={0,0,0,0}, lectura = 0;
	CLRF        eepromLeeNumero_bufferLong_L0+0 
	CLRF        eepromLeeNumero_bufferLong_L0+1 
	CLRF        eepromLeeNumero_bufferLong_L0+2 
	CLRF        eepromLeeNumero_bufferLong_L0+3 
	CLRF        eepromLeeNumero_bufferLong_L0+4 
	CLRF        eepromLeeNumero_bufferLong_L0+5 
	CLRF        eepromLeeNumero_bufferLong_L0+6 
	CLRF        eepromLeeNumero_bufferLong_L0+7 
	CLRF        eepromLeeNumero_bufferLong_L0+8 
	CLRF        eepromLeeNumero_bufferLong_L0+9 
	CLRF        eepromLeeNumero_bufferLong_L0+10 
	CLRF        eepromLeeNumero_bufferLong_L0+11 
	CLRF        eepromLeeNumero_bufferLong_L0+12 
	CLRF        eepromLeeNumero_bufferLong_L0+13 
	CLRF        eepromLeeNumero_bufferLong_L0+14 
	CLRF        eepromLeeNumero_bufferLong_L0+15 
	CLRF        eepromLeeNumero_lectura_L0+0 
	CLRF        eepromLeeNumero_lectura_L0+1 
	CLRF        eepromLeeNumero_lectura_L0+2 
	CLRF        eepromLeeNumero_lectura_L0+3 
;eepromi2cbrian_v2.h,145 :: 		RW = LEE;
	MOVLW       1
	MOVWF       _RW+0 
;eepromi2cbrian_v2.h,146 :: 		if(BYTES == 1){
	MOVF        FARG_eepromLeeNumero_BYTES+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromLeeNumero155
;eepromi2cbrian_v2.h,147 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,148 :: 		I2C_soft_write(EEPROM_DIR_24LC256);
	MOVLW       160
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,149 :: 		I2C_soft_write((registro & BYTE_ALTO)>>8);
	MOVLW       0
	ANDWF       FARG_eepromLeeNumero_registro+0, 0 
	MOVWF       R3 
	MOVF        FARG_eepromLeeNumero_registro+1, 0 
	ANDLW       255
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,150 :: 		I2C_soft_write(registro & BYTE_BAJO);
	MOVLW       255
	ANDWF       FARG_eepromLeeNumero_registro+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,151 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,152 :: 		I2C_soft_write(EEPROM_DIR_24LC256 | RW);
	MOVLW       160
	IORWF       _RW+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,153 :: 		bufferLong[0] = I2C_soft_read(NACK);
	CLRF        FARG_I2C_soft_read_ACK+0 
	CALL        _I2C_soft_read+0, 0
	MOVF        R0, 0 
	MOVWF       eepromLeeNumero_bufferLong_L0+0 
	MOVLW       0
	MOVWF       eepromLeeNumero_bufferLong_L0+1 
	MOVWF       eepromLeeNumero_bufferLong_L0+2 
	MOVWF       eepromLeeNumero_bufferLong_L0+3 
;eepromi2cbrian_v2.h,154 :: 		I2C_soft_stop();
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,156 :: 		return lectura = bufferLong[0];
	MOVF        eepromLeeNumero_bufferLong_L0+0, 0 
	MOVWF       eepromLeeNumero_lectura_L0+0 
	MOVF        eepromLeeNumero_bufferLong_L0+1, 0 
	MOVWF       eepromLeeNumero_lectura_L0+1 
	MOVF        eepromLeeNumero_bufferLong_L0+2, 0 
	MOVWF       eepromLeeNumero_lectura_L0+2 
	MOVF        eepromLeeNumero_bufferLong_L0+3, 0 
	MOVWF       eepromLeeNumero_lectura_L0+3 
	MOVF        eepromLeeNumero_bufferLong_L0+0, 0 
	MOVWF       R0 
	MOVF        eepromLeeNumero_bufferLong_L0+1, 0 
	MOVWF       R1 
	MOVF        eepromLeeNumero_bufferLong_L0+2, 0 
	MOVWF       R2 
	MOVF        eepromLeeNumero_bufferLong_L0+3, 0 
	MOVWF       R3 
	GOTO        L_end_eepromLeeNumero
;eepromi2cbrian_v2.h,157 :: 		}
L_eepromLeeNumero155:
;eepromi2cbrian_v2.h,159 :: 		if(BYTES == 2){
	MOVF        FARG_eepromLeeNumero_BYTES+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromLeeNumero156
;eepromi2cbrian_v2.h,160 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,161 :: 		I2C_soft_write(EEPROM_DIR_24LC256);
	MOVLW       160
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,162 :: 		I2C_soft_write((registro & BYTE_ALTO)>>8);
	MOVLW       0
	ANDWF       FARG_eepromLeeNumero_registro+0, 0 
	MOVWF       R3 
	MOVF        FARG_eepromLeeNumero_registro+1, 0 
	ANDLW       255
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,163 :: 		I2C_soft_write(registro & BYTE_BAJO);
	MOVLW       255
	ANDWF       FARG_eepromLeeNumero_registro+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,164 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,165 :: 		I2C_soft_write(EEPROM_DIR_24LC256 | RW);
	MOVLW       160
	IORWF       _RW+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,166 :: 		for(i = 0;i < 2;i++){
	CLRF        eepromLeeNumero_i_L0+0 
L_eepromLeeNumero157:
	MOVLW       128
	XORWF       eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromLeeNumero158
;eepromi2cbrian_v2.h,167 :: 		if(i == 2 - 1){
	MOVF        eepromLeeNumero_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromLeeNumero160
;eepromi2cbrian_v2.h,168 :: 		bufferLong[i] = I2C_soft_read(NACK);
	MOVF        eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromLeeNumero_i_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       eepromLeeNumero_bufferLong_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__eepromLeeNumero+0 
	MOVLW       hi_addr(eepromLeeNumero_bufferLong_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__eepromLeeNumero+1 
	CLRF        FARG_I2C_soft_read_ACK+0 
	CALL        _I2C_soft_read+0, 0
	MOVFF       FLOC__eepromLeeNumero+0, FSR1
	MOVFF       FLOC__eepromLeeNumero+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;eepromi2cbrian_v2.h,169 :: 		I2C_soft_stop();
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,170 :: 		}
	GOTO        L_eepromLeeNumero161
L_eepromLeeNumero160:
;eepromi2cbrian_v2.h,172 :: 		bufferLong[i] = I2C_soft_read(ACK);
	MOVF        eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromLeeNumero_i_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       eepromLeeNumero_bufferLong_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__eepromLeeNumero+0 
	MOVLW       hi_addr(eepromLeeNumero_bufferLong_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__eepromLeeNumero+1 
	MOVLW       1
	MOVWF       FARG_I2C_soft_read_ACK+0 
	CALL        _I2C_soft_read+0, 0
	MOVFF       FLOC__eepromLeeNumero+0, FSR1
	MOVFF       FLOC__eepromLeeNumero+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;eepromi2cbrian_v2.h,173 :: 		}
L_eepromLeeNumero161:
;eepromi2cbrian_v2.h,166 :: 		for(i = 0;i < 2;i++){
	INCF        eepromLeeNumero_i_L0+0, 1 
;eepromi2cbrian_v2.h,174 :: 		}
	GOTO        L_eepromLeeNumero157
L_eepromLeeNumero158:
;eepromi2cbrian_v2.h,175 :: 		lectura = bufferLong[0];
	MOVF        eepromLeeNumero_bufferLong_L0+0, 0 
	MOVWF       eepromLeeNumero_lectura_L0+0 
	MOVF        eepromLeeNumero_bufferLong_L0+1, 0 
	MOVWF       eepromLeeNumero_lectura_L0+1 
	MOVF        eepromLeeNumero_bufferLong_L0+2, 0 
	MOVWF       eepromLeeNumero_lectura_L0+2 
	MOVF        eepromLeeNumero_bufferLong_L0+3, 0 
	MOVWF       eepromLeeNumero_lectura_L0+3 
;eepromi2cbrian_v2.h,176 :: 		return lectura |= bufferLong[1]<<8;
	MOVF        eepromLeeNumero_bufferLong_L0+6, 0 
	MOVWF       R3 
	MOVF        eepromLeeNumero_bufferLong_L0+5, 0 
	MOVWF       R2 
	MOVF        eepromLeeNumero_bufferLong_L0+4, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        eepromLeeNumero_bufferLong_L0+0, 0 
	IORWF       R0, 1 
	MOVF        eepromLeeNumero_bufferLong_L0+1, 0 
	IORWF       R1, 1 
	MOVF        eepromLeeNumero_bufferLong_L0+2, 0 
	IORWF       R2, 1 
	MOVF        eepromLeeNumero_bufferLong_L0+3, 0 
	IORWF       R3, 1 
	MOVF        R0, 0 
	MOVWF       eepromLeeNumero_lectura_L0+0 
	MOVF        R1, 0 
	MOVWF       eepromLeeNumero_lectura_L0+1 
	MOVF        R2, 0 
	MOVWF       eepromLeeNumero_lectura_L0+2 
	MOVF        R3, 0 
	MOVWF       eepromLeeNumero_lectura_L0+3 
	GOTO        L_end_eepromLeeNumero
;eepromi2cbrian_v2.h,177 :: 		}
L_eepromLeeNumero156:
;eepromi2cbrian_v2.h,179 :: 		if(BYTES == 4){
	MOVF        FARG_eepromLeeNumero_BYTES+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromLeeNumero162
;eepromi2cbrian_v2.h,180 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,181 :: 		I2C_soft_write(EEPROM_DIR_24LC256);
	MOVLW       160
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,182 :: 		I2C_soft_write((registro & BYTE_ALTO)>>8);
	MOVLW       0
	ANDWF       FARG_eepromLeeNumero_registro+0, 0 
	MOVWF       R3 
	MOVF        FARG_eepromLeeNumero_registro+1, 0 
	ANDLW       255
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,183 :: 		I2C_soft_write(registro & BYTE_BAJO);
	MOVLW       255
	ANDWF       FARG_eepromLeeNumero_registro+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,184 :: 		I2C_soft_start();
	CALL        _I2C_soft_start+0, 0
;eepromi2cbrian_v2.h,185 :: 		I2C_soft_write(EEPROM_DIR_24LC256 | RW);
	MOVLW       160
	IORWF       _RW+0, 0 
	MOVWF       FARG_I2C_soft_write_dato+0 
	CALL        _I2C_soft_write+0, 0
;eepromi2cbrian_v2.h,186 :: 		for(i = 0;i < 4;i++){
	CLRF        eepromLeeNumero_i_L0+0 
L_eepromLeeNumero163:
	MOVLW       128
	XORWF       eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromLeeNumero164
;eepromi2cbrian_v2.h,187 :: 		if(i == 4 - 1){
	MOVF        eepromLeeNumero_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromLeeNumero166
;eepromi2cbrian_v2.h,188 :: 		bufferLong[i] = I2C_soft_read(NACK);
	MOVF        eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromLeeNumero_i_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       eepromLeeNumero_bufferLong_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__eepromLeeNumero+0 
	MOVLW       hi_addr(eepromLeeNumero_bufferLong_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__eepromLeeNumero+1 
	CLRF        FARG_I2C_soft_read_ACK+0 
	CALL        _I2C_soft_read+0, 0
	MOVFF       FLOC__eepromLeeNumero+0, FSR1
	MOVFF       FLOC__eepromLeeNumero+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;eepromi2cbrian_v2.h,189 :: 		I2C_soft_stop();
	CALL        _I2C_soft_stop+0, 0
;eepromi2cbrian_v2.h,190 :: 		}
	GOTO        L_eepromLeeNumero167
L_eepromLeeNumero166:
;eepromi2cbrian_v2.h,192 :: 		bufferLong[i] = I2C_soft_read(ACK);
	MOVF        eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromLeeNumero_i_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       eepromLeeNumero_bufferLong_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__eepromLeeNumero+0 
	MOVLW       hi_addr(eepromLeeNumero_bufferLong_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__eepromLeeNumero+1 
	MOVLW       1
	MOVWF       FARG_I2C_soft_read_ACK+0 
	CALL        _I2C_soft_read+0, 0
	MOVFF       FLOC__eepromLeeNumero+0, FSR1
	MOVFF       FLOC__eepromLeeNumero+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;eepromi2cbrian_v2.h,193 :: 		}
L_eepromLeeNumero167:
;eepromi2cbrian_v2.h,186 :: 		for(i = 0;i < 4;i++){
	INCF        eepromLeeNumero_i_L0+0, 1 
;eepromi2cbrian_v2.h,194 :: 		}
	GOTO        L_eepromLeeNumero163
L_eepromLeeNumero164:
;eepromi2cbrian_v2.h,195 :: 		for(i = 0;i < 4;i++){
	CLRF        eepromLeeNumero_i_L0+0 
L_eepromLeeNumero168:
	MOVLW       128
	XORWF       eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_eepromLeeNumero169
;eepromi2cbrian_v2.h,196 :: 		if(i==0){
	MOVF        eepromLeeNumero_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_eepromLeeNumero171
;eepromi2cbrian_v2.h,197 :: 		lectura = bufferLong[i];
	MOVF        eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromLeeNumero_i_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       eepromLeeNumero_bufferLong_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(eepromLeeNumero_bufferLong_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       eepromLeeNumero_lectura_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       eepromLeeNumero_lectura_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       eepromLeeNumero_lectura_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       eepromLeeNumero_lectura_L0+3 
;eepromi2cbrian_v2.h,198 :: 		}
	GOTO        L_eepromLeeNumero172
L_eepromLeeNumero171:
;eepromi2cbrian_v2.h,200 :: 		lectura |= bufferLong[i] << 8*i;
	MOVF        eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromLeeNumero_i_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       eepromLeeNumero_bufferLong_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(eepromLeeNumero_bufferLong_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVF        POSTINC0+0, 0 
	MOVWF       R7 
	MOVF        POSTINC0+0, 0 
	MOVWF       R8 
	MOVLW       3
	MOVWF       R2 
	MOVF        eepromLeeNumero_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       eepromLeeNumero_i_L0+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R2, 0 
L__eepromLeeNumero715:
	BZ          L__eepromLeeNumero716
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__eepromLeeNumero715
L__eepromLeeNumero716:
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__eepromLeeNumero717:
	BZ          L__eepromLeeNumero718
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__eepromLeeNumero717
L__eepromLeeNumero718:
	MOVF        R0, 0 
	IORWF       eepromLeeNumero_lectura_L0+0, 1 
	MOVF        R1, 0 
	IORWF       eepromLeeNumero_lectura_L0+1, 1 
	MOVF        R2, 0 
	IORWF       eepromLeeNumero_lectura_L0+2, 1 
	MOVF        R3, 0 
	IORWF       eepromLeeNumero_lectura_L0+3, 1 
;eepromi2cbrian_v2.h,201 :: 		}
L_eepromLeeNumero172:
;eepromi2cbrian_v2.h,195 :: 		for(i = 0;i < 4;i++){
	INCF        eepromLeeNumero_i_L0+0, 1 
;eepromi2cbrian_v2.h,202 :: 		}
	GOTO        L_eepromLeeNumero168
L_eepromLeeNumero169:
;eepromi2cbrian_v2.h,203 :: 		return lectura;
	MOVF        eepromLeeNumero_lectura_L0+0, 0 
	MOVWF       R0 
	MOVF        eepromLeeNumero_lectura_L0+1, 0 
	MOVWF       R1 
	MOVF        eepromLeeNumero_lectura_L0+2, 0 
	MOVWF       R2 
	MOVF        eepromLeeNumero_lectura_L0+3, 0 
	MOVWF       R3 
	GOTO        L_end_eepromLeeNumero
;eepromi2cbrian_v2.h,204 :: 		}
L_eepromLeeNumero162:
;eepromi2cbrian_v2.h,205 :: 		}
L_end_eepromLeeNumero:
	RETURN      0
; end of _eepromLeeNumero

_muestraEstatus:

;rutinasensores_v4(mstr-slv).h,42 :: 		void muestraEstatus(){
;rutinasensores_v4(mstr-slv).h,43 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_muestraEstatus173
;rutinasensores_v4(mstr-slv).h,44 :: 		lcd_out(3,8,"MST");
	MOVLW       3
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       8
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       ?lstr1_MyProject+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(?lstr1_MyProject+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,45 :: 		lecturaTablaS = eepromLeenumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaTablaS+0 
	MOVF        R1, 0 
	MOVWF       _lecturaTablaS+1 
;rutinasensores_v4(mstr-slv).h,46 :: 		bytetostr(lecturaTablaS, auxS);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxS+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxS+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,47 :: 		lcd_out(1, 15, auxS);
	MOVLW       1
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       15
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxS+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxS+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,48 :: 		lecturaTablaSubenE = eepromLeeNumero(0x0900, 2);
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaTablaSubenE+0 
	MOVF        R1, 0 
	MOVWF       _lecturaTablaSubenE+1 
;rutinasensores_v4(mstr-slv).h,49 :: 		bytetostr(lecturaTablaSubenE, auxS);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxS+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxS+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,50 :: 		lcd_out(1, 18, auxS);
	MOVLW       1
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       18
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxS+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxS+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,54 :: 		lecturaTablaB = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaTablaB+0 
	MOVF        R1, 0 
	MOVWF       _lecturaTablaB+1 
;rutinasensores_v4(mstr-slv).h,55 :: 		bytetostr(lecturaTablaB, auxB);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxB+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxB+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,56 :: 		lcd_out(2, 15, auxB);
	MOVLW       2
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       15
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxB+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxB+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,57 :: 		lecturaTablaBajanE = eepromLeeNumero(0x0700, 2);
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaTablaBajanE+0 
	MOVF        R1, 0 
	MOVWF       _lecturaTablaBajanE+1 
;rutinasensores_v4(mstr-slv).h,58 :: 		bytetostr(lecturaTablaBajanE, auxB);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxB+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxB+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,59 :: 		lcd_out(2, 18, auxB);
	MOVLW       2
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       18
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxB+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxB+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,63 :: 		lecturaTablaPVerdaderos = eepromLeeNumero(0x0005, 2);
	MOVLW       5
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaTablaPVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _lecturaTablaPVerdaderos+1 
;rutinasensores_v4(mstr-slv).h,64 :: 		bytetostr(lecturaTablaPVerdaderos, auxP);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxP+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxP+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,65 :: 		lcd_out(4, 17, auxP);
	MOVLW       4
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       17
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxP+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxP+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,69 :: 		lecturaBloqueo = eepromLeenumero(0x000B, 1) + eepromLeeNumero(0x000C, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__muestraEstatus+0 
	MOVF        R1, 0 
	MOVWF       FLOC__muestraEstatus+1 
	MOVF        R2, 0 
	MOVWF       FLOC__muestraEstatus+2 
	MOVF        R3, 0 
	MOVWF       FLOC__muestraEstatus+3 
	MOVLW       12
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        FLOC__muestraEstatus+0, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _lecturaBloqueo+0 
;rutinasensores_v4(mstr-slv).h,70 :: 		bytetostr(lecturaBloqueo, auxBloq);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxBloq+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxBloq+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,71 :: 		lcd_out(3, 18, auxBloq);
	MOVLW       3
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       18
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxBloq+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxBloq+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,75 :: 		}
	GOTO        L_muestraEstatus174
L_muestraEstatus173:
;rutinasensores_v4(mstr-slv).h,76 :: 		else if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_muestraEstatus175
;rutinasensores_v4(mstr-slv).h,77 :: 		lcd_out(3, 8, "SLV");
	MOVLW       3
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       8
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       ?lstr2_MyProject+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(?lstr2_MyProject+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,78 :: 		lecturaTablaS = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaTablaS+0 
	MOVF        R1, 0 
	MOVWF       _lecturaTablaS+1 
;rutinasensores_v4(mstr-slv).h,79 :: 		bytetostr(lecturaTablaS, auxS);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxS+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxS+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,80 :: 		lcd_out(1, 16, auxS);
	MOVLW       1
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       16
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxS+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxS+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,84 :: 		lecturaTablaB = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaTablaB+0 
	MOVF        R1, 0 
	MOVWF       _lecturaTablaB+1 
;rutinasensores_v4(mstr-slv).h,85 :: 		bytetostr(lecturaTablaB, auxB);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxB+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxB+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,86 :: 		lcd_out(2, 16, auxB);
	MOVLW       2
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       16
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxB+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxB+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,90 :: 		lecturaTablaPasajerosTotales = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaTablaPasajerosTotales+0 
	MOVF        R1, 0 
	MOVWF       _lecturaTablaPasajerosTotales+1 
;rutinasensores_v4(mstr-slv).h,91 :: 		bytetostr(lecturaTablaPasajerosTotales, auxT);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxT+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxT+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,92 :: 		lcd_out(4, 18, auxT);
	MOVLW       4
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       18
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxT+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxT+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,96 :: 		lecturaBloqueo = eepromLeenumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _lecturaBloqueo+0 
;rutinasensores_v4(mstr-slv).h,97 :: 		bytetostr(lecturaBloqueo, auxBloq);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _auxBloq+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_auxBloq+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;rutinasensores_v4(mstr-slv).h,98 :: 		lcd_out(3, 18, auxBloq);
	MOVLW       3
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       18
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _auxBloq+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_auxBloq+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;rutinasensores_v4(mstr-slv).h,99 :: 		}
L_muestraEstatus175:
L_muestraEstatus174:
;rutinasensores_v4(mstr-slv).h,100 :: 		lcd_outConst(4, 11, "TOTAL:");
	MOVLW       4
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       11
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_3_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_3_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_3_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,101 :: 		lcd_outConst(1, 10, "SUBEN:");
	MOVLW       1
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       10
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_4_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_4_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_4_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,102 :: 		lcd_outConst(2, 10, "BAJAN:");
	MOVLW       2
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       10
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_5_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_5_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_5_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,103 :: 		LCD_OUTCONST(3, 1, "ESPERA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_6_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_6_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_6_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,104 :: 		lcd_outConst(3, 12, "BLOCK:");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       12
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_7_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_7_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_7_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,105 :: 		}
L_end_muestraEstatus:
	RETURN      0
; end of _muestraEstatus

_sensorNoBloqueo:

;rutinasensores_v4(mstr-slv).h,265 :: 		void sensorNoBloqueo(){
;rutinasensores_v4(mstr-slv).h,266 :: 		espera(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_espera+0 
	CALL        _espera+0, 0
;rutinasensores_v4(mstr-slv).h,267 :: 		if(permanencia){
	MOVF        _permanencia+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_sensorNoBloqueo176
;rutinasensores_v4(mstr-slv).h,268 :: 		if(empiezaEntrada){
	MOVF        _empiezaEntrada+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_sensorNoBloqueo177
;rutinasensores_v4(mstr-slv).h,269 :: 		entrando(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_entrando+0 
	CALL        _entrando+0, 0
;rutinasensores_v4(mstr-slv).h,270 :: 		transicionE(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_transicionE+0 
	CALL        _transicionE+0, 0
;rutinasensores_v4(mstr-slv).h,271 :: 		transicionEnt(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_transicionEnt+0 
	CALL        _transicionEnt+0, 0
;rutinasensores_v4(mstr-slv).h,272 :: 		entro(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_entro+0 
	CALL        _entro+0, 0
;rutinasensores_v4(mstr-slv).h,273 :: 		}
	GOTO        L_sensorNoBloqueo178
L_sensorNoBloqueo177:
;rutinasensores_v4(mstr-slv).h,274 :: 		else if(empiezaSalida){
	MOVF        _empiezaSalida+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_sensorNoBloqueo179
;rutinasensores_v4(mstr-slv).h,275 :: 		saliendo(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_saliendo+0 
	CALL        _saliendo+0, 0
;rutinasensores_v4(mstr-slv).h,276 :: 		transicionS(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_transicionS+0 
	CALL        _transicionS+0, 0
;rutinasensores_v4(mstr-slv).h,277 :: 		transicionSal(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_transicionSal+0 
	CALL        _transicionSal+0, 0
;rutinasensores_v4(mstr-slv).h,278 :: 		salio(debugEstado);
	MOVF        _debugEstado+0, 0 
	MOVWF       FARG_salio+0 
	CALL        _salio+0, 0
;rutinasensores_v4(mstr-slv).h,279 :: 		}
L_sensorNoBloqueo179:
L_sensorNoBloqueo178:
;rutinasensores_v4(mstr-slv).h,280 :: 		}
L_sensorNoBloqueo176:
;rutinasensores_v4(mstr-slv).h,282 :: 		}
L_end_sensorNoBloqueo:
	RETURN      0
; end of _sensorNoBloqueo

_sensorBloqueo:

;rutinasensores_v4(mstr-slv).h,288 :: 		void sensorBloqueo(){
;rutinasensores_v4(mstr-slv).h,289 :: 		if(!Bandera.Par1){
	MOVF        _Bandera+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_sensorBloqueo180
;rutinasensores_v4(mstr-slv).h,290 :: 		esperaB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaB+0 
	CALL        _esperaB+0, 0
;rutinasensores_v4(mstr-slv).h,291 :: 		entrandoB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoB+0 
	CALL        _entrandoB+0, 0
;rutinasensores_v4(mstr-slv).h,292 :: 		transicionEB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEB+0 
	CALL        _transicionEB+0, 0
;rutinasensores_v4(mstr-slv).h,293 :: 		transicionEntB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntB+0 
	CALL        _transicionEntB+0, 0
;rutinasensores_v4(mstr-slv).h,294 :: 		entroB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroB+0 
	CALL        _entroB+0, 0
;rutinasensores_v4(mstr-slv).h,295 :: 		saliendoB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoB+0 
	CALL        _saliendoB+0, 0
;rutinasensores_v4(mstr-slv).h,296 :: 		transicionSB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSB+0 
	CALL        _transicionSB+0, 0
;rutinasensores_v4(mstr-slv).h,297 :: 		transicionSalB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalB+0 
	CALL        _transicionSalB+0, 0
;rutinasensores_v4(mstr-slv).h,298 :: 		salioB(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioB+0 
	CALL        _salioB+0, 0
;rutinasensores_v4(mstr-slv).h,299 :: 		}
L_sensorBloqueo180:
;rutinasensores_v4(mstr-slv).h,300 :: 		}
L_end_sensorBloqueo:
	RETURN      0
; end of _sensorBloqueo

_sensorBloqueoD:

;rutinasensores_v4(mstr-slv).h,302 :: 		void sensorBloqueoD(){
;rutinasensores_v4(mstr-slv).h,303 :: 		if(!Bandera.Par1){
	MOVF        _Bandera+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_sensorBloqueoD181
;rutinasensores_v4(mstr-slv).h,304 :: 		esperaBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBD+0 
	CALL        _esperaBD+0, 0
;rutinasensores_v4(mstr-slv).h,305 :: 		entrandoBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBD+0 
	CALL        _entrandoBD+0, 0
;rutinasensores_v4(mstr-slv).h,306 :: 		transicionEBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBD+0 
	CALL        _transicionEBD+0, 0
;rutinasensores_v4(mstr-slv).h,307 :: 		transicionEntBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBD+0 
	CALL        _transicionEntBD+0, 0
;rutinasensores_v4(mstr-slv).h,308 :: 		entroBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBD+0 
	CALL        _entroBD+0, 0
;rutinasensores_v4(mstr-slv).h,309 :: 		saliendoBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBD+0 
	CALL        _saliendoBD+0, 0
;rutinasensores_v4(mstr-slv).h,310 :: 		transicionSBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBD+0 
	CALL        _transicionSBD+0, 0
;rutinasensores_v4(mstr-slv).h,311 :: 		transicionSalBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBD+0 
	CALL        _transicionSalBD+0, 0
;rutinasensores_v4(mstr-slv).h,312 :: 		salioBD(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBD+0 
	CALL        _salioBD+0, 0
;rutinasensores_v4(mstr-slv).h,313 :: 		}
L_sensorBloqueoD181:
;rutinasensores_v4(mstr-slv).h,314 :: 		}
L_end_sensorBloqueoD:
	RETURN      0
; end of _sensorBloqueoD

_sensorBloqueoT:

;rutinasensores_v4(mstr-slv).h,316 :: 		void sensorBloqueoT(){
;rutinasensores_v4(mstr-slv).h,317 :: 		if(!Bandera.Par2){
	MOVF        _Bandera+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_sensorBloqueoT182
;rutinasensores_v4(mstr-slv).h,318 :: 		esperaBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBT+0 
	CALL        _esperaBT+0, 0
;rutinasensores_v4(mstr-slv).h,319 :: 		entrandoBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBT+0 
	CALL        _entrandoBT+0, 0
;rutinasensores_v4(mstr-slv).h,320 :: 		transicionEBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBT+0 
	CALL        _transicionEBT+0, 0
;rutinasensores_v4(mstr-slv).h,321 :: 		transicionEntBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBT+0 
	CALL        _transicionEntBT+0, 0
;rutinasensores_v4(mstr-slv).h,322 :: 		entroBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBT+0 
	CALL        _entroBT+0, 0
;rutinasensores_v4(mstr-slv).h,323 :: 		saliendoBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBT+0 
	CALL        _saliendoBT+0, 0
;rutinasensores_v4(mstr-slv).h,324 :: 		transicionSBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBT+0 
	CALL        _transicionSBT+0, 0
;rutinasensores_v4(mstr-slv).h,325 :: 		transicionSalBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBT+0 
	CALL        _transicionSalBT+0, 0
;rutinasensores_v4(mstr-slv).h,326 :: 		salioBT(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBT+0 
	CALL        _salioBT+0, 0
;rutinasensores_v4(mstr-slv).h,327 :: 		}
L_sensorBloqueoT182:
;rutinasensores_v4(mstr-slv).h,328 :: 		}
L_end_sensorBloqueoT:
	RETURN      0
; end of _sensorBloqueoT

_sensorBloqueoC:

;rutinasensores_v4(mstr-slv).h,330 :: 		void sensorBloqueoC(){
;rutinasensores_v4(mstr-slv).h,331 :: 		if(!Bandera.Par2){
	MOVF        _Bandera+1, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_sensorBloqueoC183
;rutinasensores_v4(mstr-slv).h,332 :: 		esperaBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBC+0 
	CALL        _esperaBC+0, 0
;rutinasensores_v4(mstr-slv).h,333 :: 		entrandoBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBC+0 
	CALL        _entrandoBC+0, 0
;rutinasensores_v4(mstr-slv).h,334 :: 		transicionEBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBC+0 
	CALL        _transicionEBC+0, 0
;rutinasensores_v4(mstr-slv).h,335 :: 		transicionEntBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBC+0 
	CALL        _transicionEntBC+0, 0
;rutinasensores_v4(mstr-slv).h,336 :: 		entroBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBC+0 
	CALL        _entroBC+0, 0
;rutinasensores_v4(mstr-slv).h,337 :: 		saliendoBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBC+0 
	CALL        _saliendoBC+0, 0
;rutinasensores_v4(mstr-slv).h,338 :: 		transicionSBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBC+0 
	CALL        _transicionSBC+0, 0
;rutinasensores_v4(mstr-slv).h,339 :: 		transicionSalBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBC+0 
	CALL        _transicionSalBC+0, 0
;rutinasensores_v4(mstr-slv).h,340 :: 		salioBC(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBC+0 
	CALL        _salioBC+0, 0
;rutinasensores_v4(mstr-slv).h,341 :: 		}
L_sensorBloqueoC183:
;rutinasensores_v4(mstr-slv).h,342 :: 		}
L_end_sensorBloqueoC:
	RETURN      0
; end of _sensorBloqueoC

_sensorBloqueoO:

;rutinasensores_v4(mstr-slv).h,344 :: 		void sensorBloqueoO(){
;rutinasensores_v4(mstr-slv).h,345 :: 		if(!Bandera.Par3){
	MOVF        _Bandera+2, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_sensorBloqueoO184
;rutinasensores_v4(mstr-slv).h,346 :: 		esperaBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBO+0 
	CALL        _esperaBO+0, 0
;rutinasensores_v4(mstr-slv).h,347 :: 		entrandoBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBO+0 
	CALL        _entrandoBO+0, 0
;rutinasensores_v4(mstr-slv).h,348 :: 		transicionEBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBO+0 
	CALL        _transicionEBO+0, 0
;rutinasensores_v4(mstr-slv).h,349 :: 		transicionEntBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBO+0 
	CALL        _transicionEntBO+0, 0
;rutinasensores_v4(mstr-slv).h,350 :: 		entroBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBO+0 
	CALL        _entroBO+0, 0
;rutinasensores_v4(mstr-slv).h,351 :: 		saliendoBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBO+0 
	CALL        _saliendoBO+0, 0
;rutinasensores_v4(mstr-slv).h,352 :: 		transicionSBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBO+0 
	CALL        _transicionSBO+0, 0
;rutinasensores_v4(mstr-slv).h,353 :: 		transicionSalBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBO+0 
	CALL        _transicionSalBO+0, 0
;rutinasensores_v4(mstr-slv).h,354 :: 		salioBO(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBO+0 
	CALL        _salioBO+0, 0
;rutinasensores_v4(mstr-slv).h,355 :: 		}
L_sensorBloqueoO184:
;rutinasensores_v4(mstr-slv).h,356 :: 		}
L_end_sensorBloqueoO:
	RETURN      0
; end of _sensorBloqueoO

_sensorBloqueoS:

;rutinasensores_v4(mstr-slv).h,358 :: 		void sensorBloqueoS(){
;rutinasensores_v4(mstr-slv).h,359 :: 		if(!Bandera.Par3){
	MOVF        _Bandera+2, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_sensorBloqueoS185
;rutinasensores_v4(mstr-slv).h,360 :: 		esperaBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBS+0 
	CALL        _esperaBS+0, 0
;rutinasensores_v4(mstr-slv).h,361 :: 		entrandoBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBS+0 
	CALL        _entrandoBS+0, 0
;rutinasensores_v4(mstr-slv).h,362 :: 		transicionEBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBS+0 
	CALL        _transicionEBS+0, 0
;rutinasensores_v4(mstr-slv).h,363 :: 		transicionEntBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBS+0 
	CALL        _transicionEntBS+0, 0
;rutinasensores_v4(mstr-slv).h,364 :: 		entroBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBS+0 
	CALL        _entroBS+0, 0
;rutinasensores_v4(mstr-slv).h,365 :: 		saliendoBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBS+0 
	CALL        _saliendoBS+0, 0
;rutinasensores_v4(mstr-slv).h,366 :: 		transicionSBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBS+0 
	CALL        _transicionSBS+0, 0
;rutinasensores_v4(mstr-slv).h,367 :: 		transicionSalBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBS+0 
	CALL        _transicionSalBS+0, 0
;rutinasensores_v4(mstr-slv).h,368 :: 		salioBS(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBS+0 
	CALL        _salioBS+0, 0
;rutinasensores_v4(mstr-slv).h,369 :: 		}
L_sensorBloqueoS185:
;rutinasensores_v4(mstr-slv).h,370 :: 		}
L_end_sensorBloqueoS:
	RETURN      0
; end of _sensorBloqueoS

_sensorBloqueoPar1:

;rutinasensores_v4(mstr-slv).h,372 :: 		void sensorBloqueoPar1(){
;rutinasensores_v4(mstr-slv).h,373 :: 		esperaBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBP1+0 
	CALL        _esperaBP1+0, 0
;rutinasensores_v4(mstr-slv).h,374 :: 		entrandoBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBP1+0 
	CALL        _entrandoBP1+0, 0
;rutinasensores_v4(mstr-slv).h,375 :: 		transicionEBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBP1+0 
	CALL        _transicionEBP1+0, 0
;rutinasensores_v4(mstr-slv).h,376 :: 		transicionEntBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBP1+0 
	CALL        _transicionEntBP1+0, 0
;rutinasensores_v4(mstr-slv).h,377 :: 		entroBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBP1+0 
	CALL        _entroBP1+0, 0
;rutinasensores_v4(mstr-slv).h,378 :: 		saliendoBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBP1+0 
	CALL        _saliendoBP1+0, 0
;rutinasensores_v4(mstr-slv).h,379 :: 		transicionSBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBP1+0 
	CALL        _transicionSBP1+0, 0
;rutinasensores_v4(mstr-slv).h,380 :: 		transicionSalBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBP1+0 
	CALL        _transicionSalBP1+0, 0
;rutinasensores_v4(mstr-slv).h,381 :: 		salioBP1(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBP1+0 
	CALL        _salioBP1+0, 0
;rutinasensores_v4(mstr-slv).h,382 :: 		}
L_end_sensorBloqueoPar1:
	RETURN      0
; end of _sensorBloqueoPar1

_sensorBloqueoPar2:

;rutinasensores_v4(mstr-slv).h,384 :: 		void sensorBloqueoPar2(){
;rutinasensores_v4(mstr-slv).h,385 :: 		esperaBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBP2+0 
	CALL        _esperaBP2+0, 0
;rutinasensores_v4(mstr-slv).h,386 :: 		entrandoBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBP2+0 
	CALL        _entrandoBP2+0, 0
;rutinasensores_v4(mstr-slv).h,387 :: 		transicionEBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBP2+0 
	CALL        _transicionEBP2+0, 0
;rutinasensores_v4(mstr-slv).h,388 :: 		transicionEntBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBP2+0 
	CALL        _transicionEntBP2+0, 0
;rutinasensores_v4(mstr-slv).h,389 :: 		entroBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBP2+0 
	CALL        _entroBP2+0, 0
;rutinasensores_v4(mstr-slv).h,390 :: 		saliendoBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBP2+0 
	CALL        _saliendoBP2+0, 0
;rutinasensores_v4(mstr-slv).h,391 :: 		transicionSBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBP2+0 
	CALL        _transicionSBP2+0, 0
;rutinasensores_v4(mstr-slv).h,392 :: 		transicionSalBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBP2+0 
	CALL        _transicionSalBP2+0, 0
;rutinasensores_v4(mstr-slv).h,393 :: 		salioBP2(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBP2+0 
	CALL        _salioBP2+0, 0
;rutinasensores_v4(mstr-slv).h,394 :: 		}
L_end_sensorBloqueoPar2:
	RETURN      0
; end of _sensorBloqueoPar2

_sensorBloqueoPar3:

;rutinasensores_v4(mstr-slv).h,396 :: 		void sensorBloqueoPar3(){
;rutinasensores_v4(mstr-slv).h,397 :: 		esperaBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBP3+0 
	CALL        _esperaBP3+0, 0
;rutinasensores_v4(mstr-slv).h,398 :: 		entrandoBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBP3+0 
	CALL        _entrandoBP3+0, 0
;rutinasensores_v4(mstr-slv).h,399 :: 		transicionEBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBP3+0 
	CALL        _transicionEBP3+0, 0
;rutinasensores_v4(mstr-slv).h,400 :: 		transicionEntBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBP3+0 
	CALL        _transicionEntBP3+0, 0
;rutinasensores_v4(mstr-slv).h,401 :: 		entroBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBP3+0 
	CALL        _entroBP3+0, 0
;rutinasensores_v4(mstr-slv).h,402 :: 		saliendoBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBP3+0 
	CALL        _saliendoBP3+0, 0
;rutinasensores_v4(mstr-slv).h,403 :: 		transicionSBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBP3+0 
	CALL        _transicionSBP3+0, 0
;rutinasensores_v4(mstr-slv).h,404 :: 		transicionSalBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBP3+0 
	CALL        _transicionSalBP3+0, 0
;rutinasensores_v4(mstr-slv).h,405 :: 		salioBP3(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBP3+0 
	CALL        _salioBP3+0, 0
;rutinasensores_v4(mstr-slv).h,406 :: 		}
L_end_sensorBloqueoPar3:
	RETURN      0
; end of _sensorBloqueoPar3

_sensorBloqueoPar4:

;rutinasensores_v4(mstr-slv).h,408 :: 		void sensorBloqueoPar4(){
;rutinasensores_v4(mstr-slv).h,409 :: 		esperaBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBP4+0 
	CALL        _esperaBP4+0, 0
;rutinasensores_v4(mstr-slv).h,410 :: 		entrandoBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBP4+0 
	CALL        _entrandoBP4+0, 0
;rutinasensores_v4(mstr-slv).h,411 :: 		transicionEBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBP4+0 
	CALL        _transicionEBP4+0, 0
;rutinasensores_v4(mstr-slv).h,412 :: 		transicionEntBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBP4+0 
	CALL        _transicionEntBP4+0, 0
;rutinasensores_v4(mstr-slv).h,413 :: 		entroBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBP4+0 
	CALL        _entroBP4+0, 0
;rutinasensores_v4(mstr-slv).h,414 :: 		saliendoBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBP4+0 
	CALL        _saliendoBP4+0, 0
;rutinasensores_v4(mstr-slv).h,415 :: 		transicionSBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBP4+0 
	CALL        _transicionSBP4+0, 0
;rutinasensores_v4(mstr-slv).h,416 :: 		transicionSalBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBP4+0 
	CALL        _transicionSalBP4+0, 0
;rutinasensores_v4(mstr-slv).h,417 :: 		salioBP4(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBP4+0 
	CALL        _salioBP4+0, 0
;rutinasensores_v4(mstr-slv).h,418 :: 		}
L_end_sensorBloqueoPar4:
	RETURN      0
; end of _sensorBloqueoPar4

_sensorBloqueoPar6:

;rutinasensores_v4(mstr-slv).h,420 :: 		void sensorBloqueoPar6(){
;rutinasensores_v4(mstr-slv).h,421 :: 		esperaBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBP6+0 
	CALL        _esperaBP6+0, 0
;rutinasensores_v4(mstr-slv).h,422 :: 		entrandoBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBP6+0 
	CALL        _entrandoBP6+0, 0
;rutinasensores_v4(mstr-slv).h,423 :: 		transicionEBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBP6+0 
	CALL        _transicionEBP6+0, 0
;rutinasensores_v4(mstr-slv).h,424 :: 		transicionEntBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBP6+0 
	CALL        _transicionEntBP6+0, 0
;rutinasensores_v4(mstr-slv).h,425 :: 		entroBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBP6+0 
	CALL        _entroBP6+0, 0
;rutinasensores_v4(mstr-slv).h,426 :: 		saliendoBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBP6+0 
	CALL        _saliendoBP6+0, 0
;rutinasensores_v4(mstr-slv).h,427 :: 		transicionSBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBP6+0 
	CALL        _transicionSBP6+0, 0
;rutinasensores_v4(mstr-slv).h,428 :: 		transicionSalBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBP6+0 
	CALL        _transicionSalBP6+0, 0
;rutinasensores_v4(mstr-slv).h,429 :: 		salioBP6(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBP6+0 
	CALL        _salioBP6+0, 0
;rutinasensores_v4(mstr-slv).h,430 :: 		}
L_end_sensorBloqueoPar6:
	RETURN      0
; end of _sensorBloqueoPar6

_sensorBloqueoPar7:

;rutinasensores_v4(mstr-slv).h,432 :: 		void sensorBloqueoPar7(){
;rutinasensores_v4(mstr-slv).h,433 :: 		esperaBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBP7+0 
	CALL        _esperaBP7+0, 0
;rutinasensores_v4(mstr-slv).h,434 :: 		entrandoBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBP7+0 
	CALL        _entrandoBP7+0, 0
;rutinasensores_v4(mstr-slv).h,435 :: 		transicionEBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBP7+0 
	CALL        _transicionEBP7+0, 0
;rutinasensores_v4(mstr-slv).h,436 :: 		transicionEntBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBP7+0 
	CALL        _transicionEntBP7+0, 0
;rutinasensores_v4(mstr-slv).h,437 :: 		entroBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBP7+0 
	CALL        _entroBP7+0, 0
;rutinasensores_v4(mstr-slv).h,438 :: 		saliendoBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBP7+0 
	CALL        _saliendoBP7+0, 0
;rutinasensores_v4(mstr-slv).h,439 :: 		transicionSBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBP7+0 
	CALL        _transicionSBP7+0, 0
;rutinasensores_v4(mstr-slv).h,440 :: 		transicionSalBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBP7+0 
	CALL        _transicionSalBP7+0, 0
;rutinasensores_v4(mstr-slv).h,441 :: 		salioBP7(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBP7+0 
	CALL        _salioBP7+0, 0
;rutinasensores_v4(mstr-slv).h,442 :: 		}
L_end_sensorBloqueoPar7:
	RETURN      0
; end of _sensorBloqueoPar7

_sensorBloqueoPar9:

;rutinasensores_v4(mstr-slv).h,444 :: 		void sensorBloqueoPar9(){
;rutinasensores_v4(mstr-slv).h,445 :: 		esperaBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_esperaBP9+0 
	CALL        _esperaBP9+0, 0
;rutinasensores_v4(mstr-slv).h,446 :: 		entrandoBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entrandoBP9+0 
	CALL        _entrandoBP9+0, 0
;rutinasensores_v4(mstr-slv).h,447 :: 		transicionEBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEBP9+0 
	CALL        _transicionEBP9+0, 0
;rutinasensores_v4(mstr-slv).h,448 :: 		transicionEntBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionEntBP9+0 
	CALL        _transicionEntBP9+0, 0
;rutinasensores_v4(mstr-slv).h,449 :: 		entroBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_entroBP9+0 
	CALL        _entroBP9+0, 0
;rutinasensores_v4(mstr-slv).h,450 :: 		saliendoBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_saliendoBP9+0 
	CALL        _saliendoBP9+0, 0
;rutinasensores_v4(mstr-slv).h,451 :: 		transicionSBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSBP9+0 
	CALL        _transicionSBP9+0, 0
;rutinasensores_v4(mstr-slv).h,452 :: 		transicionSalBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_transicionSalBP9+0 
	CALL        _transicionSalBP9+0, 0
;rutinasensores_v4(mstr-slv).h,453 :: 		salioBP9(debugEstadoB);
	MOVF        _debugEstadoB+0, 0 
	MOVWF       FARG_salioBP9+0 
	CALL        _salioBP9+0, 0
;rutinasensores_v4(mstr-slv).h,454 :: 		}
L_end_sensorBloqueoPar9:
	RETURN      0
; end of _sensorBloqueoPar9

_espera:

;rutinasensores_v4(mstr-slv).h,460 :: 		short espera(short estado){
;rutinasensores_v4(mstr-slv).h,461 :: 		if(estado == ESPERA){
	MOVF        FARG_espera_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_espera186
;rutinasensores_v4(mstr-slv).h,463 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,465 :: 		if( (!SENSOR1 | !SENSOR3 | !SENSOR5) & ((SENSOR2 & SENSOR4) | (SENSOR4&SENSOR6) | (SENSOR2&SENSOR6))){
	BTFSC       PORTB+0, 4 
	GOTO        L__espera735
	BSF         R1, 0 
	GOTO        L__espera736
L__espera735:
	BCF         R1, 0 
L__espera736:
	BTFSC       PORTB+0, 2 
	GOTO        L__espera737
	BSF         4056, 0 
	GOTO        L__espera738
L__espera737:
	BCF         4056, 0 
L__espera738:
	BTFSC       R1, 0 
	GOTO        L__espera739
	BTFSC       4056, 0 
	GOTO        L__espera739
	BCF         R1, 0 
	GOTO        L__espera740
L__espera739:
	BSF         R1, 0 
L__espera740:
	BTFSC       PORTB+0, 0 
	GOTO        L__espera741
	BSF         4056, 0 
	GOTO        L__espera742
L__espera741:
	BCF         4056, 0 
L__espera742:
	BTFSC       R1, 0 
	GOTO        L__espera743
	BTFSC       4056, 0 
	GOTO        L__espera743
	BCF         R1, 1 
	GOTO        L__espera744
L__espera743:
	BSF         R1, 1 
L__espera744:
	BTFSS       PORTD+0, 4 
	GOTO        L__espera745
	BTFSS       PORTB+0, 3 
	GOTO        L__espera745
	BSF         R1, 0 
	GOTO        L__espera746
L__espera745:
	BCF         R1, 0 
L__espera746:
	BTFSS       PORTB+0, 3 
	GOTO        L__espera747
	BTFSS       PORTB+0, 1 
	GOTO        L__espera747
	BSF         4056, 0 
	GOTO        L__espera748
L__espera747:
	BCF         4056, 0 
L__espera748:
	BTFSC       R1, 0 
	GOTO        L__espera749
	BTFSC       4056, 0 
	GOTO        L__espera749
	BCF         R1, 0 
	GOTO        L__espera750
L__espera749:
	BSF         R1, 0 
L__espera750:
	BTFSS       PORTD+0, 4 
	GOTO        L__espera751
	BTFSS       PORTB+0, 1 
	GOTO        L__espera751
	BSF         4056, 0 
	GOTO        L__espera752
L__espera751:
	BCF         4056, 0 
L__espera752:
	BTFSC       R1, 0 
	GOTO        L__espera753
	BTFSC       4056, 0 
	GOTO        L__espera753
	BCF         R1, 0 
	GOTO        L__espera754
L__espera753:
	BSF         R1, 0 
L__espera754:
	BTFSS       R1, 1 
	GOTO        L__espera755
	BTFSS       R1, 0 
	GOTO        L__espera755
	BSF         4056, 0 
	GOTO        L__espera756
L__espera755:
	BCF         4056, 0 
L__espera756:
	BTFSS       4056, 0 
	GOTO        L_espera187
;rutinasensores_v4(mstr-slv).h,467 :: 		cuentaUSART = 0;
	CLRF        _cuentaUSART+0 
;rutinasensores_v4(mstr-slv).h,468 :: 		permanencia = true;
	MOVLW       1
	MOVWF       _permanencia+0 
;rutinasensores_v4(mstr-slv).h,469 :: 		empiezaEntrada = true;
	MOVLW       1
	MOVWF       _empiezaEntrada+0 
;rutinasensores_v4(mstr-slv).h,470 :: 		empiezaSalida = false;
	CLRF        _empiezaSalida+0 
;rutinasensores_v4(mstr-slv).h,471 :: 		return debugEstado = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstado+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_espera
;rutinasensores_v4(mstr-slv).h,472 :: 		}
L_espera187:
;rutinasensores_v4(mstr-slv).h,473 :: 		if( (!SENSOR2 | !SENSOR4 | !SENSOR6) &((SENSOR1 & SENSOR3) | (SENSOR3&SENSOR5) | (SENSOR1&SENSOR5)) ){
	BTFSC       PORTD+0, 4 
	GOTO        L__espera757
	BSF         R1, 0 
	GOTO        L__espera758
L__espera757:
	BCF         R1, 0 
L__espera758:
	BTFSC       PORTB+0, 3 
	GOTO        L__espera759
	BSF         4056, 0 
	GOTO        L__espera760
L__espera759:
	BCF         4056, 0 
L__espera760:
	BTFSC       R1, 0 
	GOTO        L__espera761
	BTFSC       4056, 0 
	GOTO        L__espera761
	BCF         R1, 0 
	GOTO        L__espera762
L__espera761:
	BSF         R1, 0 
L__espera762:
	BTFSC       PORTB+0, 1 
	GOTO        L__espera763
	BSF         4056, 0 
	GOTO        L__espera764
L__espera763:
	BCF         4056, 0 
L__espera764:
	BTFSC       R1, 0 
	GOTO        L__espera765
	BTFSC       4056, 0 
	GOTO        L__espera765
	BCF         R1, 1 
	GOTO        L__espera766
L__espera765:
	BSF         R1, 1 
L__espera766:
	BTFSS       PORTB+0, 4 
	GOTO        L__espera767
	BTFSS       PORTB+0, 2 
	GOTO        L__espera767
	BSF         R1, 0 
	GOTO        L__espera768
L__espera767:
	BCF         R1, 0 
L__espera768:
	BTFSS       PORTB+0, 2 
	GOTO        L__espera769
	BTFSS       PORTB+0, 0 
	GOTO        L__espera769
	BSF         4056, 0 
	GOTO        L__espera770
L__espera769:
	BCF         4056, 0 
L__espera770:
	BTFSC       R1, 0 
	GOTO        L__espera771
	BTFSC       4056, 0 
	GOTO        L__espera771
	BCF         R1, 0 
	GOTO        L__espera772
L__espera771:
	BSF         R1, 0 
L__espera772:
	BTFSS       PORTB+0, 4 
	GOTO        L__espera773
	BTFSS       PORTB+0, 0 
	GOTO        L__espera773
	BSF         4056, 0 
	GOTO        L__espera774
L__espera773:
	BCF         4056, 0 
L__espera774:
	BTFSC       R1, 0 
	GOTO        L__espera775
	BTFSC       4056, 0 
	GOTO        L__espera775
	BCF         R1, 0 
	GOTO        L__espera776
L__espera775:
	BSF         R1, 0 
L__espera776:
	BTFSS       R1, 1 
	GOTO        L__espera777
	BTFSS       R1, 0 
	GOTO        L__espera777
	BSF         4056, 0 
	GOTO        L__espera778
L__espera777:
	BCF         4056, 0 
L__espera778:
	BTFSS       4056, 0 
	GOTO        L_espera188
;rutinasensores_v4(mstr-slv).h,475 :: 		cuentaUSART = 0;
	CLRF        _cuentaUSART+0 
;rutinasensores_v4(mstr-slv).h,476 :: 		permanencia = true;
	MOVLW       1
	MOVWF       _permanencia+0 
;rutinasensores_v4(mstr-slv).h,477 :: 		empiezaSalida = true;
	MOVLW       1
	MOVWF       _empiezaSalida+0 
;rutinasensores_v4(mstr-slv).h,478 :: 		empiezaEntrada = false;
	CLRF        _empiezaEntrada+0 
;rutinasensores_v4(mstr-slv).h,479 :: 		return debugEstado = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstado+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_espera
;rutinasensores_v4(mstr-slv).h,480 :: 		}
L_espera188:
;rutinasensores_v4(mstr-slv).h,481 :: 		return ESPERA;
	CLRF        R0 
	GOTO        L_end_espera
;rutinasensores_v4(mstr-slv).h,482 :: 		}
L_espera186:
;rutinasensores_v4(mstr-slv).h,483 :: 		}
L_end_espera:
	RETURN      0
; end of _espera

_entrando:

;rutinasensores_v4(mstr-slv).h,485 :: 		short entrando(short estado){
;rutinasensores_v4(mstr-slv).h,486 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrando_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrando189
;rutinasensores_v4(mstr-slv).h,487 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_8_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_8_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_8_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,489 :: 		if((!SENSOR2 | !SENSOR4 | !SENSOR6)&((!SENSOR1 & !SENSOR3)|(!SENSOR3&!SENSOR5)|(!SENSOR1&!SENSOR5))){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrando780
	BSF         R1, 0 
	GOTO        L__entrando781
L__entrando780:
	BCF         R1, 0 
L__entrando781:
	BTFSC       PORTB+0, 3 
	GOTO        L__entrando782
	BSF         4056, 0 
	GOTO        L__entrando783
L__entrando782:
	BCF         4056, 0 
L__entrando783:
	BTFSC       R1, 0 
	GOTO        L__entrando784
	BTFSC       4056, 0 
	GOTO        L__entrando784
	BCF         R1, 0 
	GOTO        L__entrando785
L__entrando784:
	BSF         R1, 0 
L__entrando785:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrando786
	BSF         4056, 0 
	GOTO        L__entrando787
L__entrando786:
	BCF         4056, 0 
L__entrando787:
	BTFSC       R1, 0 
	GOTO        L__entrando788
	BTFSC       4056, 0 
	GOTO        L__entrando788
	BCF         R1, 4 
	GOTO        L__entrando789
L__entrando788:
	BSF         R1, 4 
L__entrando789:
	BTFSC       PORTB+0, 4 
	GOTO        L__entrando790
	BSF         R1, 3 
	GOTO        L__entrando791
L__entrando790:
	BCF         R1, 3 
L__entrando791:
	BTFSC       PORTB+0, 2 
	GOTO        L__entrando792
	BSF         R1, 0 
	GOTO        L__entrando793
L__entrando792:
	BCF         R1, 0 
L__entrando793:
	BTFSS       R1, 3 
	GOTO        L__entrando794
	BTFSS       R1, 0 
	GOTO        L__entrando794
	BSF         R1, 1 
	GOTO        L__entrando795
L__entrando794:
	BCF         R1, 1 
L__entrando795:
	BTFSC       PORTB+0, 0 
	GOTO        L__entrando796
	BSF         R1, 2 
	GOTO        L__entrando797
L__entrando796:
	BCF         R1, 2 
L__entrando797:
	BTFSS       R1, 0 
	GOTO        L__entrando798
	BTFSS       R1, 2 
	GOTO        L__entrando798
	BSF         4056, 0 
	GOTO        L__entrando799
L__entrando798:
	BCF         4056, 0 
L__entrando799:
	BTFSC       R1, 1 
	GOTO        L__entrando800
	BTFSC       4056, 0 
	GOTO        L__entrando800
	BCF         R1, 1 
	GOTO        L__entrando801
L__entrando800:
	BSF         R1, 1 
L__entrando801:
	BTFSC       R1, 3 
	GOTO        L__entrando802
	BCF         R1, 0 
	GOTO        L__entrando803
L__entrando802:
	BSF         R1, 0 
L__entrando803:
	BTFSC       R1, 2 
	GOTO        L__entrando804
	BCF         4056, 0 
	GOTO        L__entrando805
L__entrando804:
	BSF         4056, 0 
L__entrando805:
	BTFSS       R1, 0 
	GOTO        L__entrando806
	BTFSS       4056, 0 
	GOTO        L__entrando806
	BSF         R1, 0 
	GOTO        L__entrando807
L__entrando806:
	BCF         R1, 0 
L__entrando807:
	BTFSC       R1, 1 
	GOTO        L__entrando808
	BTFSC       R1, 0 
	GOTO        L__entrando808
	BCF         4056, 0 
	GOTO        L__entrando809
L__entrando808:
	BSF         4056, 0 
L__entrando809:
	BTFSS       R1, 4 
	GOTO        L__entrando810
	BTFSS       4056, 0 
	GOTO        L__entrando810
	BSF         R1, 0 
	GOTO        L__entrando811
L__entrando810:
	BCF         R1, 0 
L__entrando811:
	BTFSS       R1, 0 
	GOTO        L_entrando190
;rutinasensores_v4(mstr-slv).h,491 :: 		return debugEstado = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstado+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrando
;rutinasensores_v4(mstr-slv).h,492 :: 		}
L_entrando190:
;rutinasensores_v4(mstr-slv).h,493 :: 		if((SENSOR1&SENSOR3) | (SENSOR3&SENSOR5) | (SENSOR1&SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrando812
	BTFSS       PORTB+0, 2 
	GOTO        L__entrando812
	BSF         R1, 0 
	GOTO        L__entrando813
L__entrando812:
	BCF         R1, 0 
L__entrando813:
	BTFSS       PORTB+0, 2 
	GOTO        L__entrando814
	BTFSS       PORTB+0, 0 
	GOTO        L__entrando814
	BSF         4056, 0 
	GOTO        L__entrando815
L__entrando814:
	BCF         4056, 0 
L__entrando815:
	BTFSC       R1, 0 
	GOTO        L__entrando816
	BTFSC       4056, 0 
	GOTO        L__entrando816
	BCF         R1, 0 
	GOTO        L__entrando817
L__entrando816:
	BSF         R1, 0 
L__entrando817:
	BTFSS       PORTB+0, 4 
	GOTO        L__entrando818
	BTFSS       PORTB+0, 0 
	GOTO        L__entrando818
	BSF         4056, 0 
	GOTO        L__entrando819
L__entrando818:
	BCF         4056, 0 
L__entrando819:
	BTFSC       R1, 0 
	GOTO        L__entrando820
	BTFSC       4056, 0 
	GOTO        L__entrando820
	BCF         R1, 0 
	GOTO        L__entrando821
L__entrando820:
	BSF         R1, 0 
L__entrando821:
	BTFSS       R1, 0 
	GOTO        L_entrando191
;rutinasensores_v4(mstr-slv).h,495 :: 		return debugEstado = ESPERA;
	CLRF        _debugEstado+0 
	CLRF        R0 
	GOTO        L_end_entrando
;rutinasensores_v4(mstr-slv).h,496 :: 		}
L_entrando191:
;rutinasensores_v4(mstr-slv).h,497 :: 		}
L_entrando189:
;rutinasensores_v4(mstr-slv).h,498 :: 		}
L_end_entrando:
	RETURN      0
; end of _entrando

_transicionE:

;rutinasensores_v4(mstr-slv).h,500 :: 		short transicionE(short estado){
;rutinasensores_v4(mstr-slv).h,501 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionE_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionE192
;rutinasensores_v4(mstr-slv).h,502 :: 		LCD_OUTCONST(3,1,"TRANSICIONE");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_9_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_9_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_9_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,503 :: 		if((SENSOR1&SENSOR3) | (SENSOR3&SENSOR5) | (SENSOR1& SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionE823
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionE823
	BSF         R1, 0 
	GOTO        L__transicionE824
L__transicionE823:
	BCF         R1, 0 
L__transicionE824:
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionE825
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionE825
	BSF         4056, 0 
	GOTO        L__transicionE826
L__transicionE825:
	BCF         4056, 0 
L__transicionE826:
	BTFSC       R1, 0 
	GOTO        L__transicionE827
	BTFSC       4056, 0 
	GOTO        L__transicionE827
	BCF         R1, 0 
	GOTO        L__transicionE828
L__transicionE827:
	BSF         R1, 0 
L__transicionE828:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionE829
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionE829
	BSF         4056, 0 
	GOTO        L__transicionE830
L__transicionE829:
	BCF         4056, 0 
L__transicionE830:
	BTFSC       R1, 0 
	GOTO        L__transicionE831
	BTFSC       4056, 0 
	GOTO        L__transicionE831
	BCF         R1, 0 
	GOTO        L__transicionE832
L__transicionE831:
	BSF         R1, 0 
L__transicionE832:
	BTFSS       R1, 0 
	GOTO        L_transicionE193
;rutinasensores_v4(mstr-slv).h,504 :: 		return debugEstado = TRANENT;
	MOVLW       7
	MOVWF       _debugEstado+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionE
;rutinasensores_v4(mstr-slv).h,505 :: 		}
L_transicionE193:
;rutinasensores_v4(mstr-slv).h,506 :: 		if((SENSOR2&SENSOR4) | (SENSOR4&SENSOR6) | (SENSOR2& SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionE833
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionE833
	BSF         R1, 0 
	GOTO        L__transicionE834
L__transicionE833:
	BCF         R1, 0 
L__transicionE834:
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionE835
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionE835
	BSF         4056, 0 
	GOTO        L__transicionE836
L__transicionE835:
	BCF         4056, 0 
L__transicionE836:
	BTFSC       R1, 0 
	GOTO        L__transicionE837
	BTFSC       4056, 0 
	GOTO        L__transicionE837
	BCF         R1, 0 
	GOTO        L__transicionE838
L__transicionE837:
	BSF         R1, 0 
L__transicionE838:
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionE839
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionE839
	BSF         4056, 0 
	GOTO        L__transicionE840
L__transicionE839:
	BCF         4056, 0 
L__transicionE840:
	BTFSC       R1, 0 
	GOTO        L__transicionE841
	BTFSC       4056, 0 
	GOTO        L__transicionE841
	BCF         R1, 0 
	GOTO        L__transicionE842
L__transicionE841:
	BSF         R1, 0 
L__transicionE842:
	BTFSS       R1, 0 
	GOTO        L_transicionE194
;rutinasensores_v4(mstr-slv).h,507 :: 		return debugEstado = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstado+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionE
;rutinasensores_v4(mstr-slv).h,508 :: 		}
L_transicionE194:
;rutinasensores_v4(mstr-slv).h,509 :: 		}
L_transicionE192:
;rutinasensores_v4(mstr-slv).h,510 :: 		}
L_end_transicionE:
	RETURN      0
; end of _transicionE

_transicionEnt:

;rutinasensores_v4(mstr-slv).h,512 :: 		short transicionEnt(short estado){
;rutinasensores_v4(mstr-slv).h,513 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEnt_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEnt195
;rutinasensores_v4(mstr-slv).h,514 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_10_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_10_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_10_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,516 :: 		((!SENSOR1&!SENSOR3) | (!SENSOR3&!SENSOR5) | (!SENSOR1& !SENSOR5))
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEnt844
	BSF         R1, 3 
	GOTO        L__transicionEnt845
L__transicionEnt844:
	BCF         R1, 3 
L__transicionEnt845:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEnt846
	BSF         R1, 0 
	GOTO        L__transicionEnt847
L__transicionEnt846:
	BCF         R1, 0 
L__transicionEnt847:
	BTFSS       R1, 3 
	GOTO        L__transicionEnt848
	BTFSS       R1, 0 
	GOTO        L__transicionEnt848
	BSF         R1, 1 
	GOTO        L__transicionEnt849
L__transicionEnt848:
	BCF         R1, 1 
L__transicionEnt849:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEnt850
	BSF         R1, 2 
	GOTO        L__transicionEnt851
L__transicionEnt850:
	BCF         R1, 2 
L__transicionEnt851:
	BTFSS       R1, 0 
	GOTO        L__transicionEnt852
	BTFSS       R1, 2 
	GOTO        L__transicionEnt852
	BSF         4056, 0 
	GOTO        L__transicionEnt853
L__transicionEnt852:
	BCF         4056, 0 
L__transicionEnt853:
	BTFSC       R1, 1 
	GOTO        L__transicionEnt854
	BTFSC       4056, 0 
	GOTO        L__transicionEnt854
	BCF         R1, 1 
	GOTO        L__transicionEnt855
L__transicionEnt854:
	BSF         R1, 1 
L__transicionEnt855:
	BTFSC       R1, 3 
	GOTO        L__transicionEnt856
	BCF         R1, 0 
	GOTO        L__transicionEnt857
L__transicionEnt856:
	BSF         R1, 0 
L__transicionEnt857:
	BTFSC       R1, 2 
	GOTO        L__transicionEnt858
	BCF         4056, 0 
	GOTO        L__transicionEnt859
L__transicionEnt858:
	BSF         4056, 0 
L__transicionEnt859:
	BTFSS       R1, 0 
	GOTO        L__transicionEnt860
	BTFSS       4056, 0 
	GOTO        L__transicionEnt860
	BSF         R1, 0 
	GOTO        L__transicionEnt861
L__transicionEnt860:
	BCF         R1, 0 
L__transicionEnt861:
	BTFSC       R1, 1 
	GOTO        L__transicionEnt862
	BTFSC       R1, 0 
	GOTO        L__transicionEnt862
	BCF         4056, 0 
	GOTO        L__transicionEnt863
L__transicionEnt862:
	BSF         4056, 0 
L__transicionEnt863:
;rutinasensores_v4(mstr-slv).h,517 :: 		){
	BTFSS       4056, 0 
	GOTO        L_transicionEnt196
;rutinasensores_v4(mstr-slv).h,518 :: 		return debugEstado = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstado+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEnt
;rutinasensores_v4(mstr-slv).h,519 :: 		}
L_transicionEnt196:
;rutinasensores_v4(mstr-slv).h,520 :: 		if(SENSOR2 & SENSOR4 & SENSOR6){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEnt864
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEnt864
	BSF         4056, 0 
	GOTO        L__transicionEnt865
L__transicionEnt864:
	BCF         4056, 0 
L__transicionEnt865:
	BTFSS       4056, 0 
	GOTO        L__transicionEnt866
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEnt866
	BSF         R1, 0 
	GOTO        L__transicionEnt867
L__transicionEnt866:
	BCF         R1, 0 
L__transicionEnt867:
	BTFSS       R1, 0 
	GOTO        L_transicionEnt197
;rutinasensores_v4(mstr-slv).h,521 :: 		return debugEstado = ENTRO;
	MOVLW       3
	MOVWF       _debugEstado+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEnt
;rutinasensores_v4(mstr-slv).h,522 :: 		}
L_transicionEnt197:
;rutinasensores_v4(mstr-slv).h,523 :: 		}
L_transicionEnt195:
;rutinasensores_v4(mstr-slv).h,524 :: 		}
L_end_transicionEnt:
	RETURN      0
; end of _transicionEnt

_entro:

;rutinasensores_v4(mstr-slv).h,526 :: 		short entro(short estado){
;rutinasensores_v4(mstr-slv).h,527 :: 		if(estado == ENTRO){
	MOVF        FARG_entro_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entro198
;rutinasensores_v4(mstr-slv).h,528 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_11_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_11_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_11_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,530 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,531 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,532 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,533 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,534 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entro+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entro+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entro+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entro+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entro+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entro+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entro+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entro+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,535 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,536 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entro199
;rutinasensores_v4(mstr-slv).h,537 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,538 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,539 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,540 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entro+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entro+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entro+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entro+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entro+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entro+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entro+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entro+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entro+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entro+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entro+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entro+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entro+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entro+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entro+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entro+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,541 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,542 :: 		}
L_entro199:
;rutinasensores_v4(mstr-slv).h,544 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,546 :: 		permanencia = false;
	CLRF        _permanencia+0 
;rutinasensores_v4(mstr-slv).h,547 :: 		empiezaEntrada = false;
	CLRF        _empiezaEntrada+0 
;rutinasensores_v4(mstr-slv).h,548 :: 		return debugEstado = ESPERA;
	CLRF        _debugEstado+0 
	CLRF        R0 
	GOTO        L_end_entro
;rutinasensores_v4(mstr-slv).h,549 :: 		}
L_entro198:
;rutinasensores_v4(mstr-slv).h,550 :: 		}
L_end_entro:
	RETURN      0
; end of _entro

_saliendo:

;rutinasensores_v4(mstr-slv).h,552 :: 		short saliendo(short estado){
;rutinasensores_v4(mstr-slv).h,553 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendo_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendo200
;rutinasensores_v4(mstr-slv).h,554 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_12_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_12_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_12_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,555 :: 		if( (!SENSOR1 | !SENSOR3 | !SENSOR5)&((!SENSOR2 & !SENSOR4)|(!SENSOR4&!SENSOR6)|(!SENSOR2&!SENSOR6))
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendo870
	BSF         R1, 0 
	GOTO        L__saliendo871
L__saliendo870:
	BCF         R1, 0 
L__saliendo871:
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendo872
	BSF         4056, 0 
	GOTO        L__saliendo873
L__saliendo872:
	BCF         4056, 0 
L__saliendo873:
	BTFSC       R1, 0 
	GOTO        L__saliendo874
	BTFSC       4056, 0 
	GOTO        L__saliendo874
	BCF         R1, 0 
	GOTO        L__saliendo875
L__saliendo874:
	BSF         R1, 0 
L__saliendo875:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendo876
	BSF         4056, 0 
	GOTO        L__saliendo877
L__saliendo876:
	BCF         4056, 0 
L__saliendo877:
	BTFSC       R1, 0 
	GOTO        L__saliendo878
	BTFSC       4056, 0 
	GOTO        L__saliendo878
	BCF         R1, 4 
	GOTO        L__saliendo879
L__saliendo878:
	BSF         R1, 4 
L__saliendo879:
	BTFSC       PORTD+0, 4 
	GOTO        L__saliendo880
	BSF         R1, 3 
	GOTO        L__saliendo881
L__saliendo880:
	BCF         R1, 3 
L__saliendo881:
	BTFSC       PORTB+0, 3 
	GOTO        L__saliendo882
	BSF         R1, 0 
	GOTO        L__saliendo883
L__saliendo882:
	BCF         R1, 0 
L__saliendo883:
	BTFSS       R1, 3 
	GOTO        L__saliendo884
	BTFSS       R1, 0 
	GOTO        L__saliendo884
	BSF         R1, 1 
	GOTO        L__saliendo885
L__saliendo884:
	BCF         R1, 1 
L__saliendo885:
	BTFSC       PORTB+0, 1 
	GOTO        L__saliendo886
	BSF         R1, 2 
	GOTO        L__saliendo887
L__saliendo886:
	BCF         R1, 2 
L__saliendo887:
	BTFSS       R1, 0 
	GOTO        L__saliendo888
	BTFSS       R1, 2 
	GOTO        L__saliendo888
	BSF         4056, 0 
	GOTO        L__saliendo889
L__saliendo888:
	BCF         4056, 0 
L__saliendo889:
	BTFSC       R1, 1 
	GOTO        L__saliendo890
	BTFSC       4056, 0 
	GOTO        L__saliendo890
	BCF         R1, 1 
	GOTO        L__saliendo891
L__saliendo890:
	BSF         R1, 1 
L__saliendo891:
	BTFSC       R1, 3 
	GOTO        L__saliendo892
	BCF         R1, 0 
	GOTO        L__saliendo893
L__saliendo892:
	BSF         R1, 0 
L__saliendo893:
	BTFSC       R1, 2 
	GOTO        L__saliendo894
	BCF         4056, 0 
	GOTO        L__saliendo895
L__saliendo894:
	BSF         4056, 0 
L__saliendo895:
	BTFSS       R1, 0 
	GOTO        L__saliendo896
	BTFSS       4056, 0 
	GOTO        L__saliendo896
	BSF         R1, 0 
	GOTO        L__saliendo897
L__saliendo896:
	BCF         R1, 0 
L__saliendo897:
	BTFSC       R1, 1 
	GOTO        L__saliendo898
	BTFSC       R1, 0 
	GOTO        L__saliendo898
	BCF         4056, 0 
	GOTO        L__saliendo899
L__saliendo898:
	BSF         4056, 0 
L__saliendo899:
	BTFSS       R1, 4 
	GOTO        L__saliendo900
	BTFSS       4056, 0 
	GOTO        L__saliendo900
	BSF         R1, 0 
	GOTO        L__saliendo901
L__saliendo900:
	BCF         R1, 0 
L__saliendo901:
;rutinasensores_v4(mstr-slv).h,556 :: 		){
	BTFSS       R1, 0 
	GOTO        L_saliendo201
;rutinasensores_v4(mstr-slv).h,557 :: 		return debugEstado = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstado+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendo
;rutinasensores_v4(mstr-slv).h,558 :: 		}
L_saliendo201:
;rutinasensores_v4(mstr-slv).h,559 :: 		if((SENSOR2&SENSOR4) | (SENSOR4&SENSOR6) | (SENSOR2&SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendo902
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendo902
	BSF         R1, 0 
	GOTO        L__saliendo903
L__saliendo902:
	BCF         R1, 0 
L__saliendo903:
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendo904
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendo904
	BSF         4056, 0 
	GOTO        L__saliendo905
L__saliendo904:
	BCF         4056, 0 
L__saliendo905:
	BTFSC       R1, 0 
	GOTO        L__saliendo906
	BTFSC       4056, 0 
	GOTO        L__saliendo906
	BCF         R1, 0 
	GOTO        L__saliendo907
L__saliendo906:
	BSF         R1, 0 
L__saliendo907:
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendo908
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendo908
	BSF         4056, 0 
	GOTO        L__saliendo909
L__saliendo908:
	BCF         4056, 0 
L__saliendo909:
	BTFSC       R1, 0 
	GOTO        L__saliendo910
	BTFSC       4056, 0 
	GOTO        L__saliendo910
	BCF         R1, 0 
	GOTO        L__saliendo911
L__saliendo910:
	BSF         R1, 0 
L__saliendo911:
	BTFSS       R1, 0 
	GOTO        L_saliendo202
;rutinasensores_v4(mstr-slv).h,561 :: 		return debugEstado = ESPERA;
	CLRF        _debugEstado+0 
	CLRF        R0 
	GOTO        L_end_saliendo
;rutinasensores_v4(mstr-slv).h,562 :: 		}
L_saliendo202:
;rutinasensores_v4(mstr-slv).h,563 :: 		}
L_saliendo200:
;rutinasensores_v4(mstr-slv).h,564 :: 		}
L_end_saliendo:
	RETURN      0
; end of _saliendo

_transicionS:

;rutinasensores_v4(mstr-slv).h,566 :: 		short transicionS(short estado){
;rutinasensores_v4(mstr-slv).h,567 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionS_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionS203
;rutinasensores_v4(mstr-slv).h,568 :: 		lcd_outConst(3, 1, "TRANSICION S");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_13_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_13_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_13_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,571 :: 		(SENSOR2&SENSOR4) | (SENSOR4&SENSOR6) | (SENSOR2& SENSOR6)
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionS913
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionS913
	BSF         R1, 0 
	GOTO        L__transicionS914
L__transicionS913:
	BCF         R1, 0 
L__transicionS914:
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionS915
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionS915
	BSF         4056, 0 
	GOTO        L__transicionS916
L__transicionS915:
	BCF         4056, 0 
L__transicionS916:
	BTFSC       R1, 0 
	GOTO        L__transicionS917
	BTFSC       4056, 0 
	GOTO        L__transicionS917
	BCF         R1, 0 
	GOTO        L__transicionS918
L__transicionS917:
	BSF         R1, 0 
L__transicionS918:
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionS919
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionS919
	BSF         4056, 0 
	GOTO        L__transicionS920
L__transicionS919:
	BCF         4056, 0 
L__transicionS920:
	BTFSC       R1, 0 
	GOTO        L__transicionS921
	BTFSC       4056, 0 
	GOTO        L__transicionS921
	BCF         R1, 0 
	GOTO        L__transicionS922
L__transicionS921:
	BSF         R1, 0 
L__transicionS922:
;rutinasensores_v4(mstr-slv).h,572 :: 		){
	BTFSS       R1, 0 
	GOTO        L_transicionS204
;rutinasensores_v4(mstr-slv).h,574 :: 		return debugEstado = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstado+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionS
;rutinasensores_v4(mstr-slv).h,575 :: 		}
L_transicionS204:
;rutinasensores_v4(mstr-slv).h,577 :: 		(SENSOR1&SENSOR3) | (SENSOR3&SENSOR5) | (SENSOR1& SENSOR5)
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionS923
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionS923
	BSF         R1, 0 
	GOTO        L__transicionS924
L__transicionS923:
	BCF         R1, 0 
L__transicionS924:
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionS925
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionS925
	BSF         4056, 0 
	GOTO        L__transicionS926
L__transicionS925:
	BCF         4056, 0 
L__transicionS926:
	BTFSC       R1, 0 
	GOTO        L__transicionS927
	BTFSC       4056, 0 
	GOTO        L__transicionS927
	BCF         R1, 0 
	GOTO        L__transicionS928
L__transicionS927:
	BSF         R1, 0 
L__transicionS928:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionS929
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionS929
	BSF         4056, 0 
	GOTO        L__transicionS930
L__transicionS929:
	BCF         4056, 0 
L__transicionS930:
	BTFSC       R1, 0 
	GOTO        L__transicionS931
	BTFSC       4056, 0 
	GOTO        L__transicionS931
	BCF         R1, 0 
	GOTO        L__transicionS932
L__transicionS931:
	BSF         R1, 0 
L__transicionS932:
;rutinasensores_v4(mstr-slv).h,578 :: 		){
	BTFSS       R1, 0 
	GOTO        L_transicionS205
;rutinasensores_v4(mstr-slv).h,580 :: 		return debugEstado = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstado+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionS
;rutinasensores_v4(mstr-slv).h,581 :: 		}
L_transicionS205:
;rutinasensores_v4(mstr-slv).h,582 :: 		}
L_transicionS203:
;rutinasensores_v4(mstr-slv).h,583 :: 		}
L_end_transicionS:
	RETURN      0
; end of _transicionS

_transicionSal:

;rutinasensores_v4(mstr-slv).h,585 :: 		short transicionSal(short estado){
;rutinasensores_v4(mstr-slv).h,586 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSal_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSal206
;rutinasensores_v4(mstr-slv).h,587 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_14_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_14_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_14_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,588 :: 		comienzaContarAtasco = true;
	MOVLW       1
	MOVWF       _comienzaContarAtasco+0 
;rutinasensores_v4(mstr-slv).h,589 :: 		if( (!SENSOR2&!SENSOR4) | (!SENSOR4&!SENSOR6) | (!SENSOR2& !SENSOR6)
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSal934
	BSF         R1, 3 
	GOTO        L__transicionSal935
L__transicionSal934:
	BCF         R1, 3 
L__transicionSal935:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSal936
	BSF         R1, 0 
	GOTO        L__transicionSal937
L__transicionSal936:
	BCF         R1, 0 
L__transicionSal937:
	BTFSS       R1, 3 
	GOTO        L__transicionSal938
	BTFSS       R1, 0 
	GOTO        L__transicionSal938
	BSF         R1, 1 
	GOTO        L__transicionSal939
L__transicionSal938:
	BCF         R1, 1 
L__transicionSal939:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSal940
	BSF         R1, 2 
	GOTO        L__transicionSal941
L__transicionSal940:
	BCF         R1, 2 
L__transicionSal941:
	BTFSS       R1, 0 
	GOTO        L__transicionSal942
	BTFSS       R1, 2 
	GOTO        L__transicionSal942
	BSF         4056, 0 
	GOTO        L__transicionSal943
L__transicionSal942:
	BCF         4056, 0 
L__transicionSal943:
	BTFSC       R1, 1 
	GOTO        L__transicionSal944
	BTFSC       4056, 0 
	GOTO        L__transicionSal944
	BCF         R1, 1 
	GOTO        L__transicionSal945
L__transicionSal944:
	BSF         R1, 1 
L__transicionSal945:
	BTFSC       R1, 3 
	GOTO        L__transicionSal946
	BCF         R1, 0 
	GOTO        L__transicionSal947
L__transicionSal946:
	BSF         R1, 0 
L__transicionSal947:
	BTFSC       R1, 2 
	GOTO        L__transicionSal948
	BCF         4056, 0 
	GOTO        L__transicionSal949
L__transicionSal948:
	BSF         4056, 0 
L__transicionSal949:
	BTFSS       R1, 0 
	GOTO        L__transicionSal950
	BTFSS       4056, 0 
	GOTO        L__transicionSal950
	BSF         R1, 0 
	GOTO        L__transicionSal951
L__transicionSal950:
	BCF         R1, 0 
L__transicionSal951:
	BTFSC       R1, 1 
	GOTO        L__transicionSal952
	BTFSC       R1, 0 
	GOTO        L__transicionSal952
	BCF         4056, 0 
	GOTO        L__transicionSal953
L__transicionSal952:
	BSF         4056, 0 
L__transicionSal953:
;rutinasensores_v4(mstr-slv).h,591 :: 		){
	BTFSS       4056, 0 
	GOTO        L_transicionSal207
;rutinasensores_v4(mstr-slv).h,592 :: 		return debugEstado =TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstado+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSal
;rutinasensores_v4(mstr-slv).h,593 :: 		}
L_transicionSal207:
;rutinasensores_v4(mstr-slv).h,594 :: 		if(SENSOR1 & SENSOR3 & SENSOR5 ){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSal954
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSal954
	BSF         4056, 0 
	GOTO        L__transicionSal955
L__transicionSal954:
	BCF         4056, 0 
L__transicionSal955:
	BTFSS       4056, 0 
	GOTO        L__transicionSal956
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSal956
	BSF         R1, 0 
	GOTO        L__transicionSal957
L__transicionSal956:
	BCF         R1, 0 
L__transicionSal957:
	BTFSS       R1, 0 
	GOTO        L_transicionSal208
;rutinasensores_v4(mstr-slv).h,596 :: 		return debugEstado = SALIO;
	MOVLW       6
	MOVWF       _debugEstado+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSal
;rutinasensores_v4(mstr-slv).h,597 :: 		}
L_transicionSal208:
;rutinasensores_v4(mstr-slv).h,598 :: 		}
L_transicionSal206:
;rutinasensores_v4(mstr-slv).h,599 :: 		}
L_end_transicionSal:
	RETURN      0
; end of _transicionSal

_salio:

;rutinasensores_v4(mstr-slv).h,601 :: 		short salio(short estado){
;rutinasensores_v4(mstr-slv).h,602 :: 		if(estado == SALIO){
	MOVF        FARG_salio_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salio209
;rutinasensores_v4(mstr-slv).h,603 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_15_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_15_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_15_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,605 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,606 :: 		pBajan = eepromLeeNumero(0x0003, 2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,607 :: 		eepromEscribeNumero(0x0003 ,pBajan, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,608 :: 		pBajan = eepromLeeNumero(0x0003, 2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salio+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salio+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salio+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salio+7 
	MOVF        FLOC__salio+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salio+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,609 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salio+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salio+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salio+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salio+3 
	MOVF        FLOC__salio+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salio+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salio+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salio+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salio+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salio+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,610 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,611 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salio210
;rutinasensores_v4(mstr-slv).h,612 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,613 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,614 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,615 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salio+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salio+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salio+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salio+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salio+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salio+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salio+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salio+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salio+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salio+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salio+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salio+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salio+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salio+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salio+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salio+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,616 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,617 :: 		}
L_salio210:
;rutinasensores_v4(mstr-slv).h,618 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,619 :: 		permanencia = false;
	CLRF        _permanencia+0 
;rutinasensores_v4(mstr-slv).h,620 :: 		empiezaSalida = false;
	CLRF        _empiezaSalida+0 
;rutinasensores_v4(mstr-slv).h,621 :: 		return debugEstado = ESPERA;
	CLRF        _debugEstado+0 
	CLRF        R0 
	GOTO        L_end_salio
;rutinasensores_v4(mstr-slv).h,622 :: 		}
L_salio209:
;rutinasensores_v4(mstr-slv).h,623 :: 		}
L_end_salio:
	RETURN      0
; end of _salio

_esperaB:

;rutinasensores_v4(mstr-slv).h,629 :: 		short esperaB(short estado){
;rutinasensores_v4(mstr-slv).h,630 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaB_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaB211
;rutinasensores_v4(mstr-slv).h,632 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,634 :: 		if((!SENSOR3 | !SENSOR5)){
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaB960
	BSF         R1, 0 
	GOTO        L__esperaB961
L__esperaB960:
	BCF         R1, 0 
L__esperaB961:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaB962
	BSF         4056, 0 
	GOTO        L__esperaB963
L__esperaB962:
	BCF         4056, 0 
L__esperaB963:
	BTFSC       R1, 0 
	GOTO        L__esperaB964
	BTFSC       4056, 0 
	GOTO        L__esperaB964
	BCF         R1, 0 
	GOTO        L__esperaB965
L__esperaB964:
	BSF         R1, 0 
L__esperaB965:
	BTFSS       R1, 0 
	GOTO        L_esperaB212
;rutinasensores_v4(mstr-slv).h,635 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,636 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaB
;rutinasensores_v4(mstr-slv).h,637 :: 		}
L_esperaB212:
;rutinasensores_v4(mstr-slv).h,638 :: 		if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaB966
	BSF         R1, 0 
	GOTO        L__esperaB967
L__esperaB966:
	BCF         R1, 0 
L__esperaB967:
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaB968
	BSF         4056, 0 
	GOTO        L__esperaB969
L__esperaB968:
	BCF         4056, 0 
L__esperaB969:
	BTFSC       R1, 0 
	GOTO        L__esperaB970
	BTFSC       4056, 0 
	GOTO        L__esperaB970
	BCF         R1, 0 
	GOTO        L__esperaB971
L__esperaB970:
	BSF         R1, 0 
L__esperaB971:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaB972
	BSF         4056, 0 
	GOTO        L__esperaB973
L__esperaB972:
	BCF         4056, 0 
L__esperaB973:
	BTFSC       R1, 0 
	GOTO        L__esperaB974
	BTFSC       4056, 0 
	GOTO        L__esperaB974
	BCF         R1, 0 
	GOTO        L__esperaB975
L__esperaB974:
	BSF         R1, 0 
L__esperaB975:
	BTFSS       R1, 0 
	GOTO        L_esperaB213
;rutinasensores_v4(mstr-slv).h,639 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,640 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaB
;rutinasensores_v4(mstr-slv).h,641 :: 		}
L_esperaB213:
;rutinasensores_v4(mstr-slv).h,642 :: 		}
L_esperaB211:
;rutinasensores_v4(mstr-slv).h,643 :: 		}
L_end_esperaB:
	RETURN      0
; end of _esperaB

_entrandoB:

;rutinasensores_v4(mstr-slv).h,645 :: 		short entrandoB(short estado){
;rutinasensores_v4(mstr-slv).h,646 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoB_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoB214
;rutinasensores_v4(mstr-slv).h,647 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_16_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_16_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_16_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,648 :: 		if((SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoB977
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoB977
	BSF         4056, 0 
	GOTO        L__entrandoB978
L__entrandoB977:
	BCF         4056, 0 
L__entrandoB978:
	BTFSS       4056, 0 
	GOTO        L_entrandoB215
;rutinasensores_v4(mstr-slv).h,649 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,650 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoB
;rutinasensores_v4(mstr-slv).h,651 :: 		}
L_entrandoB215:
;rutinasensores_v4(mstr-slv).h,652 :: 		if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoB979
	BSF         R1, 3 
	GOTO        L__entrandoB980
L__entrandoB979:
	BCF         R1, 3 
L__entrandoB980:
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoB981
	BSF         R1, 0 
	GOTO        L__entrandoB982
L__entrandoB981:
	BCF         R1, 0 
L__entrandoB982:
	BTFSS       R1, 3 
	GOTO        L__entrandoB983
	BTFSS       R1, 0 
	GOTO        L__entrandoB983
	BSF         R1, 1 
	GOTO        L__entrandoB984
L__entrandoB983:
	BCF         R1, 1 
L__entrandoB984:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoB985
	BSF         R1, 2 
	GOTO        L__entrandoB986
L__entrandoB985:
	BCF         R1, 2 
L__entrandoB986:
	BTFSS       R1, 0 
	GOTO        L__entrandoB987
	BTFSS       R1, 2 
	GOTO        L__entrandoB987
	BSF         4056, 0 
	GOTO        L__entrandoB988
L__entrandoB987:
	BCF         4056, 0 
L__entrandoB988:
	BTFSC       R1, 1 
	GOTO        L__entrandoB989
	BTFSC       4056, 0 
	GOTO        L__entrandoB989
	BCF         R1, 1 
	GOTO        L__entrandoB990
L__entrandoB989:
	BSF         R1, 1 
L__entrandoB990:
	BTFSC       R1, 3 
	GOTO        L__entrandoB991
	BCF         R1, 0 
	GOTO        L__entrandoB992
L__entrandoB991:
	BSF         R1, 0 
L__entrandoB992:
	BTFSC       R1, 2 
	GOTO        L__entrandoB993
	BCF         4056, 0 
	GOTO        L__entrandoB994
L__entrandoB993:
	BSF         4056, 0 
L__entrandoB994:
	BTFSS       R1, 0 
	GOTO        L__entrandoB995
	BTFSS       4056, 0 
	GOTO        L__entrandoB995
	BSF         R1, 0 
	GOTO        L__entrandoB996
L__entrandoB995:
	BCF         R1, 0 
L__entrandoB996:
	BTFSC       R1, 1 
	GOTO        L__entrandoB997
	BTFSC       R1, 0 
	GOTO        L__entrandoB997
	BCF         4056, 0 
	GOTO        L__entrandoB998
L__entrandoB997:
	BSF         4056, 0 
L__entrandoB998:
	BTFSS       4056, 0 
	GOTO        L_entrandoB216
;rutinasensores_v4(mstr-slv).h,653 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,654 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoB
;rutinasensores_v4(mstr-slv).h,655 :: 		}
L_entrandoB216:
;rutinasensores_v4(mstr-slv).h,656 :: 		}
L_entrandoB214:
;rutinasensores_v4(mstr-slv).h,657 :: 		}
L_end_entrandoB:
	RETURN      0
; end of _entrandoB

_transicionEB:

;rutinasensores_v4(mstr-slv).h,659 :: 		short transicionEB(short estado){
;rutinasensores_v4(mstr-slv).h,660 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEB_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEB217
;rutinasensores_v4(mstr-slv).h,661 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_17_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_17_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_17_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,662 :: 		if((SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEB1000
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEB1000
	BSF         4056, 0 
	GOTO        L__transicionEB1001
L__transicionEB1000:
	BCF         4056, 0 
L__transicionEB1001:
	BTFSS       4056, 0 
	GOTO        L_transicionEB218
;rutinasensores_v4(mstr-slv).h,663 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,664 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEB
;rutinasensores_v4(mstr-slv).h,665 :: 		}
L_transicionEB218:
;rutinasensores_v4(mstr-slv).h,666 :: 		if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEB1002
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEB1002
	BSF         R1, 2 
	GOTO        L__transicionEB1003
L__transicionEB1002:
	BCF         R1, 2 
L__transicionEB1003:
	BTFSS       R1, 2 
	GOTO        L__transicionEB1004
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEB1004
	BSF         R1, 0 
	GOTO        L__transicionEB1005
L__transicionEB1004:
	BCF         R1, 0 
L__transicionEB1005:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEB1006
	BSF         4056, 0 
	GOTO        L__transicionEB1007
L__transicionEB1006:
	BCF         4056, 0 
L__transicionEB1007:
	BTFSS       R1, 0 
	GOTO        L__transicionEB1008
	BTFSS       4056, 0 
	GOTO        L__transicionEB1008
	BSF         R1, 1 
	GOTO        L__transicionEB1009
L__transicionEB1008:
	BCF         R1, 1 
L__transicionEB1009:
	BTFSC       R1, 2 
	GOTO        L__transicionEB1010
	BCF         4056, 0 
	GOTO        L__transicionEB1011
L__transicionEB1010:
	BSF         4056, 0 
L__transicionEB1011:
	BTFSS       4056, 0 
	GOTO        L__transicionEB1012
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEB1012
	BSF         R1, 0 
	GOTO        L__transicionEB1013
L__transicionEB1012:
	BCF         R1, 0 
L__transicionEB1013:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEB1014
	BSF         4056, 0 
	GOTO        L__transicionEB1015
L__transicionEB1014:
	BCF         4056, 0 
L__transicionEB1015:
	BTFSS       R1, 0 
	GOTO        L__transicionEB1016
	BTFSS       4056, 0 
	GOTO        L__transicionEB1016
	BSF         R1, 0 
	GOTO        L__transicionEB1017
L__transicionEB1016:
	BCF         R1, 0 
L__transicionEB1017:
	BTFSC       R1, 1 
	GOTO        L__transicionEB1018
	BTFSC       R1, 0 
	GOTO        L__transicionEB1018
	BCF         4056, 0 
	GOTO        L__transicionEB1019
L__transicionEB1018:
	BSF         4056, 0 
L__transicionEB1019:
	BTFSS       4056, 0 
	GOTO        L_transicionEB219
;rutinasensores_v4(mstr-slv).h,667 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,668 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEB
;rutinasensores_v4(mstr-slv).h,669 :: 		}
L_transicionEB219:
;rutinasensores_v4(mstr-slv).h,670 :: 		}
L_transicionEB217:
;rutinasensores_v4(mstr-slv).h,671 :: 		}
L_end_transicionEB:
	RETURN      0
; end of _transicionEB

_transicionEntB:

;rutinasensores_v4(mstr-slv).h,673 :: 		short transicionEntB(short estado){
;rutinasensores_v4(mstr-slv).h,674 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntB_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntB220
;rutinasensores_v4(mstr-slv).h,675 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_18_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_18_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_18_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,676 :: 		if((!SENSOR3 & !SENSOR5)){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntB1021
	BSF         R1, 0 
	GOTO        L__transicionEntB1022
L__transicionEntB1021:
	BCF         R1, 0 
L__transicionEntB1022:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntB1023
	BSF         4056, 0 
	GOTO        L__transicionEntB1024
L__transicionEntB1023:
	BCF         4056, 0 
L__transicionEntB1024:
	BTFSS       R1, 0 
	GOTO        L__transicionEntB1025
	BTFSS       4056, 0 
	GOTO        L__transicionEntB1025
	BSF         R1, 0 
	GOTO        L__transicionEntB1026
L__transicionEntB1025:
	BCF         R1, 0 
L__transicionEntB1026:
	BTFSS       R1, 0 
	GOTO        L_transicionEntB221
;rutinasensores_v4(mstr-slv).h,677 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,678 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntB
;rutinasensores_v4(mstr-slv).h,679 :: 		}
L_transicionEntB221:
;rutinasensores_v4(mstr-slv).h,680 :: 		if((SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntB1027
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntB1027
	BSF         4056, 0 
	GOTO        L__transicionEntB1028
L__transicionEntB1027:
	BCF         4056, 0 
L__transicionEntB1028:
	BTFSS       4056, 0 
	GOTO        L__transicionEntB1029
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntB1029
	BSF         R1, 0 
	GOTO        L__transicionEntB1030
L__transicionEntB1029:
	BCF         R1, 0 
L__transicionEntB1030:
	BTFSS       R1, 0 
	GOTO        L_transicionEntB222
;rutinasensores_v4(mstr-slv).h,681 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,682 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntB
;rutinasensores_v4(mstr-slv).h,683 :: 		}
L_transicionEntB222:
;rutinasensores_v4(mstr-slv).h,684 :: 		}
L_transicionEntB220:
;rutinasensores_v4(mstr-slv).h,685 :: 		}
L_end_transicionEntB:
	RETURN      0
; end of _transicionEntB

_entroB:

;rutinasensores_v4(mstr-slv).h,687 :: 		short entroB(short estado){
;rutinasensores_v4(mstr-slv).h,688 :: 		if(estado == ENTRO){
	MOVF        FARG_entroB_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroB223
;rutinasensores_v4(mstr-slv).h,689 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_19_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_19_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_19_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,690 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,691 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,692 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,693 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,694 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroB+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroB+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroB+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroB+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroB+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroB+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroB+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroB+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,695 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,696 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroB224
;rutinasensores_v4(mstr-slv).h,697 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,698 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,699 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,700 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroB+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroB+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroB+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroB+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroB+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroB+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroB+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroB+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroB+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroB+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroB+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroB+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroB+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroB+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroB+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroB+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,701 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,702 :: 		}
L_entroB224:
;rutinasensores_v4(mstr-slv).h,703 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,704 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroB
;rutinasensores_v4(mstr-slv).h,705 :: 		}
L_entroB223:
;rutinasensores_v4(mstr-slv).h,706 :: 		}
L_end_entroB:
	RETURN      0
; end of _entroB

_saliendoB:

;rutinasensores_v4(mstr-slv).h,708 :: 		short saliendoB(short estado){
;rutinasensores_v4(mstr-slv).h,709 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoB_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoB225
;rutinasensores_v4(mstr-slv).h,710 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_20_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_20_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_20_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,711 :: 		if((!SENSOR3 & !SENSOR5)){
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoB1033
	BSF         R1, 0 
	GOTO        L__saliendoB1034
L__saliendoB1033:
	BCF         R1, 0 
L__saliendoB1034:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoB1035
	BSF         4056, 0 
	GOTO        L__saliendoB1036
L__saliendoB1035:
	BCF         4056, 0 
L__saliendoB1036:
	BTFSS       R1, 0 
	GOTO        L__saliendoB1037
	BTFSS       4056, 0 
	GOTO        L__saliendoB1037
	BSF         R1, 0 
	GOTO        L__saliendoB1038
L__saliendoB1037:
	BCF         R1, 0 
L__saliendoB1038:
	BTFSS       R1, 0 
	GOTO        L_saliendoB226
;rutinasensores_v4(mstr-slv).h,712 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,713 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoB
;rutinasensores_v4(mstr-slv).h,714 :: 		}
L_saliendoB226:
;rutinasensores_v4(mstr-slv).h,715 :: 		if((SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoB1039
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoB1039
	BSF         4056, 0 
	GOTO        L__saliendoB1040
L__saliendoB1039:
	BCF         4056, 0 
L__saliendoB1040:
	BTFSS       4056, 0 
	GOTO        L__saliendoB1041
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoB1041
	BSF         R1, 0 
	GOTO        L__saliendoB1042
L__saliendoB1041:
	BCF         R1, 0 
L__saliendoB1042:
	BTFSS       R1, 0 
	GOTO        L_saliendoB227
;rutinasensores_v4(mstr-slv).h,716 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,717 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoB
;rutinasensores_v4(mstr-slv).h,718 :: 		}
L_saliendoB227:
;rutinasensores_v4(mstr-slv).h,719 :: 		}
L_saliendoB225:
;rutinasensores_v4(mstr-slv).h,720 :: 		}
L_end_saliendoB:
	RETURN      0
; end of _saliendoB

_transicionSB:

;rutinasensores_v4(mstr-slv).h,722 :: 		short transicionSB(short estado){
;rutinasensores_v4(mstr-slv).h,723 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSB_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSB228
;rutinasensores_v4(mstr-slv).h,724 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_21_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_21_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_21_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,725 :: 		if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSB1044
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSB1044
	BSF         R1, 0 
	GOTO        L__transicionSB1045
L__transicionSB1044:
	BCF         R1, 0 
L__transicionSB1045:
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSB1046
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSB1046
	BSF         4056, 0 
	GOTO        L__transicionSB1047
L__transicionSB1046:
	BCF         4056, 0 
L__transicionSB1047:
	BTFSC       R1, 0 
	GOTO        L__transicionSB1048
	BTFSC       4056, 0 
	GOTO        L__transicionSB1048
	BCF         R1, 0 
	GOTO        L__transicionSB1049
L__transicionSB1048:
	BSF         R1, 0 
L__transicionSB1049:
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSB1050
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSB1050
	BSF         4056, 0 
	GOTO        L__transicionSB1051
L__transicionSB1050:
	BCF         4056, 0 
L__transicionSB1051:
	BTFSC       R1, 0 
	GOTO        L__transicionSB1052
	BTFSC       4056, 0 
	GOTO        L__transicionSB1052
	BCF         R1, 0 
	GOTO        L__transicionSB1053
L__transicionSB1052:
	BSF         R1, 0 
L__transicionSB1053:
	BTFSS       R1, 0 
	GOTO        L_transicionSB229
;rutinasensores_v4(mstr-slv).h,726 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,727 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSB
;rutinasensores_v4(mstr-slv).h,728 :: 		}
L_transicionSB229:
;rutinasensores_v4(mstr-slv).h,729 :: 		if((SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR3 & SENSOR5 & !SENSOR6)){
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSB1054
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSB1054
	BSF         R1, 2 
	GOTO        L__transicionSB1055
L__transicionSB1054:
	BCF         R1, 2 
L__transicionSB1055:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSB1056
	BSF         4056, 0 
	GOTO        L__transicionSB1057
L__transicionSB1056:
	BCF         4056, 0 
L__transicionSB1057:
	BTFSS       R1, 2 
	GOTO        L__transicionSB1058
	BTFSS       4056, 0 
	GOTO        L__transicionSB1058
	BSF         R1, 1 
	GOTO        L__transicionSB1059
L__transicionSB1058:
	BCF         R1, 1 
L__transicionSB1059:
	BTFSC       R1, 2 
	GOTO        L__transicionSB1060
	BCF         R1, 0 
	GOTO        L__transicionSB1061
L__transicionSB1060:
	BSF         R1, 0 
L__transicionSB1061:
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSB1062
	BSF         4056, 0 
	GOTO        L__transicionSB1063
L__transicionSB1062:
	BCF         4056, 0 
L__transicionSB1063:
	BTFSS       R1, 0 
	GOTO        L__transicionSB1064
	BTFSS       4056, 0 
	GOTO        L__transicionSB1064
	BSF         R1, 0 
	GOTO        L__transicionSB1065
L__transicionSB1064:
	BCF         R1, 0 
L__transicionSB1065:
	BTFSC       R1, 1 
	GOTO        L__transicionSB1066
	BTFSC       R1, 0 
	GOTO        L__transicionSB1066
	BCF         R1, 1 
	GOTO        L__transicionSB1067
L__transicionSB1066:
	BSF         R1, 1 
L__transicionSB1067:
	BTFSC       R1, 2 
	GOTO        L__transicionSB1068
	BCF         R1, 0 
	GOTO        L__transicionSB1069
L__transicionSB1068:
	BSF         R1, 0 
L__transicionSB1069:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSB1070
	BSF         4056, 0 
	GOTO        L__transicionSB1071
L__transicionSB1070:
	BCF         4056, 0 
L__transicionSB1071:
	BTFSS       R1, 0 
	GOTO        L__transicionSB1072
	BTFSS       4056, 0 
	GOTO        L__transicionSB1072
	BSF         R1, 0 
	GOTO        L__transicionSB1073
L__transicionSB1072:
	BCF         R1, 0 
L__transicionSB1073:
	BTFSC       R1, 1 
	GOTO        L__transicionSB1074
	BTFSC       R1, 0 
	GOTO        L__transicionSB1074
	BCF         4056, 0 
	GOTO        L__transicionSB1075
L__transicionSB1074:
	BSF         4056, 0 
L__transicionSB1075:
	BTFSS       4056, 0 
	GOTO        L_transicionSB230
;rutinasensores_v4(mstr-slv).h,730 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,731 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSB
;rutinasensores_v4(mstr-slv).h,732 :: 		}
L_transicionSB230:
;rutinasensores_v4(mstr-slv).h,733 :: 		}
L_transicionSB228:
;rutinasensores_v4(mstr-slv).h,734 :: 		}
L_end_transicionSB:
	RETURN      0
; end of _transicionSB

_transicionSalB:

;rutinasensores_v4(mstr-slv).h,736 :: 		short transicionSalB(short estado){
;rutinasensores_v4(mstr-slv).h,737 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalB_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalB231
;rutinasensores_v4(mstr-slv).h,738 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_22_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_22_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_22_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,739 :: 		if(!SENSOR2 & !SENSOR4 & !SENSOR6){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalB1077
	BSF         R1, 0 
	GOTO        L__transicionSalB1078
L__transicionSalB1077:
	BCF         R1, 0 
L__transicionSalB1078:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalB1079
	BSF         4056, 0 
	GOTO        L__transicionSalB1080
L__transicionSalB1079:
	BCF         4056, 0 
L__transicionSalB1080:
	BTFSS       R1, 0 
	GOTO        L__transicionSalB1081
	BTFSS       4056, 0 
	GOTO        L__transicionSalB1081
	BSF         R1, 0 
	GOTO        L__transicionSalB1082
L__transicionSalB1081:
	BCF         R1, 0 
L__transicionSalB1082:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalB1083
	BSF         4056, 0 
	GOTO        L__transicionSalB1084
L__transicionSalB1083:
	BCF         4056, 0 
L__transicionSalB1084:
	BTFSS       R1, 0 
	GOTO        L__transicionSalB1085
	BTFSS       4056, 0 
	GOTO        L__transicionSalB1085
	BSF         R1, 0 
	GOTO        L__transicionSalB1086
L__transicionSalB1085:
	BCF         R1, 0 
L__transicionSalB1086:
	BTFSS       R1, 0 
	GOTO        L_transicionSalB232
;rutinasensores_v4(mstr-slv).h,740 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,741 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalB
;rutinasensores_v4(mstr-slv).h,742 :: 		}
L_transicionSalB232:
;rutinasensores_v4(mstr-slv).h,743 :: 		if((SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalB1087
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalB1087
	BSF         4056, 0 
	GOTO        L__transicionSalB1088
L__transicionSalB1087:
	BCF         4056, 0 
L__transicionSalB1088:
	BTFSS       4056, 0 
	GOTO        L_transicionSalB233
;rutinasensores_v4(mstr-slv).h,744 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,745 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalB
;rutinasensores_v4(mstr-slv).h,746 :: 		}
L_transicionSalB233:
;rutinasensores_v4(mstr-slv).h,747 :: 		}
L_transicionSalB231:
;rutinasensores_v4(mstr-slv).h,748 :: 		}
L_end_transicionSalB:
	RETURN      0
; end of _transicionSalB

_salioB:

;rutinasensores_v4(mstr-slv).h,750 :: 		short salioB(short estado){
;rutinasensores_v4(mstr-slv).h,751 :: 		if(estado == SALIO){
	MOVF        FARG_salioB_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioB234
;rutinasensores_v4(mstr-slv).h,752 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_23_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_23_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_23_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,753 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,754 :: 		pBajan = eepromLeeNumero(0x0003, 2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,755 :: 		eepromEscribeNumero(0x0003 ,pBajan, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,756 :: 		pBajan = eepromLeeNumero(0x0003, 2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioB+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioB+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioB+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioB+7 
	MOVF        FLOC__salioB+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioB+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,757 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioB+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioB+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioB+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioB+3 
	MOVF        FLOC__salioB+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioB+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioB+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioB+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioB+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioB+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,758 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,759 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioB235
;rutinasensores_v4(mstr-slv).h,760 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,761 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,762 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,763 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioB+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioB+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioB+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioB+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioB+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioB+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioB+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioB+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioB+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioB+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioB+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioB+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioB+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioB+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioB+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioB+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,764 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,765 :: 		}
L_salioB235:
;rutinasensores_v4(mstr-slv).h,766 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,767 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioB
;rutinasensores_v4(mstr-slv).h,768 :: 		}
L_salioB234:
;rutinasensores_v4(mstr-slv).h,769 :: 		}
L_end_salioB:
	RETURN      0
; end of _salioB

_esperaBD:

;rutinasensores_v4(mstr-slv).h,775 :: 		short esperaBD(short estado){
;rutinasensores_v4(mstr-slv).h,776 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBD_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBD236
;rutinasensores_v4(mstr-slv).h,777 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,778 :: 		if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBD1091
	BSF         R1, 0 
	GOTO        L__esperaBD1092
L__esperaBD1091:
	BCF         R1, 0 
L__esperaBD1092:
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaBD1093
	BSF         4056, 0 
	GOTO        L__esperaBD1094
L__esperaBD1093:
	BCF         4056, 0 
L__esperaBD1094:
	BTFSC       R1, 0 
	GOTO        L__esperaBD1095
	BTFSC       4056, 0 
	GOTO        L__esperaBD1095
	BCF         R1, 0 
	GOTO        L__esperaBD1096
L__esperaBD1095:
	BSF         R1, 0 
L__esperaBD1096:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaBD1097
	BSF         4056, 0 
	GOTO        L__esperaBD1098
L__esperaBD1097:
	BCF         4056, 0 
L__esperaBD1098:
	BTFSC       R1, 0 
	GOTO        L__esperaBD1099
	BTFSC       4056, 0 
	GOTO        L__esperaBD1099
	BCF         R1, 0 
	GOTO        L__esperaBD1100
L__esperaBD1099:
	BSF         R1, 0 
L__esperaBD1100:
	BTFSS       R1, 0 
	GOTO        L_esperaBD237
;rutinasensores_v4(mstr-slv).h,779 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,780 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBD
;rutinasensores_v4(mstr-slv).h,781 :: 		}
L_esperaBD237:
;rutinasensores_v4(mstr-slv).h,782 :: 		if((!SENSOR4 | !SENSOR6)){
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaBD1101
	BSF         R1, 0 
	GOTO        L__esperaBD1102
L__esperaBD1101:
	BCF         R1, 0 
L__esperaBD1102:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaBD1103
	BSF         4056, 0 
	GOTO        L__esperaBD1104
L__esperaBD1103:
	BCF         4056, 0 
L__esperaBD1104:
	BTFSC       R1, 0 
	GOTO        L__esperaBD1105
	BTFSC       4056, 0 
	GOTO        L__esperaBD1105
	BCF         R1, 0 
	GOTO        L__esperaBD1106
L__esperaBD1105:
	BSF         R1, 0 
L__esperaBD1106:
	BTFSS       R1, 0 
	GOTO        L_esperaBD238
;rutinasensores_v4(mstr-slv).h,783 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,784 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBD
;rutinasensores_v4(mstr-slv).h,785 :: 		}
L_esperaBD238:
;rutinasensores_v4(mstr-slv).h,786 :: 		}
L_esperaBD236:
;rutinasensores_v4(mstr-slv).h,787 :: 		}
L_end_esperaBD:
	RETURN      0
; end of _esperaBD

_entrandoBD:

;rutinasensores_v4(mstr-slv).h,789 :: 		short entrandoBD(short estado){
;rutinasensores_v4(mstr-slv).h,790 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBD_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBD239
;rutinasensores_v4(mstr-slv).h,791 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_24_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_24_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_24_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,792 :: 		if((SENSOR1 & SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBD1108
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoBD1108
	BSF         4056, 0 
	GOTO        L__entrandoBD1109
L__entrandoBD1108:
	BCF         4056, 0 
L__entrandoBD1109:
	BTFSS       4056, 0 
	GOTO        L__entrandoBD1110
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoBD1110
	BSF         R1, 0 
	GOTO        L__entrandoBD1111
L__entrandoBD1110:
	BCF         R1, 0 
L__entrandoBD1111:
	BTFSS       R1, 0 
	GOTO        L_entrandoBD240
;rutinasensores_v4(mstr-slv).h,793 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,794 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBD
;rutinasensores_v4(mstr-slv).h,795 :: 		}
L_entrandoBD240:
;rutinasensores_v4(mstr-slv).h,796 :: 		if((!SENSOR4 & !SENSOR6)){
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoBD1112
	BSF         R1, 0 
	GOTO        L__entrandoBD1113
L__entrandoBD1112:
	BCF         R1, 0 
L__entrandoBD1113:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoBD1114
	BSF         4056, 0 
	GOTO        L__entrandoBD1115
L__entrandoBD1114:
	BCF         4056, 0 
L__entrandoBD1115:
	BTFSS       R1, 0 
	GOTO        L__entrandoBD1116
	BTFSS       4056, 0 
	GOTO        L__entrandoBD1116
	BSF         R1, 0 
	GOTO        L__entrandoBD1117
L__entrandoBD1116:
	BCF         R1, 0 
L__entrandoBD1117:
	BTFSS       R1, 0 
	GOTO        L_entrandoBD241
;rutinasensores_v4(mstr-slv).h,797 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,798 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBD
;rutinasensores_v4(mstr-slv).h,799 :: 		}
L_entrandoBD241:
;rutinasensores_v4(mstr-slv).h,800 :: 		}
L_entrandoBD239:
;rutinasensores_v4(mstr-slv).h,801 :: 		}
L_end_entrandoBD:
	RETURN      0
; end of _entrandoBD

_transicionEBD:

;rutinasensores_v4(mstr-slv).h,803 :: 		short transicionEBD(short estado){
;rutinasensores_v4(mstr-slv).h,804 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBD_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBD242
;rutinasensores_v4(mstr-slv).h,805 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_25_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_25_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_25_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,806 :: 		if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBD1119
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBD1119
	BSF         R1, 0 
	GOTO        L__transicionEBD1120
L__transicionEBD1119:
	BCF         R1, 0 
L__transicionEBD1120:
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBD1121
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBD1121
	BSF         4056, 0 
	GOTO        L__transicionEBD1122
L__transicionEBD1121:
	BCF         4056, 0 
L__transicionEBD1122:
	BTFSC       R1, 0 
	GOTO        L__transicionEBD1123
	BTFSC       4056, 0 
	GOTO        L__transicionEBD1123
	BCF         R1, 0 
	GOTO        L__transicionEBD1124
L__transicionEBD1123:
	BSF         R1, 0 
L__transicionEBD1124:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBD1125
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBD1125
	BSF         4056, 0 
	GOTO        L__transicionEBD1126
L__transicionEBD1125:
	BCF         4056, 0 
L__transicionEBD1126:
	BTFSC       R1, 0 
	GOTO        L__transicionEBD1127
	BTFSC       4056, 0 
	GOTO        L__transicionEBD1127
	BCF         R1, 0 
	GOTO        L__transicionEBD1128
L__transicionEBD1127:
	BSF         R1, 0 
L__transicionEBD1128:
	BTFSS       R1, 0 
	GOTO        L_transicionEBD243
;rutinasensores_v4(mstr-slv).h,807 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,808 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBD
;rutinasensores_v4(mstr-slv).h,809 :: 		}
L_transicionEBD243:
;rutinasensores_v4(mstr-slv).h,810 :: 		if((SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR4 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEBD1129
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBD1129
	BSF         R1, 2 
	GOTO        L__transicionEBD1130
L__transicionEBD1129:
	BCF         R1, 2 
L__transicionEBD1130:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBD1131
	BSF         4056, 0 
	GOTO        L__transicionEBD1132
L__transicionEBD1131:
	BCF         4056, 0 
L__transicionEBD1132:
	BTFSS       R1, 2 
	GOTO        L__transicionEBD1133
	BTFSS       4056, 0 
	GOTO        L__transicionEBD1133
	BSF         R1, 1 
	GOTO        L__transicionEBD1134
L__transicionEBD1133:
	BCF         R1, 1 
L__transicionEBD1134:
	BTFSC       R1, 2 
	GOTO        L__transicionEBD1135
	BCF         R1, 0 
	GOTO        L__transicionEBD1136
L__transicionEBD1135:
	BSF         R1, 0 
L__transicionEBD1136:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBD1137
	BSF         4056, 0 
	GOTO        L__transicionEBD1138
L__transicionEBD1137:
	BCF         4056, 0 
L__transicionEBD1138:
	BTFSS       R1, 0 
	GOTO        L__transicionEBD1139
	BTFSS       4056, 0 
	GOTO        L__transicionEBD1139
	BSF         R1, 0 
	GOTO        L__transicionEBD1140
L__transicionEBD1139:
	BCF         R1, 0 
L__transicionEBD1140:
	BTFSC       R1, 1 
	GOTO        L__transicionEBD1141
	BTFSC       R1, 0 
	GOTO        L__transicionEBD1141
	BCF         R1, 1 
	GOTO        L__transicionEBD1142
L__transicionEBD1141:
	BSF         R1, 1 
L__transicionEBD1142:
	BTFSC       R1, 2 
	GOTO        L__transicionEBD1143
	BCF         R1, 0 
	GOTO        L__transicionEBD1144
L__transicionEBD1143:
	BSF         R1, 0 
L__transicionEBD1144:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBD1145
	BSF         4056, 0 
	GOTO        L__transicionEBD1146
L__transicionEBD1145:
	BCF         4056, 0 
L__transicionEBD1146:
	BTFSS       R1, 0 
	GOTO        L__transicionEBD1147
	BTFSS       4056, 0 
	GOTO        L__transicionEBD1147
	BSF         R1, 0 
	GOTO        L__transicionEBD1148
L__transicionEBD1147:
	BCF         R1, 0 
L__transicionEBD1148:
	BTFSC       R1, 1 
	GOTO        L__transicionEBD1149
	BTFSC       R1, 0 
	GOTO        L__transicionEBD1149
	BCF         4056, 0 
	GOTO        L__transicionEBD1150
L__transicionEBD1149:
	BSF         4056, 0 
L__transicionEBD1150:
	BTFSS       4056, 0 
	GOTO        L_transicionEBD244
;rutinasensores_v4(mstr-slv).h,811 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,812 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBD
;rutinasensores_v4(mstr-slv).h,813 :: 		}
L_transicionEBD244:
;rutinasensores_v4(mstr-slv).h,814 :: 		}
L_transicionEBD242:
;rutinasensores_v4(mstr-slv).h,815 :: 		}
L_end_transicionEBD:
	RETURN      0
; end of _transicionEBD

_transicionEntBD:

;rutinasensores_v4(mstr-slv).h,817 :: 		short transicionEntBD(short estado){
;rutinasensores_v4(mstr-slv).h,818 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBD_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBD245
;rutinasensores_v4(mstr-slv).h,819 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_26_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_26_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_26_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,820 :: 		if((!SENSOR3 & !SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntBD1152
	BSF         R1, 0 
	GOTO        L__transicionEntBD1153
L__transicionEntBD1152:
	BCF         R1, 0 
L__transicionEntBD1153:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBD1154
	BSF         4056, 0 
	GOTO        L__transicionEntBD1155
L__transicionEntBD1154:
	BCF         4056, 0 
L__transicionEntBD1155:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBD1156
	BTFSS       4056, 0 
	GOTO        L__transicionEntBD1156
	BSF         R1, 0 
	GOTO        L__transicionEntBD1157
L__transicionEntBD1156:
	BCF         R1, 0 
L__transicionEntBD1157:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntBD1158
	BSF         4056, 0 
	GOTO        L__transicionEntBD1159
L__transicionEntBD1158:
	BCF         4056, 0 
L__transicionEntBD1159:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBD1160
	BTFSS       4056, 0 
	GOTO        L__transicionEntBD1160
	BSF         R1, 0 
	GOTO        L__transicionEntBD1161
L__transicionEntBD1160:
	BCF         R1, 0 
L__transicionEntBD1161:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBD246
;rutinasensores_v4(mstr-slv).h,821 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,822 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBD
;rutinasensores_v4(mstr-slv).h,823 :: 		}
L_transicionEntBD246:
;rutinasensores_v4(mstr-slv).h,824 :: 		if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR4 & SENSOR6)){
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntBD1162
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBD1162
	BSF         4056, 0 
	GOTO        L__transicionEntBD1163
L__transicionEntBD1162:
	BCF         4056, 0 
L__transicionEntBD1163:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBD247
;rutinasensores_v4(mstr-slv).h,825 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,826 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBD
;rutinasensores_v4(mstr-slv).h,827 :: 		}
L_transicionEntBD247:
;rutinasensores_v4(mstr-slv).h,828 :: 		}
L_transicionEntBD245:
;rutinasensores_v4(mstr-slv).h,829 :: 		}
L_end_transicionEntBD:
	RETURN      0
; end of _transicionEntBD

_entroBD:

;rutinasensores_v4(mstr-slv).h,831 :: 		short entroBD(short estado){
;rutinasensores_v4(mstr-slv).h,832 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBD_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBD248
;rutinasensores_v4(mstr-slv).h,833 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_27_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_27_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_27_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,834 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,835 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,836 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,837 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,838 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBD+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBD+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBD+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBD+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBD+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBD+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBD+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBD+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,839 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,840 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBD249
;rutinasensores_v4(mstr-slv).h,841 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,842 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,843 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,844 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBD+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBD+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBD+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBD+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBD+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBD+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBD+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBD+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBD+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBD+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBD+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBD+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBD+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBD+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBD+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBD+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,845 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,846 :: 		}
L_entroBD249:
;rutinasensores_v4(mstr-slv).h,847 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,848 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBD
;rutinasensores_v4(mstr-slv).h,849 :: 		}
L_entroBD248:
;rutinasensores_v4(mstr-slv).h,850 :: 		}
L_end_entroBD:
	RETURN      0
; end of _entroBD

_saliendoBD:

;rutinasensores_v4(mstr-slv).h,852 :: 		short saliendoBD(short estado){
;rutinasensores_v4(mstr-slv).h,853 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBD_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBD250
;rutinasensores_v4(mstr-slv).h,854 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_28_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_28_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_28_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,855 :: 		if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBD1166
	BSF         R1, 3 
	GOTO        L__saliendoBD1167
L__saliendoBD1166:
	BCF         R1, 3 
L__saliendoBD1167:
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoBD1168
	BSF         R1, 0 
	GOTO        L__saliendoBD1169
L__saliendoBD1168:
	BCF         R1, 0 
L__saliendoBD1169:
	BTFSS       R1, 3 
	GOTO        L__saliendoBD1170
	BTFSS       R1, 0 
	GOTO        L__saliendoBD1170
	BSF         R1, 1 
	GOTO        L__saliendoBD1171
L__saliendoBD1170:
	BCF         R1, 1 
L__saliendoBD1171:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoBD1172
	BSF         R1, 2 
	GOTO        L__saliendoBD1173
L__saliendoBD1172:
	BCF         R1, 2 
L__saliendoBD1173:
	BTFSS       R1, 0 
	GOTO        L__saliendoBD1174
	BTFSS       R1, 2 
	GOTO        L__saliendoBD1174
	BSF         4056, 0 
	GOTO        L__saliendoBD1175
L__saliendoBD1174:
	BCF         4056, 0 
L__saliendoBD1175:
	BTFSC       R1, 1 
	GOTO        L__saliendoBD1176
	BTFSC       4056, 0 
	GOTO        L__saliendoBD1176
	BCF         R1, 1 
	GOTO        L__saliendoBD1177
L__saliendoBD1176:
	BSF         R1, 1 
L__saliendoBD1177:
	BTFSC       R1, 3 
	GOTO        L__saliendoBD1178
	BCF         R1, 0 
	GOTO        L__saliendoBD1179
L__saliendoBD1178:
	BSF         R1, 0 
L__saliendoBD1179:
	BTFSC       R1, 2 
	GOTO        L__saliendoBD1180
	BCF         4056, 0 
	GOTO        L__saliendoBD1181
L__saliendoBD1180:
	BSF         4056, 0 
L__saliendoBD1181:
	BTFSS       R1, 0 
	GOTO        L__saliendoBD1182
	BTFSS       4056, 0 
	GOTO        L__saliendoBD1182
	BSF         R1, 0 
	GOTO        L__saliendoBD1183
L__saliendoBD1182:
	BCF         R1, 0 
L__saliendoBD1183:
	BTFSC       R1, 1 
	GOTO        L__saliendoBD1184
	BTFSC       R1, 0 
	GOTO        L__saliendoBD1184
	BCF         4056, 0 
	GOTO        L__saliendoBD1185
L__saliendoBD1184:
	BSF         4056, 0 
L__saliendoBD1185:
	BTFSS       4056, 0 
	GOTO        L_saliendoBD251
;rutinasensores_v4(mstr-slv).h,856 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,857 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBD
;rutinasensores_v4(mstr-slv).h,858 :: 		}
L_saliendoBD251:
;rutinasensores_v4(mstr-slv).h,859 :: 		if((SENSOR4 & SENSOR6)){
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoBD1186
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoBD1186
	BSF         4056, 0 
	GOTO        L__saliendoBD1187
L__saliendoBD1186:
	BCF         4056, 0 
L__saliendoBD1187:
	BTFSS       4056, 0 
	GOTO        L_saliendoBD252
;rutinasensores_v4(mstr-slv).h,860 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,861 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBD
;rutinasensores_v4(mstr-slv).h,862 :: 		}
L_saliendoBD252:
;rutinasensores_v4(mstr-slv).h,863 :: 		}
L_saliendoBD250:
;rutinasensores_v4(mstr-slv).h,864 :: 		}
L_end_saliendoBD:
	RETURN      0
; end of _saliendoBD

_transicionSBD:

;rutinasensores_v4(mstr-slv).h,866 :: 		short transicionSBD(short estado){
;rutinasensores_v4(mstr-slv).h,867 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBD_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBD253
;rutinasensores_v4(mstr-slv).h,868 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_29_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_29_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_29_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,869 :: 		if((SENSOR4 & SENSOR6)){
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBD1189
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBD1189
	BSF         4056, 0 
	GOTO        L__transicionSBD1190
L__transicionSBD1189:
	BCF         4056, 0 
L__transicionSBD1190:
	BTFSS       4056, 0 
	GOTO        L_transicionSBD254
;rutinasensores_v4(mstr-slv).h,870 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,871 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBD
;rutinasensores_v4(mstr-slv).h,872 :: 		}
L_transicionSBD254:
;rutinasensores_v4(mstr-slv).h,873 :: 		if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBD1191
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSBD1191
	BSF         R1, 2 
	GOTO        L__transicionSBD1192
L__transicionSBD1191:
	BCF         R1, 2 
L__transicionSBD1192:
	BTFSS       R1, 2 
	GOTO        L__transicionSBD1193
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBD1193
	BSF         R1, 0 
	GOTO        L__transicionSBD1194
L__transicionSBD1193:
	BCF         R1, 0 
L__transicionSBD1194:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBD1195
	BSF         4056, 0 
	GOTO        L__transicionSBD1196
L__transicionSBD1195:
	BCF         4056, 0 
L__transicionSBD1196:
	BTFSS       R1, 0 
	GOTO        L__transicionSBD1197
	BTFSS       4056, 0 
	GOTO        L__transicionSBD1197
	BSF         R1, 1 
	GOTO        L__transicionSBD1198
L__transicionSBD1197:
	BCF         R1, 1 
L__transicionSBD1198:
	BTFSC       R1, 2 
	GOTO        L__transicionSBD1199
	BCF         4056, 0 
	GOTO        L__transicionSBD1200
L__transicionSBD1199:
	BSF         4056, 0 
L__transicionSBD1200:
	BTFSS       4056, 0 
	GOTO        L__transicionSBD1201
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBD1201
	BSF         R1, 0 
	GOTO        L__transicionSBD1202
L__transicionSBD1201:
	BCF         R1, 0 
L__transicionSBD1202:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBD1203
	BSF         4056, 0 
	GOTO        L__transicionSBD1204
L__transicionSBD1203:
	BCF         4056, 0 
L__transicionSBD1204:
	BTFSS       R1, 0 
	GOTO        L__transicionSBD1205
	BTFSS       4056, 0 
	GOTO        L__transicionSBD1205
	BSF         R1, 0 
	GOTO        L__transicionSBD1206
L__transicionSBD1205:
	BCF         R1, 0 
L__transicionSBD1206:
	BTFSC       R1, 1 
	GOTO        L__transicionSBD1207
	BTFSC       R1, 0 
	GOTO        L__transicionSBD1207
	BCF         4056, 0 
	GOTO        L__transicionSBD1208
L__transicionSBD1207:
	BSF         4056, 0 
L__transicionSBD1208:
	BTFSS       4056, 0 
	GOTO        L_transicionSBD255
;rutinasensores_v4(mstr-slv).h,874 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,875 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBD
;rutinasensores_v4(mstr-slv).h,876 :: 		}
L_transicionSBD255:
;rutinasensores_v4(mstr-slv).h,877 :: 		}
L_transicionSBD253:
;rutinasensores_v4(mstr-slv).h,878 :: 		}
L_end_transicionSBD:
	RETURN      0
; end of _transicionSBD

_transicionSalBD:

;rutinasensores_v4(mstr-slv).h,880 :: 		short transicionSalBD(short estado){
;rutinasensores_v4(mstr-slv).h,881 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBD_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBD256
;rutinasensores_v4(mstr-slv).h,882 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_30_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_30_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_30_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,883 :: 		if(!SENSOR4 & !SENSOR6){
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBD1210
	BSF         R1, 0 
	GOTO        L__transicionSalBD1211
L__transicionSalBD1210:
	BCF         R1, 0 
L__transicionSalBD1211:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBD1212
	BSF         4056, 0 
	GOTO        L__transicionSalBD1213
L__transicionSalBD1212:
	BCF         4056, 0 
L__transicionSalBD1213:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBD1214
	BTFSS       4056, 0 
	GOTO        L__transicionSalBD1214
	BSF         R1, 0 
	GOTO        L__transicionSalBD1215
L__transicionSalBD1214:
	BCF         R1, 0 
L__transicionSalBD1215:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBD257
;rutinasensores_v4(mstr-slv).h,884 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,885 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBD
;rutinasensores_v4(mstr-slv).h,886 :: 		}
L_transicionSalBD257:
;rutinasensores_v4(mstr-slv).h,887 :: 		if((SENSOR1 & SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBD1216
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalBD1216
	BSF         4056, 0 
	GOTO        L__transicionSalBD1217
L__transicionSalBD1216:
	BCF         4056, 0 
L__transicionSalBD1217:
	BTFSS       4056, 0 
	GOTO        L__transicionSalBD1218
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBD1218
	BSF         R1, 0 
	GOTO        L__transicionSalBD1219
L__transicionSalBD1218:
	BCF         R1, 0 
L__transicionSalBD1219:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBD258
;rutinasensores_v4(mstr-slv).h,888 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,889 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBD
;rutinasensores_v4(mstr-slv).h,890 :: 		}
L_transicionSalBD258:
;rutinasensores_v4(mstr-slv).h,891 :: 		}
L_transicionSalBD256:
;rutinasensores_v4(mstr-slv).h,892 :: 		}
L_end_transicionSalBD:
	RETURN      0
; end of _transicionSalBD

_salioBD:

;rutinasensores_v4(mstr-slv).h,894 :: 		short salioBD(short estado){
;rutinasensores_v4(mstr-slv).h,895 :: 		if(estado == SALIO){
	MOVF        FARG_salioBD_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBD259
;rutinasensores_v4(mstr-slv).h,896 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_31_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_31_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_31_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,897 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,898 :: 		pBajan = eepromLeeNumero(0x0003, 2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,899 :: 		eepromEscribeNumero(0x0003 ,pBajan, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,900 :: 		pBajan = eepromLeeNumero(0x0003, 2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBD+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBD+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBD+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBD+7 
	MOVF        FLOC__salioBD+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBD+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,901 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBD+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBD+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBD+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBD+3 
	MOVF        FLOC__salioBD+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBD+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBD+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBD+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBD+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBD+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,902 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,903 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBD260
;rutinasensores_v4(mstr-slv).h,904 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,905 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,906 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,907 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBD+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBD+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBD+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBD+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBD+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBD+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBD+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBD+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBD+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBD+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBD+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBD+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBD+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBD+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBD+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBD+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,908 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,909 :: 		}
L_salioBD260:
;rutinasensores_v4(mstr-slv).h,910 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,911 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBD
;rutinasensores_v4(mstr-slv).h,912 :: 		}
L_salioBD259:
;rutinasensores_v4(mstr-slv).h,913 :: 		}
L_end_salioBD:
	RETURN      0
; end of _salioBD

_esperaBT:

;rutinasensores_v4(mstr-slv).h,919 :: 		short esperaBT(short estado){
;rutinasensores_v4(mstr-slv).h,920 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBT_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBT261
;rutinasensores_v4(mstr-slv).h,921 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,922 :: 		if((!SENSOR1 | !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBT1222
	BSF         R1, 0 
	GOTO        L__esperaBT1223
L__esperaBT1222:
	BCF         R1, 0 
L__esperaBT1223:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaBT1224
	BSF         4056, 0 
	GOTO        L__esperaBT1225
L__esperaBT1224:
	BCF         4056, 0 
L__esperaBT1225:
	BTFSC       R1, 0 
	GOTO        L__esperaBT1226
	BTFSC       4056, 0 
	GOTO        L__esperaBT1226
	BCF         R1, 0 
	GOTO        L__esperaBT1227
L__esperaBT1226:
	BSF         R1, 0 
L__esperaBT1227:
	BTFSS       R1, 0 
	GOTO        L_esperaBT262
;rutinasensores_v4(mstr-slv).h,923 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,924 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBT
;rutinasensores_v4(mstr-slv).h,925 :: 		}
L_esperaBT262:
;rutinasensores_v4(mstr-slv).h,926 :: 		if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaBT1228
	BSF         R1, 0 
	GOTO        L__esperaBT1229
L__esperaBT1228:
	BCF         R1, 0 
L__esperaBT1229:
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaBT1230
	BSF         4056, 0 
	GOTO        L__esperaBT1231
L__esperaBT1230:
	BCF         4056, 0 
L__esperaBT1231:
	BTFSC       R1, 0 
	GOTO        L__esperaBT1232
	BTFSC       4056, 0 
	GOTO        L__esperaBT1232
	BCF         R1, 0 
	GOTO        L__esperaBT1233
L__esperaBT1232:
	BSF         R1, 0 
L__esperaBT1233:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaBT1234
	BSF         4056, 0 
	GOTO        L__esperaBT1235
L__esperaBT1234:
	BCF         4056, 0 
L__esperaBT1235:
	BTFSC       R1, 0 
	GOTO        L__esperaBT1236
	BTFSC       4056, 0 
	GOTO        L__esperaBT1236
	BCF         R1, 0 
	GOTO        L__esperaBT1237
L__esperaBT1236:
	BSF         R1, 0 
L__esperaBT1237:
	BTFSS       R1, 0 
	GOTO        L_esperaBT263
;rutinasensores_v4(mstr-slv).h,927 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,928 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBT
;rutinasensores_v4(mstr-slv).h,929 :: 		}
L_esperaBT263:
;rutinasensores_v4(mstr-slv).h,930 :: 		}
L_esperaBT261:
;rutinasensores_v4(mstr-slv).h,931 :: 		}
L_end_esperaBT:
	RETURN      0
; end of _esperaBT

_entrandoBT:

;rutinasensores_v4(mstr-slv).h,933 :: 		short entrandoBT(short estado){
;rutinasensores_v4(mstr-slv).h,934 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBT_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBT264
;rutinasensores_v4(mstr-slv).h,935 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_32_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_32_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_32_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,936 :: 		if((SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBT1239
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoBT1239
	BSF         4056, 0 
	GOTO        L__entrandoBT1240
L__entrandoBT1239:
	BCF         4056, 0 
L__entrandoBT1240:
	BTFSS       4056, 0 
	GOTO        L_entrandoBT265
;rutinasensores_v4(mstr-slv).h,937 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,938 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBT
;rutinasensores_v4(mstr-slv).h,939 :: 		}
L_entrandoBT265:
;rutinasensores_v4(mstr-slv).h,940 :: 		if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoBT1241
	BSF         R1, 3 
	GOTO        L__entrandoBT1242
L__entrandoBT1241:
	BCF         R1, 3 
L__entrandoBT1242:
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoBT1243
	BSF         R1, 0 
	GOTO        L__entrandoBT1244
L__entrandoBT1243:
	BCF         R1, 0 
L__entrandoBT1244:
	BTFSS       R1, 3 
	GOTO        L__entrandoBT1245
	BTFSS       R1, 0 
	GOTO        L__entrandoBT1245
	BSF         R1, 1 
	GOTO        L__entrandoBT1246
L__entrandoBT1245:
	BCF         R1, 1 
L__entrandoBT1246:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoBT1247
	BSF         R1, 2 
	GOTO        L__entrandoBT1248
L__entrandoBT1247:
	BCF         R1, 2 
L__entrandoBT1248:
	BTFSS       R1, 0 
	GOTO        L__entrandoBT1249
	BTFSS       R1, 2 
	GOTO        L__entrandoBT1249
	BSF         4056, 0 
	GOTO        L__entrandoBT1250
L__entrandoBT1249:
	BCF         4056, 0 
L__entrandoBT1250:
	BTFSC       R1, 1 
	GOTO        L__entrandoBT1251
	BTFSC       4056, 0 
	GOTO        L__entrandoBT1251
	BCF         R1, 1 
	GOTO        L__entrandoBT1252
L__entrandoBT1251:
	BSF         R1, 1 
L__entrandoBT1252:
	BTFSC       R1, 3 
	GOTO        L__entrandoBT1253
	BCF         R1, 0 
	GOTO        L__entrandoBT1254
L__entrandoBT1253:
	BSF         R1, 0 
L__entrandoBT1254:
	BTFSC       R1, 2 
	GOTO        L__entrandoBT1255
	BCF         4056, 0 
	GOTO        L__entrandoBT1256
L__entrandoBT1255:
	BSF         4056, 0 
L__entrandoBT1256:
	BTFSS       R1, 0 
	GOTO        L__entrandoBT1257
	BTFSS       4056, 0 
	GOTO        L__entrandoBT1257
	BSF         R1, 0 
	GOTO        L__entrandoBT1258
L__entrandoBT1257:
	BCF         R1, 0 
L__entrandoBT1258:
	BTFSC       R1, 1 
	GOTO        L__entrandoBT1259
	BTFSC       R1, 0 
	GOTO        L__entrandoBT1259
	BCF         4056, 0 
	GOTO        L__entrandoBT1260
L__entrandoBT1259:
	BSF         4056, 0 
L__entrandoBT1260:
	BTFSS       4056, 0 
	GOTO        L_entrandoBT266
;rutinasensores_v4(mstr-slv).h,941 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,942 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBT
;rutinasensores_v4(mstr-slv).h,943 :: 		}
L_entrandoBT266:
;rutinasensores_v4(mstr-slv).h,944 :: 		}
L_entrandoBT264:
;rutinasensores_v4(mstr-slv).h,945 :: 		}
L_end_entrandoBT:
	RETURN      0
; end of _entrandoBT

_transicionEBT:

;rutinasensores_v4(mstr-slv).h,947 :: 		short transicionEBT(short estado){
;rutinasensores_v4(mstr-slv).h,948 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBT_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBT267
;rutinasensores_v4(mstr-slv).h,949 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_33_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_33_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_33_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,950 :: 		if((SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBT1262
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBT1262
	BSF         4056, 0 
	GOTO        L__transicionEBT1263
L__transicionEBT1262:
	BCF         4056, 0 
L__transicionEBT1263:
	BTFSS       4056, 0 
	GOTO        L_transicionEBT268
;rutinasensores_v4(mstr-slv).h,951 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,952 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBT
;rutinasensores_v4(mstr-slv).h,953 :: 		}
L_transicionEBT268:
;rutinasensores_v4(mstr-slv).h,954 :: 		if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBT1264
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEBT1264
	BSF         R1, 2 
	GOTO        L__transicionEBT1265
L__transicionEBT1264:
	BCF         R1, 2 
L__transicionEBT1265:
	BTFSS       R1, 2 
	GOTO        L__transicionEBT1266
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBT1266
	BSF         R1, 0 
	GOTO        L__transicionEBT1267
L__transicionEBT1266:
	BCF         R1, 0 
L__transicionEBT1267:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBT1268
	BSF         4056, 0 
	GOTO        L__transicionEBT1269
L__transicionEBT1268:
	BCF         4056, 0 
L__transicionEBT1269:
	BTFSS       R1, 0 
	GOTO        L__transicionEBT1270
	BTFSS       4056, 0 
	GOTO        L__transicionEBT1270
	BSF         R1, 1 
	GOTO        L__transicionEBT1271
L__transicionEBT1270:
	BCF         R1, 1 
L__transicionEBT1271:
	BTFSC       R1, 2 
	GOTO        L__transicionEBT1272
	BCF         4056, 0 
	GOTO        L__transicionEBT1273
L__transicionEBT1272:
	BSF         4056, 0 
L__transicionEBT1273:
	BTFSS       4056, 0 
	GOTO        L__transicionEBT1274
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBT1274
	BSF         R1, 0 
	GOTO        L__transicionEBT1275
L__transicionEBT1274:
	BCF         R1, 0 
L__transicionEBT1275:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBT1276
	BSF         4056, 0 
	GOTO        L__transicionEBT1277
L__transicionEBT1276:
	BCF         4056, 0 
L__transicionEBT1277:
	BTFSS       R1, 0 
	GOTO        L__transicionEBT1278
	BTFSS       4056, 0 
	GOTO        L__transicionEBT1278
	BSF         R1, 0 
	GOTO        L__transicionEBT1279
L__transicionEBT1278:
	BCF         R1, 0 
L__transicionEBT1279:
	BTFSC       R1, 1 
	GOTO        L__transicionEBT1280
	BTFSC       R1, 0 
	GOTO        L__transicionEBT1280
	BCF         4056, 0 
	GOTO        L__transicionEBT1281
L__transicionEBT1280:
	BSF         4056, 0 
L__transicionEBT1281:
	BTFSS       4056, 0 
	GOTO        L_transicionEBT269
;rutinasensores_v4(mstr-slv).h,955 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,956 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBT
;rutinasensores_v4(mstr-slv).h,957 :: 		}
L_transicionEBT269:
;rutinasensores_v4(mstr-slv).h,958 :: 		}
L_transicionEBT267:
;rutinasensores_v4(mstr-slv).h,959 :: 		}
L_end_transicionEBT:
	RETURN      0
; end of _transicionEBT

_transicionEntBT:

;rutinasensores_v4(mstr-slv).h,961 :: 		short transicionEntBT(short estado){
;rutinasensores_v4(mstr-slv).h,962 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBT_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBT270
;rutinasensores_v4(mstr-slv).h,963 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_34_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_34_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_34_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,964 :: 		if((!SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBT1283
	BSF         R1, 0 
	GOTO        L__transicionEntBT1284
L__transicionEntBT1283:
	BCF         R1, 0 
L__transicionEntBT1284:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntBT1285
	BSF         4056, 0 
	GOTO        L__transicionEntBT1286
L__transicionEntBT1285:
	BCF         4056, 0 
L__transicionEntBT1286:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBT1287
	BTFSS       4056, 0 
	GOTO        L__transicionEntBT1287
	BSF         R1, 0 
	GOTO        L__transicionEntBT1288
L__transicionEntBT1287:
	BCF         R1, 0 
L__transicionEntBT1288:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBT271
;rutinasensores_v4(mstr-slv).h,965 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,966 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBT
;rutinasensores_v4(mstr-slv).h,967 :: 		}
L_transicionEntBT271:
;rutinasensores_v4(mstr-slv).h,968 :: 		if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBT1289
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntBT1289
	BSF         4056, 0 
	GOTO        L__transicionEntBT1290
L__transicionEntBT1289:
	BCF         4056, 0 
L__transicionEntBT1290:
	BTFSS       4056, 0 
	GOTO        L__transicionEntBT1291
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBT1291
	BSF         R1, 0 
	GOTO        L__transicionEntBT1292
L__transicionEntBT1291:
	BCF         R1, 0 
L__transicionEntBT1292:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBT272
;rutinasensores_v4(mstr-slv).h,969 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,970 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBT
;rutinasensores_v4(mstr-slv).h,971 :: 		}
L_transicionEntBT272:
;rutinasensores_v4(mstr-slv).h,972 :: 		}
L_transicionEntBT270:
;rutinasensores_v4(mstr-slv).h,973 :: 		}
L_end_transicionEntBT:
	RETURN      0
; end of _transicionEntBT

_entroBT:

;rutinasensores_v4(mstr-slv).h,975 :: 		short entroBT(short estado){
;rutinasensores_v4(mstr-slv).h,976 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBT_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBT273
;rutinasensores_v4(mstr-slv).h,977 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_35_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_35_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_35_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,978 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,979 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,980 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,981 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,982 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBT+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBT+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBT+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBT+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBT+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBT+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBT+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBT+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,983 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,984 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBT274
;rutinasensores_v4(mstr-slv).h,985 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,986 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,987 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,988 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBT+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBT+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBT+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBT+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBT+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBT+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBT+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBT+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBT+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBT+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBT+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBT+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBT+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBT+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBT+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBT+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,989 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,990 :: 		}
L_entroBT274:
;rutinasensores_v4(mstr-slv).h,991 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,992 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBT
;rutinasensores_v4(mstr-slv).h,993 :: 		}
L_entroBT273:
;rutinasensores_v4(mstr-slv).h,994 :: 		}
L_end_entroBT:
	RETURN      0
; end of _entroBT

_saliendoBT:

;rutinasensores_v4(mstr-slv).h,996 :: 		short saliendoBT(short estado){
;rutinasensores_v4(mstr-slv).h,997 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBT_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBT275
;rutinasensores_v4(mstr-slv).h,998 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_36_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_36_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_36_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,999 :: 		if((!SENSOR1 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBT1295
	BSF         R1, 0 
	GOTO        L__saliendoBT1296
L__saliendoBT1295:
	BCF         R1, 0 
L__saliendoBT1296:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoBT1297
	BSF         4056, 0 
	GOTO        L__saliendoBT1298
L__saliendoBT1297:
	BCF         4056, 0 
L__saliendoBT1298:
	BTFSS       R1, 0 
	GOTO        L__saliendoBT1299
	BTFSS       4056, 0 
	GOTO        L__saliendoBT1299
	BSF         R1, 0 
	GOTO        L__saliendoBT1300
L__saliendoBT1299:
	BCF         R1, 0 
L__saliendoBT1300:
	BTFSS       R1, 0 
	GOTO        L_saliendoBT276
;rutinasensores_v4(mstr-slv).h,1000 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1001 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBT
;rutinasensores_v4(mstr-slv).h,1002 :: 		}
L_saliendoBT276:
;rutinasensores_v4(mstr-slv).h,1003 :: 		if((SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoBT1301
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoBT1301
	BSF         4056, 0 
	GOTO        L__saliendoBT1302
L__saliendoBT1301:
	BCF         4056, 0 
L__saliendoBT1302:
	BTFSS       4056, 0 
	GOTO        L__saliendoBT1303
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoBT1303
	BSF         R1, 0 
	GOTO        L__saliendoBT1304
L__saliendoBT1303:
	BCF         R1, 0 
L__saliendoBT1304:
	BTFSS       R1, 0 
	GOTO        L_saliendoBT277
;rutinasensores_v4(mstr-slv).h,1004 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1005 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBT
;rutinasensores_v4(mstr-slv).h,1006 :: 		}
L_saliendoBT277:
;rutinasensores_v4(mstr-slv).h,1007 :: 		}
L_saliendoBT275:
;rutinasensores_v4(mstr-slv).h,1008 :: 		}
L_end_saliendoBT:
	RETURN      0
; end of _saliendoBT

_transicionSBT:

;rutinasensores_v4(mstr-slv).h,1010 :: 		short transicionSBT(short estado){
;rutinasensores_v4(mstr-slv).h,1011 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBT_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBT278
;rutinasensores_v4(mstr-slv).h,1012 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_37_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_37_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_37_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1013 :: 		if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBT1306
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBT1306
	BSF         R1, 0 
	GOTO        L__transicionSBT1307
L__transicionSBT1306:
	BCF         R1, 0 
L__transicionSBT1307:
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBT1308
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBT1308
	BSF         4056, 0 
	GOTO        L__transicionSBT1309
L__transicionSBT1308:
	BCF         4056, 0 
L__transicionSBT1309:
	BTFSC       R1, 0 
	GOTO        L__transicionSBT1310
	BTFSC       4056, 0 
	GOTO        L__transicionSBT1310
	BCF         R1, 0 
	GOTO        L__transicionSBT1311
L__transicionSBT1310:
	BSF         R1, 0 
L__transicionSBT1311:
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBT1312
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBT1312
	BSF         4056, 0 
	GOTO        L__transicionSBT1313
L__transicionSBT1312:
	BCF         4056, 0 
L__transicionSBT1313:
	BTFSC       R1, 0 
	GOTO        L__transicionSBT1314
	BTFSC       4056, 0 
	GOTO        L__transicionSBT1314
	BCF         R1, 0 
	GOTO        L__transicionSBT1315
L__transicionSBT1314:
	BSF         R1, 0 
L__transicionSBT1315:
	BTFSS       R1, 0 
	GOTO        L_transicionSBT279
;rutinasensores_v4(mstr-slv).h,1014 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1015 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBT
;rutinasensores_v4(mstr-slv).h,1016 :: 		}
L_transicionSBT279:
;rutinasensores_v4(mstr-slv).h,1017 :: 		if((SENSOR1 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR5 & !SENSOR6)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBT1316
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBT1316
	BSF         R1, 2 
	GOTO        L__transicionSBT1317
L__transicionSBT1316:
	BCF         R1, 2 
L__transicionSBT1317:
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBT1318
	BSF         4056, 0 
	GOTO        L__transicionSBT1319
L__transicionSBT1318:
	BCF         4056, 0 
L__transicionSBT1319:
	BTFSS       R1, 2 
	GOTO        L__transicionSBT1320
	BTFSS       4056, 0 
	GOTO        L__transicionSBT1320
	BSF         R1, 1 
	GOTO        L__transicionSBT1321
L__transicionSBT1320:
	BCF         R1, 1 
L__transicionSBT1321:
	BTFSC       R1, 2 
	GOTO        L__transicionSBT1322
	BCF         R1, 0 
	GOTO        L__transicionSBT1323
L__transicionSBT1322:
	BSF         R1, 0 
L__transicionSBT1323:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBT1324
	BSF         4056, 0 
	GOTO        L__transicionSBT1325
L__transicionSBT1324:
	BCF         4056, 0 
L__transicionSBT1325:
	BTFSS       R1, 0 
	GOTO        L__transicionSBT1326
	BTFSS       4056, 0 
	GOTO        L__transicionSBT1326
	BSF         R1, 0 
	GOTO        L__transicionSBT1327
L__transicionSBT1326:
	BCF         R1, 0 
L__transicionSBT1327:
	BTFSC       R1, 1 
	GOTO        L__transicionSBT1328
	BTFSC       R1, 0 
	GOTO        L__transicionSBT1328
	BCF         R1, 1 
	GOTO        L__transicionSBT1329
L__transicionSBT1328:
	BSF         R1, 1 
L__transicionSBT1329:
	BTFSC       R1, 2 
	GOTO        L__transicionSBT1330
	BCF         R1, 0 
	GOTO        L__transicionSBT1331
L__transicionSBT1330:
	BSF         R1, 0 
L__transicionSBT1331:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBT1332
	BSF         4056, 0 
	GOTO        L__transicionSBT1333
L__transicionSBT1332:
	BCF         4056, 0 
L__transicionSBT1333:
	BTFSS       R1, 0 
	GOTO        L__transicionSBT1334
	BTFSS       4056, 0 
	GOTO        L__transicionSBT1334
	BSF         R1, 0 
	GOTO        L__transicionSBT1335
L__transicionSBT1334:
	BCF         R1, 0 
L__transicionSBT1335:
	BTFSC       R1, 1 
	GOTO        L__transicionSBT1336
	BTFSC       R1, 0 
	GOTO        L__transicionSBT1336
	BCF         4056, 0 
	GOTO        L__transicionSBT1337
L__transicionSBT1336:
	BSF         4056, 0 
L__transicionSBT1337:
	BTFSS       4056, 0 
	GOTO        L_transicionSBT280
;rutinasensores_v4(mstr-slv).h,1018 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1019 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBT
;rutinasensores_v4(mstr-slv).h,1020 :: 		}
L_transicionSBT280:
;rutinasensores_v4(mstr-slv).h,1021 :: 		}
L_transicionSBT278:
;rutinasensores_v4(mstr-slv).h,1022 :: 		}
L_end_transicionSBT:
	RETURN      0
; end of _transicionSBT

_transicionSalBT:

;rutinasensores_v4(mstr-slv).h,1024 :: 		short transicionSalBT(short estado){
;rutinasensores_v4(mstr-slv).h,1025 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBT_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBT281
;rutinasensores_v4(mstr-slv).h,1026 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_38_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_38_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_38_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1027 :: 		if(!SENSOR2 & !SENSOR4 & !SENSOR6){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBT1339
	BSF         R1, 0 
	GOTO        L__transicionSalBT1340
L__transicionSalBT1339:
	BCF         R1, 0 
L__transicionSalBT1340:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBT1341
	BSF         4056, 0 
	GOTO        L__transicionSalBT1342
L__transicionSalBT1341:
	BCF         4056, 0 
L__transicionSalBT1342:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBT1343
	BTFSS       4056, 0 
	GOTO        L__transicionSalBT1343
	BSF         R1, 0 
	GOTO        L__transicionSalBT1344
L__transicionSalBT1343:
	BCF         R1, 0 
L__transicionSalBT1344:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBT1345
	BSF         4056, 0 
	GOTO        L__transicionSalBT1346
L__transicionSalBT1345:
	BCF         4056, 0 
L__transicionSalBT1346:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBT1347
	BTFSS       4056, 0 
	GOTO        L__transicionSalBT1347
	BSF         R1, 0 
	GOTO        L__transicionSalBT1348
L__transicionSalBT1347:
	BCF         R1, 0 
L__transicionSalBT1348:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBT282
;rutinasensores_v4(mstr-slv).h,1028 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1029 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBT
;rutinasensores_v4(mstr-slv).h,1030 :: 		}
L_transicionSalBT282:
;rutinasensores_v4(mstr-slv).h,1031 :: 		if((SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBT1349
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBT1349
	BSF         4056, 0 
	GOTO        L__transicionSalBT1350
L__transicionSalBT1349:
	BCF         4056, 0 
L__transicionSalBT1350:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBT283
;rutinasensores_v4(mstr-slv).h,1032 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1033 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBT
;rutinasensores_v4(mstr-slv).h,1034 :: 		}
L_transicionSalBT283:
;rutinasensores_v4(mstr-slv).h,1035 :: 		}
L_transicionSalBT281:
;rutinasensores_v4(mstr-slv).h,1036 :: 		}
L_end_transicionSalBT:
	RETURN      0
; end of _transicionSalBT

_salioBT:

;rutinasensores_v4(mstr-slv).h,1038 :: 		short salioBT(short estado){
;rutinasensores_v4(mstr-slv).h,1039 :: 		if(estado == SALIO){
	MOVF        FARG_salioBT_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBT284
;rutinasensores_v4(mstr-slv).h,1040 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_39_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_39_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_39_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1041 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1042 :: 		pBajan = eepromLeeNumero(0x0003, 2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1043 :: 		eepromEscribeNumero(0x0003 ,pBajan, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1044 :: 		pBajan = eepromLeeNumero(0x0003, 2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBT+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBT+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBT+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBT+7 
	MOVF        FLOC__salioBT+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBT+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1045 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBT+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBT+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBT+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBT+3 
	MOVF        FLOC__salioBT+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBT+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBT+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBT+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBT+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBT+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1046 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1047 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBT285
;rutinasensores_v4(mstr-slv).h,1048 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1049 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1050 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1051 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBT+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBT+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBT+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBT+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBT+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBT+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBT+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBT+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBT+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBT+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBT+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBT+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBT+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBT+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBT+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBT+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1052 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1053 :: 		}
L_salioBT285:
;rutinasensores_v4(mstr-slv).h,1054 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1055 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBT
;rutinasensores_v4(mstr-slv).h,1056 :: 		}
L_salioBT284:
;rutinasensores_v4(mstr-slv).h,1057 :: 		}
L_end_salioBT:
	RETURN      0
; end of _salioBT

_esperaBC:

;rutinasensores_v4(mstr-slv).h,1063 :: 		short esperaBC(short estado){
;rutinasensores_v4(mstr-slv).h,1064 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBC_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBC286
;rutinasensores_v4(mstr-slv).h,1065 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,1066 :: 		if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBC1353
	BSF         R1, 0 
	GOTO        L__esperaBC1354
L__esperaBC1353:
	BCF         R1, 0 
L__esperaBC1354:
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaBC1355
	BSF         4056, 0 
	GOTO        L__esperaBC1356
L__esperaBC1355:
	BCF         4056, 0 
L__esperaBC1356:
	BTFSC       R1, 0 
	GOTO        L__esperaBC1357
	BTFSC       4056, 0 
	GOTO        L__esperaBC1357
	BCF         R1, 0 
	GOTO        L__esperaBC1358
L__esperaBC1357:
	BSF         R1, 0 
L__esperaBC1358:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaBC1359
	BSF         4056, 0 
	GOTO        L__esperaBC1360
L__esperaBC1359:
	BCF         4056, 0 
L__esperaBC1360:
	BTFSC       R1, 0 
	GOTO        L__esperaBC1361
	BTFSC       4056, 0 
	GOTO        L__esperaBC1361
	BCF         R1, 0 
	GOTO        L__esperaBC1362
L__esperaBC1361:
	BSF         R1, 0 
L__esperaBC1362:
	BTFSS       R1, 0 
	GOTO        L_esperaBC287
;rutinasensores_v4(mstr-slv).h,1067 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1068 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBC
;rutinasensores_v4(mstr-slv).h,1069 :: 		}
L_esperaBC287:
;rutinasensores_v4(mstr-slv).h,1070 :: 		if((!SENSOR2 | !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaBC1363
	BSF         R1, 0 
	GOTO        L__esperaBC1364
L__esperaBC1363:
	BCF         R1, 0 
L__esperaBC1364:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaBC1365
	BSF         4056, 0 
	GOTO        L__esperaBC1366
L__esperaBC1365:
	BCF         4056, 0 
L__esperaBC1366:
	BTFSC       R1, 0 
	GOTO        L__esperaBC1367
	BTFSC       4056, 0 
	GOTO        L__esperaBC1367
	BCF         R1, 0 
	GOTO        L__esperaBC1368
L__esperaBC1367:
	BSF         R1, 0 
L__esperaBC1368:
	BTFSS       R1, 0 
	GOTO        L_esperaBC288
;rutinasensores_v4(mstr-slv).h,1071 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1072 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBC
;rutinasensores_v4(mstr-slv).h,1073 :: 		}
L_esperaBC288:
;rutinasensores_v4(mstr-slv).h,1074 :: 		}
L_esperaBC286:
;rutinasensores_v4(mstr-slv).h,1075 :: 		}
L_end_esperaBC:
	RETURN      0
; end of _esperaBC

_entrandoBC:

;rutinasensores_v4(mstr-slv).h,1077 :: 		short entrandoBC(short estado){
;rutinasensores_v4(mstr-slv).h,1078 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBC_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBC289
;rutinasensores_v4(mstr-slv).h,1079 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_40_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_40_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_40_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1080 :: 		if((SENSOR1 & SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBC1370
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoBC1370
	BSF         4056, 0 
	GOTO        L__entrandoBC1371
L__entrandoBC1370:
	BCF         4056, 0 
L__entrandoBC1371:
	BTFSS       4056, 0 
	GOTO        L__entrandoBC1372
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoBC1372
	BSF         R1, 0 
	GOTO        L__entrandoBC1373
L__entrandoBC1372:
	BCF         R1, 0 
L__entrandoBC1373:
	BTFSS       R1, 0 
	GOTO        L_entrandoBC290
;rutinasensores_v4(mstr-slv).h,1081 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1082 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBC
;rutinasensores_v4(mstr-slv).h,1083 :: 		}
L_entrandoBC290:
;rutinasensores_v4(mstr-slv).h,1084 :: 		if((!SENSOR2 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoBC1374
	BSF         R1, 0 
	GOTO        L__entrandoBC1375
L__entrandoBC1374:
	BCF         R1, 0 
L__entrandoBC1375:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoBC1376
	BSF         4056, 0 
	GOTO        L__entrandoBC1377
L__entrandoBC1376:
	BCF         4056, 0 
L__entrandoBC1377:
	BTFSS       R1, 0 
	GOTO        L__entrandoBC1378
	BTFSS       4056, 0 
	GOTO        L__entrandoBC1378
	BSF         R1, 0 
	GOTO        L__entrandoBC1379
L__entrandoBC1378:
	BCF         R1, 0 
L__entrandoBC1379:
	BTFSS       R1, 0 
	GOTO        L_entrandoBC291
;rutinasensores_v4(mstr-slv).h,1085 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1086 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBC
;rutinasensores_v4(mstr-slv).h,1087 :: 		}
L_entrandoBC291:
;rutinasensores_v4(mstr-slv).h,1088 :: 		}
L_entrandoBC289:
;rutinasensores_v4(mstr-slv).h,1089 :: 		}
L_end_entrandoBC:
	RETURN      0
; end of _entrandoBC

_transicionEBC:

;rutinasensores_v4(mstr-slv).h,1091 :: 		short transicionEBC(short estado){
;rutinasensores_v4(mstr-slv).h,1092 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBC_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBC292
;rutinasensores_v4(mstr-slv).h,1093 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_41_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_41_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_41_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1094 :: 		if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBC1381
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBC1381
	BSF         R1, 0 
	GOTO        L__transicionEBC1382
L__transicionEBC1381:
	BCF         R1, 0 
L__transicionEBC1382:
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBC1383
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBC1383
	BSF         4056, 0 
	GOTO        L__transicionEBC1384
L__transicionEBC1383:
	BCF         4056, 0 
L__transicionEBC1384:
	BTFSC       R1, 0 
	GOTO        L__transicionEBC1385
	BTFSC       4056, 0 
	GOTO        L__transicionEBC1385
	BCF         R1, 0 
	GOTO        L__transicionEBC1386
L__transicionEBC1385:
	BSF         R1, 0 
L__transicionEBC1386:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBC1387
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBC1387
	BSF         4056, 0 
	GOTO        L__transicionEBC1388
L__transicionEBC1387:
	BCF         4056, 0 
L__transicionEBC1388:
	BTFSC       R1, 0 
	GOTO        L__transicionEBC1389
	BTFSC       4056, 0 
	GOTO        L__transicionEBC1389
	BCF         R1, 0 
	GOTO        L__transicionEBC1390
L__transicionEBC1389:
	BSF         R1, 0 
L__transicionEBC1390:
	BTFSS       R1, 0 
	GOTO        L_transicionEBC293
;rutinasensores_v4(mstr-slv).h,1095 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1096 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBC
;rutinasensores_v4(mstr-slv).h,1097 :: 		}
L_transicionEBC293:
;rutinasensores_v4(mstr-slv).h,1098 :: 		if((SENSOR2 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBC1391
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBC1391
	BSF         R1, 2 
	GOTO        L__transicionEBC1392
L__transicionEBC1391:
	BCF         R1, 2 
L__transicionEBC1392:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBC1393
	BSF         4056, 0 
	GOTO        L__transicionEBC1394
L__transicionEBC1393:
	BCF         4056, 0 
L__transicionEBC1394:
	BTFSS       R1, 2 
	GOTO        L__transicionEBC1395
	BTFSS       4056, 0 
	GOTO        L__transicionEBC1395
	BSF         R1, 1 
	GOTO        L__transicionEBC1396
L__transicionEBC1395:
	BCF         R1, 1 
L__transicionEBC1396:
	BTFSC       R1, 2 
	GOTO        L__transicionEBC1397
	BCF         R1, 0 
	GOTO        L__transicionEBC1398
L__transicionEBC1397:
	BSF         R1, 0 
L__transicionEBC1398:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBC1399
	BSF         4056, 0 
	GOTO        L__transicionEBC1400
L__transicionEBC1399:
	BCF         4056, 0 
L__transicionEBC1400:
	BTFSS       R1, 0 
	GOTO        L__transicionEBC1401
	BTFSS       4056, 0 
	GOTO        L__transicionEBC1401
	BSF         R1, 0 
	GOTO        L__transicionEBC1402
L__transicionEBC1401:
	BCF         R1, 0 
L__transicionEBC1402:
	BTFSC       R1, 1 
	GOTO        L__transicionEBC1403
	BTFSC       R1, 0 
	GOTO        L__transicionEBC1403
	BCF         R1, 1 
	GOTO        L__transicionEBC1404
L__transicionEBC1403:
	BSF         R1, 1 
L__transicionEBC1404:
	BTFSC       R1, 2 
	GOTO        L__transicionEBC1405
	BCF         R1, 0 
	GOTO        L__transicionEBC1406
L__transicionEBC1405:
	BSF         R1, 0 
L__transicionEBC1406:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBC1407
	BSF         4056, 0 
	GOTO        L__transicionEBC1408
L__transicionEBC1407:
	BCF         4056, 0 
L__transicionEBC1408:
	BTFSS       R1, 0 
	GOTO        L__transicionEBC1409
	BTFSS       4056, 0 
	GOTO        L__transicionEBC1409
	BSF         R1, 0 
	GOTO        L__transicionEBC1410
L__transicionEBC1409:
	BCF         R1, 0 
L__transicionEBC1410:
	BTFSC       R1, 1 
	GOTO        L__transicionEBC1411
	BTFSC       R1, 0 
	GOTO        L__transicionEBC1411
	BCF         4056, 0 
	GOTO        L__transicionEBC1412
L__transicionEBC1411:
	BSF         4056, 0 
L__transicionEBC1412:
	BTFSS       4056, 0 
	GOTO        L_transicionEBC294
;rutinasensores_v4(mstr-slv).h,1099 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1100 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBC
;rutinasensores_v4(mstr-slv).h,1101 :: 		}
L_transicionEBC294:
;rutinasensores_v4(mstr-slv).h,1102 :: 		}
L_transicionEBC292:
;rutinasensores_v4(mstr-slv).h,1103 :: 		}
L_end_transicionEBC:
	RETURN      0
; end of _transicionEBC

_transicionEntBC:

;rutinasensores_v4(mstr-slv).h,1105 :: 		short transicionEntBC(short estado){
;rutinasensores_v4(mstr-slv).h,1106 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBC_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBC295
;rutinasensores_v4(mstr-slv).h,1107 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_42_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_42_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_42_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1108 :: 		if((!SENSOR3 & !SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntBC1414
	BSF         R1, 0 
	GOTO        L__transicionEntBC1415
L__transicionEntBC1414:
	BCF         R1, 0 
L__transicionEntBC1415:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBC1416
	BSF         4056, 0 
	GOTO        L__transicionEntBC1417
L__transicionEntBC1416:
	BCF         4056, 0 
L__transicionEntBC1417:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBC1418
	BTFSS       4056, 0 
	GOTO        L__transicionEntBC1418
	BSF         R1, 0 
	GOTO        L__transicionEntBC1419
L__transicionEntBC1418:
	BCF         R1, 0 
L__transicionEntBC1419:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntBC1420
	BSF         4056, 0 
	GOTO        L__transicionEntBC1421
L__transicionEntBC1420:
	BCF         4056, 0 
L__transicionEntBC1421:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBC1422
	BTFSS       4056, 0 
	GOTO        L__transicionEntBC1422
	BSF         R1, 0 
	GOTO        L__transicionEntBC1423
L__transicionEntBC1422:
	BCF         R1, 0 
L__transicionEntBC1423:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBC296
;rutinasensores_v4(mstr-slv).h,1109 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1110 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBC
;rutinasensores_v4(mstr-slv).h,1111 :: 		}
L_transicionEntBC296:
;rutinasensores_v4(mstr-slv).h,1112 :: 		if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBC1424
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBC1424
	BSF         4056, 0 
	GOTO        L__transicionEntBC1425
L__transicionEntBC1424:
	BCF         4056, 0 
L__transicionEntBC1425:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBC297
;rutinasensores_v4(mstr-slv).h,1113 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1114 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBC
;rutinasensores_v4(mstr-slv).h,1115 :: 		}
L_transicionEntBC297:
;rutinasensores_v4(mstr-slv).h,1116 :: 		}
L_transicionEntBC295:
;rutinasensores_v4(mstr-slv).h,1117 :: 		}
L_end_transicionEntBC:
	RETURN      0
; end of _transicionEntBC

_entroBC:

;rutinasensores_v4(mstr-slv).h,1119 :: 		short entroBC(short estado){
;rutinasensores_v4(mstr-slv).h,1120 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBC_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBC298
;rutinasensores_v4(mstr-slv).h,1121 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_43_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_43_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_43_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1122 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1123 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1124 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1125 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1126 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBC+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBC+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBC+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBC+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBC+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBC+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBC+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBC+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1127 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1128 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBC299
;rutinasensores_v4(mstr-slv).h,1129 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1130 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1131 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1132 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBC+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBC+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBC+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBC+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBC+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBC+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBC+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBC+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBC+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBC+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBC+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBC+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBC+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBC+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBC+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBC+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1133 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1134 :: 		}
L_entroBC299:
;rutinasensores_v4(mstr-slv).h,1135 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1136 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBC
;rutinasensores_v4(mstr-slv).h,1137 :: 		}
L_entroBC298:
;rutinasensores_v4(mstr-slv).h,1138 :: 		}
L_end_entroBC:
	RETURN      0
; end of _entroBC

_saliendoBC:

;rutinasensores_v4(mstr-slv).h,1140 :: 		short saliendoBC(short estado){
;rutinasensores_v4(mstr-slv).h,1141 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBC_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBC300
;rutinasensores_v4(mstr-slv).h,1142 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_44_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_44_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_44_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1143 :: 		if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBC1428
	BSF         R1, 3 
	GOTO        L__saliendoBC1429
L__saliendoBC1428:
	BCF         R1, 3 
L__saliendoBC1429:
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoBC1430
	BSF         R1, 0 
	GOTO        L__saliendoBC1431
L__saliendoBC1430:
	BCF         R1, 0 
L__saliendoBC1431:
	BTFSS       R1, 3 
	GOTO        L__saliendoBC1432
	BTFSS       R1, 0 
	GOTO        L__saliendoBC1432
	BSF         R1, 1 
	GOTO        L__saliendoBC1433
L__saliendoBC1432:
	BCF         R1, 1 
L__saliendoBC1433:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoBC1434
	BSF         R1, 2 
	GOTO        L__saliendoBC1435
L__saliendoBC1434:
	BCF         R1, 2 
L__saliendoBC1435:
	BTFSS       R1, 0 
	GOTO        L__saliendoBC1436
	BTFSS       R1, 2 
	GOTO        L__saliendoBC1436
	BSF         4056, 0 
	GOTO        L__saliendoBC1437
L__saliendoBC1436:
	BCF         4056, 0 
L__saliendoBC1437:
	BTFSC       R1, 1 
	GOTO        L__saliendoBC1438
	BTFSC       4056, 0 
	GOTO        L__saliendoBC1438
	BCF         R1, 1 
	GOTO        L__saliendoBC1439
L__saliendoBC1438:
	BSF         R1, 1 
L__saliendoBC1439:
	BTFSC       R1, 3 
	GOTO        L__saliendoBC1440
	BCF         R1, 0 
	GOTO        L__saliendoBC1441
L__saliendoBC1440:
	BSF         R1, 0 
L__saliendoBC1441:
	BTFSC       R1, 2 
	GOTO        L__saliendoBC1442
	BCF         4056, 0 
	GOTO        L__saliendoBC1443
L__saliendoBC1442:
	BSF         4056, 0 
L__saliendoBC1443:
	BTFSS       R1, 0 
	GOTO        L__saliendoBC1444
	BTFSS       4056, 0 
	GOTO        L__saliendoBC1444
	BSF         R1, 0 
	GOTO        L__saliendoBC1445
L__saliendoBC1444:
	BCF         R1, 0 
L__saliendoBC1445:
	BTFSC       R1, 1 
	GOTO        L__saliendoBC1446
	BTFSC       R1, 0 
	GOTO        L__saliendoBC1446
	BCF         4056, 0 
	GOTO        L__saliendoBC1447
L__saliendoBC1446:
	BSF         4056, 0 
L__saliendoBC1447:
	BTFSS       4056, 0 
	GOTO        L_saliendoBC301
;rutinasensores_v4(mstr-slv).h,1144 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1145 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBC
;rutinasensores_v4(mstr-slv).h,1146 :: 		}
L_saliendoBC301:
;rutinasensores_v4(mstr-slv).h,1147 :: 		if((SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoBC1448
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoBC1448
	BSF         4056, 0 
	GOTO        L__saliendoBC1449
L__saliendoBC1448:
	BCF         4056, 0 
L__saliendoBC1449:
	BTFSS       4056, 0 
	GOTO        L_saliendoBC302
;rutinasensores_v4(mstr-slv).h,1148 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1149 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBC
;rutinasensores_v4(mstr-slv).h,1150 :: 		}
L_saliendoBC302:
;rutinasensores_v4(mstr-slv).h,1151 :: 		}
L_saliendoBC300:
;rutinasensores_v4(mstr-slv).h,1152 :: 		}
L_end_saliendoBC:
	RETURN      0
; end of _saliendoBC

_transicionSBC:

;rutinasensores_v4(mstr-slv).h,1154 :: 		short transicionSBC(short estado){
;rutinasensores_v4(mstr-slv).h,1155 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBC_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBC303
;rutinasensores_v4(mstr-slv).h,1156 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_45_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_45_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_45_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1157 :: 		if((SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBC1451
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBC1451
	BSF         4056, 0 
	GOTO        L__transicionSBC1452
L__transicionSBC1451:
	BCF         4056, 0 
L__transicionSBC1452:
	BTFSS       4056, 0 
	GOTO        L_transicionSBC304
;rutinasensores_v4(mstr-slv).h,1158 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1159 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBC
;rutinasensores_v4(mstr-slv).h,1160 :: 		}
L_transicionSBC304:
;rutinasensores_v4(mstr-slv).h,1161 :: 		if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBC1453
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSBC1453
	BSF         R1, 2 
	GOTO        L__transicionSBC1454
L__transicionSBC1453:
	BCF         R1, 2 
L__transicionSBC1454:
	BTFSS       R1, 2 
	GOTO        L__transicionSBC1455
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBC1455
	BSF         R1, 0 
	GOTO        L__transicionSBC1456
L__transicionSBC1455:
	BCF         R1, 0 
L__transicionSBC1456:
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBC1457
	BSF         4056, 0 
	GOTO        L__transicionSBC1458
L__transicionSBC1457:
	BCF         4056, 0 
L__transicionSBC1458:
	BTFSS       R1, 0 
	GOTO        L__transicionSBC1459
	BTFSS       4056, 0 
	GOTO        L__transicionSBC1459
	BSF         R1, 1 
	GOTO        L__transicionSBC1460
L__transicionSBC1459:
	BCF         R1, 1 
L__transicionSBC1460:
	BTFSC       R1, 2 
	GOTO        L__transicionSBC1461
	BCF         4056, 0 
	GOTO        L__transicionSBC1462
L__transicionSBC1461:
	BSF         4056, 0 
L__transicionSBC1462:
	BTFSS       4056, 0 
	GOTO        L__transicionSBC1463
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBC1463
	BSF         R1, 0 
	GOTO        L__transicionSBC1464
L__transicionSBC1463:
	BCF         R1, 0 
L__transicionSBC1464:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBC1465
	BSF         4056, 0 
	GOTO        L__transicionSBC1466
L__transicionSBC1465:
	BCF         4056, 0 
L__transicionSBC1466:
	BTFSS       R1, 0 
	GOTO        L__transicionSBC1467
	BTFSS       4056, 0 
	GOTO        L__transicionSBC1467
	BSF         R1, 0 
	GOTO        L__transicionSBC1468
L__transicionSBC1467:
	BCF         R1, 0 
L__transicionSBC1468:
	BTFSC       R1, 1 
	GOTO        L__transicionSBC1469
	BTFSC       R1, 0 
	GOTO        L__transicionSBC1469
	BCF         4056, 0 
	GOTO        L__transicionSBC1470
L__transicionSBC1469:
	BSF         4056, 0 
L__transicionSBC1470:
	BTFSS       4056, 0 
	GOTO        L_transicionSBC305
;rutinasensores_v4(mstr-slv).h,1162 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1163 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBC
;rutinasensores_v4(mstr-slv).h,1164 :: 		}
L_transicionSBC305:
;rutinasensores_v4(mstr-slv).h,1165 :: 		}
L_transicionSBC303:
;rutinasensores_v4(mstr-slv).h,1166 :: 		}
L_end_transicionSBC:
	RETURN      0
; end of _transicionSBC

_transicionSalBC:

;rutinasensores_v4(mstr-slv).h,1168 :: 		short transicionSalBC(short estado){
;rutinasensores_v4(mstr-slv).h,1169 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBC_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBC306
;rutinasensores_v4(mstr-slv).h,1170 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_46_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_46_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_46_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1171 :: 		if(!SENSOR2 & !SENSOR6){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBC1472
	BSF         R1, 0 
	GOTO        L__transicionSalBC1473
L__transicionSalBC1472:
	BCF         R1, 0 
L__transicionSalBC1473:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBC1474
	BSF         4056, 0 
	GOTO        L__transicionSalBC1475
L__transicionSalBC1474:
	BCF         4056, 0 
L__transicionSalBC1475:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBC1476
	BTFSS       4056, 0 
	GOTO        L__transicionSalBC1476
	BSF         R1, 0 
	GOTO        L__transicionSalBC1477
L__transicionSalBC1476:
	BCF         R1, 0 
L__transicionSalBC1477:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBC307
;rutinasensores_v4(mstr-slv).h,1172 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1173 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBC
;rutinasensores_v4(mstr-slv).h,1174 :: 		}
L_transicionSalBC307:
;rutinasensores_v4(mstr-slv).h,1175 :: 		if((SENSOR1 & SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBC1478
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalBC1478
	BSF         4056, 0 
	GOTO        L__transicionSalBC1479
L__transicionSalBC1478:
	BCF         4056, 0 
L__transicionSalBC1479:
	BTFSS       4056, 0 
	GOTO        L__transicionSalBC1480
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBC1480
	BSF         R1, 0 
	GOTO        L__transicionSalBC1481
L__transicionSalBC1480:
	BCF         R1, 0 
L__transicionSalBC1481:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBC308
;rutinasensores_v4(mstr-slv).h,1176 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1177 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBC
;rutinasensores_v4(mstr-slv).h,1178 :: 		}
L_transicionSalBC308:
;rutinasensores_v4(mstr-slv).h,1179 :: 		}
L_transicionSalBC306:
;rutinasensores_v4(mstr-slv).h,1180 :: 		}
L_end_transicionSalBC:
	RETURN      0
; end of _transicionSalBC

_salioBC:

;rutinasensores_v4(mstr-slv).h,1182 :: 		short salioBC(short estado){
;rutinasensores_v4(mstr-slv).h,1183 :: 		if(estado == SALIO){
	MOVF        FARG_salioBC_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBC309
;rutinasensores_v4(mstr-slv).h,1184 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_47_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_47_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_47_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1185 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1186 :: 		pBajan = eepromLeeNumero(0x0003, 2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1187 :: 		eepromEscribeNumero(0x0003 ,pBajan, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1188 :: 		pBajan = eepromLeeNumero(0x0003, 2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBC+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBC+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBC+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBC+7 
	MOVF        FLOC__salioBC+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBC+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1189 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBC+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBC+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBC+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBC+3 
	MOVF        FLOC__salioBC+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBC+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBC+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBC+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBC+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBC+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1190 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1191 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBC310
;rutinasensores_v4(mstr-slv).h,1192 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1193 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1194 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1195 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBC+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBC+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBC+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBC+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBC+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBC+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBC+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBC+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBC+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBC+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBC+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBC+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBC+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBC+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBC+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBC+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1196 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1197 :: 		}
L_salioBC310:
;rutinasensores_v4(mstr-slv).h,1198 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1199 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBC
;rutinasensores_v4(mstr-slv).h,1200 :: 		}
L_salioBC309:
;rutinasensores_v4(mstr-slv).h,1201 :: 		}
L_end_salioBC:
	RETURN      0
; end of _salioBC

_esperaBO:

;rutinasensores_v4(mstr-slv).h,1207 :: 		short esperaBO(short estado){
;rutinasensores_v4(mstr-slv).h,1208 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBO_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBO311
;rutinasensores_v4(mstr-slv).h,1209 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,1210 :: 		if((!SENSOR1 | !SENSOR3)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBO1484
	BSF         R1, 0 
	GOTO        L__esperaBO1485
L__esperaBO1484:
	BCF         R1, 0 
L__esperaBO1485:
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaBO1486
	BSF         4056, 0 
	GOTO        L__esperaBO1487
L__esperaBO1486:
	BCF         4056, 0 
L__esperaBO1487:
	BTFSC       R1, 0 
	GOTO        L__esperaBO1488
	BTFSC       4056, 0 
	GOTO        L__esperaBO1488
	BCF         R1, 0 
	GOTO        L__esperaBO1489
L__esperaBO1488:
	BSF         R1, 0 
L__esperaBO1489:
	BTFSS       R1, 0 
	GOTO        L_esperaBO312
;rutinasensores_v4(mstr-slv).h,1211 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1212 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBO
;rutinasensores_v4(mstr-slv).h,1213 :: 		}
L_esperaBO312:
;rutinasensores_v4(mstr-slv).h,1214 :: 		if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaBO1490
	BSF         R1, 0 
	GOTO        L__esperaBO1491
L__esperaBO1490:
	BCF         R1, 0 
L__esperaBO1491:
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaBO1492
	BSF         4056, 0 
	GOTO        L__esperaBO1493
L__esperaBO1492:
	BCF         4056, 0 
L__esperaBO1493:
	BTFSC       R1, 0 
	GOTO        L__esperaBO1494
	BTFSC       4056, 0 
	GOTO        L__esperaBO1494
	BCF         R1, 0 
	GOTO        L__esperaBO1495
L__esperaBO1494:
	BSF         R1, 0 
L__esperaBO1495:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaBO1496
	BSF         4056, 0 
	GOTO        L__esperaBO1497
L__esperaBO1496:
	BCF         4056, 0 
L__esperaBO1497:
	BTFSC       R1, 0 
	GOTO        L__esperaBO1498
	BTFSC       4056, 0 
	GOTO        L__esperaBO1498
	BCF         R1, 0 
	GOTO        L__esperaBO1499
L__esperaBO1498:
	BSF         R1, 0 
L__esperaBO1499:
	BTFSS       R1, 0 
	GOTO        L_esperaBO313
;rutinasensores_v4(mstr-slv).h,1215 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1216 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBO
;rutinasensores_v4(mstr-slv).h,1217 :: 		}
L_esperaBO313:
;rutinasensores_v4(mstr-slv).h,1218 :: 		}
L_esperaBO311:
;rutinasensores_v4(mstr-slv).h,1219 :: 		}
L_end_esperaBO:
	RETURN      0
; end of _esperaBO

_entrandoBO:

;rutinasensores_v4(mstr-slv).h,1221 :: 		short entrandoBO(short estado){
;rutinasensores_v4(mstr-slv).h,1222 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBO_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBO314
;rutinasensores_v4(mstr-slv).h,1223 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_48_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_48_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_48_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1224 :: 		if((SENSOR1 & SENSOR3)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBO1501
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoBO1501
	BSF         4056, 0 
	GOTO        L__entrandoBO1502
L__entrandoBO1501:
	BCF         4056, 0 
L__entrandoBO1502:
	BTFSS       4056, 0 
	GOTO        L_entrandoBO315
;rutinasensores_v4(mstr-slv).h,1225 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1226 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBO
;rutinasensores_v4(mstr-slv).h,1227 :: 		}
L_entrandoBO315:
;rutinasensores_v4(mstr-slv).h,1228 :: 		if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoBO1503
	BSF         R1, 3 
	GOTO        L__entrandoBO1504
L__entrandoBO1503:
	BCF         R1, 3 
L__entrandoBO1504:
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoBO1505
	BSF         R1, 0 
	GOTO        L__entrandoBO1506
L__entrandoBO1505:
	BCF         R1, 0 
L__entrandoBO1506:
	BTFSS       R1, 3 
	GOTO        L__entrandoBO1507
	BTFSS       R1, 0 
	GOTO        L__entrandoBO1507
	BSF         R1, 1 
	GOTO        L__entrandoBO1508
L__entrandoBO1507:
	BCF         R1, 1 
L__entrandoBO1508:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoBO1509
	BSF         R1, 2 
	GOTO        L__entrandoBO1510
L__entrandoBO1509:
	BCF         R1, 2 
L__entrandoBO1510:
	BTFSS       R1, 0 
	GOTO        L__entrandoBO1511
	BTFSS       R1, 2 
	GOTO        L__entrandoBO1511
	BSF         4056, 0 
	GOTO        L__entrandoBO1512
L__entrandoBO1511:
	BCF         4056, 0 
L__entrandoBO1512:
	BTFSC       R1, 1 
	GOTO        L__entrandoBO1513
	BTFSC       4056, 0 
	GOTO        L__entrandoBO1513
	BCF         R1, 1 
	GOTO        L__entrandoBO1514
L__entrandoBO1513:
	BSF         R1, 1 
L__entrandoBO1514:
	BTFSC       R1, 3 
	GOTO        L__entrandoBO1515
	BCF         R1, 0 
	GOTO        L__entrandoBO1516
L__entrandoBO1515:
	BSF         R1, 0 
L__entrandoBO1516:
	BTFSC       R1, 2 
	GOTO        L__entrandoBO1517
	BCF         4056, 0 
	GOTO        L__entrandoBO1518
L__entrandoBO1517:
	BSF         4056, 0 
L__entrandoBO1518:
	BTFSS       R1, 0 
	GOTO        L__entrandoBO1519
	BTFSS       4056, 0 
	GOTO        L__entrandoBO1519
	BSF         R1, 0 
	GOTO        L__entrandoBO1520
L__entrandoBO1519:
	BCF         R1, 0 
L__entrandoBO1520:
	BTFSC       R1, 1 
	GOTO        L__entrandoBO1521
	BTFSC       R1, 0 
	GOTO        L__entrandoBO1521
	BCF         4056, 0 
	GOTO        L__entrandoBO1522
L__entrandoBO1521:
	BSF         4056, 0 
L__entrandoBO1522:
	BTFSS       4056, 0 
	GOTO        L_entrandoBO316
;rutinasensores_v4(mstr-slv).h,1229 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1230 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBO
;rutinasensores_v4(mstr-slv).h,1231 :: 		}
L_entrandoBO316:
;rutinasensores_v4(mstr-slv).h,1232 :: 		}
L_entrandoBO314:
;rutinasensores_v4(mstr-slv).h,1233 :: 		}
L_end_entrandoBO:
	RETURN      0
; end of _entrandoBO

_transicionEBO:

;rutinasensores_v4(mstr-slv).h,1235 :: 		short transicionEBO(short estado){
;rutinasensores_v4(mstr-slv).h,1236 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBO_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBO317
;rutinasensores_v4(mstr-slv).h,1237 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_49_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_49_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_49_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1238 :: 		if((SENSOR1 & SENSOR3)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBO1524
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBO1524
	BSF         4056, 0 
	GOTO        L__transicionEBO1525
L__transicionEBO1524:
	BCF         4056, 0 
L__transicionEBO1525:
	BTFSS       4056, 0 
	GOTO        L_transicionEBO318
;rutinasensores_v4(mstr-slv).h,1239 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1240 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBO
;rutinasensores_v4(mstr-slv).h,1241 :: 		}
L_transicionEBO318:
;rutinasensores_v4(mstr-slv).h,1242 :: 		if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBO1526
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEBO1526
	BSF         R1, 2 
	GOTO        L__transicionEBO1527
L__transicionEBO1526:
	BCF         R1, 2 
L__transicionEBO1527:
	BTFSS       R1, 2 
	GOTO        L__transicionEBO1528
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBO1528
	BSF         R1, 0 
	GOTO        L__transicionEBO1529
L__transicionEBO1528:
	BCF         R1, 0 
L__transicionEBO1529:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBO1530
	BSF         4056, 0 
	GOTO        L__transicionEBO1531
L__transicionEBO1530:
	BCF         4056, 0 
L__transicionEBO1531:
	BTFSS       R1, 0 
	GOTO        L__transicionEBO1532
	BTFSS       4056, 0 
	GOTO        L__transicionEBO1532
	BSF         R1, 1 
	GOTO        L__transicionEBO1533
L__transicionEBO1532:
	BCF         R1, 1 
L__transicionEBO1533:
	BTFSC       R1, 2 
	GOTO        L__transicionEBO1534
	BCF         4056, 0 
	GOTO        L__transicionEBO1535
L__transicionEBO1534:
	BSF         4056, 0 
L__transicionEBO1535:
	BTFSS       4056, 0 
	GOTO        L__transicionEBO1536
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBO1536
	BSF         R1, 0 
	GOTO        L__transicionEBO1537
L__transicionEBO1536:
	BCF         R1, 0 
L__transicionEBO1537:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBO1538
	BSF         4056, 0 
	GOTO        L__transicionEBO1539
L__transicionEBO1538:
	BCF         4056, 0 
L__transicionEBO1539:
	BTFSS       R1, 0 
	GOTO        L__transicionEBO1540
	BTFSS       4056, 0 
	GOTO        L__transicionEBO1540
	BSF         R1, 0 
	GOTO        L__transicionEBO1541
L__transicionEBO1540:
	BCF         R1, 0 
L__transicionEBO1541:
	BTFSC       R1, 1 
	GOTO        L__transicionEBO1542
	BTFSC       R1, 0 
	GOTO        L__transicionEBO1542
	BCF         4056, 0 
	GOTO        L__transicionEBO1543
L__transicionEBO1542:
	BSF         4056, 0 
L__transicionEBO1543:
	BTFSS       4056, 0 
	GOTO        L_transicionEBO319
;rutinasensores_v4(mstr-slv).h,1243 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1244 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBO
;rutinasensores_v4(mstr-slv).h,1245 :: 		}
L_transicionEBO319:
;rutinasensores_v4(mstr-slv).h,1246 :: 		}
L_transicionEBO317:
;rutinasensores_v4(mstr-slv).h,1247 :: 		}
L_end_transicionEBO:
	RETURN      0
; end of _transicionEBO

_transicionEntBO:

;rutinasensores_v4(mstr-slv).h,1249 :: 		short transicionEntBO(short estado){
;rutinasensores_v4(mstr-slv).h,1250 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBO_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBO320
;rutinasensores_v4(mstr-slv).h,1251 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_50_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_50_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_50_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1252 :: 		if((!SENSOR3 & !SENSOR1)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntBO1545
	BSF         R1, 0 
	GOTO        L__transicionEntBO1546
L__transicionEntBO1545:
	BCF         R1, 0 
L__transicionEntBO1546:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBO1547
	BSF         4056, 0 
	GOTO        L__transicionEntBO1548
L__transicionEntBO1547:
	BCF         4056, 0 
L__transicionEntBO1548:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBO1549
	BTFSS       4056, 0 
	GOTO        L__transicionEntBO1549
	BSF         R1, 0 
	GOTO        L__transicionEntBO1550
L__transicionEntBO1549:
	BCF         R1, 0 
L__transicionEntBO1550:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBO321
;rutinasensores_v4(mstr-slv).h,1253 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1254 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBO
;rutinasensores_v4(mstr-slv).h,1255 :: 		}
L_transicionEntBO321:
;rutinasensores_v4(mstr-slv).h,1256 :: 		if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBO1551
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntBO1551
	BSF         4056, 0 
	GOTO        L__transicionEntBO1552
L__transicionEntBO1551:
	BCF         4056, 0 
L__transicionEntBO1552:
	BTFSS       4056, 0 
	GOTO        L__transicionEntBO1553
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBO1553
	BSF         R1, 0 
	GOTO        L__transicionEntBO1554
L__transicionEntBO1553:
	BCF         R1, 0 
L__transicionEntBO1554:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBO322
;rutinasensores_v4(mstr-slv).h,1257 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1258 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBO
;rutinasensores_v4(mstr-slv).h,1259 :: 		}
L_transicionEntBO322:
;rutinasensores_v4(mstr-slv).h,1260 :: 		}
L_transicionEntBO320:
;rutinasensores_v4(mstr-slv).h,1261 :: 		}
L_end_transicionEntBO:
	RETURN      0
; end of _transicionEntBO

_entroBO:

;rutinasensores_v4(mstr-slv).h,1263 :: 		short entroBO(short estado){
;rutinasensores_v4(mstr-slv).h,1264 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBO_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBO323
;rutinasensores_v4(mstr-slv).h,1265 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_51_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_51_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_51_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1266 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1267 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1268 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1269 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1270 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBO+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBO+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBO+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBO+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBO+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBO+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBO+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBO+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1271 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1272 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBO324
;rutinasensores_v4(mstr-slv).h,1273 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1274 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1275 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1276 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBO+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBO+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBO+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBO+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBO+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBO+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBO+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBO+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBO+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBO+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBO+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBO+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBO+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBO+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBO+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBO+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1277 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1278 :: 		}
L_entroBO324:
;rutinasensores_v4(mstr-slv).h,1279 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1280 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBO
;rutinasensores_v4(mstr-slv).h,1281 :: 		}
L_entroBO323:
;rutinasensores_v4(mstr-slv).h,1282 :: 		}
L_end_entroBO:
	RETURN      0
; end of _entroBO

_saliendoBO:

;rutinasensores_v4(mstr-slv).h,1284 :: 		short saliendoBO(short estado){
;rutinasensores_v4(mstr-slv).h,1285 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBO_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBO325
;rutinasensores_v4(mstr-slv).h,1286 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_52_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_52_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_52_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1287 :: 		if((!SENSOR1 & !SENSOR3)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBO1557
	BSF         R1, 0 
	GOTO        L__saliendoBO1558
L__saliendoBO1557:
	BCF         R1, 0 
L__saliendoBO1558:
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoBO1559
	BSF         4056, 0 
	GOTO        L__saliendoBO1560
L__saliendoBO1559:
	BCF         4056, 0 
L__saliendoBO1560:
	BTFSS       R1, 0 
	GOTO        L__saliendoBO1561
	BTFSS       4056, 0 
	GOTO        L__saliendoBO1561
	BSF         R1, 0 
	GOTO        L__saliendoBO1562
L__saliendoBO1561:
	BCF         R1, 0 
L__saliendoBO1562:
	BTFSS       R1, 0 
	GOTO        L_saliendoBO326
;rutinasensores_v4(mstr-slv).h,1288 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1289 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBO
;rutinasensores_v4(mstr-slv).h,1290 :: 		}
L_saliendoBO326:
;rutinasensores_v4(mstr-slv).h,1291 :: 		if((SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoBO1563
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoBO1563
	BSF         4056, 0 
	GOTO        L__saliendoBO1564
L__saliendoBO1563:
	BCF         4056, 0 
L__saliendoBO1564:
	BTFSS       4056, 0 
	GOTO        L__saliendoBO1565
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoBO1565
	BSF         R1, 0 
	GOTO        L__saliendoBO1566
L__saliendoBO1565:
	BCF         R1, 0 
L__saliendoBO1566:
	BTFSS       R1, 0 
	GOTO        L_saliendoBO327
;rutinasensores_v4(mstr-slv).h,1292 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1293 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBO
;rutinasensores_v4(mstr-slv).h,1294 :: 		}
L_saliendoBO327:
;rutinasensores_v4(mstr-slv).h,1295 :: 		}
L_saliendoBO325:
;rutinasensores_v4(mstr-slv).h,1296 :: 		}
L_end_saliendoBO:
	RETURN      0
; end of _saliendoBO

_transicionSBO:

;rutinasensores_v4(mstr-slv).h,1298 :: 		short transicionSBO(short estado){
;rutinasensores_v4(mstr-slv).h,1299 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBO_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBO328
;rutinasensores_v4(mstr-slv).h,1300 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_53_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_53_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_53_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1301 :: 		if((SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBO1568
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBO1568
	BSF         R1, 0 
	GOTO        L__transicionSBO1569
L__transicionSBO1568:
	BCF         R1, 0 
L__transicionSBO1569:
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBO1570
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBO1570
	BSF         4056, 0 
	GOTO        L__transicionSBO1571
L__transicionSBO1570:
	BCF         4056, 0 
L__transicionSBO1571:
	BTFSC       R1, 0 
	GOTO        L__transicionSBO1572
	BTFSC       4056, 0 
	GOTO        L__transicionSBO1572
	BCF         R1, 0 
	GOTO        L__transicionSBO1573
L__transicionSBO1572:
	BSF         R1, 0 
L__transicionSBO1573:
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBO1574
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBO1574
	BSF         4056, 0 
	GOTO        L__transicionSBO1575
L__transicionSBO1574:
	BCF         4056, 0 
L__transicionSBO1575:
	BTFSC       R1, 0 
	GOTO        L__transicionSBO1576
	BTFSC       4056, 0 
	GOTO        L__transicionSBO1576
	BCF         R1, 0 
	GOTO        L__transicionSBO1577
L__transicionSBO1576:
	BSF         R1, 0 
L__transicionSBO1577:
	BTFSS       R1, 0 
	GOTO        L_transicionSBO329
;rutinasensores_v4(mstr-slv).h,1302 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1303 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBO
;rutinasensores_v4(mstr-slv).h,1304 :: 		}
L_transicionSBO329:
;rutinasensores_v4(mstr-slv).h,1305 :: 		if((SENSOR1 & SENSOR3 & !SENSOR2) | (SENSOR1 & SENSOR3 & !SENSOR4) | (SENSOR1 & SENSOR3 & !SENSOR6)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBO1578
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSBO1578
	BSF         R1, 2 
	GOTO        L__transicionSBO1579
L__transicionSBO1578:
	BCF         R1, 2 
L__transicionSBO1579:
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBO1580
	BSF         4056, 0 
	GOTO        L__transicionSBO1581
L__transicionSBO1580:
	BCF         4056, 0 
L__transicionSBO1581:
	BTFSS       R1, 2 
	GOTO        L__transicionSBO1582
	BTFSS       4056, 0 
	GOTO        L__transicionSBO1582
	BSF         R1, 1 
	GOTO        L__transicionSBO1583
L__transicionSBO1582:
	BCF         R1, 1 
L__transicionSBO1583:
	BTFSC       R1, 2 
	GOTO        L__transicionSBO1584
	BCF         R1, 0 
	GOTO        L__transicionSBO1585
L__transicionSBO1584:
	BSF         R1, 0 
L__transicionSBO1585:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBO1586
	BSF         4056, 0 
	GOTO        L__transicionSBO1587
L__transicionSBO1586:
	BCF         4056, 0 
L__transicionSBO1587:
	BTFSS       R1, 0 
	GOTO        L__transicionSBO1588
	BTFSS       4056, 0 
	GOTO        L__transicionSBO1588
	BSF         R1, 0 
	GOTO        L__transicionSBO1589
L__transicionSBO1588:
	BCF         R1, 0 
L__transicionSBO1589:
	BTFSC       R1, 1 
	GOTO        L__transicionSBO1590
	BTFSC       R1, 0 
	GOTO        L__transicionSBO1590
	BCF         R1, 1 
	GOTO        L__transicionSBO1591
L__transicionSBO1590:
	BSF         R1, 1 
L__transicionSBO1591:
	BTFSC       R1, 2 
	GOTO        L__transicionSBO1592
	BCF         R1, 0 
	GOTO        L__transicionSBO1593
L__transicionSBO1592:
	BSF         R1, 0 
L__transicionSBO1593:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBO1594
	BSF         4056, 0 
	GOTO        L__transicionSBO1595
L__transicionSBO1594:
	BCF         4056, 0 
L__transicionSBO1595:
	BTFSS       R1, 0 
	GOTO        L__transicionSBO1596
	BTFSS       4056, 0 
	GOTO        L__transicionSBO1596
	BSF         R1, 0 
	GOTO        L__transicionSBO1597
L__transicionSBO1596:
	BCF         R1, 0 
L__transicionSBO1597:
	BTFSC       R1, 1 
	GOTO        L__transicionSBO1598
	BTFSC       R1, 0 
	GOTO        L__transicionSBO1598
	BCF         4056, 0 
	GOTO        L__transicionSBO1599
L__transicionSBO1598:
	BSF         4056, 0 
L__transicionSBO1599:
	BTFSS       4056, 0 
	GOTO        L_transicionSBO330
;rutinasensores_v4(mstr-slv).h,1306 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1307 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBO
;rutinasensores_v4(mstr-slv).h,1308 :: 		}
L_transicionSBO330:
;rutinasensores_v4(mstr-slv).h,1309 :: 		}
L_transicionSBO328:
;rutinasensores_v4(mstr-slv).h,1310 :: 		}
L_end_transicionSBO:
	RETURN      0
; end of _transicionSBO

_transicionSalBO:

;rutinasensores_v4(mstr-slv).h,1312 :: 		short transicionSalBO(short estado){
;rutinasensores_v4(mstr-slv).h,1313 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBO_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBO331
;rutinasensores_v4(mstr-slv).h,1314 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_54_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_54_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_54_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1315 :: 		if(!SENSOR2 & !SENSOR4 & !SENSOR6){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBO1601
	BSF         R1, 0 
	GOTO        L__transicionSalBO1602
L__transicionSalBO1601:
	BCF         R1, 0 
L__transicionSalBO1602:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBO1603
	BSF         4056, 0 
	GOTO        L__transicionSalBO1604
L__transicionSalBO1603:
	BCF         4056, 0 
L__transicionSalBO1604:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBO1605
	BTFSS       4056, 0 
	GOTO        L__transicionSalBO1605
	BSF         R1, 0 
	GOTO        L__transicionSalBO1606
L__transicionSalBO1605:
	BCF         R1, 0 
L__transicionSalBO1606:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBO1607
	BSF         4056, 0 
	GOTO        L__transicionSalBO1608
L__transicionSalBO1607:
	BCF         4056, 0 
L__transicionSalBO1608:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBO1609
	BTFSS       4056, 0 
	GOTO        L__transicionSalBO1609
	BSF         R1, 0 
	GOTO        L__transicionSalBO1610
L__transicionSalBO1609:
	BCF         R1, 0 
L__transicionSalBO1610:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBO332
;rutinasensores_v4(mstr-slv).h,1316 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1317 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBO
;rutinasensores_v4(mstr-slv).h,1318 :: 		}
L_transicionSalBO332:
;rutinasensores_v4(mstr-slv).h,1319 :: 		if((SENSOR1 & SENSOR3)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBO1611
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalBO1611
	BSF         4056, 0 
	GOTO        L__transicionSalBO1612
L__transicionSalBO1611:
	BCF         4056, 0 
L__transicionSalBO1612:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBO333
;rutinasensores_v4(mstr-slv).h,1320 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1321 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBO
;rutinasensores_v4(mstr-slv).h,1322 :: 		}
L_transicionSalBO333:
;rutinasensores_v4(mstr-slv).h,1323 :: 		}
L_transicionSalBO331:
;rutinasensores_v4(mstr-slv).h,1324 :: 		}
L_end_transicionSalBO:
	RETURN      0
; end of _transicionSalBO

_salioBO:

;rutinasensores_v4(mstr-slv).h,1326 :: 		short salioBO(short estado){
;rutinasensores_v4(mstr-slv).h,1327 :: 		if(estado == SALIO){
	MOVF        FARG_salioBO_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBO334
;rutinasensores_v4(mstr-slv).h,1328 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_55_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_55_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_55_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1329 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1330 :: 		pBajan = eepromLeeNumero(0x0003, 2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1331 :: 		eepromEscribeNumero(0x0003 ,pBajan, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1332 :: 		pBajan = eepromLeeNumero(0x0003, 2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBO+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBO+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBO+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBO+7 
	MOVF        FLOC__salioBO+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBO+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1333 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBO+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBO+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBO+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBO+3 
	MOVF        FLOC__salioBO+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBO+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBO+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBO+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBO+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBO+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1334 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1335 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBO335
;rutinasensores_v4(mstr-slv).h,1336 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1337 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1338 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1339 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBO+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBO+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBO+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBO+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBO+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBO+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBO+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBO+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBO+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBO+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBO+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBO+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBO+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBO+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBO+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBO+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1340 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1341 :: 		}
L_salioBO335:
;rutinasensores_v4(mstr-slv).h,1342 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1343 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBO
;rutinasensores_v4(mstr-slv).h,1344 :: 		}
L_salioBO334:
;rutinasensores_v4(mstr-slv).h,1345 :: 		}
L_end_salioBO:
	RETURN      0
; end of _salioBO

_esperaBS:

;rutinasensores_v4(mstr-slv).h,1351 :: 		short esperaBS(short estado){
;rutinasensores_v4(mstr-slv).h,1352 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBS_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBS336
;rutinasensores_v4(mstr-slv).h,1353 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,1354 :: 		if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBS1615
	BSF         R1, 0 
	GOTO        L__esperaBS1616
L__esperaBS1615:
	BCF         R1, 0 
L__esperaBS1616:
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaBS1617
	BSF         4056, 0 
	GOTO        L__esperaBS1618
L__esperaBS1617:
	BCF         4056, 0 
L__esperaBS1618:
	BTFSC       R1, 0 
	GOTO        L__esperaBS1619
	BTFSC       4056, 0 
	GOTO        L__esperaBS1619
	BCF         R1, 0 
	GOTO        L__esperaBS1620
L__esperaBS1619:
	BSF         R1, 0 
L__esperaBS1620:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaBS1621
	BSF         4056, 0 
	GOTO        L__esperaBS1622
L__esperaBS1621:
	BCF         4056, 0 
L__esperaBS1622:
	BTFSC       R1, 0 
	GOTO        L__esperaBS1623
	BTFSC       4056, 0 
	GOTO        L__esperaBS1623
	BCF         R1, 0 
	GOTO        L__esperaBS1624
L__esperaBS1623:
	BSF         R1, 0 
L__esperaBS1624:
	BTFSS       R1, 0 
	GOTO        L_esperaBS337
;rutinasensores_v4(mstr-slv).h,1355 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1356 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBS
;rutinasensores_v4(mstr-slv).h,1357 :: 		}
L_esperaBS337:
;rutinasensores_v4(mstr-slv).h,1358 :: 		if((!SENSOR2 | !SENSOR4)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaBS1625
	BSF         R1, 0 
	GOTO        L__esperaBS1626
L__esperaBS1625:
	BCF         R1, 0 
L__esperaBS1626:
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaBS1627
	BSF         4056, 0 
	GOTO        L__esperaBS1628
L__esperaBS1627:
	BCF         4056, 0 
L__esperaBS1628:
	BTFSC       R1, 0 
	GOTO        L__esperaBS1629
	BTFSC       4056, 0 
	GOTO        L__esperaBS1629
	BCF         R1, 0 
	GOTO        L__esperaBS1630
L__esperaBS1629:
	BSF         R1, 0 
L__esperaBS1630:
	BTFSS       R1, 0 
	GOTO        L_esperaBS338
;rutinasensores_v4(mstr-slv).h,1359 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1360 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBS
;rutinasensores_v4(mstr-slv).h,1361 :: 		}
L_esperaBS338:
;rutinasensores_v4(mstr-slv).h,1362 :: 		}
L_esperaBS336:
;rutinasensores_v4(mstr-slv).h,1363 :: 		}
L_end_esperaBS:
	RETURN      0
; end of _esperaBS

_entrandoBS:

;rutinasensores_v4(mstr-slv).h,1365 :: 		short entrandoBS(short estado){
;rutinasensores_v4(mstr-slv).h,1366 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBS_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBS339
;rutinasensores_v4(mstr-slv).h,1367 :: 		LCD_OUTCONST(3,1,"ENTRANDO DEBUG");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_56_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_56_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_56_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1368 :: 		if((SENSOR1 & SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBS1632
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoBS1632
	BSF         4056, 0 
	GOTO        L__entrandoBS1633
L__entrandoBS1632:
	BCF         4056, 0 
L__entrandoBS1633:
	BTFSS       4056, 0 
	GOTO        L__entrandoBS1634
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoBS1634
	BSF         R1, 0 
	GOTO        L__entrandoBS1635
L__entrandoBS1634:
	BCF         R1, 0 
L__entrandoBS1635:
	BTFSS       R1, 0 
	GOTO        L_entrandoBS340
;rutinasensores_v4(mstr-slv).h,1369 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1370 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBS
;rutinasensores_v4(mstr-slv).h,1371 :: 		}
L_entrandoBS340:
;rutinasensores_v4(mstr-slv).h,1372 :: 		if((!SENSOR2 & !SENSOR4)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoBS1636
	BSF         R1, 0 
	GOTO        L__entrandoBS1637
L__entrandoBS1636:
	BCF         R1, 0 
L__entrandoBS1637:
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoBS1638
	BSF         4056, 0 
	GOTO        L__entrandoBS1639
L__entrandoBS1638:
	BCF         4056, 0 
L__entrandoBS1639:
	BTFSS       R1, 0 
	GOTO        L__entrandoBS1640
	BTFSS       4056, 0 
	GOTO        L__entrandoBS1640
	BSF         R1, 0 
	GOTO        L__entrandoBS1641
L__entrandoBS1640:
	BCF         R1, 0 
L__entrandoBS1641:
	BTFSS       R1, 0 
	GOTO        L_entrandoBS341
;rutinasensores_v4(mstr-slv).h,1373 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1374 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBS
;rutinasensores_v4(mstr-slv).h,1375 :: 		}
L_entrandoBS341:
;rutinasensores_v4(mstr-slv).h,1376 :: 		}
L_entrandoBS339:
;rutinasensores_v4(mstr-slv).h,1377 :: 		}
L_end_entrandoBS:
	RETURN      0
; end of _entrandoBS

_transicionEBS:

;rutinasensores_v4(mstr-slv).h,1379 :: 		short transicionEBS(short estado){
;rutinasensores_v4(mstr-slv).h,1380 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBS_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBS342
;rutinasensores_v4(mstr-slv).h,1381 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_57_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_57_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_57_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1382 :: 		if((SENSOR1 & SENSOR3) | (SENSOR3 & SENSOR5) | (SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBS1643
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBS1643
	BSF         R1, 0 
	GOTO        L__transicionEBS1644
L__transicionEBS1643:
	BCF         R1, 0 
L__transicionEBS1644:
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBS1645
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBS1645
	BSF         4056, 0 
	GOTO        L__transicionEBS1646
L__transicionEBS1645:
	BCF         4056, 0 
L__transicionEBS1646:
	BTFSC       R1, 0 
	GOTO        L__transicionEBS1647
	BTFSC       4056, 0 
	GOTO        L__transicionEBS1647
	BCF         R1, 0 
	GOTO        L__transicionEBS1648
L__transicionEBS1647:
	BSF         R1, 0 
L__transicionEBS1648:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBS1649
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBS1649
	BSF         4056, 0 
	GOTO        L__transicionEBS1650
L__transicionEBS1649:
	BCF         4056, 0 
L__transicionEBS1650:
	BTFSC       R1, 0 
	GOTO        L__transicionEBS1651
	BTFSC       4056, 0 
	GOTO        L__transicionEBS1651
	BCF         R1, 0 
	GOTO        L__transicionEBS1652
L__transicionEBS1651:
	BSF         R1, 0 
L__transicionEBS1652:
	BTFSS       R1, 0 
	GOTO        L_transicionEBS343
;rutinasensores_v4(mstr-slv).h,1383 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1384 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBS
;rutinasensores_v4(mstr-slv).h,1385 :: 		}
L_transicionEBS343:
;rutinasensores_v4(mstr-slv).h,1386 :: 		if((SENSOR2 & SENSOR4 & !SENSOR1) | (SENSOR2 & SENSOR4 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBS1653
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEBS1653
	BSF         R1, 2 
	GOTO        L__transicionEBS1654
L__transicionEBS1653:
	BCF         R1, 2 
L__transicionEBS1654:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBS1655
	BSF         4056, 0 
	GOTO        L__transicionEBS1656
L__transicionEBS1655:
	BCF         4056, 0 
L__transicionEBS1656:
	BTFSS       R1, 2 
	GOTO        L__transicionEBS1657
	BTFSS       4056, 0 
	GOTO        L__transicionEBS1657
	BSF         R1, 1 
	GOTO        L__transicionEBS1658
L__transicionEBS1657:
	BCF         R1, 1 
L__transicionEBS1658:
	BTFSC       R1, 2 
	GOTO        L__transicionEBS1659
	BCF         R1, 0 
	GOTO        L__transicionEBS1660
L__transicionEBS1659:
	BSF         R1, 0 
L__transicionEBS1660:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBS1661
	BSF         4056, 0 
	GOTO        L__transicionEBS1662
L__transicionEBS1661:
	BCF         4056, 0 
L__transicionEBS1662:
	BTFSS       R1, 0 
	GOTO        L__transicionEBS1663
	BTFSS       4056, 0 
	GOTO        L__transicionEBS1663
	BSF         R1, 0 
	GOTO        L__transicionEBS1664
L__transicionEBS1663:
	BCF         R1, 0 
L__transicionEBS1664:
	BTFSC       R1, 1 
	GOTO        L__transicionEBS1665
	BTFSC       R1, 0 
	GOTO        L__transicionEBS1665
	BCF         R1, 1 
	GOTO        L__transicionEBS1666
L__transicionEBS1665:
	BSF         R1, 1 
L__transicionEBS1666:
	BTFSC       R1, 2 
	GOTO        L__transicionEBS1667
	BCF         4056, 0 
	GOTO        L__transicionEBS1668
L__transicionEBS1667:
	BSF         4056, 0 
L__transicionEBS1668:
	BTFSS       4056, 0 
	GOTO        L__transicionEBS1669
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBS1669
	BSF         R1, 0 
	GOTO        L__transicionEBS1670
L__transicionEBS1669:
	BCF         R1, 0 
L__transicionEBS1670:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBS1671
	BSF         4056, 0 
	GOTO        L__transicionEBS1672
L__transicionEBS1671:
	BCF         4056, 0 
L__transicionEBS1672:
	BTFSS       R1, 0 
	GOTO        L__transicionEBS1673
	BTFSS       4056, 0 
	GOTO        L__transicionEBS1673
	BSF         R1, 0 
	GOTO        L__transicionEBS1674
L__transicionEBS1673:
	BCF         R1, 0 
L__transicionEBS1674:
	BTFSC       R1, 1 
	GOTO        L__transicionEBS1675
	BTFSC       R1, 0 
	GOTO        L__transicionEBS1675
	BCF         4056, 0 
	GOTO        L__transicionEBS1676
L__transicionEBS1675:
	BSF         4056, 0 
L__transicionEBS1676:
	BTFSS       4056, 0 
	GOTO        L_transicionEBS344
;rutinasensores_v4(mstr-slv).h,1387 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1388 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBS
;rutinasensores_v4(mstr-slv).h,1389 :: 		}
L_transicionEBS344:
;rutinasensores_v4(mstr-slv).h,1390 :: 		}
L_transicionEBS342:
;rutinasensores_v4(mstr-slv).h,1391 :: 		}
L_end_transicionEBS:
	RETURN      0
; end of _transicionEBS

_transicionEntBS:

;rutinasensores_v4(mstr-slv).h,1393 :: 		short transicionEntBS(short estado){
;rutinasensores_v4(mstr-slv).h,1394 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBS_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBS345
;rutinasensores_v4(mstr-slv).h,1395 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_58_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_58_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_58_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1396 :: 		if((!SENSOR3 & !SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntBS1678
	BSF         R1, 0 
	GOTO        L__transicionEntBS1679
L__transicionEntBS1678:
	BCF         R1, 0 
L__transicionEntBS1679:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBS1680
	BSF         4056, 0 
	GOTO        L__transicionEntBS1681
L__transicionEntBS1680:
	BCF         4056, 0 
L__transicionEntBS1681:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBS1682
	BTFSS       4056, 0 
	GOTO        L__transicionEntBS1682
	BSF         R1, 0 
	GOTO        L__transicionEntBS1683
L__transicionEntBS1682:
	BCF         R1, 0 
L__transicionEntBS1683:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntBS1684
	BSF         4056, 0 
	GOTO        L__transicionEntBS1685
L__transicionEntBS1684:
	BCF         4056, 0 
L__transicionEntBS1685:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBS1686
	BTFSS       4056, 0 
	GOTO        L__transicionEntBS1686
	BSF         R1, 0 
	GOTO        L__transicionEntBS1687
L__transicionEntBS1686:
	BCF         R1, 0 
L__transicionEntBS1687:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBS346
;rutinasensores_v4(mstr-slv).h,1397 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1398 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBS
;rutinasensores_v4(mstr-slv).h,1399 :: 		}
L_transicionEntBS346:
;rutinasensores_v4(mstr-slv).h,1400 :: 		if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR4)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBS1688
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntBS1688
	BSF         4056, 0 
	GOTO        L__transicionEntBS1689
L__transicionEntBS1688:
	BCF         4056, 0 
L__transicionEntBS1689:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBS347
;rutinasensores_v4(mstr-slv).h,1401 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1402 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBS
;rutinasensores_v4(mstr-slv).h,1403 :: 		}
L_transicionEntBS347:
;rutinasensores_v4(mstr-slv).h,1404 :: 		}
L_transicionEntBS345:
;rutinasensores_v4(mstr-slv).h,1405 :: 		}
L_end_transicionEntBS:
	RETURN      0
; end of _transicionEntBS

_entroBS:

;rutinasensores_v4(mstr-slv).h,1407 :: 		short entroBS(short estado){
;rutinasensores_v4(mstr-slv).h,1408 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBS_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBS348
;rutinasensores_v4(mstr-slv).h,1409 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_59_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_59_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_59_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1410 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1411 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1412 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1413 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1414 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBS+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBS+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBS+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBS+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBS+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBS+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBS+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBS+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1415 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1416 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBS349
;rutinasensores_v4(mstr-slv).h,1417 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1418 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1419 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1420 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBS+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBS+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBS+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBS+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBS+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBS+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBS+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBS+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBS+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBS+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBS+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBS+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBS+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBS+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBS+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBS+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1421 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1422 :: 		}
L_entroBS349:
;rutinasensores_v4(mstr-slv).h,1423 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1424 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBS
;rutinasensores_v4(mstr-slv).h,1425 :: 		}
L_entroBS348:
;rutinasensores_v4(mstr-slv).h,1426 :: 		}
L_end_entroBS:
	RETURN      0
; end of _entroBS

_saliendoBS:

;rutinasensores_v4(mstr-slv).h,1428 :: 		short saliendoBS(short estado){
;rutinasensores_v4(mstr-slv).h,1429 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBS_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBS350
;rutinasensores_v4(mstr-slv).h,1430 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_60_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_60_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_60_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1431 :: 		if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBS1692
	BSF         R1, 3 
	GOTO        L__saliendoBS1693
L__saliendoBS1692:
	BCF         R1, 3 
L__saliendoBS1693:
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoBS1694
	BSF         R1, 0 
	GOTO        L__saliendoBS1695
L__saliendoBS1694:
	BCF         R1, 0 
L__saliendoBS1695:
	BTFSS       R1, 3 
	GOTO        L__saliendoBS1696
	BTFSS       R1, 0 
	GOTO        L__saliendoBS1696
	BSF         R1, 1 
	GOTO        L__saliendoBS1697
L__saliendoBS1696:
	BCF         R1, 1 
L__saliendoBS1697:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoBS1698
	BSF         R1, 2 
	GOTO        L__saliendoBS1699
L__saliendoBS1698:
	BCF         R1, 2 
L__saliendoBS1699:
	BTFSS       R1, 0 
	GOTO        L__saliendoBS1700
	BTFSS       R1, 2 
	GOTO        L__saliendoBS1700
	BSF         4056, 0 
	GOTO        L__saliendoBS1701
L__saliendoBS1700:
	BCF         4056, 0 
L__saliendoBS1701:
	BTFSC       R1, 1 
	GOTO        L__saliendoBS1702
	BTFSC       4056, 0 
	GOTO        L__saliendoBS1702
	BCF         R1, 1 
	GOTO        L__saliendoBS1703
L__saliendoBS1702:
	BSF         R1, 1 
L__saliendoBS1703:
	BTFSC       R1, 3 
	GOTO        L__saliendoBS1704
	BCF         R1, 0 
	GOTO        L__saliendoBS1705
L__saliendoBS1704:
	BSF         R1, 0 
L__saliendoBS1705:
	BTFSC       R1, 2 
	GOTO        L__saliendoBS1706
	BCF         4056, 0 
	GOTO        L__saliendoBS1707
L__saliendoBS1706:
	BSF         4056, 0 
L__saliendoBS1707:
	BTFSS       R1, 0 
	GOTO        L__saliendoBS1708
	BTFSS       4056, 0 
	GOTO        L__saliendoBS1708
	BSF         R1, 0 
	GOTO        L__saliendoBS1709
L__saliendoBS1708:
	BCF         R1, 0 
L__saliendoBS1709:
	BTFSC       R1, 1 
	GOTO        L__saliendoBS1710
	BTFSC       R1, 0 
	GOTO        L__saliendoBS1710
	BCF         4056, 0 
	GOTO        L__saliendoBS1711
L__saliendoBS1710:
	BSF         4056, 0 
L__saliendoBS1711:
	BTFSS       4056, 0 
	GOTO        L_saliendoBS351
;rutinasensores_v4(mstr-slv).h,1432 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1433 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBS
;rutinasensores_v4(mstr-slv).h,1434 :: 		}
L_saliendoBS351:
;rutinasensores_v4(mstr-slv).h,1435 :: 		if((SENSOR2 & SENSOR4)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoBS1712
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoBS1712
	BSF         4056, 0 
	GOTO        L__saliendoBS1713
L__saliendoBS1712:
	BCF         4056, 0 
L__saliendoBS1713:
	BTFSS       4056, 0 
	GOTO        L_saliendoBS352
;rutinasensores_v4(mstr-slv).h,1436 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1437 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBS
;rutinasensores_v4(mstr-slv).h,1438 :: 		}
L_saliendoBS352:
;rutinasensores_v4(mstr-slv).h,1439 :: 		}
L_saliendoBS350:
;rutinasensores_v4(mstr-slv).h,1440 :: 		}
L_end_saliendoBS:
	RETURN      0
; end of _saliendoBS

_transicionSBS:

;rutinasensores_v4(mstr-slv).h,1442 :: 		short transicionSBS(short estado){
;rutinasensores_v4(mstr-slv).h,1443 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBS_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBS353
;rutinasensores_v4(mstr-slv).h,1444 :: 		lcd_outConst(3, 1, "TRANSICION DEBUG");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_61_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_61_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_61_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1445 :: 		if((SENSOR2 & SENSOR4)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBS1715
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBS1715
	BSF         4056, 0 
	GOTO        L__transicionSBS1716
L__transicionSBS1715:
	BCF         4056, 0 
L__transicionSBS1716:
	BTFSS       4056, 0 
	GOTO        L_transicionSBS354
;rutinasensores_v4(mstr-slv).h,1446 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1447 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBS
;rutinasensores_v4(mstr-slv).h,1448 :: 		}
L_transicionSBS354:
;rutinasensores_v4(mstr-slv).h,1449 :: 		if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR4)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBS1717
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSBS1717
	BSF         R1, 2 
	GOTO        L__transicionSBS1718
L__transicionSBS1717:
	BCF         R1, 2 
L__transicionSBS1718:
	BTFSS       R1, 2 
	GOTO        L__transicionSBS1719
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBS1719
	BSF         R1, 0 
	GOTO        L__transicionSBS1720
L__transicionSBS1719:
	BCF         R1, 0 
L__transicionSBS1720:
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBS1721
	BSF         4056, 0 
	GOTO        L__transicionSBS1722
L__transicionSBS1721:
	BCF         4056, 0 
L__transicionSBS1722:
	BTFSS       R1, 0 
	GOTO        L__transicionSBS1723
	BTFSS       4056, 0 
	GOTO        L__transicionSBS1723
	BSF         R1, 1 
	GOTO        L__transicionSBS1724
L__transicionSBS1723:
	BCF         R1, 1 
L__transicionSBS1724:
	BTFSC       R1, 2 
	GOTO        L__transicionSBS1725
	BCF         4056, 0 
	GOTO        L__transicionSBS1726
L__transicionSBS1725:
	BSF         4056, 0 
L__transicionSBS1726:
	BTFSS       4056, 0 
	GOTO        L__transicionSBS1727
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBS1727
	BSF         R1, 0 
	GOTO        L__transicionSBS1728
L__transicionSBS1727:
	BCF         R1, 0 
L__transicionSBS1728:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBS1729
	BSF         4056, 0 
	GOTO        L__transicionSBS1730
L__transicionSBS1729:
	BCF         4056, 0 
L__transicionSBS1730:
	BTFSS       R1, 0 
	GOTO        L__transicionSBS1731
	BTFSS       4056, 0 
	GOTO        L__transicionSBS1731
	BSF         R1, 0 
	GOTO        L__transicionSBS1732
L__transicionSBS1731:
	BCF         R1, 0 
L__transicionSBS1732:
	BTFSC       R1, 1 
	GOTO        L__transicionSBS1733
	BTFSC       R1, 0 
	GOTO        L__transicionSBS1733
	BCF         4056, 0 
	GOTO        L__transicionSBS1734
L__transicionSBS1733:
	BSF         4056, 0 
L__transicionSBS1734:
	BTFSS       4056, 0 
	GOTO        L_transicionSBS355
;rutinasensores_v4(mstr-slv).h,1450 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1451 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBS
;rutinasensores_v4(mstr-slv).h,1452 :: 		}
L_transicionSBS355:
;rutinasensores_v4(mstr-slv).h,1453 :: 		}
L_transicionSBS353:
;rutinasensores_v4(mstr-slv).h,1454 :: 		}
L_end_transicionSBS:
	RETURN      0
; end of _transicionSBS

_transicionSalBS:

;rutinasensores_v4(mstr-slv).h,1456 :: 		short transicionSalBS(short estado){
;rutinasensores_v4(mstr-slv).h,1457 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBS_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBS356
;rutinasensores_v4(mstr-slv).h,1458 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_62_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_62_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_62_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1459 :: 		if(!SENSOR2 & !SENSOR4){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBS1736
	BSF         R1, 0 
	GOTO        L__transicionSalBS1737
L__transicionSalBS1736:
	BCF         R1, 0 
L__transicionSalBS1737:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBS1738
	BSF         4056, 0 
	GOTO        L__transicionSalBS1739
L__transicionSalBS1738:
	BCF         4056, 0 
L__transicionSalBS1739:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBS1740
	BTFSS       4056, 0 
	GOTO        L__transicionSalBS1740
	BSF         R1, 0 
	GOTO        L__transicionSalBS1741
L__transicionSalBS1740:
	BCF         R1, 0 
L__transicionSalBS1741:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBS357
;rutinasensores_v4(mstr-slv).h,1460 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1461 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBS
;rutinasensores_v4(mstr-slv).h,1462 :: 		}
L_transicionSalBS357:
;rutinasensores_v4(mstr-slv).h,1463 :: 		if((SENSOR1 & SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBS1742
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalBS1742
	BSF         4056, 0 
	GOTO        L__transicionSalBS1743
L__transicionSalBS1742:
	BCF         4056, 0 
L__transicionSalBS1743:
	BTFSS       4056, 0 
	GOTO        L__transicionSalBS1744
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBS1744
	BSF         R1, 0 
	GOTO        L__transicionSalBS1745
L__transicionSalBS1744:
	BCF         R1, 0 
L__transicionSalBS1745:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBS358
;rutinasensores_v4(mstr-slv).h,1464 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1465 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBS
;rutinasensores_v4(mstr-slv).h,1466 :: 		}
L_transicionSalBS358:
;rutinasensores_v4(mstr-slv).h,1467 :: 		}
L_transicionSalBS356:
;rutinasensores_v4(mstr-slv).h,1468 :: 		}
L_end_transicionSalBS:
	RETURN      0
; end of _transicionSalBS

_salioBS:

;rutinasensores_v4(mstr-slv).h,1470 :: 		short salioBS(short estado){
;rutinasensores_v4(mstr-slv).h,1471 :: 		if(estado == SALIO){
	MOVF        FARG_salioBS_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBS359
;rutinasensores_v4(mstr-slv).h,1472 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_63_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_63_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_63_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1473 :: 		pSuben = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1474 :: 		pBajan = eepromLeeNumero(0x0003, 2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1475 :: 		eepromEscribeNumero(0x0003 ,pBajan, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1476 :: 		pBajan = eepromLeeNumero(0x0003, 2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBS+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBS+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBS+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBS+7 
	MOVF        FLOC__salioBS+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBS+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1477 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBS+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBS+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBS+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBS+3 
	MOVF        FLOC__salioBS+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBS+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBS+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBS+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBS+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBS+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1478 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1479 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBS360
;rutinasensores_v4(mstr-slv).h,1480 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1481 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1482 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1483 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBS+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBS+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBS+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBS+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBS+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBS+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBS+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBS+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBS+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBS+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBS+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBS+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBS+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBS+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBS+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBS+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1484 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1485 :: 		}
L_salioBS360:
;rutinasensores_v4(mstr-slv).h,1486 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1487 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBS
;rutinasensores_v4(mstr-slv).h,1488 :: 		}
L_salioBS359:
;rutinasensores_v4(mstr-slv).h,1489 :: 		}
L_end_salioBS:
	RETURN      0
; end of _salioBS

_esperaBP1:

;rutinasensores_v4(mstr-slv).h,1495 :: 		short esperaBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1496 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBP1_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBP1361
;rutinasensores_v4(mstr-slv).h,1497 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,1499 :: 		if((!SENSOR3 | !SENSOR5)){
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaBP11748
	BSF         R1, 0 
	GOTO        L__esperaBP11749
L__esperaBP11748:
	BCF         R1, 0 
L__esperaBP11749:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaBP11750
	BSF         4056, 0 
	GOTO        L__esperaBP11751
L__esperaBP11750:
	BCF         4056, 0 
L__esperaBP11751:
	BTFSC       R1, 0 
	GOTO        L__esperaBP11752
	BTFSC       4056, 0 
	GOTO        L__esperaBP11752
	BCF         R1, 0 
	GOTO        L__esperaBP11753
L__esperaBP11752:
	BSF         R1, 0 
L__esperaBP11753:
	BTFSS       R1, 0 
	GOTO        L_esperaBP1362
;rutinasensores_v4(mstr-slv).h,1500 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1501 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBP1
;rutinasensores_v4(mstr-slv).h,1502 :: 		}
L_esperaBP1362:
;rutinasensores_v4(mstr-slv).h,1503 :: 		if((!SENSOR4 | !SENSOR6)){
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaBP11754
	BSF         R1, 0 
	GOTO        L__esperaBP11755
L__esperaBP11754:
	BCF         R1, 0 
L__esperaBP11755:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaBP11756
	BSF         4056, 0 
	GOTO        L__esperaBP11757
L__esperaBP11756:
	BCF         4056, 0 
L__esperaBP11757:
	BTFSC       R1, 0 
	GOTO        L__esperaBP11758
	BTFSC       4056, 0 
	GOTO        L__esperaBP11758
	BCF         R1, 0 
	GOTO        L__esperaBP11759
L__esperaBP11758:
	BSF         R1, 0 
L__esperaBP11759:
	BTFSS       R1, 0 
	GOTO        L_esperaBP1363
;rutinasensores_v4(mstr-slv).h,1504 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1505 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBP1
;rutinasensores_v4(mstr-slv).h,1506 :: 		}
L_esperaBP1363:
;rutinasensores_v4(mstr-slv).h,1507 :: 		}
L_esperaBP1361:
;rutinasensores_v4(mstr-slv).h,1508 :: 		}
L_end_esperaBP1:
	RETURN      0
; end of _esperaBP1

_entrandoBP1:

;rutinasensores_v4(mstr-slv).h,1510 :: 		short entrandoBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1511 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBP1_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBP1364
;rutinasensores_v4(mstr-slv).h,1512 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_64_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_64_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_64_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1513 :: 		if((SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoBP11761
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoBP11761
	BSF         4056, 0 
	GOTO        L__entrandoBP11762
L__entrandoBP11761:
	BCF         4056, 0 
L__entrandoBP11762:
	BTFSS       4056, 0 
	GOTO        L_entrandoBP1365
;rutinasensores_v4(mstr-slv).h,1514 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1515 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBP1
;rutinasensores_v4(mstr-slv).h,1516 :: 		}
L_entrandoBP1365:
;rutinasensores_v4(mstr-slv).h,1517 :: 		if((!SENSOR4 & !SENSOR6)){
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoBP11763
	BSF         R1, 0 
	GOTO        L__entrandoBP11764
L__entrandoBP11763:
	BCF         R1, 0 
L__entrandoBP11764:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoBP11765
	BSF         4056, 0 
	GOTO        L__entrandoBP11766
L__entrandoBP11765:
	BCF         4056, 0 
L__entrandoBP11766:
	BTFSS       R1, 0 
	GOTO        L__entrandoBP11767
	BTFSS       4056, 0 
	GOTO        L__entrandoBP11767
	BSF         R1, 0 
	GOTO        L__entrandoBP11768
L__entrandoBP11767:
	BCF         R1, 0 
L__entrandoBP11768:
	BTFSS       R1, 0 
	GOTO        L_entrandoBP1366
;rutinasensores_v4(mstr-slv).h,1518 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1519 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBP1
;rutinasensores_v4(mstr-slv).h,1520 :: 		}
L_entrandoBP1366:
;rutinasensores_v4(mstr-slv).h,1521 :: 		}
L_entrandoBP1364:
;rutinasensores_v4(mstr-slv).h,1522 :: 		}
L_end_entrandoBP1:
	RETURN      0
; end of _entrandoBP1

_transicionEBP1:

;rutinasensores_v4(mstr-slv).h,1524 :: 		short transicionEBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1525 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBP1_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBP1367
;rutinasensores_v4(mstr-slv).h,1526 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_65_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_65_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_65_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1527 :: 		if((SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBP11770
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBP11770
	BSF         4056, 0 
	GOTO        L__transicionEBP11771
L__transicionEBP11770:
	BCF         4056, 0 
L__transicionEBP11771:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP1368
;rutinasensores_v4(mstr-slv).h,1528 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1529 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBP1
;rutinasensores_v4(mstr-slv).h,1530 :: 		}
L_transicionEBP1368:
;rutinasensores_v4(mstr-slv).h,1531 :: 		if((SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR4 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEBP11772
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP11772
	BSF         R1, 0 
	GOTO        L__transicionEBP11773
L__transicionEBP11772:
	BCF         R1, 0 
L__transicionEBP11773:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBP11774
	BSF         4056, 0 
	GOTO        L__transicionEBP11775
L__transicionEBP11774:
	BCF         4056, 0 
L__transicionEBP11775:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP11776
	BTFSS       4056, 0 
	GOTO        L__transicionEBP11776
	BSF         R1, 1 
	GOTO        L__transicionEBP11777
L__transicionEBP11776:
	BCF         R1, 1 
L__transicionEBP11777:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBP11778
	BSF         4056, 0 
	GOTO        L__transicionEBP11779
L__transicionEBP11778:
	BCF         4056, 0 
L__transicionEBP11779:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP11780
	BTFSS       4056, 0 
	GOTO        L__transicionEBP11780
	BSF         R1, 0 
	GOTO        L__transicionEBP11781
L__transicionEBP11780:
	BCF         R1, 0 
L__transicionEBP11781:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP11782
	BTFSC       R1, 0 
	GOTO        L__transicionEBP11782
	BCF         4056, 0 
	GOTO        L__transicionEBP11783
L__transicionEBP11782:
	BSF         4056, 0 
L__transicionEBP11783:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP1369
;rutinasensores_v4(mstr-slv).h,1532 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1533 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBP1
;rutinasensores_v4(mstr-slv).h,1534 :: 		}
L_transicionEBP1369:
;rutinasensores_v4(mstr-slv).h,1535 :: 		}
L_transicionEBP1367:
;rutinasensores_v4(mstr-slv).h,1536 :: 		}
L_end_transicionEBP1:
	RETURN      0
; end of _transicionEBP1

_transicionEntBP1:

;rutinasensores_v4(mstr-slv).h,1538 :: 		short transicionEntBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1539 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBP1_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBP1370
;rutinasensores_v4(mstr-slv).h,1540 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_66_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_66_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_66_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1541 :: 		if((!SENSOR3 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntBP11785
	BSF         R1, 0 
	GOTO        L__transicionEntBP11786
L__transicionEntBP11785:
	BCF         R1, 0 
L__transicionEntBP11786:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntBP11787
	BSF         4056, 0 
	GOTO        L__transicionEntBP11788
L__transicionEntBP11787:
	BCF         4056, 0 
L__transicionEntBP11788:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBP11789
	BTFSS       4056, 0 
	GOTO        L__transicionEntBP11789
	BSF         R1, 0 
	GOTO        L__transicionEntBP11790
L__transicionEntBP11789:
	BCF         R1, 0 
L__transicionEntBP11790:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBP1371
;rutinasensores_v4(mstr-slv).h,1542 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1543 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBP1
;rutinasensores_v4(mstr-slv).h,1544 :: 		}
L_transicionEntBP1371:
;rutinasensores_v4(mstr-slv).h,1545 :: 		if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR4 & SENSOR6)){
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntBP11791
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBP11791
	BSF         4056, 0 
	GOTO        L__transicionEntBP11792
L__transicionEntBP11791:
	BCF         4056, 0 
L__transicionEntBP11792:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBP1372
;rutinasensores_v4(mstr-slv).h,1546 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1547 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBP1
;rutinasensores_v4(mstr-slv).h,1548 :: 		}
L_transicionEntBP1372:
;rutinasensores_v4(mstr-slv).h,1549 :: 		}
L_transicionEntBP1370:
;rutinasensores_v4(mstr-slv).h,1550 :: 		}
L_end_transicionEntBP1:
	RETURN      0
; end of _transicionEntBP1

_entroBP1:

;rutinasensores_v4(mstr-slv).h,1552 :: 		short entroBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1553 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBP1_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBP1373
;rutinasensores_v4(mstr-slv).h,1554 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_67_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_67_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_67_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1555 :: 		delay_ms(350);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_entroBP1374:
	DECFSZ      R13, 1, 1
	BRA         L_entroBP1374
	DECFSZ      R12, 1, 1
	BRA         L_entroBP1374
	DECFSZ      R11, 1, 1
	BRA         L_entroBP1374
	NOP
;rutinasensores_v4(mstr-slv).h,1556 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1557 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1558 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1559 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1560 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP1+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP1+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP1+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP1+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBP1+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBP1+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBP1+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBP1+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1561 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1562 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBP1375
;rutinasensores_v4(mstr-slv).h,1563 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1564 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1565 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1566 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP1+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP1+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP1+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP1+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP1+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP1+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP1+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP1+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP1+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP1+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP1+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP1+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP1+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP1+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP1+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP1+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1567 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1568 :: 		}
L_entroBP1375:
;rutinasensores_v4(mstr-slv).h,1569 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1570 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBP1
;rutinasensores_v4(mstr-slv).h,1571 :: 		}
L_entroBP1373:
;rutinasensores_v4(mstr-slv).h,1572 :: 		}
L_end_entroBP1:
	RETURN      0
; end of _entroBP1

_saliendoBP1:

;rutinasensores_v4(mstr-slv).h,1574 :: 		short saliendoBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1575 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBP1_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBP1376
;rutinasensores_v4(mstr-slv).h,1576 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_68_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_68_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_68_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1577 :: 		if((!SENSOR3 & !SENSOR5)){
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoBP11795
	BSF         R1, 0 
	GOTO        L__saliendoBP11796
L__saliendoBP11795:
	BCF         R1, 0 
L__saliendoBP11796:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoBP11797
	BSF         4056, 0 
	GOTO        L__saliendoBP11798
L__saliendoBP11797:
	BCF         4056, 0 
L__saliendoBP11798:
	BTFSS       R1, 0 
	GOTO        L__saliendoBP11799
	BTFSS       4056, 0 
	GOTO        L__saliendoBP11799
	BSF         R1, 0 
	GOTO        L__saliendoBP11800
L__saliendoBP11799:
	BCF         R1, 0 
L__saliendoBP11800:
	BTFSS       R1, 0 
	GOTO        L_saliendoBP1377
;rutinasensores_v4(mstr-slv).h,1578 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1579 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBP1
;rutinasensores_v4(mstr-slv).h,1580 :: 		}
L_saliendoBP1377:
;rutinasensores_v4(mstr-slv).h,1581 :: 		if((SENSOR4 & SENSOR6)){
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoBP11801
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoBP11801
	BSF         4056, 0 
	GOTO        L__saliendoBP11802
L__saliendoBP11801:
	BCF         4056, 0 
L__saliendoBP11802:
	BTFSS       4056, 0 
	GOTO        L_saliendoBP1378
;rutinasensores_v4(mstr-slv).h,1582 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1583 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBP1
;rutinasensores_v4(mstr-slv).h,1584 :: 		}
L_saliendoBP1378:
;rutinasensores_v4(mstr-slv).h,1585 :: 		}
L_saliendoBP1376:
;rutinasensores_v4(mstr-slv).h,1586 :: 		}
L_end_saliendoBP1:
	RETURN      0
; end of _saliendoBP1

_transicionSBP1:

;rutinasensores_v4(mstr-slv).h,1588 :: 		short transicionSBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1589 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBP1_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBP1379
;rutinasensores_v4(mstr-slv).h,1590 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_69_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_69_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_69_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1591 :: 		if((SENSOR4 & SENSOR6)){
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBP11804
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBP11804
	BSF         4056, 0 
	GOTO        L__transicionSBP11805
L__transicionSBP11804:
	BCF         4056, 0 
L__transicionSBP11805:
	BTFSS       4056, 0 
	GOTO        L_transicionSBP1380
;rutinasensores_v4(mstr-slv).h,1592 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1593 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBP1
;rutinasensores_v4(mstr-slv).h,1594 :: 		}
L_transicionSBP1380:
;rutinasensores_v4(mstr-slv).h,1595 :: 		if((SENSOR3 & SENSOR5 & !SENSOR4) | (SENSOR3 & SENSOR5 & !SENSOR6)){
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSBP11806
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBP11806
	BSF         R1, 0 
	GOTO        L__transicionSBP11807
L__transicionSBP11806:
	BCF         R1, 0 
L__transicionSBP11807:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBP11808
	BSF         4056, 0 
	GOTO        L__transicionSBP11809
L__transicionSBP11808:
	BCF         4056, 0 
L__transicionSBP11809:
	BTFSS       R1, 0 
	GOTO        L__transicionSBP11810
	BTFSS       4056, 0 
	GOTO        L__transicionSBP11810
	BSF         R1, 1 
	GOTO        L__transicionSBP11811
L__transicionSBP11810:
	BCF         R1, 1 
L__transicionSBP11811:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBP11812
	BSF         4056, 0 
	GOTO        L__transicionSBP11813
L__transicionSBP11812:
	BCF         4056, 0 
L__transicionSBP11813:
	BTFSS       R1, 0 
	GOTO        L__transicionSBP11814
	BTFSS       4056, 0 
	GOTO        L__transicionSBP11814
	BSF         R1, 0 
	GOTO        L__transicionSBP11815
L__transicionSBP11814:
	BCF         R1, 0 
L__transicionSBP11815:
	BTFSC       R1, 1 
	GOTO        L__transicionSBP11816
	BTFSC       R1, 0 
	GOTO        L__transicionSBP11816
	BCF         4056, 0 
	GOTO        L__transicionSBP11817
L__transicionSBP11816:
	BSF         4056, 0 
L__transicionSBP11817:
	BTFSS       4056, 0 
	GOTO        L_transicionSBP1381
;rutinasensores_v4(mstr-slv).h,1596 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1597 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBP1
;rutinasensores_v4(mstr-slv).h,1598 :: 		}
L_transicionSBP1381:
;rutinasensores_v4(mstr-slv).h,1599 :: 		}
L_transicionSBP1379:
;rutinasensores_v4(mstr-slv).h,1600 :: 		}
L_end_transicionSBP1:
	RETURN      0
; end of _transicionSBP1

_transicionSalBP1:

;rutinasensores_v4(mstr-slv).h,1602 :: 		short transicionSalBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1603 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBP1_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBP1382
;rutinasensores_v4(mstr-slv).h,1604 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_70_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_70_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_70_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1605 :: 		if(!SENSOR4 & !SENSOR6){
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBP11819
	BSF         R1, 0 
	GOTO        L__transicionSalBP11820
L__transicionSalBP11819:
	BCF         R1, 0 
L__transicionSalBP11820:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBP11821
	BSF         4056, 0 
	GOTO        L__transicionSalBP11822
L__transicionSalBP11821:
	BCF         4056, 0 
L__transicionSalBP11822:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBP11823
	BTFSS       4056, 0 
	GOTO        L__transicionSalBP11823
	BSF         R1, 0 
	GOTO        L__transicionSalBP11824
L__transicionSalBP11823:
	BCF         R1, 0 
L__transicionSalBP11824:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBP1383
;rutinasensores_v4(mstr-slv).h,1606 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1607 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBP1
;rutinasensores_v4(mstr-slv).h,1608 :: 		}
L_transicionSalBP1383:
;rutinasensores_v4(mstr-slv).h,1609 :: 		if((SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalBP11825
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBP11825
	BSF         4056, 0 
	GOTO        L__transicionSalBP11826
L__transicionSalBP11825:
	BCF         4056, 0 
L__transicionSalBP11826:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBP1384
;rutinasensores_v4(mstr-slv).h,1610 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1611 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBP1
;rutinasensores_v4(mstr-slv).h,1612 :: 		}
L_transicionSalBP1384:
;rutinasensores_v4(mstr-slv).h,1613 :: 		}
L_transicionSalBP1382:
;rutinasensores_v4(mstr-slv).h,1614 :: 		}
L_end_transicionSalBP1:
	RETURN      0
; end of _transicionSalBP1

_salioBP1:

;rutinasensores_v4(mstr-slv).h,1616 :: 		short salioBP1(short estado){
;rutinasensores_v4(mstr-slv).h,1617 :: 		if(estado == SALIO){
	MOVF        FARG_salioBP1_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBP1385
;rutinasensores_v4(mstr-slv).h,1618 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_71_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_71_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_71_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1619 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1620 :: 		pBajan = eepromLeeNumero(0x0003,2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1621 :: 		eepromEscribeNumero(0x0003,pBajan,2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1622 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP1+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP1+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP1+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP1+7 
	MOVF        FLOC__salioBP1+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBP1+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1623 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP1+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP1+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP1+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP1+3 
	MOVF        FLOC__salioBP1+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBP1+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBP1+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBP1+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBP1+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBP1+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1624 :: 		eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Longint+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVF        R2, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVF        R3, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1625 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBP1386
;rutinasensores_v4(mstr-slv).h,1626 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1627 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1628 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1629 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP1+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP1+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP1+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP1+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP1+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP1+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP1+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP1+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP1+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP1+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP1+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP1+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP1+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP1+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP1+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP1+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1630 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1631 :: 		}
L_salioBP1386:
;rutinasensores_v4(mstr-slv).h,1632 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1633 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBP1
;rutinasensores_v4(mstr-slv).h,1634 :: 		}
L_salioBP1385:
;rutinasensores_v4(mstr-slv).h,1635 :: 		}
L_end_salioBP1:
	RETURN      0
; end of _salioBP1

_esperaBP2:

;rutinasensores_v4(mstr-slv).h,1641 :: 		short esperaBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1642 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBP2_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBP2387
;rutinasensores_v4(mstr-slv).h,1644 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,1646 :: 		if((!SENSOR1 | !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBP21829
	BSF         R1, 0 
	GOTO        L__esperaBP21830
L__esperaBP21829:
	BCF         R1, 0 
L__esperaBP21830:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaBP21831
	BSF         4056, 0 
	GOTO        L__esperaBP21832
L__esperaBP21831:
	BCF         4056, 0 
L__esperaBP21832:
	BTFSC       R1, 0 
	GOTO        L__esperaBP21833
	BTFSC       4056, 0 
	GOTO        L__esperaBP21833
	BCF         R1, 0 
	GOTO        L__esperaBP21834
L__esperaBP21833:
	BSF         R1, 0 
L__esperaBP21834:
	BTFSS       R1, 0 
	GOTO        L_esperaBP2388
;rutinasensores_v4(mstr-slv).h,1647 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1648 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBP2
;rutinasensores_v4(mstr-slv).h,1649 :: 		}
L_esperaBP2388:
;rutinasensores_v4(mstr-slv).h,1650 :: 		if((!SENSOR2 | !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaBP21835
	BSF         R1, 0 
	GOTO        L__esperaBP21836
L__esperaBP21835:
	BCF         R1, 0 
L__esperaBP21836:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaBP21837
	BSF         4056, 0 
	GOTO        L__esperaBP21838
L__esperaBP21837:
	BCF         4056, 0 
L__esperaBP21838:
	BTFSC       R1, 0 
	GOTO        L__esperaBP21839
	BTFSC       4056, 0 
	GOTO        L__esperaBP21839
	BCF         R1, 0 
	GOTO        L__esperaBP21840
L__esperaBP21839:
	BSF         R1, 0 
L__esperaBP21840:
	BTFSS       R1, 0 
	GOTO        L_esperaBP2389
;rutinasensores_v4(mstr-slv).h,1651 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1652 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBP2
;rutinasensores_v4(mstr-slv).h,1653 :: 		}
L_esperaBP2389:
;rutinasensores_v4(mstr-slv).h,1654 :: 		}
L_esperaBP2387:
;rutinasensores_v4(mstr-slv).h,1655 :: 		}
L_end_esperaBP2:
	RETURN      0
; end of _esperaBP2

_entrandoBP2:

;rutinasensores_v4(mstr-slv).h,1657 :: 		short entrandoBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1658 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBP2_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBP2390
;rutinasensores_v4(mstr-slv).h,1659 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_72_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_72_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_72_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1660 :: 		if((SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBP21842
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoBP21842
	BSF         4056, 0 
	GOTO        L__entrandoBP21843
L__entrandoBP21842:
	BCF         4056, 0 
L__entrandoBP21843:
	BTFSS       4056, 0 
	GOTO        L_entrandoBP2391
;rutinasensores_v4(mstr-slv).h,1661 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1662 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBP2
;rutinasensores_v4(mstr-slv).h,1663 :: 		}
L_entrandoBP2391:
;rutinasensores_v4(mstr-slv).h,1664 :: 		if((!SENSOR2 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoBP21844
	BSF         R1, 0 
	GOTO        L__entrandoBP21845
L__entrandoBP21844:
	BCF         R1, 0 
L__entrandoBP21845:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoBP21846
	BSF         4056, 0 
	GOTO        L__entrandoBP21847
L__entrandoBP21846:
	BCF         4056, 0 
L__entrandoBP21847:
	BTFSS       R1, 0 
	GOTO        L__entrandoBP21848
	BTFSS       4056, 0 
	GOTO        L__entrandoBP21848
	BSF         R1, 0 
	GOTO        L__entrandoBP21849
L__entrandoBP21848:
	BCF         R1, 0 
L__entrandoBP21849:
	BTFSS       R1, 0 
	GOTO        L_entrandoBP2392
;rutinasensores_v4(mstr-slv).h,1665 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1666 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBP2
;rutinasensores_v4(mstr-slv).h,1667 :: 		}
L_entrandoBP2392:
;rutinasensores_v4(mstr-slv).h,1668 :: 		}
L_entrandoBP2390:
;rutinasensores_v4(mstr-slv).h,1669 :: 		}
L_end_entrandoBP2:
	RETURN      0
; end of _entrandoBP2

_transicionEBP2:

;rutinasensores_v4(mstr-slv).h,1671 :: 		short transicionEBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1672 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBP2_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBP2393
;rutinasensores_v4(mstr-slv).h,1673 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_73_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_73_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_73_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1674 :: 		if((SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBP21851
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBP21851
	BSF         4056, 0 
	GOTO        L__transicionEBP21852
L__transicionEBP21851:
	BCF         4056, 0 
L__transicionEBP21852:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP2394
;rutinasensores_v4(mstr-slv).h,1675 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1676 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBP2
;rutinasensores_v4(mstr-slv).h,1677 :: 		}
L_transicionEBP2394:
;rutinasensores_v4(mstr-slv).h,1678 :: 		if((SENSOR2 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBP21853
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP21853
	BSF         R1, 0 
	GOTO        L__transicionEBP21854
L__transicionEBP21853:
	BCF         R1, 0 
L__transicionEBP21854:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBP21855
	BSF         4056, 0 
	GOTO        L__transicionEBP21856
L__transicionEBP21855:
	BCF         4056, 0 
L__transicionEBP21856:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP21857
	BTFSS       4056, 0 
	GOTO        L__transicionEBP21857
	BSF         R1, 1 
	GOTO        L__transicionEBP21858
L__transicionEBP21857:
	BCF         R1, 1 
L__transicionEBP21858:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBP21859
	BSF         4056, 0 
	GOTO        L__transicionEBP21860
L__transicionEBP21859:
	BCF         4056, 0 
L__transicionEBP21860:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP21861
	BTFSS       4056, 0 
	GOTO        L__transicionEBP21861
	BSF         R1, 0 
	GOTO        L__transicionEBP21862
L__transicionEBP21861:
	BCF         R1, 0 
L__transicionEBP21862:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP21863
	BTFSC       R1, 0 
	GOTO        L__transicionEBP21863
	BCF         4056, 0 
	GOTO        L__transicionEBP21864
L__transicionEBP21863:
	BSF         4056, 0 
L__transicionEBP21864:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP2395
;rutinasensores_v4(mstr-slv).h,1679 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1680 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBP2
;rutinasensores_v4(mstr-slv).h,1681 :: 		}
L_transicionEBP2395:
;rutinasensores_v4(mstr-slv).h,1682 :: 		}
L_transicionEBP2393:
;rutinasensores_v4(mstr-slv).h,1683 :: 		}
L_end_transicionEBP2:
	RETURN      0
; end of _transicionEBP2

_transicionEntBP2:

;rutinasensores_v4(mstr-slv).h,1685 :: 		short transicionEntBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1686 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBP2_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBP2396
;rutinasensores_v4(mstr-slv).h,1687 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_74_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_74_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_74_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1688 :: 		if((!SENSOR1 & !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBP21866
	BSF         R1, 0 
	GOTO        L__transicionEntBP21867
L__transicionEntBP21866:
	BCF         R1, 0 
L__transicionEntBP21867:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntBP21868
	BSF         4056, 0 
	GOTO        L__transicionEntBP21869
L__transicionEntBP21868:
	BCF         4056, 0 
L__transicionEntBP21869:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBP21870
	BTFSS       4056, 0 
	GOTO        L__transicionEntBP21870
	BSF         R1, 0 
	GOTO        L__transicionEntBP21871
L__transicionEntBP21870:
	BCF         R1, 0 
L__transicionEntBP21871:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBP2397
;rutinasensores_v4(mstr-slv).h,1689 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1690 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBP2
;rutinasensores_v4(mstr-slv).h,1691 :: 		}
L_transicionEntBP2397:
;rutinasensores_v4(mstr-slv).h,1692 :: 		if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBP21872
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBP21872
	BSF         4056, 0 
	GOTO        L__transicionEntBP21873
L__transicionEntBP21872:
	BCF         4056, 0 
L__transicionEntBP21873:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBP2398
;rutinasensores_v4(mstr-slv).h,1693 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1694 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBP2
;rutinasensores_v4(mstr-slv).h,1695 :: 		}
L_transicionEntBP2398:
;rutinasensores_v4(mstr-slv).h,1696 :: 		}
L_transicionEntBP2396:
;rutinasensores_v4(mstr-slv).h,1697 :: 		}
L_end_transicionEntBP2:
	RETURN      0
; end of _transicionEntBP2

_entroBP2:

;rutinasensores_v4(mstr-slv).h,1699 :: 		short entroBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1700 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBP2_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBP2399
;rutinasensores_v4(mstr-slv).h,1701 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_75_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_75_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_75_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1702 :: 		delay_ms(350);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_entroBP2400:
	DECFSZ      R13, 1, 1
	BRA         L_entroBP2400
	DECFSZ      R12, 1, 1
	BRA         L_entroBP2400
	DECFSZ      R11, 1, 1
	BRA         L_entroBP2400
	NOP
;rutinasensores_v4(mstr-slv).h,1703 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1704 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1705 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1706 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1707 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP2+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP2+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP2+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP2+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBP2+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBP2+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBP2+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBP2+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1708 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1709 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBP2401
;rutinasensores_v4(mstr-slv).h,1710 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1711 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1712 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1713 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP2+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP2+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP2+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP2+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP2+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP2+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP2+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP2+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP2+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP2+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP2+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP2+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP2+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP2+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP2+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP2+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1714 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1715 :: 		}
L_entroBP2401:
;rutinasensores_v4(mstr-slv).h,1716 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1717 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBP2
;rutinasensores_v4(mstr-slv).h,1718 :: 		}
L_entroBP2399:
;rutinasensores_v4(mstr-slv).h,1719 :: 		}
L_end_entroBP2:
	RETURN      0
; end of _entroBP2

_saliendoBP2:

;rutinasensores_v4(mstr-slv).h,1721 :: 		short saliendoBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1722 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBP2_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBP2402
;rutinasensores_v4(mstr-slv).h,1723 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_76_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_76_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_76_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1724 :: 		if((!SENSOR1 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBP21876
	BSF         R1, 0 
	GOTO        L__saliendoBP21877
L__saliendoBP21876:
	BCF         R1, 0 
L__saliendoBP21877:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoBP21878
	BSF         4056, 0 
	GOTO        L__saliendoBP21879
L__saliendoBP21878:
	BCF         4056, 0 
L__saliendoBP21879:
	BTFSS       R1, 0 
	GOTO        L__saliendoBP21880
	BTFSS       4056, 0 
	GOTO        L__saliendoBP21880
	BSF         R1, 0 
	GOTO        L__saliendoBP21881
L__saliendoBP21880:
	BCF         R1, 0 
L__saliendoBP21881:
	BTFSS       R1, 0 
	GOTO        L_saliendoBP2403
;rutinasensores_v4(mstr-slv).h,1725 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1726 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBP2
;rutinasensores_v4(mstr-slv).h,1727 :: 		}
L_saliendoBP2403:
;rutinasensores_v4(mstr-slv).h,1728 :: 		if((SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoBP21882
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoBP21882
	BSF         4056, 0 
	GOTO        L__saliendoBP21883
L__saliendoBP21882:
	BCF         4056, 0 
L__saliendoBP21883:
	BTFSS       4056, 0 
	GOTO        L_saliendoBP2404
;rutinasensores_v4(mstr-slv).h,1729 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1730 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBP2
;rutinasensores_v4(mstr-slv).h,1731 :: 		}
L_saliendoBP2404:
;rutinasensores_v4(mstr-slv).h,1732 :: 		}
L_saliendoBP2402:
;rutinasensores_v4(mstr-slv).h,1733 :: 		}
L_end_saliendoBP2:
	RETURN      0
; end of _saliendoBP2

_transicionSBP2:

;rutinasensores_v4(mstr-slv).h,1735 :: 		short transicionSBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1736 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBP2_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBP2405
;rutinasensores_v4(mstr-slv).h,1737 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_77_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_77_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_77_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1738 :: 		if((SENSOR2 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBP21885
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBP21885
	BSF         4056, 0 
	GOTO        L__transicionSBP21886
L__transicionSBP21885:
	BCF         4056, 0 
L__transicionSBP21886:
	BTFSS       4056, 0 
	GOTO        L_transicionSBP2406
;rutinasensores_v4(mstr-slv).h,1739 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1740 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBP2
;rutinasensores_v4(mstr-slv).h,1741 :: 		}
L_transicionSBP2406:
;rutinasensores_v4(mstr-slv).h,1742 :: 		if((SENSOR1 & SENSOR5 & !SENSOR2) | (SENSOR1 & SENSOR5 & !SENSOR4) | (SENSOR1 & SENSOR5 & !SENSOR6)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBP21887
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBP21887
	BSF         R1, 2 
	GOTO        L__transicionSBP21888
L__transicionSBP21887:
	BCF         R1, 2 
L__transicionSBP21888:
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBP21889
	BSF         4056, 0 
	GOTO        L__transicionSBP21890
L__transicionSBP21889:
	BCF         4056, 0 
L__transicionSBP21890:
	BTFSS       R1, 2 
	GOTO        L__transicionSBP21891
	BTFSS       4056, 0 
	GOTO        L__transicionSBP21891
	BSF         R1, 1 
	GOTO        L__transicionSBP21892
L__transicionSBP21891:
	BCF         R1, 1 
L__transicionSBP21892:
	BTFSC       R1, 2 
	GOTO        L__transicionSBP21893
	BCF         R1, 0 
	GOTO        L__transicionSBP21894
L__transicionSBP21893:
	BSF         R1, 0 
L__transicionSBP21894:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBP21895
	BSF         4056, 0 
	GOTO        L__transicionSBP21896
L__transicionSBP21895:
	BCF         4056, 0 
L__transicionSBP21896:
	BTFSS       R1, 0 
	GOTO        L__transicionSBP21897
	BTFSS       4056, 0 
	GOTO        L__transicionSBP21897
	BSF         R1, 0 
	GOTO        L__transicionSBP21898
L__transicionSBP21897:
	BCF         R1, 0 
L__transicionSBP21898:
	BTFSC       R1, 1 
	GOTO        L__transicionSBP21899
	BTFSC       R1, 0 
	GOTO        L__transicionSBP21899
	BCF         R1, 1 
	GOTO        L__transicionSBP21900
L__transicionSBP21899:
	BSF         R1, 1 
L__transicionSBP21900:
	BTFSC       R1, 2 
	GOTO        L__transicionSBP21901
	BCF         R1, 0 
	GOTO        L__transicionSBP21902
L__transicionSBP21901:
	BSF         R1, 0 
L__transicionSBP21902:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBP21903
	BSF         4056, 0 
	GOTO        L__transicionSBP21904
L__transicionSBP21903:
	BCF         4056, 0 
L__transicionSBP21904:
	BTFSS       R1, 0 
	GOTO        L__transicionSBP21905
	BTFSS       4056, 0 
	GOTO        L__transicionSBP21905
	BSF         R1, 0 
	GOTO        L__transicionSBP21906
L__transicionSBP21905:
	BCF         R1, 0 
L__transicionSBP21906:
	BTFSC       R1, 1 
	GOTO        L__transicionSBP21907
	BTFSC       R1, 0 
	GOTO        L__transicionSBP21907
	BCF         4056, 0 
	GOTO        L__transicionSBP21908
L__transicionSBP21907:
	BSF         4056, 0 
L__transicionSBP21908:
	BTFSS       4056, 0 
	GOTO        L_transicionSBP2407
;rutinasensores_v4(mstr-slv).h,1743 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1744 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBP2
;rutinasensores_v4(mstr-slv).h,1745 :: 		}
L_transicionSBP2407:
;rutinasensores_v4(mstr-slv).h,1746 :: 		}
L_transicionSBP2405:
;rutinasensores_v4(mstr-slv).h,1747 :: 		}
L_end_transicionSBP2:
	RETURN      0
; end of _transicionSBP2

_transicionSalBP2:

;rutinasensores_v4(mstr-slv).h,1749 :: 		short transicionSalBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1750 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBP2_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBP2408
;rutinasensores_v4(mstr-slv).h,1751 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_78_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_78_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_78_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1752 :: 		if(!SENSOR2 & !SENSOR6){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBP21910
	BSF         R1, 0 
	GOTO        L__transicionSalBP21911
L__transicionSalBP21910:
	BCF         R1, 0 
L__transicionSalBP21911:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBP21912
	BSF         4056, 0 
	GOTO        L__transicionSalBP21913
L__transicionSalBP21912:
	BCF         4056, 0 
L__transicionSalBP21913:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBP21914
	BTFSS       4056, 0 
	GOTO        L__transicionSalBP21914
	BSF         R1, 0 
	GOTO        L__transicionSalBP21915
L__transicionSalBP21914:
	BCF         R1, 0 
L__transicionSalBP21915:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBP2409
;rutinasensores_v4(mstr-slv).h,1753 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1754 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBP2
;rutinasensores_v4(mstr-slv).h,1755 :: 		}
L_transicionSalBP2409:
;rutinasensores_v4(mstr-slv).h,1756 :: 		if((SENSOR1 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBP21916
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBP21916
	BSF         4056, 0 
	GOTO        L__transicionSalBP21917
L__transicionSalBP21916:
	BCF         4056, 0 
L__transicionSalBP21917:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBP2410
;rutinasensores_v4(mstr-slv).h,1757 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1758 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBP2
;rutinasensores_v4(mstr-slv).h,1759 :: 		}
L_transicionSalBP2410:
;rutinasensores_v4(mstr-slv).h,1760 :: 		}
L_transicionSalBP2408:
;rutinasensores_v4(mstr-slv).h,1761 :: 		}
L_end_transicionSalBP2:
	RETURN      0
; end of _transicionSalBP2

_salioBP2:

;rutinasensores_v4(mstr-slv).h,1763 :: 		short salioBP2(short estado){
;rutinasensores_v4(mstr-slv).h,1764 :: 		if(estado == SALIO){
	MOVF        FARG_salioBP2_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBP2411
;rutinasensores_v4(mstr-slv).h,1765 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_79_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_79_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_79_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1766 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1767 :: 		pBajan = eepromLeeNumero(0x0003,2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1768 :: 		eepromEscribeNumero(0x0003,pBajan,2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1769 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP2+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP2+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP2+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP2+7 
	MOVF        FLOC__salioBP2+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBP2+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1770 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP2+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP2+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP2+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP2+3 
	MOVF        FLOC__salioBP2+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBP2+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBP2+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBP2+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBP2+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBP2+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1771 :: 		eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Longint+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVF        R2, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVF        R3, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1772 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBP2412
;rutinasensores_v4(mstr-slv).h,1773 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1774 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1775 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1776 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP2+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP2+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP2+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP2+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP2+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP2+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP2+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP2+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP2+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP2+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP2+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP2+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP2+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP2+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP2+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP2+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1777 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1778 :: 		}
L_salioBP2412:
;rutinasensores_v4(mstr-slv).h,1779 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1780 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBP2
;rutinasensores_v4(mstr-slv).h,1781 :: 		}
L_salioBP2411:
;rutinasensores_v4(mstr-slv).h,1782 :: 		}
L_end_salioBP2:
	RETURN      0
; end of _salioBP2

_esperaBP3:

;rutinasensores_v4(mstr-slv).h,1788 :: 		short esperaBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1789 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBP3_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBP3413
;rutinasensores_v4(mstr-slv).h,1790 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,1792 :: 		if((!SENSOR1 | !SENSOR3)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBP31920
	BSF         R1, 0 
	GOTO        L__esperaBP31921
L__esperaBP31920:
	BCF         R1, 0 
L__esperaBP31921:
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaBP31922
	BSF         4056, 0 
	GOTO        L__esperaBP31923
L__esperaBP31922:
	BCF         4056, 0 
L__esperaBP31923:
	BTFSC       R1, 0 
	GOTO        L__esperaBP31924
	BTFSC       4056, 0 
	GOTO        L__esperaBP31924
	BCF         R1, 0 
	GOTO        L__esperaBP31925
L__esperaBP31924:
	BSF         R1, 0 
L__esperaBP31925:
	BTFSS       R1, 0 
	GOTO        L_esperaBP3414
;rutinasensores_v4(mstr-slv).h,1793 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1794 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBP3
;rutinasensores_v4(mstr-slv).h,1795 :: 		}
L_esperaBP3414:
;rutinasensores_v4(mstr-slv).h,1796 :: 		if((!SENSOR2 | !SENSOR4)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaBP31926
	BSF         R1, 0 
	GOTO        L__esperaBP31927
L__esperaBP31926:
	BCF         R1, 0 
L__esperaBP31927:
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaBP31928
	BSF         4056, 0 
	GOTO        L__esperaBP31929
L__esperaBP31928:
	BCF         4056, 0 
L__esperaBP31929:
	BTFSC       R1, 0 
	GOTO        L__esperaBP31930
	BTFSC       4056, 0 
	GOTO        L__esperaBP31930
	BCF         R1, 0 
	GOTO        L__esperaBP31931
L__esperaBP31930:
	BSF         R1, 0 
L__esperaBP31931:
	BTFSS       R1, 0 
	GOTO        L_esperaBP3415
;rutinasensores_v4(mstr-slv).h,1797 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1798 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBP3
;rutinasensores_v4(mstr-slv).h,1799 :: 		}
L_esperaBP3415:
;rutinasensores_v4(mstr-slv).h,1800 :: 		}
L_esperaBP3413:
;rutinasensores_v4(mstr-slv).h,1801 :: 		}
L_end_esperaBP3:
	RETURN      0
; end of _esperaBP3

_entrandoBP3:

;rutinasensores_v4(mstr-slv).h,1803 :: 		short entrandoBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1804 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBP3_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBP3416
;rutinasensores_v4(mstr-slv).h,1805 :: 		LCD_OUTCONST(3,1,"ENTRANDO DEBUG");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_80_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_80_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_80_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1806 :: 		if((SENSOR1 & SENSOR3)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBP31933
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoBP31933
	BSF         4056, 0 
	GOTO        L__entrandoBP31934
L__entrandoBP31933:
	BCF         4056, 0 
L__entrandoBP31934:
	BTFSS       4056, 0 
	GOTO        L_entrandoBP3417
;rutinasensores_v4(mstr-slv).h,1807 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1808 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBP3
;rutinasensores_v4(mstr-slv).h,1809 :: 		}
L_entrandoBP3417:
;rutinasensores_v4(mstr-slv).h,1810 :: 		if((!SENSOR2 & !SENSOR4)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoBP31935
	BSF         R1, 0 
	GOTO        L__entrandoBP31936
L__entrandoBP31935:
	BCF         R1, 0 
L__entrandoBP31936:
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoBP31937
	BSF         4056, 0 
	GOTO        L__entrandoBP31938
L__entrandoBP31937:
	BCF         4056, 0 
L__entrandoBP31938:
	BTFSS       R1, 0 
	GOTO        L__entrandoBP31939
	BTFSS       4056, 0 
	GOTO        L__entrandoBP31939
	BSF         R1, 0 
	GOTO        L__entrandoBP31940
L__entrandoBP31939:
	BCF         R1, 0 
L__entrandoBP31940:
	BTFSS       R1, 0 
	GOTO        L_entrandoBP3418
;rutinasensores_v4(mstr-slv).h,1811 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1812 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBP3
;rutinasensores_v4(mstr-slv).h,1813 :: 		}
L_entrandoBP3418:
;rutinasensores_v4(mstr-slv).h,1814 :: 		}
L_entrandoBP3416:
;rutinasensores_v4(mstr-slv).h,1815 :: 		}
L_end_entrandoBP3:
	RETURN      0
; end of _entrandoBP3

_transicionEBP3:

;rutinasensores_v4(mstr-slv).h,1817 :: 		short transicionEBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1818 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBP3_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBP3419
;rutinasensores_v4(mstr-slv).h,1819 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_81_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_81_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_81_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1820 :: 		if((SENSOR1 & SENSOR3)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBP31942
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBP31942
	BSF         4056, 0 
	GOTO        L__transicionEBP31943
L__transicionEBP31942:
	BCF         4056, 0 
L__transicionEBP31943:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP3420
;rutinasensores_v4(mstr-slv).h,1821 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1822 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBP3
;rutinasensores_v4(mstr-slv).h,1823 :: 		}
L_transicionEBP3420:
;rutinasensores_v4(mstr-slv).h,1824 :: 		if((SENSOR2 & SENSOR4 & !SENSOR1) | (SENSOR2 & SENSOR4 & !SENSOR3)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBP31944
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEBP31944
	BSF         R1, 0 
	GOTO        L__transicionEBP31945
L__transicionEBP31944:
	BCF         R1, 0 
L__transicionEBP31945:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBP31946
	BSF         4056, 0 
	GOTO        L__transicionEBP31947
L__transicionEBP31946:
	BCF         4056, 0 
L__transicionEBP31947:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP31948
	BTFSS       4056, 0 
	GOTO        L__transicionEBP31948
	BSF         R1, 1 
	GOTO        L__transicionEBP31949
L__transicionEBP31948:
	BCF         R1, 1 
L__transicionEBP31949:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBP31950
	BSF         4056, 0 
	GOTO        L__transicionEBP31951
L__transicionEBP31950:
	BCF         4056, 0 
L__transicionEBP31951:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP31952
	BTFSS       4056, 0 
	GOTO        L__transicionEBP31952
	BSF         R1, 0 
	GOTO        L__transicionEBP31953
L__transicionEBP31952:
	BCF         R1, 0 
L__transicionEBP31953:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP31954
	BTFSC       R1, 0 
	GOTO        L__transicionEBP31954
	BCF         4056, 0 
	GOTO        L__transicionEBP31955
L__transicionEBP31954:
	BSF         4056, 0 
L__transicionEBP31955:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP3421
;rutinasensores_v4(mstr-slv).h,1825 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1826 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBP3
;rutinasensores_v4(mstr-slv).h,1827 :: 		}
L_transicionEBP3421:
;rutinasensores_v4(mstr-slv).h,1828 :: 		}
L_transicionEBP3419:
;rutinasensores_v4(mstr-slv).h,1829 :: 		}
L_end_transicionEBP3:
	RETURN      0
; end of _transicionEBP3

_transicionEntBP3:

;rutinasensores_v4(mstr-slv).h,1831 :: 		short transicionEntBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1832 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBP3_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBP3422
;rutinasensores_v4(mstr-slv).h,1833 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_82_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_82_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_82_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1834 :: 		if((!SENSOR3 & !SENSOR1)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntBP31957
	BSF         R1, 0 
	GOTO        L__transicionEntBP31958
L__transicionEntBP31957:
	BCF         R1, 0 
L__transicionEntBP31958:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBP31959
	BSF         4056, 0 
	GOTO        L__transicionEntBP31960
L__transicionEntBP31959:
	BCF         4056, 0 
L__transicionEntBP31960:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBP31961
	BTFSS       4056, 0 
	GOTO        L__transicionEntBP31961
	BSF         R1, 0 
	GOTO        L__transicionEntBP31962
L__transicionEntBP31961:
	BCF         R1, 0 
L__transicionEntBP31962:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBP3423
;rutinasensores_v4(mstr-slv).h,1835 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1836 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBP3
;rutinasensores_v4(mstr-slv).h,1837 :: 		}
L_transicionEntBP3423:
;rutinasensores_v4(mstr-slv).h,1838 :: 		if(/*(SENSOR2 & SENSOR4) | (SENSOR4 & SENSOR6) | (SENSOR2 & SENSOR6) | */(SENSOR2 & SENSOR4)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBP31963
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntBP31963
	BSF         4056, 0 
	GOTO        L__transicionEntBP31964
L__transicionEntBP31963:
	BCF         4056, 0 
L__transicionEntBP31964:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBP3424
;rutinasensores_v4(mstr-slv).h,1839 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1840 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBP3
;rutinasensores_v4(mstr-slv).h,1841 :: 		}
L_transicionEntBP3424:
;rutinasensores_v4(mstr-slv).h,1842 :: 		}
L_transicionEntBP3422:
;rutinasensores_v4(mstr-slv).h,1843 :: 		}
L_end_transicionEntBP3:
	RETURN      0
; end of _transicionEntBP3

_entroBP3:

;rutinasensores_v4(mstr-slv).h,1845 :: 		short entroBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1846 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBP3_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBP3425
;rutinasensores_v4(mstr-slv).h,1847 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_83_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_83_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_83_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1848 :: 		delay_ms(350);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_entroBP3426:
	DECFSZ      R13, 1, 1
	BRA         L_entroBP3426
	DECFSZ      R12, 1, 1
	BRA         L_entroBP3426
	DECFSZ      R11, 1, 1
	BRA         L_entroBP3426
	NOP
;rutinasensores_v4(mstr-slv).h,1849 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1850 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1851 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1852 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1853 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP3+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP3+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP3+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP3+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBP3+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBP3+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBP3+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBP3+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1854 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1855 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBP3427
;rutinasensores_v4(mstr-slv).h,1856 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1857 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1858 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1859 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP3+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP3+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP3+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP3+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP3+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP3+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP3+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP3+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP3+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP3+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP3+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP3+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP3+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP3+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP3+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP3+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1860 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1861 :: 		}
L_entroBP3427:
;rutinasensores_v4(mstr-slv).h,1862 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1863 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBP3
;rutinasensores_v4(mstr-slv).h,1864 :: 		}
L_entroBP3425:
;rutinasensores_v4(mstr-slv).h,1865 :: 		}
L_end_entroBP3:
	RETURN      0
; end of _entroBP3

_saliendoBP3:

;rutinasensores_v4(mstr-slv).h,1867 :: 		short saliendoBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1868 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBP3_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBP3428
;rutinasensores_v4(mstr-slv).h,1869 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_84_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_84_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_84_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1870 :: 		if((!SENSOR1 & !SENSOR3)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBP31967
	BSF         R1, 0 
	GOTO        L__saliendoBP31968
L__saliendoBP31967:
	BCF         R1, 0 
L__saliendoBP31968:
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoBP31969
	BSF         4056, 0 
	GOTO        L__saliendoBP31970
L__saliendoBP31969:
	BCF         4056, 0 
L__saliendoBP31970:
	BTFSS       R1, 0 
	GOTO        L__saliendoBP31971
	BTFSS       4056, 0 
	GOTO        L__saliendoBP31971
	BSF         R1, 0 
	GOTO        L__saliendoBP31972
L__saliendoBP31971:
	BCF         R1, 0 
L__saliendoBP31972:
	BTFSS       R1, 0 
	GOTO        L_saliendoBP3429
;rutinasensores_v4(mstr-slv).h,1871 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1872 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBP3
;rutinasensores_v4(mstr-slv).h,1873 :: 		}
L_saliendoBP3429:
;rutinasensores_v4(mstr-slv).h,1874 :: 		if((SENSOR2 & SENSOR4)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoBP31973
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoBP31973
	BSF         4056, 0 
	GOTO        L__saliendoBP31974
L__saliendoBP31973:
	BCF         4056, 0 
L__saliendoBP31974:
	BTFSS       4056, 0 
	GOTO        L_saliendoBP3430
;rutinasensores_v4(mstr-slv).h,1875 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1876 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBP3
;rutinasensores_v4(mstr-slv).h,1877 :: 		}
L_saliendoBP3430:
;rutinasensores_v4(mstr-slv).h,1878 :: 		}
L_saliendoBP3428:
;rutinasensores_v4(mstr-slv).h,1879 :: 		}
L_end_saliendoBP3:
	RETURN      0
; end of _saliendoBP3

_transicionSBP3:

;rutinasensores_v4(mstr-slv).h,1881 :: 		short transicionSBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1882 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBP3_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBP3431
;rutinasensores_v4(mstr-slv).h,1883 :: 		lcd_outConst(3, 1, "TRANSICION DEBUG");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_85_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_85_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_85_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1884 :: 		if((SENSOR2 & SENSOR4)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBP31976
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBP31976
	BSF         4056, 0 
	GOTO        L__transicionSBP31977
L__transicionSBP31976:
	BCF         4056, 0 
L__transicionSBP31977:
	BTFSS       4056, 0 
	GOTO        L_transicionSBP3432
;rutinasensores_v4(mstr-slv).h,1885 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1886 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBP3
;rutinasensores_v4(mstr-slv).h,1887 :: 		}
L_transicionSBP3432:
;rutinasensores_v4(mstr-slv).h,1888 :: 		if((SENSOR1 & SENSOR3 & !SENSOR2) | (SENSOR1 & SENSOR3 & !SENSOR4)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBP31978
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSBP31978
	BSF         R1, 0 
	GOTO        L__transicionSBP31979
L__transicionSBP31978:
	BCF         R1, 0 
L__transicionSBP31979:
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBP31980
	BSF         4056, 0 
	GOTO        L__transicionSBP31981
L__transicionSBP31980:
	BCF         4056, 0 
L__transicionSBP31981:
	BTFSS       R1, 0 
	GOTO        L__transicionSBP31982
	BTFSS       4056, 0 
	GOTO        L__transicionSBP31982
	BSF         R1, 1 
	GOTO        L__transicionSBP31983
L__transicionSBP31982:
	BCF         R1, 1 
L__transicionSBP31983:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBP31984
	BSF         4056, 0 
	GOTO        L__transicionSBP31985
L__transicionSBP31984:
	BCF         4056, 0 
L__transicionSBP31985:
	BTFSS       R1, 0 
	GOTO        L__transicionSBP31986
	BTFSS       4056, 0 
	GOTO        L__transicionSBP31986
	BSF         R1, 0 
	GOTO        L__transicionSBP31987
L__transicionSBP31986:
	BCF         R1, 0 
L__transicionSBP31987:
	BTFSC       R1, 1 
	GOTO        L__transicionSBP31988
	BTFSC       R1, 0 
	GOTO        L__transicionSBP31988
	BCF         4056, 0 
	GOTO        L__transicionSBP31989
L__transicionSBP31988:
	BSF         4056, 0 
L__transicionSBP31989:
	BTFSS       4056, 0 
	GOTO        L_transicionSBP3433
;rutinasensores_v4(mstr-slv).h,1889 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1890 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBP3
;rutinasensores_v4(mstr-slv).h,1891 :: 		}
L_transicionSBP3433:
;rutinasensores_v4(mstr-slv).h,1892 :: 		}
L_transicionSBP3431:
;rutinasensores_v4(mstr-slv).h,1893 :: 		}
L_end_transicionSBP3:
	RETURN      0
; end of _transicionSBP3

_transicionSalBP3:

;rutinasensores_v4(mstr-slv).h,1895 :: 		short transicionSalBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1896 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBP3_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBP3434
;rutinasensores_v4(mstr-slv).h,1897 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_86_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_86_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_86_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1898 :: 		if(!SENSOR2 & !SENSOR4 ){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBP31991
	BSF         R1, 0 
	GOTO        L__transicionSalBP31992
L__transicionSalBP31991:
	BCF         R1, 0 
L__transicionSalBP31992:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBP31993
	BSF         4056, 0 
	GOTO        L__transicionSalBP31994
L__transicionSalBP31993:
	BCF         4056, 0 
L__transicionSalBP31994:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBP31995
	BTFSS       4056, 0 
	GOTO        L__transicionSalBP31995
	BSF         R1, 0 
	GOTO        L__transicionSalBP31996
L__transicionSalBP31995:
	BCF         R1, 0 
L__transicionSalBP31996:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBP3435
;rutinasensores_v4(mstr-slv).h,1899 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1900 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBP3
;rutinasensores_v4(mstr-slv).h,1901 :: 		}
L_transicionSalBP3435:
;rutinasensores_v4(mstr-slv).h,1902 :: 		if((SENSOR1 & SENSOR3)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBP31997
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalBP31997
	BSF         4056, 0 
	GOTO        L__transicionSalBP31998
L__transicionSalBP31997:
	BCF         4056, 0 
L__transicionSalBP31998:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBP3436
;rutinasensores_v4(mstr-slv).h,1903 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1904 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBP3
;rutinasensores_v4(mstr-slv).h,1905 :: 		}
L_transicionSalBP3436:
;rutinasensores_v4(mstr-slv).h,1906 :: 		}
L_transicionSalBP3434:
;rutinasensores_v4(mstr-slv).h,1907 :: 		}
L_end_transicionSalBP3:
	RETURN      0
; end of _transicionSalBP3

_salioBP3:

;rutinasensores_v4(mstr-slv).h,1909 :: 		short salioBP3(short estado){
;rutinasensores_v4(mstr-slv).h,1910 :: 		if(estado == SALIO){
	MOVF        FARG_salioBP3_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBP3437
;rutinasensores_v4(mstr-slv).h,1911 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_87_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_87_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_87_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1912 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1913 :: 		pBajan = eepromLeeNumero(0x0003,2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1914 :: 		eepromEscribeNumero(0x0003,pBajan,2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1915 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP3+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP3+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP3+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP3+7 
	MOVF        FLOC__salioBP3+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBP3+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1916 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP3+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP3+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP3+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP3+3 
	MOVF        FLOC__salioBP3+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBP3+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBP3+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBP3+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBP3+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBP3+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1917 :: 		eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Longint+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVF        R2, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVF        R3, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1918 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBP3438
;rutinasensores_v4(mstr-slv).h,1919 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,1920 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,1921 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,1922 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP3+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP3+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP3+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP3+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP3+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP3+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP3+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP3+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP3+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP3+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP3+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP3+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP3+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP3+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP3+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP3+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,1923 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1924 :: 		}
L_salioBP3438:
;rutinasensores_v4(mstr-slv).h,1925 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1926 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBP3
;rutinasensores_v4(mstr-slv).h,1927 :: 		}
L_salioBP3437:
;rutinasensores_v4(mstr-slv).h,1928 :: 		}
L_end_salioBP3:
	RETURN      0
; end of _salioBP3

_esperaBP4:

;rutinasensores_v4(mstr-slv).h,1934 :: 		short esperaBP4(short estado){
;rutinasensores_v4(mstr-slv).h,1935 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBP4_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBP4439
;rutinasensores_v4(mstr-slv).h,1936 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,1937 :: 		if((!SENSOR5)){
	BTFSC       PORTB+0, 0 
	GOTO        L_esperaBP4440
;rutinasensores_v4(mstr-slv).h,1938 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1939 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBP4
;rutinasensores_v4(mstr-slv).h,1940 :: 		}
L_esperaBP4440:
;rutinasensores_v4(mstr-slv).h,1941 :: 		if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaBP42001
	BSF         R1, 0 
	GOTO        L__esperaBP42002
L__esperaBP42001:
	BCF         R1, 0 
L__esperaBP42002:
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaBP42003
	BSF         4056, 0 
	GOTO        L__esperaBP42004
L__esperaBP42003:
	BCF         4056, 0 
L__esperaBP42004:
	BTFSC       R1, 0 
	GOTO        L__esperaBP42005
	BTFSC       4056, 0 
	GOTO        L__esperaBP42005
	BCF         R1, 0 
	GOTO        L__esperaBP42006
L__esperaBP42005:
	BSF         R1, 0 
L__esperaBP42006:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaBP42007
	BSF         4056, 0 
	GOTO        L__esperaBP42008
L__esperaBP42007:
	BCF         4056, 0 
L__esperaBP42008:
	BTFSC       R1, 0 
	GOTO        L__esperaBP42009
	BTFSC       4056, 0 
	GOTO        L__esperaBP42009
	BCF         R1, 0 
	GOTO        L__esperaBP42010
L__esperaBP42009:
	BSF         R1, 0 
L__esperaBP42010:
	BTFSS       R1, 0 
	GOTO        L_esperaBP4441
;rutinasensores_v4(mstr-slv).h,1942 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1943 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBP4
;rutinasensores_v4(mstr-slv).h,1944 :: 		}
L_esperaBP4441:
;rutinasensores_v4(mstr-slv).h,1945 :: 		}
L_esperaBP4439:
;rutinasensores_v4(mstr-slv).h,1946 :: 		}
L_end_esperaBP4:
	RETURN      0
; end of _esperaBP4

_entrandoBP4:

;rutinasensores_v4(mstr-slv).h,1948 :: 		short entrandoBP4(short estado){
;rutinasensores_v4(mstr-slv).h,1949 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBP4_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBP4442
;rutinasensores_v4(mstr-slv).h,1950 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_88_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_88_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_88_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1951 :: 		if((SENSOR5)){
	BTFSS       PORTB+0, 0 
	GOTO        L_entrandoBP4443
;rutinasensores_v4(mstr-slv).h,1952 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1953 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBP4
;rutinasensores_v4(mstr-slv).h,1954 :: 		}
L_entrandoBP4443:
;rutinasensores_v4(mstr-slv).h,1955 :: 		if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoBP42012
	BSF         R1, 3 
	GOTO        L__entrandoBP42013
L__entrandoBP42012:
	BCF         R1, 3 
L__entrandoBP42013:
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoBP42014
	BSF         R1, 0 
	GOTO        L__entrandoBP42015
L__entrandoBP42014:
	BCF         R1, 0 
L__entrandoBP42015:
	BTFSS       R1, 3 
	GOTO        L__entrandoBP42016
	BTFSS       R1, 0 
	GOTO        L__entrandoBP42016
	BSF         R1, 1 
	GOTO        L__entrandoBP42017
L__entrandoBP42016:
	BCF         R1, 1 
L__entrandoBP42017:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoBP42018
	BSF         R1, 2 
	GOTO        L__entrandoBP42019
L__entrandoBP42018:
	BCF         R1, 2 
L__entrandoBP42019:
	BTFSS       R1, 0 
	GOTO        L__entrandoBP42020
	BTFSS       R1, 2 
	GOTO        L__entrandoBP42020
	BSF         4056, 0 
	GOTO        L__entrandoBP42021
L__entrandoBP42020:
	BCF         4056, 0 
L__entrandoBP42021:
	BTFSC       R1, 1 
	GOTO        L__entrandoBP42022
	BTFSC       4056, 0 
	GOTO        L__entrandoBP42022
	BCF         R1, 1 
	GOTO        L__entrandoBP42023
L__entrandoBP42022:
	BSF         R1, 1 
L__entrandoBP42023:
	BTFSC       R1, 3 
	GOTO        L__entrandoBP42024
	BCF         R1, 0 
	GOTO        L__entrandoBP42025
L__entrandoBP42024:
	BSF         R1, 0 
L__entrandoBP42025:
	BTFSC       R1, 2 
	GOTO        L__entrandoBP42026
	BCF         4056, 0 
	GOTO        L__entrandoBP42027
L__entrandoBP42026:
	BSF         4056, 0 
L__entrandoBP42027:
	BTFSS       R1, 0 
	GOTO        L__entrandoBP42028
	BTFSS       4056, 0 
	GOTO        L__entrandoBP42028
	BSF         R1, 0 
	GOTO        L__entrandoBP42029
L__entrandoBP42028:
	BCF         R1, 0 
L__entrandoBP42029:
	BTFSC       R1, 1 
	GOTO        L__entrandoBP42030
	BTFSC       R1, 0 
	GOTO        L__entrandoBP42030
	BCF         4056, 0 
	GOTO        L__entrandoBP42031
L__entrandoBP42030:
	BSF         4056, 0 
L__entrandoBP42031:
	BTFSS       4056, 0 
	GOTO        L_entrandoBP4444
;rutinasensores_v4(mstr-slv).h,1956 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1957 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBP4
;rutinasensores_v4(mstr-slv).h,1958 :: 		}
L_entrandoBP4444:
;rutinasensores_v4(mstr-slv).h,1959 :: 		}
L_entrandoBP4442:
;rutinasensores_v4(mstr-slv).h,1960 :: 		}
L_end_entrandoBP4:
	RETURN      0
; end of _entrandoBP4

_transicionEBP4:

;rutinasensores_v4(mstr-slv).h,1962 :: 		short transicionEBP4(short estado){
;rutinasensores_v4(mstr-slv).h,1963 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBP4_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBP4445
;rutinasensores_v4(mstr-slv).h,1964 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_89_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_89_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_89_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1965 :: 		if(SENSOR5){
	BTFSS       PORTB+0, 0 
	GOTO        L_transicionEBP4446
;rutinasensores_v4(mstr-slv).h,1966 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1967 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBP4
;rutinasensores_v4(mstr-slv).h,1968 :: 		}
L_transicionEBP4446:
;rutinasensores_v4(mstr-slv).h,1969 :: 		if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBP42033
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEBP42033
	BSF         4056, 0 
	GOTO        L__transicionEBP42034
L__transicionEBP42033:
	BCF         4056, 0 
L__transicionEBP42034:
	BTFSS       4056, 0 
	GOTO        L__transicionEBP42035
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP42035
	BSF         R1, 0 
	GOTO        L__transicionEBP42036
L__transicionEBP42035:
	BCF         R1, 0 
L__transicionEBP42036:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBP42037
	BSF         4056, 0 
	GOTO        L__transicionEBP42038
L__transicionEBP42037:
	BCF         4056, 0 
L__transicionEBP42038:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP42039
	BTFSS       4056, 0 
	GOTO        L__transicionEBP42039
	BSF         R1, 0 
	GOTO        L__transicionEBP42040
L__transicionEBP42039:
	BCF         R1, 0 
L__transicionEBP42040:
	BTFSS       R1, 0 
	GOTO        L_transicionEBP4447
;rutinasensores_v4(mstr-slv).h,1970 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1971 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBP4
;rutinasensores_v4(mstr-slv).h,1972 :: 		}
L_transicionEBP4447:
;rutinasensores_v4(mstr-slv).h,1973 :: 		}
L_transicionEBP4445:
;rutinasensores_v4(mstr-slv).h,1974 :: 		}
L_end_transicionEBP4:
	RETURN      0
; end of _transicionEBP4

_transicionEntBP4:

;rutinasensores_v4(mstr-slv).h,1976 :: 		short transicionEntBP4(short estado){
;rutinasensores_v4(mstr-slv).h,1977 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBP4_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBP4448
;rutinasensores_v4(mstr-slv).h,1978 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_90_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_90_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_90_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1979 :: 		if((!SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 0 
	GOTO        L_transicionEntBP4449
;rutinasensores_v4(mstr-slv).h,1980 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1981 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBP4
;rutinasensores_v4(mstr-slv).h,1982 :: 		}
L_transicionEntBP4449:
;rutinasensores_v4(mstr-slv).h,1983 :: 		if(SENSOR2 & SENSOR4 & SENSOR6 & SENSOR5){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBP42042
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntBP42042
	BSF         4056, 0 
	GOTO        L__transicionEntBP42043
L__transicionEntBP42042:
	BCF         4056, 0 
L__transicionEntBP42043:
	BTFSS       4056, 0 
	GOTO        L__transicionEntBP42044
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBP42044
	BSF         R1, 0 
	GOTO        L__transicionEntBP42045
L__transicionEntBP42044:
	BCF         R1, 0 
L__transicionEntBP42045:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBP42046
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEntBP42046
	BSF         4056, 0 
	GOTO        L__transicionEntBP42047
L__transicionEntBP42046:
	BCF         4056, 0 
L__transicionEntBP42047:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBP4450
;rutinasensores_v4(mstr-slv).h,1984 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,1985 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBP4
;rutinasensores_v4(mstr-slv).h,1986 :: 		}
L_transicionEntBP4450:
;rutinasensores_v4(mstr-slv).h,1987 :: 		}
L_transicionEntBP4448:
;rutinasensores_v4(mstr-slv).h,1988 :: 		}
L_end_transicionEntBP4:
	RETURN      0
; end of _transicionEntBP4

_entroBP4:

;rutinasensores_v4(mstr-slv).h,1990 :: 		short entroBP4(short estado){
;rutinasensores_v4(mstr-slv).h,1991 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBP4_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBP4451
;rutinasensores_v4(mstr-slv).h,1992 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_91_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_91_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_91_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,1993 :: 		delay_ms(350);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_entroBP4452:
	DECFSZ      R13, 1, 1
	BRA         L_entroBP4452
	DECFSZ      R12, 1, 1
	BRA         L_entroBP4452
	DECFSZ      R11, 1, 1
	BRA         L_entroBP4452
	NOP
;rutinasensores_v4(mstr-slv).h,1994 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,1995 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1996 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,1997 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,1998 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP4+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP4+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP4+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP4+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBP4+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBP4+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBP4+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBP4+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,1999 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2000 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBP4453
;rutinasensores_v4(mstr-slv).h,2001 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,2002 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,2003 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,2004 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP4+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP4+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP4+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP4+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP4+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP4+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP4+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP4+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP4+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP4+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP4+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP4+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP4+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP4+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP4+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP4+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,2005 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2006 :: 		}
L_entroBP4453:
;rutinasensores_v4(mstr-slv).h,2007 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2008 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBP4
;rutinasensores_v4(mstr-slv).h,2009 :: 		}
L_entroBP4451:
;rutinasensores_v4(mstr-slv).h,2010 :: 		}
L_end_entroBP4:
	RETURN      0
; end of _entroBP4

_saliendoBP4:

;rutinasensores_v4(mstr-slv).h,2012 :: 		short saliendoBP4(short estado){
;rutinasensores_v4(mstr-slv).h,2013 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBP4_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBP4454
;rutinasensores_v4(mstr-slv).h,2014 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_92_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_92_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_92_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2015 :: 		if(!SENSOR5){
	BTFSC       PORTB+0, 0 
	GOTO        L_saliendoBP4455
;rutinasensores_v4(mstr-slv).h,2016 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2017 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBP4
;rutinasensores_v4(mstr-slv).h,2018 :: 		}
L_saliendoBP4455:
;rutinasensores_v4(mstr-slv).h,2019 :: 		if((SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoBP42050
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoBP42050
	BSF         4056, 0 
	GOTO        L__saliendoBP42051
L__saliendoBP42050:
	BCF         4056, 0 
L__saliendoBP42051:
	BTFSS       4056, 0 
	GOTO        L__saliendoBP42052
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoBP42052
	BSF         R1, 0 
	GOTO        L__saliendoBP42053
L__saliendoBP42052:
	BCF         R1, 0 
L__saliendoBP42053:
	BTFSS       R1, 0 
	GOTO        L_saliendoBP4456
;rutinasensores_v4(mstr-slv).h,2020 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2021 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBP4
;rutinasensores_v4(mstr-slv).h,2022 :: 		}
L_saliendoBP4456:
;rutinasensores_v4(mstr-slv).h,2023 :: 		}
L_saliendoBP4454:
;rutinasensores_v4(mstr-slv).h,2024 :: 		}
L_end_saliendoBP4:
	RETURN      0
; end of _saliendoBP4

_transicionSBP4:

;rutinasensores_v4(mstr-slv).h,2026 :: 		short transicionSBP4(short estado){
;rutinasensores_v4(mstr-slv).h,2027 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBP4_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBP4457
;rutinasensores_v4(mstr-slv).h,2028 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_93_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_93_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_93_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2029 :: 		if(SENSOR2 & SENSOR4 & SENSOR6){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBP42055
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBP42055
	BSF         4056, 0 
	GOTO        L__transicionSBP42056
L__transicionSBP42055:
	BCF         4056, 0 
L__transicionSBP42056:
	BTFSS       4056, 0 
	GOTO        L__transicionSBP42057
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBP42057
	BSF         R1, 0 
	GOTO        L__transicionSBP42058
L__transicionSBP42057:
	BCF         R1, 0 
L__transicionSBP42058:
	BTFSS       R1, 0 
	GOTO        L_transicionSBP4458
;rutinasensores_v4(mstr-slv).h,2030 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2031 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBP4
;rutinasensores_v4(mstr-slv).h,2032 :: 		}
L_transicionSBP4458:
;rutinasensores_v4(mstr-slv).h,2033 :: 		if((SENSOR5 & !SENSOR2) | (SENSOR5 & !SENSOR4) | (SENSOR5 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBP42059
	BSF         4056, 0 
	GOTO        L__transicionSBP42060
L__transicionSBP42059:
	BCF         4056, 0 
L__transicionSBP42060:
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBP42061
	BTFSS       4056, 0 
	GOTO        L__transicionSBP42061
	BSF         R1, 1 
	GOTO        L__transicionSBP42062
L__transicionSBP42061:
	BCF         R1, 1 
L__transicionSBP42062:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBP42063
	BSF         4056, 0 
	GOTO        L__transicionSBP42064
L__transicionSBP42063:
	BCF         4056, 0 
L__transicionSBP42064:
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBP42065
	BTFSS       4056, 0 
	GOTO        L__transicionSBP42065
	BSF         R1, 0 
	GOTO        L__transicionSBP42066
L__transicionSBP42065:
	BCF         R1, 0 
L__transicionSBP42066:
	BTFSC       R1, 1 
	GOTO        L__transicionSBP42067
	BTFSC       R1, 0 
	GOTO        L__transicionSBP42067
	BCF         R1, 1 
	GOTO        L__transicionSBP42068
L__transicionSBP42067:
	BSF         R1, 1 
L__transicionSBP42068:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBP42069
	BSF         4056, 0 
	GOTO        L__transicionSBP42070
L__transicionSBP42069:
	BCF         4056, 0 
L__transicionSBP42070:
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBP42071
	BTFSS       4056, 0 
	GOTO        L__transicionSBP42071
	BSF         R1, 0 
	GOTO        L__transicionSBP42072
L__transicionSBP42071:
	BCF         R1, 0 
L__transicionSBP42072:
	BTFSC       R1, 1 
	GOTO        L__transicionSBP42073
	BTFSC       R1, 0 
	GOTO        L__transicionSBP42073
	BCF         4056, 0 
	GOTO        L__transicionSBP42074
L__transicionSBP42073:
	BSF         4056, 0 
L__transicionSBP42074:
	BTFSS       4056, 0 
	GOTO        L_transicionSBP4459
;rutinasensores_v4(mstr-slv).h,2034 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2035 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBP4
;rutinasensores_v4(mstr-slv).h,2036 :: 		}
L_transicionSBP4459:
;rutinasensores_v4(mstr-slv).h,2037 :: 		}
L_transicionSBP4457:
;rutinasensores_v4(mstr-slv).h,2038 :: 		}
L_end_transicionSBP4:
	RETURN      0
; end of _transicionSBP4

_transicionSalBP4:

;rutinasensores_v4(mstr-slv).h,2040 :: 		short transicionSalBP4(short estado){
;rutinasensores_v4(mstr-slv).h,2041 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBP4_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBP4460
;rutinasensores_v4(mstr-slv).h,2042 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_94_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_94_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_94_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2043 :: 		if(!SENSOR2 | !SENSOR4 | !SENSOR6){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBP42076
	BSF         R1, 0 
	GOTO        L__transicionSalBP42077
L__transicionSalBP42076:
	BCF         R1, 0 
L__transicionSalBP42077:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBP42078
	BSF         4056, 0 
	GOTO        L__transicionSalBP42079
L__transicionSalBP42078:
	BCF         4056, 0 
L__transicionSalBP42079:
	BTFSC       R1, 0 
	GOTO        L__transicionSalBP42080
	BTFSC       4056, 0 
	GOTO        L__transicionSalBP42080
	BCF         R1, 0 
	GOTO        L__transicionSalBP42081
L__transicionSalBP42080:
	BSF         R1, 0 
L__transicionSalBP42081:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBP42082
	BSF         4056, 0 
	GOTO        L__transicionSalBP42083
L__transicionSalBP42082:
	BCF         4056, 0 
L__transicionSalBP42083:
	BTFSC       R1, 0 
	GOTO        L__transicionSalBP42084
	BTFSC       4056, 0 
	GOTO        L__transicionSalBP42084
	BCF         R1, 0 
	GOTO        L__transicionSalBP42085
L__transicionSalBP42084:
	BSF         R1, 0 
L__transicionSalBP42085:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBP4461
;rutinasensores_v4(mstr-slv).h,2044 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2045 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBP4
;rutinasensores_v4(mstr-slv).h,2046 :: 		}
L_transicionSalBP4461:
;rutinasensores_v4(mstr-slv).h,2047 :: 		if((SENSOR5) & (SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSalBP42086
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSalBP42086
	BSF         4056, 0 
	GOTO        L__transicionSalBP42087
L__transicionSalBP42086:
	BCF         4056, 0 
L__transicionSalBP42087:
	BTFSS       4056, 0 
	GOTO        L__transicionSalBP42088
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSalBP42088
	BSF         R1, 0 
	GOTO        L__transicionSalBP42089
L__transicionSalBP42088:
	BCF         R1, 0 
L__transicionSalBP42089:
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBP42090
	BTFSS       R1, 0 
	GOTO        L__transicionSalBP42090
	BSF         4056, 0 
	GOTO        L__transicionSalBP42091
L__transicionSalBP42090:
	BCF         4056, 0 
L__transicionSalBP42091:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBP4462
;rutinasensores_v4(mstr-slv).h,2048 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2049 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBP4
;rutinasensores_v4(mstr-slv).h,2050 :: 		}
L_transicionSalBP4462:
;rutinasensores_v4(mstr-slv).h,2051 :: 		}
L_transicionSalBP4460:
;rutinasensores_v4(mstr-slv).h,2052 :: 		}
L_end_transicionSalBP4:
	RETURN      0
; end of _transicionSalBP4

_salioBP4:

;rutinasensores_v4(mstr-slv).h,2054 :: 		short salioBP4(short estado){
;rutinasensores_v4(mstr-slv).h,2055 :: 		if(estado == SALIO){
	MOVF        FARG_salioBP4_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBP4463
;rutinasensores_v4(mstr-slv).h,2056 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_95_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_95_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_95_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2057 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2058 :: 		pBajan = eepromLeeNumero(0x0003,2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2059 :: 		eepromEscribeNumero(0x0003,pBajan,2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2060 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP4+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP4+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP4+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP4+7 
	MOVF        FLOC__salioBP4+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBP4+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2061 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP4+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP4+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP4+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP4+3 
	MOVF        FLOC__salioBP4+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBP4+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBP4+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBP4+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBP4+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBP4+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,2062 :: 		eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Longint+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVF        R2, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVF        R3, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2063 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBP4464
;rutinasensores_v4(mstr-slv).h,2064 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,2065 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,2066 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,2067 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP4+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP4+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP4+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP4+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP4+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP4+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP4+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP4+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP4+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP4+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP4+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP4+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP4+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP4+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP4+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP4+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,2068 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2069 :: 		}
L_salioBP4464:
;rutinasensores_v4(mstr-slv).h,2070 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2071 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBP4
;rutinasensores_v4(mstr-slv).h,2072 :: 		}
L_salioBP4463:
;rutinasensores_v4(mstr-slv).h,2073 :: 		}
L_end_salioBP4:
	RETURN      0
; end of _salioBP4

_esperaBP6:

;rutinasensores_v4(mstr-slv).h,2079 :: 		short esperaBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2080 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBP6_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBP6465
;rutinasensores_v4(mstr-slv).h,2081 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,2083 :: 		if(!SENSOR1){
	BTFSC       PORTB+0, 4 
	GOTO        L_esperaBP6466
;rutinasensores_v4(mstr-slv).h,2084 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2085 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBP6
;rutinasensores_v4(mstr-slv).h,2086 :: 		}
L_esperaBP6466:
;rutinasensores_v4(mstr-slv).h,2087 :: 		if((!SENSOR2 | !SENSOR4 | !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__esperaBP62094
	BSF         R1, 0 
	GOTO        L__esperaBP62095
L__esperaBP62094:
	BCF         R1, 0 
L__esperaBP62095:
	BTFSC       PORTB+0, 3 
	GOTO        L__esperaBP62096
	BSF         4056, 0 
	GOTO        L__esperaBP62097
L__esperaBP62096:
	BCF         4056, 0 
L__esperaBP62097:
	BTFSC       R1, 0 
	GOTO        L__esperaBP62098
	BTFSC       4056, 0 
	GOTO        L__esperaBP62098
	BCF         R1, 0 
	GOTO        L__esperaBP62099
L__esperaBP62098:
	BSF         R1, 0 
L__esperaBP62099:
	BTFSC       PORTB+0, 1 
	GOTO        L__esperaBP62100
	BSF         4056, 0 
	GOTO        L__esperaBP62101
L__esperaBP62100:
	BCF         4056, 0 
L__esperaBP62101:
	BTFSC       R1, 0 
	GOTO        L__esperaBP62102
	BTFSC       4056, 0 
	GOTO        L__esperaBP62102
	BCF         R1, 0 
	GOTO        L__esperaBP62103
L__esperaBP62102:
	BSF         R1, 0 
L__esperaBP62103:
	BTFSS       R1, 0 
	GOTO        L_esperaBP6467
;rutinasensores_v4(mstr-slv).h,2088 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2089 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBP6
;rutinasensores_v4(mstr-slv).h,2090 :: 		}
L_esperaBP6467:
;rutinasensores_v4(mstr-slv).h,2091 :: 		}
L_esperaBP6465:
;rutinasensores_v4(mstr-slv).h,2092 :: 		}
L_end_esperaBP6:
	RETURN      0
; end of _esperaBP6

_entrandoBP6:

;rutinasensores_v4(mstr-slv).h,2094 :: 		short entrandoBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2095 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBP6_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBP6468
;rutinasensores_v4(mstr-slv).h,2096 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_96_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_96_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_96_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2097 :: 		if((SENSOR1)){
	BTFSS       PORTB+0, 4 
	GOTO        L_entrandoBP6469
;rutinasensores_v4(mstr-slv).h,2098 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2099 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBP6
;rutinasensores_v4(mstr-slv).h,2100 :: 		}
L_entrandoBP6469:
;rutinasensores_v4(mstr-slv).h,2101 :: 		if((!SENSOR2 & !SENSOR4) | (!SENSOR4 & !SENSOR6) | (!SENSOR2 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__entrandoBP62105
	BSF         R1, 3 
	GOTO        L__entrandoBP62106
L__entrandoBP62105:
	BCF         R1, 3 
L__entrandoBP62106:
	BTFSC       PORTB+0, 3 
	GOTO        L__entrandoBP62107
	BSF         R1, 0 
	GOTO        L__entrandoBP62108
L__entrandoBP62107:
	BCF         R1, 0 
L__entrandoBP62108:
	BTFSS       R1, 3 
	GOTO        L__entrandoBP62109
	BTFSS       R1, 0 
	GOTO        L__entrandoBP62109
	BSF         R1, 1 
	GOTO        L__entrandoBP62110
L__entrandoBP62109:
	BCF         R1, 1 
L__entrandoBP62110:
	BTFSC       PORTB+0, 1 
	GOTO        L__entrandoBP62111
	BSF         R1, 2 
	GOTO        L__entrandoBP62112
L__entrandoBP62111:
	BCF         R1, 2 
L__entrandoBP62112:
	BTFSS       R1, 0 
	GOTO        L__entrandoBP62113
	BTFSS       R1, 2 
	GOTO        L__entrandoBP62113
	BSF         4056, 0 
	GOTO        L__entrandoBP62114
L__entrandoBP62113:
	BCF         4056, 0 
L__entrandoBP62114:
	BTFSC       R1, 1 
	GOTO        L__entrandoBP62115
	BTFSC       4056, 0 
	GOTO        L__entrandoBP62115
	BCF         R1, 1 
	GOTO        L__entrandoBP62116
L__entrandoBP62115:
	BSF         R1, 1 
L__entrandoBP62116:
	BTFSC       R1, 3 
	GOTO        L__entrandoBP62117
	BCF         R1, 0 
	GOTO        L__entrandoBP62118
L__entrandoBP62117:
	BSF         R1, 0 
L__entrandoBP62118:
	BTFSC       R1, 2 
	GOTO        L__entrandoBP62119
	BCF         4056, 0 
	GOTO        L__entrandoBP62120
L__entrandoBP62119:
	BSF         4056, 0 
L__entrandoBP62120:
	BTFSS       R1, 0 
	GOTO        L__entrandoBP62121
	BTFSS       4056, 0 
	GOTO        L__entrandoBP62121
	BSF         R1, 0 
	GOTO        L__entrandoBP62122
L__entrandoBP62121:
	BCF         R1, 0 
L__entrandoBP62122:
	BTFSC       R1, 1 
	GOTO        L__entrandoBP62123
	BTFSC       R1, 0 
	GOTO        L__entrandoBP62123
	BCF         4056, 0 
	GOTO        L__entrandoBP62124
L__entrandoBP62123:
	BSF         4056, 0 
L__entrandoBP62124:
	BTFSS       4056, 0 
	GOTO        L_entrandoBP6470
;rutinasensores_v4(mstr-slv).h,2102 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2103 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBP6
;rutinasensores_v4(mstr-slv).h,2104 :: 		}
L_entrandoBP6470:
;rutinasensores_v4(mstr-slv).h,2105 :: 		}
L_entrandoBP6468:
;rutinasensores_v4(mstr-slv).h,2106 :: 		}
L_end_entrandoBP6:
	RETURN      0
; end of _entrandoBP6

_transicionEBP6:

;rutinasensores_v4(mstr-slv).h,2108 :: 		short transicionEBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2109 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBP6_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBP6471
;rutinasensores_v4(mstr-slv).h,2110 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_97_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_97_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_97_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2111 :: 		if(SENSOR1){
	BTFSS       PORTB+0, 4 
	GOTO        L_transicionEBP6472
;rutinasensores_v4(mstr-slv).h,2112 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2113 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBP6
;rutinasensores_v4(mstr-slv).h,2114 :: 		}
L_transicionEBP6472:
;rutinasensores_v4(mstr-slv).h,2115 :: 		if((SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR1) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR3) | (SENSOR2 & SENSOR4 & SENSOR6 & !SENSOR5)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBP62126
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEBP62126
	BSF         R1, 2 
	GOTO        L__transicionEBP62127
L__transicionEBP62126:
	BCF         R1, 2 
L__transicionEBP62127:
	BTFSS       R1, 2 
	GOTO        L__transicionEBP62128
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP62128
	BSF         R1, 0 
	GOTO        L__transicionEBP62129
L__transicionEBP62128:
	BCF         R1, 0 
L__transicionEBP62129:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBP62130
	BSF         4056, 0 
	GOTO        L__transicionEBP62131
L__transicionEBP62130:
	BCF         4056, 0 
L__transicionEBP62131:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP62132
	BTFSS       4056, 0 
	GOTO        L__transicionEBP62132
	BSF         R1, 1 
	GOTO        L__transicionEBP62133
L__transicionEBP62132:
	BCF         R1, 1 
L__transicionEBP62133:
	BTFSC       R1, 2 
	GOTO        L__transicionEBP62134
	BCF         4056, 0 
	GOTO        L__transicionEBP62135
L__transicionEBP62134:
	BSF         4056, 0 
L__transicionEBP62135:
	BTFSS       4056, 0 
	GOTO        L__transicionEBP62136
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP62136
	BSF         R1, 0 
	GOTO        L__transicionEBP62137
L__transicionEBP62136:
	BCF         R1, 0 
L__transicionEBP62137:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBP62138
	BSF         4056, 0 
	GOTO        L__transicionEBP62139
L__transicionEBP62138:
	BCF         4056, 0 
L__transicionEBP62139:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP62140
	BTFSS       4056, 0 
	GOTO        L__transicionEBP62140
	BSF         R1, 0 
	GOTO        L__transicionEBP62141
L__transicionEBP62140:
	BCF         R1, 0 
L__transicionEBP62141:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP62142
	BTFSC       R1, 0 
	GOTO        L__transicionEBP62142
	BCF         R1, 1 
	GOTO        L__transicionEBP62143
L__transicionEBP62142:
	BSF         R1, 1 
L__transicionEBP62143:
	BTFSC       R1, 2 
	GOTO        L__transicionEBP62144
	BCF         4056, 0 
	GOTO        L__transicionEBP62145
L__transicionEBP62144:
	BSF         4056, 0 
L__transicionEBP62145:
	BTFSS       4056, 0 
	GOTO        L__transicionEBP62146
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP62146
	BSF         R1, 0 
	GOTO        L__transicionEBP62147
L__transicionEBP62146:
	BCF         R1, 0 
L__transicionEBP62147:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBP62148
	BSF         4056, 0 
	GOTO        L__transicionEBP62149
L__transicionEBP62148:
	BCF         4056, 0 
L__transicionEBP62149:
	BTFSS       R1, 0 
	GOTO        L__transicionEBP62150
	BTFSS       4056, 0 
	GOTO        L__transicionEBP62150
	BSF         R1, 0 
	GOTO        L__transicionEBP62151
L__transicionEBP62150:
	BCF         R1, 0 
L__transicionEBP62151:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP62152
	BTFSC       R1, 0 
	GOTO        L__transicionEBP62152
	BCF         4056, 0 
	GOTO        L__transicionEBP62153
L__transicionEBP62152:
	BSF         4056, 0 
L__transicionEBP62153:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP6473
;rutinasensores_v4(mstr-slv).h,2116 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2117 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBP6
;rutinasensores_v4(mstr-slv).h,2118 :: 		}
L_transicionEBP6473:
;rutinasensores_v4(mstr-slv).h,2119 :: 		}
L_transicionEBP6471:
;rutinasensores_v4(mstr-slv).h,2120 :: 		}
L_end_transicionEBP6:
	RETURN      0
; end of _transicionEBP6

_transicionEntBP6:

;rutinasensores_v4(mstr-slv).h,2122 :: 		short transicionEntBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2123 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBP6_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBP6474
;rutinasensores_v4(mstr-slv).h,2124 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_98_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_98_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_98_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2125 :: 		if((!SENSOR1)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 4 
	GOTO        L_transicionEntBP6475
;rutinasensores_v4(mstr-slv).h,2126 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2127 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBP6
;rutinasensores_v4(mstr-slv).h,2128 :: 		}
L_transicionEntBP6475:
;rutinasensores_v4(mstr-slv).h,2129 :: 		if(SENSOR2 & SENSOR4 & SENSOR6 & SENSOR1){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBP62155
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionEntBP62155
	BSF         4056, 0 
	GOTO        L__transicionEntBP62156
L__transicionEntBP62155:
	BCF         4056, 0 
L__transicionEntBP62156:
	BTFSS       4056, 0 
	GOTO        L__transicionEntBP62157
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBP62157
	BSF         R1, 0 
	GOTO        L__transicionEntBP62158
L__transicionEntBP62157:
	BCF         R1, 0 
L__transicionEntBP62158:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBP62159
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEntBP62159
	BSF         4056, 0 
	GOTO        L__transicionEntBP62160
L__transicionEntBP62159:
	BCF         4056, 0 
L__transicionEntBP62160:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBP6476
;rutinasensores_v4(mstr-slv).h,2130 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2131 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBP6
;rutinasensores_v4(mstr-slv).h,2132 :: 		}
L_transicionEntBP6476:
;rutinasensores_v4(mstr-slv).h,2133 :: 		}
L_transicionEntBP6474:
;rutinasensores_v4(mstr-slv).h,2134 :: 		}
L_end_transicionEntBP6:
	RETURN      0
; end of _transicionEntBP6

_entroBP6:

;rutinasensores_v4(mstr-slv).h,2136 :: 		short entroBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2137 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBP6_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBP6477
;rutinasensores_v4(mstr-slv).h,2138 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_99_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_99_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_99_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2139 :: 		delay_ms(350);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_entroBP6478:
	DECFSZ      R13, 1, 1
	BRA         L_entroBP6478
	DECFSZ      R12, 1, 1
	BRA         L_entroBP6478
	DECFSZ      R11, 1, 1
	BRA         L_entroBP6478
	NOP
;rutinasensores_v4(mstr-slv).h,2140 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2141 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2142 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2143 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2144 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP6+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP6+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP6+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP6+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBP6+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBP6+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBP6+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBP6+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,2145 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2146 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBP6479
;rutinasensores_v4(mstr-slv).h,2147 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,2148 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,2149 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,2150 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP6+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP6+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP6+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP6+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP6+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP6+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP6+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP6+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP6+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP6+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP6+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP6+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP6+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP6+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP6+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP6+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,2151 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2152 :: 		}
L_entroBP6479:
;rutinasensores_v4(mstr-slv).h,2153 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2154 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBP6
;rutinasensores_v4(mstr-slv).h,2155 :: 		}
L_entroBP6477:
;rutinasensores_v4(mstr-slv).h,2156 :: 		}
L_end_entroBP6:
	RETURN      0
; end of _entroBP6

_saliendoBP6:

;rutinasensores_v4(mstr-slv).h,2158 :: 		short saliendoBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2159 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBP6_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBP6480
;rutinasensores_v4(mstr-slv).h,2160 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_100_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_100_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_100_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2161 :: 		if(!SENSOR1){
	BTFSC       PORTB+0, 4 
	GOTO        L_saliendoBP6481
;rutinasensores_v4(mstr-slv).h,2162 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2163 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBP6
;rutinasensores_v4(mstr-slv).h,2164 :: 		}
L_saliendoBP6481:
;rutinasensores_v4(mstr-slv).h,2165 :: 		if((SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__saliendoBP62163
	BTFSS       PORTB+0, 3 
	GOTO        L__saliendoBP62163
	BSF         4056, 0 
	GOTO        L__saliendoBP62164
L__saliendoBP62163:
	BCF         4056, 0 
L__saliendoBP62164:
	BTFSS       4056, 0 
	GOTO        L__saliendoBP62165
	BTFSS       PORTB+0, 1 
	GOTO        L__saliendoBP62165
	BSF         R1, 0 
	GOTO        L__saliendoBP62166
L__saliendoBP62165:
	BCF         R1, 0 
L__saliendoBP62166:
	BTFSS       R1, 0 
	GOTO        L_saliendoBP6482
;rutinasensores_v4(mstr-slv).h,2166 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2167 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBP6
;rutinasensores_v4(mstr-slv).h,2168 :: 		}
L_saliendoBP6482:
;rutinasensores_v4(mstr-slv).h,2169 :: 		}
L_saliendoBP6480:
;rutinasensores_v4(mstr-slv).h,2170 :: 		}
L_end_saliendoBP6:
	RETURN      0
; end of _saliendoBP6

_transicionSBP6:

;rutinasensores_v4(mstr-slv).h,2172 :: 		short transicionSBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2173 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBP6_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBP6483
;rutinasensores_v4(mstr-slv).h,2174 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_101_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_101_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_101_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2175 :: 		if(SENSOR2 & SENSOR4 & SENSOR6){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSBP62168
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSBP62168
	BSF         4056, 0 
	GOTO        L__transicionSBP62169
L__transicionSBP62168:
	BCF         4056, 0 
L__transicionSBP62169:
	BTFSS       4056, 0 
	GOTO        L__transicionSBP62170
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSBP62170
	BSF         R1, 0 
	GOTO        L__transicionSBP62171
L__transicionSBP62170:
	BCF         R1, 0 
L__transicionSBP62171:
	BTFSS       R1, 0 
	GOTO        L_transicionSBP6484
;rutinasensores_v4(mstr-slv).h,2176 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2177 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBP6
;rutinasensores_v4(mstr-slv).h,2178 :: 		}
L_transicionSBP6484:
;rutinasensores_v4(mstr-slv).h,2179 :: 		if((SENSOR1 & !SENSOR2) | (SENSOR1 & !SENSOR4) | (SENSOR1 & !SENSOR6)){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBP62172
	BSF         4056, 0 
	GOTO        L__transicionSBP62173
L__transicionSBP62172:
	BCF         4056, 0 
L__transicionSBP62173:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBP62174
	BTFSS       4056, 0 
	GOTO        L__transicionSBP62174
	BSF         R1, 1 
	GOTO        L__transicionSBP62175
L__transicionSBP62174:
	BCF         R1, 1 
L__transicionSBP62175:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSBP62176
	BSF         4056, 0 
	GOTO        L__transicionSBP62177
L__transicionSBP62176:
	BCF         4056, 0 
L__transicionSBP62177:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBP62178
	BTFSS       4056, 0 
	GOTO        L__transicionSBP62178
	BSF         R1, 0 
	GOTO        L__transicionSBP62179
L__transicionSBP62178:
	BCF         R1, 0 
L__transicionSBP62179:
	BTFSC       R1, 1 
	GOTO        L__transicionSBP62180
	BTFSC       R1, 0 
	GOTO        L__transicionSBP62180
	BCF         R1, 1 
	GOTO        L__transicionSBP62181
L__transicionSBP62180:
	BSF         R1, 1 
L__transicionSBP62181:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBP62182
	BSF         4056, 0 
	GOTO        L__transicionSBP62183
L__transicionSBP62182:
	BCF         4056, 0 
L__transicionSBP62183:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBP62184
	BTFSS       4056, 0 
	GOTO        L__transicionSBP62184
	BSF         R1, 0 
	GOTO        L__transicionSBP62185
L__transicionSBP62184:
	BCF         R1, 0 
L__transicionSBP62185:
	BTFSC       R1, 1 
	GOTO        L__transicionSBP62186
	BTFSC       R1, 0 
	GOTO        L__transicionSBP62186
	BCF         4056, 0 
	GOTO        L__transicionSBP62187
L__transicionSBP62186:
	BSF         4056, 0 
L__transicionSBP62187:
	BTFSS       4056, 0 
	GOTO        L_transicionSBP6485
;rutinasensores_v4(mstr-slv).h,2180 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2181 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBP6
;rutinasensores_v4(mstr-slv).h,2182 :: 		}
L_transicionSBP6485:
;rutinasensores_v4(mstr-slv).h,2183 :: 		}
L_transicionSBP6483:
;rutinasensores_v4(mstr-slv).h,2184 :: 		}
L_end_transicionSBP6:
	RETURN      0
; end of _transicionSBP6

_transicionSalBP6:

;rutinasensores_v4(mstr-slv).h,2186 :: 		short transicionSalBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2187 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBP6_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBP6486
;rutinasensores_v4(mstr-slv).h,2188 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_102_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_102_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_102_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2189 :: 		if(!SENSOR2 | !SENSOR4 | !SENSOR6){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBP62189
	BSF         R1, 0 
	GOTO        L__transicionSalBP62190
L__transicionSalBP62189:
	BCF         R1, 0 
L__transicionSalBP62190:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBP62191
	BSF         4056, 0 
	GOTO        L__transicionSalBP62192
L__transicionSalBP62191:
	BCF         4056, 0 
L__transicionSalBP62192:
	BTFSC       R1, 0 
	GOTO        L__transicionSalBP62193
	BTFSC       4056, 0 
	GOTO        L__transicionSalBP62193
	BCF         R1, 0 
	GOTO        L__transicionSalBP62194
L__transicionSalBP62193:
	BSF         R1, 0 
L__transicionSalBP62194:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBP62195
	BSF         4056, 0 
	GOTO        L__transicionSalBP62196
L__transicionSalBP62195:
	BCF         4056, 0 
L__transicionSalBP62196:
	BTFSC       R1, 0 
	GOTO        L__transicionSalBP62197
	BTFSC       4056, 0 
	GOTO        L__transicionSalBP62197
	BCF         R1, 0 
	GOTO        L__transicionSalBP62198
L__transicionSalBP62197:
	BSF         R1, 0 
L__transicionSalBP62198:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBP6487
;rutinasensores_v4(mstr-slv).h,2190 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2191 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBP6
;rutinasensores_v4(mstr-slv).h,2192 :: 		}
L_transicionSalBP6487:
;rutinasensores_v4(mstr-slv).h,2193 :: 		if((SENSOR1) & (SENSOR2 & SENSOR4 & SENSOR6)){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSalBP62199
	BTFSS       PORTB+0, 3 
	GOTO        L__transicionSalBP62199
	BSF         4056, 0 
	GOTO        L__transicionSalBP62200
L__transicionSalBP62199:
	BCF         4056, 0 
L__transicionSalBP62200:
	BTFSS       4056, 0 
	GOTO        L__transicionSalBP62201
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSalBP62201
	BSF         R1, 0 
	GOTO        L__transicionSalBP62202
L__transicionSalBP62201:
	BCF         R1, 0 
L__transicionSalBP62202:
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBP62203
	BTFSS       R1, 0 
	GOTO        L__transicionSalBP62203
	BSF         4056, 0 
	GOTO        L__transicionSalBP62204
L__transicionSalBP62203:
	BCF         4056, 0 
L__transicionSalBP62204:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBP6488
;rutinasensores_v4(mstr-slv).h,2194 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2195 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBP6
;rutinasensores_v4(mstr-slv).h,2196 :: 		}
L_transicionSalBP6488:
;rutinasensores_v4(mstr-slv).h,2197 :: 		}
L_transicionSalBP6486:
;rutinasensores_v4(mstr-slv).h,2198 :: 		}
L_end_transicionSalBP6:
	RETURN      0
; end of _transicionSalBP6

_salioBP6:

;rutinasensores_v4(mstr-slv).h,2200 :: 		short salioBP6(short estado){
;rutinasensores_v4(mstr-slv).h,2201 :: 		if(estado == SALIO){
	MOVF        FARG_salioBP6_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBP6489
;rutinasensores_v4(mstr-slv).h,2202 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_103_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_103_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_103_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2203 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2204 :: 		pBajan = eepromLeeNumero(0x0003,2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2205 :: 		eepromEscribeNumero(0x0003,pBajan,2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2206 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP6+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP6+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP6+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP6+7 
	MOVF        FLOC__salioBP6+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBP6+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2207 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP6+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP6+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP6+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP6+3 
	MOVF        FLOC__salioBP6+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBP6+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBP6+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBP6+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBP6+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBP6+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,2208 :: 		eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Longint+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVF        R2, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVF        R3, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2209 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBP6490
;rutinasensores_v4(mstr-slv).h,2210 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,2211 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,2212 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,2213 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP6+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP6+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP6+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP6+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP6+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP6+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP6+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP6+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP6+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP6+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP6+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP6+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP6+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP6+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP6+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP6+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,2214 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2215 :: 		}
L_salioBP6490:
;rutinasensores_v4(mstr-slv).h,2216 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2217 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBP6
;rutinasensores_v4(mstr-slv).h,2218 :: 		}
L_salioBP6489:
;rutinasensores_v4(mstr-slv).h,2219 :: 		}
L_end_salioBP6:
	RETURN      0
; end of _salioBP6

_esperaBP7:

;rutinasensores_v4(mstr-slv).h,2225 :: 		short esperaBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2226 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBP7_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBP7491
;rutinasensores_v4(mstr-slv).h,2227 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,2229 :: 		if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBP72207
	BSF         R1, 0 
	GOTO        L__esperaBP72208
L__esperaBP72207:
	BCF         R1, 0 
L__esperaBP72208:
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaBP72209
	BSF         4056, 0 
	GOTO        L__esperaBP72210
L__esperaBP72209:
	BCF         4056, 0 
L__esperaBP72210:
	BTFSC       R1, 0 
	GOTO        L__esperaBP72211
	BTFSC       4056, 0 
	GOTO        L__esperaBP72211
	BCF         R1, 0 
	GOTO        L__esperaBP72212
L__esperaBP72211:
	BSF         R1, 0 
L__esperaBP72212:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaBP72213
	BSF         4056, 0 
	GOTO        L__esperaBP72214
L__esperaBP72213:
	BCF         4056, 0 
L__esperaBP72214:
	BTFSC       R1, 0 
	GOTO        L__esperaBP72215
	BTFSC       4056, 0 
	GOTO        L__esperaBP72215
	BCF         R1, 0 
	GOTO        L__esperaBP72216
L__esperaBP72215:
	BSF         R1, 0 
L__esperaBP72216:
	BTFSS       R1, 0 
	GOTO        L_esperaBP7492
;rutinasensores_v4(mstr-slv).h,2230 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2231 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBP7
;rutinasensores_v4(mstr-slv).h,2232 :: 		}
L_esperaBP7492:
;rutinasensores_v4(mstr-slv).h,2233 :: 		if((!SENSOR6)){
	BTFSC       PORTB+0, 1 
	GOTO        L_esperaBP7493
;rutinasensores_v4(mstr-slv).h,2234 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2235 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBP7
;rutinasensores_v4(mstr-slv).h,2236 :: 		}
L_esperaBP7493:
;rutinasensores_v4(mstr-slv).h,2237 :: 		}
L_esperaBP7491:
;rutinasensores_v4(mstr-slv).h,2238 :: 		}
L_end_esperaBP7:
	RETURN      0
; end of _esperaBP7

_entrandoBP7:

;rutinasensores_v4(mstr-slv).h,2240 :: 		short entrandoBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2241 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBP7_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBP7494
;rutinasensores_v4(mstr-slv).h,2242 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_104_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_104_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_104_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2243 :: 		if((SENSOR1 & SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBP72218
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoBP72218
	BSF         4056, 0 
	GOTO        L__entrandoBP72219
L__entrandoBP72218:
	BCF         4056, 0 
L__entrandoBP72219:
	BTFSS       4056, 0 
	GOTO        L__entrandoBP72220
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoBP72220
	BSF         R1, 0 
	GOTO        L__entrandoBP72221
L__entrandoBP72220:
	BCF         R1, 0 
L__entrandoBP72221:
	BTFSS       R1, 0 
	GOTO        L_entrandoBP7495
;rutinasensores_v4(mstr-slv).h,2244 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2245 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBP7
;rutinasensores_v4(mstr-slv).h,2246 :: 		}
L_entrandoBP7495:
;rutinasensores_v4(mstr-slv).h,2247 :: 		if(!SENSOR6){
	BTFSC       PORTB+0, 1 
	GOTO        L_entrandoBP7496
;rutinasensores_v4(mstr-slv).h,2248 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2249 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBP7
;rutinasensores_v4(mstr-slv).h,2250 :: 		}
L_entrandoBP7496:
;rutinasensores_v4(mstr-slv).h,2251 :: 		}
L_entrandoBP7494:
;rutinasensores_v4(mstr-slv).h,2252 :: 		}
L_end_entrandoBP7:
	RETURN      0
; end of _entrandoBP7

_transicionEBP7:

;rutinasensores_v4(mstr-slv).h,2254 :: 		short transicionEBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2255 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBP7_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBP7497
;rutinasensores_v4(mstr-slv).h,2256 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_105_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_105_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_105_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2257 :: 		if(SENSOR1 & SENSOR3 & SENSOR5){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBP72223
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBP72223
	BSF         4056, 0 
	GOTO        L__transicionEBP72224
L__transicionEBP72223:
	BCF         4056, 0 
L__transicionEBP72224:
	BTFSS       4056, 0 
	GOTO        L__transicionEBP72225
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBP72225
	BSF         R1, 0 
	GOTO        L__transicionEBP72226
L__transicionEBP72225:
	BCF         R1, 0 
L__transicionEBP72226:
	BTFSS       R1, 0 
	GOTO        L_transicionEBP7498
;rutinasensores_v4(mstr-slv).h,2258 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2259 :: 		return debugEstado = TRANENT;
	MOVLW       7
	MOVWF       _debugEstado+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBP7
;rutinasensores_v4(mstr-slv).h,2260 :: 		}
L_transicionEBP7498:
;rutinasensores_v4(mstr-slv).h,2261 :: 		if((SENSOR6 & !SENSOR1) | (SENSOR6 & !SENSOR3) | (SENSOR6 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBP72227
	BSF         4056, 0 
	GOTO        L__transicionEBP72228
L__transicionEBP72227:
	BCF         4056, 0 
L__transicionEBP72228:
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP72229
	BTFSS       4056, 0 
	GOTO        L__transicionEBP72229
	BSF         R1, 1 
	GOTO        L__transicionEBP72230
L__transicionEBP72229:
	BCF         R1, 1 
L__transicionEBP72230:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBP72231
	BSF         4056, 0 
	GOTO        L__transicionEBP72232
L__transicionEBP72231:
	BCF         4056, 0 
L__transicionEBP72232:
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP72233
	BTFSS       4056, 0 
	GOTO        L__transicionEBP72233
	BSF         R1, 0 
	GOTO        L__transicionEBP72234
L__transicionEBP72233:
	BCF         R1, 0 
L__transicionEBP72234:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP72235
	BTFSC       R1, 0 
	GOTO        L__transicionEBP72235
	BCF         R1, 1 
	GOTO        L__transicionEBP72236
L__transicionEBP72235:
	BSF         R1, 1 
L__transicionEBP72236:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBP72237
	BSF         4056, 0 
	GOTO        L__transicionEBP72238
L__transicionEBP72237:
	BCF         4056, 0 
L__transicionEBP72238:
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEBP72239
	BTFSS       4056, 0 
	GOTO        L__transicionEBP72239
	BSF         R1, 0 
	GOTO        L__transicionEBP72240
L__transicionEBP72239:
	BCF         R1, 0 
L__transicionEBP72240:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP72241
	BTFSC       R1, 0 
	GOTO        L__transicionEBP72241
	BCF         4056, 0 
	GOTO        L__transicionEBP72242
L__transicionEBP72241:
	BSF         4056, 0 
L__transicionEBP72242:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP7499
;rutinasensores_v4(mstr-slv).h,2262 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2263 :: 		return debugEstado = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstado+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBP7
;rutinasensores_v4(mstr-slv).h,2264 :: 		}
L_transicionEBP7499:
;rutinasensores_v4(mstr-slv).h,2265 :: 		}
L_transicionEBP7497:
;rutinasensores_v4(mstr-slv).h,2266 :: 		}
L_end_transicionEBP7:
	RETURN      0
; end of _transicionEBP7

_transicionEntBP7:

;rutinasensores_v4(mstr-slv).h,2268 :: 		short transicionEntBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2269 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBP7_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBP7500
;rutinasensores_v4(mstr-slv).h,2270 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_106_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_106_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_106_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2271 :: 		if((!SENSOR3 | !SENSOR1 | !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntBP72244
	BSF         R1, 0 
	GOTO        L__transicionEntBP72245
L__transicionEntBP72244:
	BCF         R1, 0 
L__transicionEntBP72245:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBP72246
	BSF         4056, 0 
	GOTO        L__transicionEntBP72247
L__transicionEntBP72246:
	BCF         4056, 0 
L__transicionEntBP72247:
	BTFSC       R1, 0 
	GOTO        L__transicionEntBP72248
	BTFSC       4056, 0 
	GOTO        L__transicionEntBP72248
	BCF         R1, 0 
	GOTO        L__transicionEntBP72249
L__transicionEntBP72248:
	BSF         R1, 0 
L__transicionEntBP72249:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntBP72250
	BSF         4056, 0 
	GOTO        L__transicionEntBP72251
L__transicionEntBP72250:
	BCF         4056, 0 
L__transicionEntBP72251:
	BTFSC       R1, 0 
	GOTO        L__transicionEntBP72252
	BTFSC       4056, 0 
	GOTO        L__transicionEntBP72252
	BCF         R1, 0 
	GOTO        L__transicionEntBP72253
L__transicionEntBP72252:
	BSF         R1, 0 
L__transicionEntBP72253:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBP7501
;rutinasensores_v4(mstr-slv).h,2272 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2273 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBP7
;rutinasensores_v4(mstr-slv).h,2274 :: 		}
L_transicionEntBP7501:
;rutinasensores_v4(mstr-slv).h,2275 :: 		if(SENSOR6 & SENSOR1 & SENSOR3 & SENSOR5){
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionEntBP72254
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEntBP72254
	BSF         4056, 0 
	GOTO        L__transicionEntBP72255
L__transicionEntBP72254:
	BCF         4056, 0 
L__transicionEntBP72255:
	BTFSS       4056, 0 
	GOTO        L__transicionEntBP72256
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEntBP72256
	BSF         R1, 0 
	GOTO        L__transicionEntBP72257
L__transicionEntBP72256:
	BCF         R1, 0 
L__transicionEntBP72257:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBP72258
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEntBP72258
	BSF         4056, 0 
	GOTO        L__transicionEntBP72259
L__transicionEntBP72258:
	BCF         4056, 0 
L__transicionEntBP72259:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBP7502
;rutinasensores_v4(mstr-slv).h,2276 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2277 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBP7
;rutinasensores_v4(mstr-slv).h,2278 :: 		}
L_transicionEntBP7502:
;rutinasensores_v4(mstr-slv).h,2279 :: 		}
L_transicionEntBP7500:
;rutinasensores_v4(mstr-slv).h,2280 :: 		}
L_end_transicionEntBP7:
	RETURN      0
; end of _transicionEntBP7

_entroBP7:

;rutinasensores_v4(mstr-slv).h,2282 :: 		short entroBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2283 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBP7_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBP7503
;rutinasensores_v4(mstr-slv).h,2284 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_107_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_107_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_107_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2285 :: 		delay_ms(350);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_entroBP7504:
	DECFSZ      R13, 1, 1
	BRA         L_entroBP7504
	DECFSZ      R12, 1, 1
	BRA         L_entroBP7504
	DECFSZ      R11, 1, 1
	BRA         L_entroBP7504
	NOP
;rutinasensores_v4(mstr-slv).h,2286 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2287 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2288 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2289 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2290 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP7+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP7+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP7+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP7+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBP7+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBP7+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBP7+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBP7+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,2291 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2292 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBP7505
;rutinasensores_v4(mstr-slv).h,2293 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,2294 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,2295 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,2296 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP7+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP7+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP7+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP7+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP7+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP7+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP7+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP7+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP7+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP7+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP7+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP7+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP7+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP7+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP7+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP7+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,2297 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2298 :: 		}
L_entroBP7505:
;rutinasensores_v4(mstr-slv).h,2299 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2300 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBP7
;rutinasensores_v4(mstr-slv).h,2301 :: 		}
L_entroBP7503:
;rutinasensores_v4(mstr-slv).h,2302 :: 		}
L_end_entroBP7:
	RETURN      0
; end of _entroBP7

_saliendoBP7:

;rutinasensores_v4(mstr-slv).h,2304 :: 		short saliendoBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2305 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBP7_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBP7506
;rutinasensores_v4(mstr-slv).h,2306 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_108_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_108_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_108_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2307 :: 		if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBP72262
	BSF         R1, 3 
	GOTO        L__saliendoBP72263
L__saliendoBP72262:
	BCF         R1, 3 
L__saliendoBP72263:
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoBP72264
	BSF         R1, 0 
	GOTO        L__saliendoBP72265
L__saliendoBP72264:
	BCF         R1, 0 
L__saliendoBP72265:
	BTFSS       R1, 3 
	GOTO        L__saliendoBP72266
	BTFSS       R1, 0 
	GOTO        L__saliendoBP72266
	BSF         R1, 1 
	GOTO        L__saliendoBP72267
L__saliendoBP72266:
	BCF         R1, 1 
L__saliendoBP72267:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoBP72268
	BSF         R1, 2 
	GOTO        L__saliendoBP72269
L__saliendoBP72268:
	BCF         R1, 2 
L__saliendoBP72269:
	BTFSS       R1, 0 
	GOTO        L__saliendoBP72270
	BTFSS       R1, 2 
	GOTO        L__saliendoBP72270
	BSF         4056, 0 
	GOTO        L__saliendoBP72271
L__saliendoBP72270:
	BCF         4056, 0 
L__saliendoBP72271:
	BTFSC       R1, 1 
	GOTO        L__saliendoBP72272
	BTFSC       4056, 0 
	GOTO        L__saliendoBP72272
	BCF         R1, 1 
	GOTO        L__saliendoBP72273
L__saliendoBP72272:
	BSF         R1, 1 
L__saliendoBP72273:
	BTFSC       R1, 3 
	GOTO        L__saliendoBP72274
	BCF         R1, 0 
	GOTO        L__saliendoBP72275
L__saliendoBP72274:
	BSF         R1, 0 
L__saliendoBP72275:
	BTFSC       R1, 2 
	GOTO        L__saliendoBP72276
	BCF         4056, 0 
	GOTO        L__saliendoBP72277
L__saliendoBP72276:
	BSF         4056, 0 
L__saliendoBP72277:
	BTFSS       R1, 0 
	GOTO        L__saliendoBP72278
	BTFSS       4056, 0 
	GOTO        L__saliendoBP72278
	BSF         R1, 0 
	GOTO        L__saliendoBP72279
L__saliendoBP72278:
	BCF         R1, 0 
L__saliendoBP72279:
	BTFSC       R1, 1 
	GOTO        L__saliendoBP72280
	BTFSC       R1, 0 
	GOTO        L__saliendoBP72280
	BCF         4056, 0 
	GOTO        L__saliendoBP72281
L__saliendoBP72280:
	BSF         4056, 0 
L__saliendoBP72281:
	BTFSS       4056, 0 
	GOTO        L_saliendoBP7507
;rutinasensores_v4(mstr-slv).h,2308 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2309 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBP7
;rutinasensores_v4(mstr-slv).h,2310 :: 		}
L_saliendoBP7507:
;rutinasensores_v4(mstr-slv).h,2311 :: 		if((SENSOR6)){
	BTFSS       PORTB+0, 1 
	GOTO        L_saliendoBP7508
;rutinasensores_v4(mstr-slv).h,2312 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2313 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBP7
;rutinasensores_v4(mstr-slv).h,2314 :: 		}
L_saliendoBP7508:
;rutinasensores_v4(mstr-slv).h,2315 :: 		}
L_saliendoBP7506:
;rutinasensores_v4(mstr-slv).h,2316 :: 		}
L_end_saliendoBP7:
	RETURN      0
; end of _saliendoBP7

_transicionSBP7:

;rutinasensores_v4(mstr-slv).h,2318 :: 		short transicionSBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2319 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBP7_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBP7509
;rutinasensores_v4(mstr-slv).h,2320 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_109_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_109_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_109_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2321 :: 		if(SENSOR6){
	BTFSS       PORTB+0, 1 
	GOTO        L_transicionSBP7510
;rutinasensores_v4(mstr-slv).h,2322 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2323 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBP7
;rutinasensores_v4(mstr-slv).h,2324 :: 		}
L_transicionSBP7510:
;rutinasensores_v4(mstr-slv).h,2325 :: 		if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR6)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBP72283
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSBP72283
	BSF         4056, 0 
	GOTO        L__transicionSBP72284
L__transicionSBP72283:
	BCF         4056, 0 
L__transicionSBP72284:
	BTFSS       4056, 0 
	GOTO        L__transicionSBP72285
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBP72285
	BSF         R1, 0 
	GOTO        L__transicionSBP72286
L__transicionSBP72285:
	BCF         R1, 0 
L__transicionSBP72286:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSBP72287
	BSF         4056, 0 
	GOTO        L__transicionSBP72288
L__transicionSBP72287:
	BCF         4056, 0 
L__transicionSBP72288:
	BTFSS       R1, 0 
	GOTO        L__transicionSBP72289
	BTFSS       4056, 0 
	GOTO        L__transicionSBP72289
	BSF         R1, 0 
	GOTO        L__transicionSBP72290
L__transicionSBP72289:
	BCF         R1, 0 
L__transicionSBP72290:
	BTFSS       R1, 0 
	GOTO        L_transicionSBP7511
;rutinasensores_v4(mstr-slv).h,2326 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2327 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBP7
;rutinasensores_v4(mstr-slv).h,2328 :: 		}
L_transicionSBP7511:
;rutinasensores_v4(mstr-slv).h,2329 :: 		}
L_transicionSBP7509:
;rutinasensores_v4(mstr-slv).h,2330 :: 		}
L_end_transicionSBP7:
	RETURN      0
; end of _transicionSBP7

_transicionSalBP7:

;rutinasensores_v4(mstr-slv).h,2332 :: 		short transicionSalBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2333 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBP7_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBP7512
;rutinasensores_v4(mstr-slv).h,2334 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_110_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_110_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_110_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2335 :: 		if(!SENSOR6){
	BTFSC       PORTB+0, 1 
	GOTO        L_transicionSalBP7513
;rutinasensores_v4(mstr-slv).h,2336 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2337 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBP7
;rutinasensores_v4(mstr-slv).h,2338 :: 		}
L_transicionSalBP7513:
;rutinasensores_v4(mstr-slv).h,2339 :: 		if((SENSOR1 & SENSOR3 & SENSOR5) & (SENSOR6)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBP72292
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalBP72292
	BSF         4056, 0 
	GOTO        L__transicionSalBP72293
L__transicionSalBP72292:
	BCF         4056, 0 
L__transicionSalBP72293:
	BTFSS       4056, 0 
	GOTO        L__transicionSalBP72294
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBP72294
	BSF         R1, 0 
	GOTO        L__transicionSalBP72295
L__transicionSalBP72294:
	BCF         R1, 0 
L__transicionSalBP72295:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBP72296
	BTFSS       PORTB+0, 1 
	GOTO        L__transicionSalBP72296
	BSF         4056, 0 
	GOTO        L__transicionSalBP72297
L__transicionSalBP72296:
	BCF         4056, 0 
L__transicionSalBP72297:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBP7514
;rutinasensores_v4(mstr-slv).h,2340 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2341 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBP7
;rutinasensores_v4(mstr-slv).h,2342 :: 		}
L_transicionSalBP7514:
;rutinasensores_v4(mstr-slv).h,2343 :: 		}
L_transicionSalBP7512:
;rutinasensores_v4(mstr-slv).h,2344 :: 		}
L_end_transicionSalBP7:
	RETURN      0
; end of _transicionSalBP7

_salioBP7:

;rutinasensores_v4(mstr-slv).h,2346 :: 		short salioBP7(short estado){
;rutinasensores_v4(mstr-slv).h,2347 :: 		if(estado == SALIO){
	MOVF        FARG_salioBP7_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBP7515
;rutinasensores_v4(mstr-slv).h,2348 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_111_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_111_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_111_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2349 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2350 :: 		pBajan = eepromLeeNumero(0x0003,2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2351 :: 		eepromEscribeNumero(0x0003,pBajan,2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2352 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP7+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP7+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP7+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP7+7 
	MOVF        FLOC__salioBP7+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBP7+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2353 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP7+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP7+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP7+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP7+3 
	MOVF        FLOC__salioBP7+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBP7+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBP7+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBP7+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBP7+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBP7+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,2354 :: 		eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Longint+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVF        R2, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVF        R3, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2355 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBP7516
;rutinasensores_v4(mstr-slv).h,2356 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,2357 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,2358 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,2359 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP7+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP7+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP7+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP7+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP7+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP7+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP7+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP7+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP7+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP7+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP7+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP7+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP7+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP7+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP7+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP7+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,2360 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2361 :: 		}
L_salioBP7516:
;rutinasensores_v4(mstr-slv).h,2362 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2363 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBP7
;rutinasensores_v4(mstr-slv).h,2364 :: 		}
L_salioBP7515:
;rutinasensores_v4(mstr-slv).h,2365 :: 		}
L_end_salioBP7:
	RETURN      0
; end of _salioBP7

_esperaBP9:

;rutinasensores_v4(mstr-slv).h,2371 :: 		short esperaBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2372 :: 		if(estado == ESPERA){
	MOVF        FARG_esperaBP9_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_esperaBP9517
;rutinasensores_v4(mstr-slv).h,2373 :: 		muestraEstatus();
	CALL        _muestraEstatus+0, 0
;rutinasensores_v4(mstr-slv).h,2375 :: 		if((!SENSOR1 | !SENSOR3 | !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__esperaBP92300
	BSF         R1, 0 
	GOTO        L__esperaBP92301
L__esperaBP92300:
	BCF         R1, 0 
L__esperaBP92301:
	BTFSC       PORTB+0, 2 
	GOTO        L__esperaBP92302
	BSF         4056, 0 
	GOTO        L__esperaBP92303
L__esperaBP92302:
	BCF         4056, 0 
L__esperaBP92303:
	BTFSC       R1, 0 
	GOTO        L__esperaBP92304
	BTFSC       4056, 0 
	GOTO        L__esperaBP92304
	BCF         R1, 0 
	GOTO        L__esperaBP92305
L__esperaBP92304:
	BSF         R1, 0 
L__esperaBP92305:
	BTFSC       PORTB+0, 0 
	GOTO        L__esperaBP92306
	BSF         4056, 0 
	GOTO        L__esperaBP92307
L__esperaBP92306:
	BCF         4056, 0 
L__esperaBP92307:
	BTFSC       R1, 0 
	GOTO        L__esperaBP92308
	BTFSC       4056, 0 
	GOTO        L__esperaBP92308
	BCF         R1, 0 
	GOTO        L__esperaBP92309
L__esperaBP92308:
	BSF         R1, 0 
L__esperaBP92309:
	BTFSS       R1, 0 
	GOTO        L_esperaBP9518
;rutinasensores_v4(mstr-slv).h,2376 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2377 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_esperaBP9
;rutinasensores_v4(mstr-slv).h,2378 :: 		}
L_esperaBP9518:
;rutinasensores_v4(mstr-slv).h,2379 :: 		if((!SENSOR2)){
	BTFSC       PORTD+0, 4 
	GOTO        L_esperaBP9519
;rutinasensores_v4(mstr-slv).h,2380 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2381 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_esperaBP9
;rutinasensores_v4(mstr-slv).h,2382 :: 		}
L_esperaBP9519:
;rutinasensores_v4(mstr-slv).h,2383 :: 		}
L_esperaBP9517:
;rutinasensores_v4(mstr-slv).h,2384 :: 		}
L_end_esperaBP9:
	RETURN      0
; end of _esperaBP9

_entrandoBP9:

;rutinasensores_v4(mstr-slv).h,2386 :: 		short entrandoBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2387 :: 		if(estado == ENTRANDO){
	MOVF        FARG_entrandoBP9_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_entrandoBP9520
;rutinasensores_v4(mstr-slv).h,2388 :: 		LCD_OUTCONST(3,1,"ENTRANDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_112_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_112_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_112_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2389 :: 		if((SENSOR1 & SENSOR3 & SENSOR5)){
	BTFSS       PORTB+0, 4 
	GOTO        L__entrandoBP92311
	BTFSS       PORTB+0, 2 
	GOTO        L__entrandoBP92311
	BSF         4056, 0 
	GOTO        L__entrandoBP92312
L__entrandoBP92311:
	BCF         4056, 0 
L__entrandoBP92312:
	BTFSS       4056, 0 
	GOTO        L__entrandoBP92313
	BTFSS       PORTB+0, 0 
	GOTO        L__entrandoBP92313
	BSF         R1, 0 
	GOTO        L__entrandoBP92314
L__entrandoBP92313:
	BCF         R1, 0 
L__entrandoBP92314:
	BTFSS       R1, 0 
	GOTO        L_entrandoBP9521
;rutinasensores_v4(mstr-slv).h,2390 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2391 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entrandoBP9
;rutinasensores_v4(mstr-slv).h,2392 :: 		}
L_entrandoBP9521:
;rutinasensores_v4(mstr-slv).h,2393 :: 		if(!SENSOR2){
	BTFSC       PORTD+0, 4 
	GOTO        L_entrandoBP9522
;rutinasensores_v4(mstr-slv).h,2394 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2395 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_entrandoBP9
;rutinasensores_v4(mstr-slv).h,2396 :: 		}
L_entrandoBP9522:
;rutinasensores_v4(mstr-slv).h,2397 :: 		}
L_entrandoBP9520:
;rutinasensores_v4(mstr-slv).h,2398 :: 		}
L_end_entrandoBP9:
	RETURN      0
; end of _entrandoBP9

_transicionEBP9:

;rutinasensores_v4(mstr-slv).h,2400 :: 		short transicionEBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2401 :: 		if(estado == TRANSICION){
	MOVF        FARG_transicionEBP9_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEBP9523
;rutinasensores_v4(mstr-slv).h,2402 :: 		LCD_OUTCONST(3,1,"TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_113_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_113_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_113_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2403 :: 		if(SENSOR1 & SENSOR3 & SENSOR5){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEBP92316
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEBP92316
	BSF         4056, 0 
	GOTO        L__transicionEBP92317
L__transicionEBP92316:
	BCF         4056, 0 
L__transicionEBP92317:
	BTFSS       4056, 0 
	GOTO        L__transicionEBP92318
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEBP92318
	BSF         R1, 0 
	GOTO        L__transicionEBP92319
L__transicionEBP92318:
	BCF         R1, 0 
L__transicionEBP92319:
	BTFSS       R1, 0 
	GOTO        L_transicionEBP9524
;rutinasensores_v4(mstr-slv).h,2404 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2405 :: 		return debugEstadoB = TRANENT;
	MOVLW       7
	MOVWF       _debugEstadoB+0 
	MOVLW       7
	MOVWF       R0 
	GOTO        L_end_transicionEBP9
;rutinasensores_v4(mstr-slv).h,2406 :: 		}
L_transicionEBP9524:
;rutinasensores_v4(mstr-slv).h,2407 :: 		if((SENSOR2 & !SENSOR1) | (SENSOR2 & !SENSOR3) | (SENSOR2 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEBP92320
	BSF         4056, 0 
	GOTO        L__transicionEBP92321
L__transicionEBP92320:
	BCF         4056, 0 
L__transicionEBP92321:
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBP92322
	BTFSS       4056, 0 
	GOTO        L__transicionEBP92322
	BSF         R1, 1 
	GOTO        L__transicionEBP92323
L__transicionEBP92322:
	BCF         R1, 1 
L__transicionEBP92323:
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEBP92324
	BSF         4056, 0 
	GOTO        L__transicionEBP92325
L__transicionEBP92324:
	BCF         4056, 0 
L__transicionEBP92325:
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBP92326
	BTFSS       4056, 0 
	GOTO        L__transicionEBP92326
	BSF         R1, 0 
	GOTO        L__transicionEBP92327
L__transicionEBP92326:
	BCF         R1, 0 
L__transicionEBP92327:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP92328
	BTFSC       R1, 0 
	GOTO        L__transicionEBP92328
	BCF         R1, 1 
	GOTO        L__transicionEBP92329
L__transicionEBP92328:
	BSF         R1, 1 
L__transicionEBP92329:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEBP92330
	BSF         4056, 0 
	GOTO        L__transicionEBP92331
L__transicionEBP92330:
	BCF         4056, 0 
L__transicionEBP92331:
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEBP92332
	BTFSS       4056, 0 
	GOTO        L__transicionEBP92332
	BSF         R1, 0 
	GOTO        L__transicionEBP92333
L__transicionEBP92332:
	BCF         R1, 0 
L__transicionEBP92333:
	BTFSC       R1, 1 
	GOTO        L__transicionEBP92334
	BTFSC       R1, 0 
	GOTO        L__transicionEBP92334
	BCF         4056, 0 
	GOTO        L__transicionEBP92335
L__transicionEBP92334:
	BSF         4056, 0 
L__transicionEBP92335:
	BTFSS       4056, 0 
	GOTO        L_transicionEBP9525
;rutinasensores_v4(mstr-slv).h,2408 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2409 :: 		return debugEstadoB = ENTRANDO;
	MOVLW       1
	MOVWF       _debugEstadoB+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_transicionEBP9
;rutinasensores_v4(mstr-slv).h,2410 :: 		}
L_transicionEBP9525:
;rutinasensores_v4(mstr-slv).h,2411 :: 		}
L_transicionEBP9523:
;rutinasensores_v4(mstr-slv).h,2412 :: 		}
L_end_transicionEBP9:
	RETURN      0
; end of _transicionEBP9

_transicionEntBP9:

;rutinasensores_v4(mstr-slv).h,2414 :: 		short transicionEntBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2415 :: 		if(estado == TRANENT){
	MOVF        FARG_transicionEntBP9_estado+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionEntBP9526
;rutinasensores_v4(mstr-slv).h,2416 :: 		LCD_OUTCONST(3,1,"TRANSICION ENTRADA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_114_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_114_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_114_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2417 :: 		if((!SENSOR3 | !SENSOR1 | !SENSOR5)/*(!SENSOR1 | !SENSOR3) | (!SENSOR3 | !SENSOR5) | (!SENSOR1 | !SENSOR5)*/){
	BTFSC       PORTB+0, 2 
	GOTO        L__transicionEntBP92337
	BSF         R1, 0 
	GOTO        L__transicionEntBP92338
L__transicionEntBP92337:
	BCF         R1, 0 
L__transicionEntBP92338:
	BTFSC       PORTB+0, 4 
	GOTO        L__transicionEntBP92339
	BSF         4056, 0 
	GOTO        L__transicionEntBP92340
L__transicionEntBP92339:
	BCF         4056, 0 
L__transicionEntBP92340:
	BTFSC       R1, 0 
	GOTO        L__transicionEntBP92341
	BTFSC       4056, 0 
	GOTO        L__transicionEntBP92341
	BCF         R1, 0 
	GOTO        L__transicionEntBP92342
L__transicionEntBP92341:
	BSF         R1, 0 
L__transicionEntBP92342:
	BTFSC       PORTB+0, 0 
	GOTO        L__transicionEntBP92343
	BSF         4056, 0 
	GOTO        L__transicionEntBP92344
L__transicionEntBP92343:
	BCF         4056, 0 
L__transicionEntBP92344:
	BTFSC       R1, 0 
	GOTO        L__transicionEntBP92345
	BTFSC       4056, 0 
	GOTO        L__transicionEntBP92345
	BCF         R1, 0 
	GOTO        L__transicionEntBP92346
L__transicionEntBP92345:
	BSF         R1, 0 
L__transicionEntBP92346:
	BTFSS       R1, 0 
	GOTO        L_transicionEntBP9527
;rutinasensores_v4(mstr-slv).h,2418 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2419 :: 		return debugEstadoB = TRANSICION;
	MOVLW       2
	MOVWF       _debugEstadoB+0 
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_transicionEntBP9
;rutinasensores_v4(mstr-slv).h,2420 :: 		}
L_transicionEntBP9527:
;rutinasensores_v4(mstr-slv).h,2421 :: 		if(SENSOR2 & SENSOR1 & SENSOR3 & SENSOR5){
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionEntBP92347
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionEntBP92347
	BSF         4056, 0 
	GOTO        L__transicionEntBP92348
L__transicionEntBP92347:
	BCF         4056, 0 
L__transicionEntBP92348:
	BTFSS       4056, 0 
	GOTO        L__transicionEntBP92349
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionEntBP92349
	BSF         R1, 0 
	GOTO        L__transicionEntBP92350
L__transicionEntBP92349:
	BCF         R1, 0 
L__transicionEntBP92350:
	BTFSS       R1, 0 
	GOTO        L__transicionEntBP92351
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionEntBP92351
	BSF         4056, 0 
	GOTO        L__transicionEntBP92352
L__transicionEntBP92351:
	BCF         4056, 0 
L__transicionEntBP92352:
	BTFSS       4056, 0 
	GOTO        L_transicionEntBP9528
;rutinasensores_v4(mstr-slv).h,2422 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2423 :: 		return debugEstadoB = ENTRO;
	MOVLW       3
	MOVWF       _debugEstadoB+0 
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_transicionEntBP9
;rutinasensores_v4(mstr-slv).h,2424 :: 		}
L_transicionEntBP9528:
;rutinasensores_v4(mstr-slv).h,2425 :: 		}
L_transicionEntBP9526:
;rutinasensores_v4(mstr-slv).h,2426 :: 		}
L_end_transicionEntBP9:
	RETURN      0
; end of _transicionEntBP9

_entroBP9:

;rutinasensores_v4(mstr-slv).h,2428 :: 		short entroBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2429 :: 		if(estado == ENTRO){
	MOVF        FARG_entroBP9_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_entroBP9529
;rutinasensores_v4(mstr-slv).h,2430 :: 		LCD_OUTCONST(3,1,"BIENVENIDO: $6.00");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_115_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_115_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_115_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2431 :: 		delay_ms(350);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_entroBP9530:
	DECFSZ      R13, 1, 1
	BRA         L_entroBP9530
	DECFSZ      R12, 1, 1
	BRA         L_entroBP9530
	DECFSZ      R11, 1, 1
	BRA         L_entroBP9530
	NOP
;rutinasensores_v4(mstr-slv).h,2432 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2433 :: 		pSuben = eepromLeeNumero(0x0000,2) + 1;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2434 :: 		eepromEscribeNumero(0x0000,pSuben,2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2435 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2436 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP9+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP9+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP9+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP9+3 
	MOVF        _pBajan+0, 0 
	MOVWF       R0 
	MOVF        _pBajan+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__entroBP9+0, 0 
	MOVWF       R4 
	MOVF        FLOC__entroBP9+1, 0 
	MOVWF       R5 
	MOVF        FLOC__entroBP9+2, 0 
	MOVWF       R6 
	MOVF        FLOC__entroBP9+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,2437 :: 		eepromEscribeNumero(0x0009, (unsigned int)pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2438 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_entroBP9531
;rutinasensores_v4(mstr-slv).h,2439 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,2440 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,2441 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,2442 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__entroBP9+0 
	MOVF        R1, 0 
	MOVWF       FLOC__entroBP9+1 
	MOVF        R2, 0 
	MOVWF       FLOC__entroBP9+2 
	MOVF        R3, 0 
	MOVWF       FLOC__entroBP9+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP9+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP9+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP9+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP9+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP9+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP9+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP9+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP9+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__entroBP9+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__entroBP9+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__entroBP9+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__entroBP9+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,2443 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2444 :: 		}
L_entroBP9531:
;rutinasensores_v4(mstr-slv).h,2445 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2446 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_entroBP9
;rutinasensores_v4(mstr-slv).h,2447 :: 		}
L_entroBP9529:
;rutinasensores_v4(mstr-slv).h,2448 :: 		}
L_end_entroBP9:
	RETURN      0
; end of _entroBP9

_saliendoBP9:

;rutinasensores_v4(mstr-slv).h,2450 :: 		short saliendoBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2451 :: 		if(estado == SALIENDO){
	MOVF        FARG_saliendoBP9_estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_saliendoBP9532
;rutinasensores_v4(mstr-slv).h,2452 :: 		lcd_outConst(3, 1, "SALIENDO");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_116_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_116_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_116_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2453 :: 		if((!SENSOR1 & !SENSOR3) | (!SENSOR3 & !SENSOR5) | (!SENSOR1 & !SENSOR5)){
	BTFSC       PORTB+0, 4 
	GOTO        L__saliendoBP92355
	BSF         R1, 3 
	GOTO        L__saliendoBP92356
L__saliendoBP92355:
	BCF         R1, 3 
L__saliendoBP92356:
	BTFSC       PORTB+0, 2 
	GOTO        L__saliendoBP92357
	BSF         R1, 0 
	GOTO        L__saliendoBP92358
L__saliendoBP92357:
	BCF         R1, 0 
L__saliendoBP92358:
	BTFSS       R1, 3 
	GOTO        L__saliendoBP92359
	BTFSS       R1, 0 
	GOTO        L__saliendoBP92359
	BSF         R1, 1 
	GOTO        L__saliendoBP92360
L__saliendoBP92359:
	BCF         R1, 1 
L__saliendoBP92360:
	BTFSC       PORTB+0, 0 
	GOTO        L__saliendoBP92361
	BSF         R1, 2 
	GOTO        L__saliendoBP92362
L__saliendoBP92361:
	BCF         R1, 2 
L__saliendoBP92362:
	BTFSS       R1, 0 
	GOTO        L__saliendoBP92363
	BTFSS       R1, 2 
	GOTO        L__saliendoBP92363
	BSF         4056, 0 
	GOTO        L__saliendoBP92364
L__saliendoBP92363:
	BCF         4056, 0 
L__saliendoBP92364:
	BTFSC       R1, 1 
	GOTO        L__saliendoBP92365
	BTFSC       4056, 0 
	GOTO        L__saliendoBP92365
	BCF         R1, 1 
	GOTO        L__saliendoBP92366
L__saliendoBP92365:
	BSF         R1, 1 
L__saliendoBP92366:
	BTFSC       R1, 3 
	GOTO        L__saliendoBP92367
	BCF         R1, 0 
	GOTO        L__saliendoBP92368
L__saliendoBP92367:
	BSF         R1, 0 
L__saliendoBP92368:
	BTFSC       R1, 2 
	GOTO        L__saliendoBP92369
	BCF         4056, 0 
	GOTO        L__saliendoBP92370
L__saliendoBP92369:
	BSF         4056, 0 
L__saliendoBP92370:
	BTFSS       R1, 0 
	GOTO        L__saliendoBP92371
	BTFSS       4056, 0 
	GOTO        L__saliendoBP92371
	BSF         R1, 0 
	GOTO        L__saliendoBP92372
L__saliendoBP92371:
	BCF         R1, 0 
L__saliendoBP92372:
	BTFSC       R1, 1 
	GOTO        L__saliendoBP92373
	BTFSC       R1, 0 
	GOTO        L__saliendoBP92373
	BCF         4056, 0 
	GOTO        L__saliendoBP92374
L__saliendoBP92373:
	BSF         4056, 0 
L__saliendoBP92374:
	BTFSS       4056, 0 
	GOTO        L_saliendoBP9533
;rutinasensores_v4(mstr-slv).h,2454 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2455 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_saliendoBP9
;rutinasensores_v4(mstr-slv).h,2456 :: 		}
L_saliendoBP9533:
;rutinasensores_v4(mstr-slv).h,2457 :: 		if((SENSOR2)){
	BTFSS       PORTD+0, 4 
	GOTO        L_saliendoBP9534
;rutinasensores_v4(mstr-slv).h,2458 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2459 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_saliendoBP9
;rutinasensores_v4(mstr-slv).h,2460 :: 		}
L_saliendoBP9534:
;rutinasensores_v4(mstr-slv).h,2461 :: 		}
L_saliendoBP9532:
;rutinasensores_v4(mstr-slv).h,2462 :: 		}
L_end_saliendoBP9:
	RETURN      0
; end of _saliendoBP9

_transicionSBP9:

;rutinasensores_v4(mstr-slv).h,2464 :: 		short transicionSBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2465 :: 		if(estado == TRANSICIONS){
	MOVF        FARG_transicionSBP9_estado+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSBP9535
;rutinasensores_v4(mstr-slv).h,2466 :: 		lcd_outConst(3, 1, "TRANSICION");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_117_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_117_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_117_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2467 :: 		if(SENSOR2){
	BTFSS       PORTD+0, 4 
	GOTO        L_transicionSBP9536
;rutinasensores_v4(mstr-slv).h,2468 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2469 :: 		return debugEstadoB = TRANSAL;
	MOVLW       5
	MOVWF       _debugEstadoB+0 
	MOVLW       5
	MOVWF       R0 
	GOTO        L_end_transicionSBP9
;rutinasensores_v4(mstr-slv).h,2470 :: 		}
L_transicionSBP9536:
;rutinasensores_v4(mstr-slv).h,2471 :: 		if((SENSOR1 & SENSOR3 & SENSOR5 & !SENSOR2)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSBP92376
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSBP92376
	BSF         4056, 0 
	GOTO        L__transicionSBP92377
L__transicionSBP92376:
	BCF         4056, 0 
L__transicionSBP92377:
	BTFSS       4056, 0 
	GOTO        L__transicionSBP92378
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSBP92378
	BSF         R1, 0 
	GOTO        L__transicionSBP92379
L__transicionSBP92378:
	BCF         R1, 0 
L__transicionSBP92379:
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSBP92380
	BSF         4056, 0 
	GOTO        L__transicionSBP92381
L__transicionSBP92380:
	BCF         4056, 0 
L__transicionSBP92381:
	BTFSS       R1, 0 
	GOTO        L__transicionSBP92382
	BTFSS       4056, 0 
	GOTO        L__transicionSBP92382
	BSF         R1, 0 
	GOTO        L__transicionSBP92383
L__transicionSBP92382:
	BCF         R1, 0 
L__transicionSBP92383:
	BTFSS       R1, 0 
	GOTO        L_transicionSBP9537
;rutinasensores_v4(mstr-slv).h,2472 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2473 :: 		return debugEstadoB = SALIENDO;
	MOVLW       4
	MOVWF       _debugEstadoB+0 
	MOVLW       4
	MOVWF       R0 
	GOTO        L_end_transicionSBP9
;rutinasensores_v4(mstr-slv).h,2474 :: 		}
L_transicionSBP9537:
;rutinasensores_v4(mstr-slv).h,2475 :: 		}
L_transicionSBP9535:
;rutinasensores_v4(mstr-slv).h,2476 :: 		}
L_end_transicionSBP9:
	RETURN      0
; end of _transicionSBP9

_transicionSalBP9:

;rutinasensores_v4(mstr-slv).h,2478 :: 		short transicionSalBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2479 :: 		if(estado == TRANSAL){
	MOVF        FARG_transicionSalBP9_estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_transicionSalBP9538
;rutinasensores_v4(mstr-slv).h,2480 :: 		LCD_OUTCONST(3,1,"TRANSICION SALIDA");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_118_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_118_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_118_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2481 :: 		if(!SENSOR2 | !SENSOR4 | !SENSOR6){
	BTFSC       PORTD+0, 4 
	GOTO        L__transicionSalBP92385
	BSF         R1, 0 
	GOTO        L__transicionSalBP92386
L__transicionSalBP92385:
	BCF         R1, 0 
L__transicionSalBP92386:
	BTFSC       PORTB+0, 3 
	GOTO        L__transicionSalBP92387
	BSF         4056, 0 
	GOTO        L__transicionSalBP92388
L__transicionSalBP92387:
	BCF         4056, 0 
L__transicionSalBP92388:
	BTFSC       R1, 0 
	GOTO        L__transicionSalBP92389
	BTFSC       4056, 0 
	GOTO        L__transicionSalBP92389
	BCF         R1, 0 
	GOTO        L__transicionSalBP92390
L__transicionSalBP92389:
	BSF         R1, 0 
L__transicionSalBP92390:
	BTFSC       PORTB+0, 1 
	GOTO        L__transicionSalBP92391
	BSF         4056, 0 
	GOTO        L__transicionSalBP92392
L__transicionSalBP92391:
	BCF         4056, 0 
L__transicionSalBP92392:
	BTFSC       R1, 0 
	GOTO        L__transicionSalBP92393
	BTFSC       4056, 0 
	GOTO        L__transicionSalBP92393
	BCF         R1, 0 
	GOTO        L__transicionSalBP92394
L__transicionSalBP92393:
	BSF         R1, 0 
L__transicionSalBP92394:
	BTFSS       R1, 0 
	GOTO        L_transicionSalBP9539
;rutinasensores_v4(mstr-slv).h,2482 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2483 :: 		return debugEstadoB = TRANSICIONS;
	MOVLW       8
	MOVWF       _debugEstadoB+0 
	MOVLW       8
	MOVWF       R0 
	GOTO        L_end_transicionSalBP9
;rutinasensores_v4(mstr-slv).h,2484 :: 		}
L_transicionSalBP9539:
;rutinasensores_v4(mstr-slv).h,2485 :: 		if((SENSOR1 & SENSOR3 & SENSOR5) & (SENSOR2)){
	BTFSS       PORTB+0, 4 
	GOTO        L__transicionSalBP92395
	BTFSS       PORTB+0, 2 
	GOTO        L__transicionSalBP92395
	BSF         4056, 0 
	GOTO        L__transicionSalBP92396
L__transicionSalBP92395:
	BCF         4056, 0 
L__transicionSalBP92396:
	BTFSS       4056, 0 
	GOTO        L__transicionSalBP92397
	BTFSS       PORTB+0, 0 
	GOTO        L__transicionSalBP92397
	BSF         R1, 0 
	GOTO        L__transicionSalBP92398
L__transicionSalBP92397:
	BCF         R1, 0 
L__transicionSalBP92398:
	BTFSS       R1, 0 
	GOTO        L__transicionSalBP92399
	BTFSS       PORTD+0, 4 
	GOTO        L__transicionSalBP92399
	BSF         4056, 0 
	GOTO        L__transicionSalBP92400
L__transicionSalBP92399:
	BCF         4056, 0 
L__transicionSalBP92400:
	BTFSS       4056, 0 
	GOTO        L_transicionSalBP9540
;rutinasensores_v4(mstr-slv).h,2486 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2487 :: 		return debugEstadoB = SALIO;
	MOVLW       6
	MOVWF       _debugEstadoB+0 
	MOVLW       6
	MOVWF       R0 
	GOTO        L_end_transicionSalBP9
;rutinasensores_v4(mstr-slv).h,2488 :: 		}
L_transicionSalBP9540:
;rutinasensores_v4(mstr-slv).h,2489 :: 		}
L_transicionSalBP9538:
;rutinasensores_v4(mstr-slv).h,2490 :: 		}
L_end_transicionSalBP9:
	RETURN      0
; end of _transicionSalBP9

_salioBP9:

;rutinasensores_v4(mstr-slv).h,2492 :: 		short salioBP9(short estado){
;rutinasensores_v4(mstr-slv).h,2493 :: 		if(estado == SALIO){
	MOVF        FARG_salioBP9_estado+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_salioBP9541
;rutinasensores_v4(mstr-slv).h,2494 :: 		LCD_OUTCONST(3,1,"GRACIAS!");
	MOVLW       3
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_119_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_119_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_119_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;rutinasensores_v4(mstr-slv).h,2495 :: 		pSuben = eepromLeeNumero(0x0000,2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pSuben+0 
	MOVF        R1, 0 
	MOVWF       _pSuben+1 
;rutinasensores_v4(mstr-slv).h,2496 :: 		pBajan = eepromLeeNumero(0x0003,2) + 1;
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       _pBajan+0 
	MOVF        R1, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2497 :: 		eepromEscribeNumero(0x0003,pBajan,2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2498 :: 		pBajan = eepromLeeNumero(0x0003,2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP9+4 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP9+5 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP9+6 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP9+7 
	MOVF        FLOC__salioBP9+4, 0 
	MOVWF       _pBajan+0 
	MOVF        FLOC__salioBP9+5, 0 
	MOVWF       _pBajan+1 
;rutinasensores_v4(mstr-slv).h,2499 :: 		pasajerosVerdaderos = ((float)pSuben + (float)pBajan)/2;
	MOVF        _pSuben+0, 0 
	MOVWF       R0 
	MOVF        _pSuben+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP9+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP9+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP9+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP9+3 
	MOVF        FLOC__salioBP9+4, 0 
	MOVWF       R0 
	MOVF        FLOC__salioBP9+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__salioBP9+0, 0 
	MOVWF       R4 
	MOVF        FLOC__salioBP9+1, 0 
	MOVWF       R5 
	MOVF        FLOC__salioBP9+2, 0 
	MOVWF       R6 
	MOVF        FLOC__salioBP9+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosVerdaderos+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosVerdaderos+1 
	MOVF        R2, 0 
	MOVWF       _pasajerosVerdaderos+2 
	MOVF        R3, 0 
	MOVWF       _pasajerosVerdaderos+3 
;rutinasensores_v4(mstr-slv).h,2500 :: 		eepromEscribeNumero(0x0009, pasajerosVerdaderos, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CALL        _Double2Longint+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVF        R2, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVF        R3, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2501 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_salioBP9542
;rutinasensores_v4(mstr-slv).h,2502 :: 		pVerdaderosMEntero = eepromLeeNumero(0x0009, 2);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosMEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosMEntero+1 
;rutinasensores_v4(mstr-slv).h,2503 :: 		pVerdaderosEEntero = eepromLeeNumero(0x0007, 2);
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pVerdaderosEEntero+0 
	MOVF        R1, 0 
	MOVWF       _pVerdaderosEEntero+1 
;rutinasensores_v4(mstr-slv).h,2504 :: 		pasajerosTotalesL = pVerdaderosMEntero + pVerdaderosEEntero;
	MOVF        R0, 0 
	ADDWF       _pVerdaderosMEntero+0, 0 
	MOVWF       _pasajerosTotalesL+0 
	MOVF        R1, 0 
	ADDWFC      _pVerdaderosMEntero+1, 0 
	MOVWF       _pasajerosTotalesL+1 
;rutinasensores_v4(mstr-slv).h,2505 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__salioBP9+0 
	MOVF        R1, 0 
	MOVWF       FLOC__salioBP9+1 
	MOVF        R2, 0 
	MOVWF       FLOC__salioBP9+2 
	MOVF        R3, 0 
	MOVWF       FLOC__salioBP9+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP9+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP9+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP9+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP9+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP9+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP9+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP9+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP9+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__salioBP9+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__salioBP9+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__salioBP9+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__salioBP9+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+1 
;rutinasensores_v4(mstr-slv).h,2506 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        R1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;rutinasensores_v4(mstr-slv).h,2507 :: 		}
L_salioBP9542:
;rutinasensores_v4(mstr-slv).h,2508 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;rutinasensores_v4(mstr-slv).h,2509 :: 		return debugEstadoB = ESPERA;
	CLRF        _debugEstadoB+0 
	CLRF        R0 
	GOTO        L_end_salioBP9
;rutinasensores_v4(mstr-slv).h,2510 :: 		}
L_salioBP9541:
;rutinasensores_v4(mstr-slv).h,2511 :: 		}
L_end_salioBP9:
	RETURN      0
; end of _salioBP9

_interrupcionesAltoNivel:

;MyProject.c,155 :: 		void interrupcionesAltoNivel() iv 0x0008 ics ICS_AUTO {
;MyProject.c,157 :: 		if(PIR1.RCIF & PIE1.RCIE){
	BTFSS       PIR1+0, 5 
	GOTO        L__interrupcionesAltoNivel2404
	BTFSS       PIE1+0, 5 
	GOTO        L__interrupcionesAltoNivel2404
	BSF         4056, 0 
	GOTO        L__interrupcionesAltoNivel2405
L__interrupcionesAltoNivel2404:
	BCF         4056, 0 
L__interrupcionesAltoNivel2405:
	BTFSS       4056, 0 
	GOTO        L_interrupcionesAltoNivel543
;MyProject.c,158 :: 		RX_PIC_PIC();
	CALL        _RX_PIC_PIC+0, 0
;MyProject.c,159 :: 		}
L_interrupcionesAltoNivel543:
;MyProject.c,161 :: 		if(PIR2.TMR3IF & PIE2.TMR3IE & MSTR){
	BTFSS       PIR2+0, 1 
	GOTO        L__interrupcionesAltoNivel2406
	BTFSS       PIE2+0, 1 
	GOTO        L__interrupcionesAltoNivel2406
	BSF         4056, 0 
	GOTO        L__interrupcionesAltoNivel2407
L__interrupcionesAltoNivel2406:
	BCF         4056, 0 
L__interrupcionesAltoNivel2407:
	BTFSS       4056, 0 
	GOTO        L__interrupcionesAltoNivel2408
	BTFSS       PORTD+0, 2 
	GOTO        L__interrupcionesAltoNivel2408
	BSF         R1, 0 
	GOTO        L__interrupcionesAltoNivel2409
L__interrupcionesAltoNivel2408:
	BCF         R1, 0 
L__interrupcionesAltoNivel2409:
	BTFSS       R1, 0 
	GOTO        L_interrupcionesAltoNivel544
;MyProject.c,162 :: 		cuentaSoftRead++;
	INCF        _cuentaSoftRead+0, 1 
;MyProject.c,163 :: 		if(cuentaSoftRead >=1){
	MOVLW       128
	XORWF       _cuentaSoftRead+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupcionesAltoNivel545
;MyProject.c,164 :: 		Soft_UART_Break();
	CALL        _Soft_UART_Break+0, 0
;MyProject.c,165 :: 		PIR2.TMR3IF = false;
	BCF         PIR2+0, 1 
;MyProject.c,166 :: 		}
L_interrupcionesAltoNivel545:
;MyProject.c,167 :: 		}
L_interrupcionesAltoNivel544:
;MyProject.c,168 :: 		}
L_end_interrupcionesAltoNivel:
L__interrupcionesAltoNivel2403:
	RETFIE      1
; end of _interrupcionesAltoNivel

_interrupcionesBajoNivel:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;MyProject.c,170 :: 		void interrupcionesBajoNivel() iv 0x0018 ics ICS_AUTO {
;MyProject.c,171 :: 		desbordoTemporizadorCero();
	CALL        _desbordoTemporizadorCero+0, 0
;MyProject.c,172 :: 		}
L_end_interrupcionesBajoNivel:
L__interrupcionesBajoNivel2411:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _interrupcionesBajoNivel

_main:

;MyProject.c,180 :: 		void main() {
;MyProject.c,181 :: 		PicInit();
	CALL        _PicInit+0, 0
;MyProject.c,183 :: 		while(1){
L_main546:
;MyProject.c,185 :: 		bytetostr(posteDesc, Aux6);    //BANDERA DE DESCONEXION DE POSTE TRASERO; 0 = "CONECTADO" - 1 = "DESCONECTADO"
	MOVF        _posteDesc+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _Aux6+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_Aux6+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;MyProject.c,186 :: 		lcd_out(4,8,aux6);
	MOVLW       4
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       8
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _Aux6+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_Aux6+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;MyProject.c,187 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_main548
;MyProject.c,188 :: 		WDTCON.SWDTEN = 1;
	BSF         WDTCON+0, 0 
;MyProject.c,189 :: 		T3CON.TMR3ON = 1;
	BSF         T3CON+0, 0 
;MyProject.c,190 :: 		wioRX[0] = Soft_UART_Read(&errorSoftUART);
	MOVLW       _errorSoftUART+0
	MOVWF       FARG_Soft_UART_Read_error+0 
	MOVLW       hi_addr(_errorSoftUART+0)
	MOVWF       FARG_Soft_UART_Read_error+1 
	CALL        _Soft_UART_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _WioRX+0 
;MyProject.c,191 :: 		if((!errorSoftUART) | errorSoftUART == 255){
	MOVF        _errorSoftUART+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _errorSoftUART+0, 0 
	XORLW       255
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main549
;MyProject.c,192 :: 		if(!errorSoftUART){
	MOVF        _errorSoftUART+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main550
;MyProject.c,193 :: 		if(wioRX[0] == 'r'){
	MOVF        _WioRX+0, 0 
	XORLW       114
	BTFSS       STATUS+0, 2 
	GOTO        L_main551
;MyProject.c,194 :: 		desbordoGPS = periodoEnvioGPS - 1;
	MOVLW       179
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;MyProject.c,195 :: 		lcd_chr(2,8,wioRX[0]);
	MOVLW       2
	MOVWF       FARG_lcd_chr_fila+0 
	MOVLW       8
	MOVWF       FARG_lcd_chr_col+0 
	MOVF        _WioRX+0, 0 
	MOVWF       FARG_lcd_chr_c+0 
	CALL        _lcd_chr+0, 0
;MyProject.c,196 :: 		}
	GOTO        L_main552
L_main551:
;MyProject.c,197 :: 		else if(wioRX[0] == 'B'){
	MOVF        _WioRX+0, 0 
	XORLW       66
	BTFSS       STATUS+0, 2 
	GOTO        L_main553
;MyProject.c,198 :: 		resetWioLTE = true;
	MOVLW       1
	MOVWF       _resetWioLTE+0 
;MyProject.c,199 :: 		lcd_chr(2,8,wioRX[0]);
	MOVLW       2
	MOVWF       FARG_lcd_chr_fila+0 
	MOVLW       8
	MOVWF       FARG_lcd_chr_col+0 
	MOVF        _WioRX+0, 0 
	MOVWF       FARG_lcd_chr_c+0 
	CALL        _lcd_chr+0, 0
;MyProject.c,200 :: 		}
L_main553:
L_main552:
;MyProject.c,201 :: 		}
L_main550:
;MyProject.c,203 :: 		T3CON.TMR3ON = 0;
	BCF         T3CON+0, 0 
;MyProject.c,204 :: 		TMR3L = 0x85;
	MOVLW       133
	MOVWF       TMR3L+0 
;MyProject.c,205 :: 		TMR3H = 0xFD;
	MOVLW       253
	MOVWF       TMR3H+0 
;MyProject.c,206 :: 		memset(wioRX, 0, sizeof(wioRX));
	MOVLW       _WioRX+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_WioRX+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       2
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,207 :: 		cuentaSoftRead = 0;
	CLRF        _cuentaSoftRead+0 
;MyProject.c,208 :: 		}
L_main549:
;MyProject.c,209 :: 		WDTCON.SWDTEN = 0;
	BCF         WDTCON+0, 0 
;MyProject.c,210 :: 		WDTCON.SWDTEN = 1;
	BSF         WDTCON+0, 0 
;MyProject.c,211 :: 		MASTER();
	CALL        _MASTER+0, 0
;MyProject.c,212 :: 		WDTCON.SWDTEN = 0;
	BCF         WDTCON+0, 0 
;MyProject.c,213 :: 		}
	GOTO        L_main554
L_main548:
;MyProject.c,217 :: 		SLV();
	CALL        _SLV+0, 0
;MyProject.c,219 :: 		}
L_main554:
;MyProject.c,221 :: 		if(SENSOR1 & SENSOR2 & SENSOR3 & SENSOR4 & SENSOR5 & SENSOR6){
	BTFSS       PORTB+0, 4 
	GOTO        L__main2413
	BTFSS       PORTD+0, 4 
	GOTO        L__main2413
	BSF         4056, 0 
	GOTO        L__main2414
L__main2413:
	BCF         4056, 0 
L__main2414:
	BTFSS       4056, 0 
	GOTO        L__main2415
	BTFSS       PORTB+0, 2 
	GOTO        L__main2415
	BSF         R2, 0 
	GOTO        L__main2416
L__main2415:
	BCF         R2, 0 
L__main2416:
	BTFSS       R2, 0 
	GOTO        L__main2417
	BTFSS       PORTB+0, 3 
	GOTO        L__main2417
	BSF         4056, 0 
	GOTO        L__main2418
L__main2417:
	BCF         4056, 0 
L__main2418:
	BTFSS       4056, 0 
	GOTO        L__main2419
	BTFSS       PORTB+0, 0 
	GOTO        L__main2419
	BSF         R2, 0 
	GOTO        L__main2420
L__main2419:
	BCF         R2, 0 
L__main2420:
	BTFSS       R2, 0 
	GOTO        L__main2421
	BTFSS       PORTB+0, 1 
	GOTO        L__main2421
	BSF         4056, 0 
	GOTO        L__main2422
L__main2421:
	BCF         4056, 0 
L__main2422:
	BTFSS       4056, 0 
	GOTO        L_main555
;MyProject.c,222 :: 		SENSORESDEBUG = 1;
	BSF         PORTC+0, 4 
;MyProject.c,223 :: 		}
	GOTO        L_main556
L_main555:
;MyProject.c,225 :: 		SENSORESDEBUG = 0;
	BCF         PORTC+0, 4 
;MyProject.c,226 :: 		}
L_main556:
;MyProject.c,227 :: 		}
	GOTO        L_main546
;MyProject.c,229 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_PicInit:

;MyProject.c,237 :: 		void PicInit(){
;MyProject.c,240 :: 		OSCCON = 0x40;                   //Oscilador externo  20MHz
	MOVLW       64
	MOVWF       OSCCON+0 
;MyProject.c,242 :: 		ADCON1 = 0x0F;                  //Todos digitales
	MOVLW       15
	MOVWF       ADCON1+0 
;MyProject.c,243 :: 		CMCON = 0x07;                   //Apagar los comparadores
	MOVLW       7
	MOVWF       CMCON+0 
;MyProject.c,246 :: 		lcd_init();
	CALL        _lcd_init+0, 0
;MyProject.c,247 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;MyProject.c,248 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;MyProject.c,249 :: 		lcd_outConst(1,1,"INICILIZANDO...")  ;
	MOVLW       1
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_120_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_120_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_120_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;MyProject.c,253 :: 		SENSOR1D = 1;
	BSF         TRISB+0, 4 
;MyProject.c,254 :: 		SENSOR2D = 1;
	BSF         TRISD+0, 4 
;MyProject.c,255 :: 		SENSOR3D = 1;
	BSF         TRISB+0, 2 
;MyProject.c,256 :: 		SENSOR4D = 1;
	BSF         TRISB+0, 3 
;MyProject.c,257 :: 		SENSOR5D = 1;
	BSF         TRISB+0, 0 
;MyProject.c,258 :: 		SENSOR6D = 1;
	BSF         TRISB+0, 1 
;MyProject.c,259 :: 		RESET_BOTOND = 1;
	BSF         TRISD+0, 1 
;MyProject.c,260 :: 		RX_PICD = 1;
	BSF         TRISC+0, 7 
;MyProject.c,261 :: 		TRISC.B1 = 1;                        //Serial Rx WioLTE
	BSF         TRISC+0, 1 
;MyProject.c,264 :: 		TX_PICD = 0;
	BCF         TRISC+0, 6 
;MyProject.c,265 :: 		POLARIZACIOND = 0;
	BCF         TRISC+0, 2 
;MyProject.c,266 :: 		BLOQUEOACTIVOD = 0;
	BCF         TRISC+0, 3 
;MyProject.c,267 :: 		SENSORESDEBUGD = 0;
	BCF         TRISC+0, 4 
;MyProject.c,270 :: 		SENSORESDEBUG = 0;
	BCF         PORTC+0, 4 
;MyProject.c,271 :: 		BLOQUEOACTIVO = 0;
	BCF         PORTC+0, 3 
;MyProject.c,274 :: 		PWM1_Init(44000);
	BCF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       112
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;MyProject.c,275 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;MyProject.c,276 :: 		PWM1_Set_Duty(127);
	MOVLW       127
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;MyProject.c,279 :: 		iniciaEeprom();
	CALL        _iniciaEeprom+0, 0
;MyProject.c,282 :: 		T0CON.TMR0ON = 1;                         //encendido timer0
	BSF         T0CON+0, 7 
;MyProject.c,283 :: 		T0CON.T08BIT = 0;                         //contador de 16 bits
	BCF         T0CON+0, 6 
;MyProject.c,284 :: 		T0CON.T0CS = 0;                           //SELECCIONA RELOJ INTERNO
	BCF         T0CON+0, 5 
;MyProject.c,285 :: 		T0CON.PSA = 0;                            //Asigna el PREESCALADOR
	BCF         T0CON+0, 3 
;MyProject.c,286 :: 		T0CON.T0PS0 = 0;                          //valor
	BCF         T0CON+0, 0 
;MyProject.c,287 :: 		T0CON.T0PS1 = 1;                          //preescalador
	BSF         T0CON+0, 1 
;MyProject.c,288 :: 		T0CON.T0PS2 = 1;                          //1:128
	BSF         T0CON+0, 2 
;MyProject.c,292 :: 		TMR0L = 0x69;                             //1 segundo para el desbordo del contador
	MOVLW       105
	MOVWF       TMR0L+0 
;MyProject.c,293 :: 		TMR0H = 0x67;
	MOVLW       103
	MOVWF       TMR0H+0 
;MyProject.c,296 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_PicInit557
;MyProject.c,297 :: 		T1CON.RD16 = 0;                           //CONTADOR 16 BITS EN DOS REGISTROS DE 8
	BCF         T1CON+0, 7 
;MyProject.c,298 :: 		T1CON.TMR1CS = 0;                         //OSCILADOR INTERNO (FOSC/4)
	BCF         T1CON+0, 1 
;MyProject.c,299 :: 		T1CON.T1CKPS0 = 1;
	BSF         T1CON+0, 4 
;MyProject.c,300 :: 		T1CON.T1CKPS1 = 1;                        //PREESCALADOR 1:1
	BSF         T1CON+0, 5 
;MyProject.c,302 :: 		TMR1L = 0x8E;
	MOVLW       142
	MOVWF       TMR1L+0 
;MyProject.c,303 :: 		TMR1H = 0xFD;
	MOVLW       253
	MOVWF       TMR1H+0 
;MyProject.c,304 :: 		T1CON.TMR1ON = 1;
	BSF         T1CON+0, 0 
;MyProject.c,308 :: 		T3CON.RD16 = 0;                           //CONTADOR 16 BITS EN DOS REGISTROS DE 8
	BCF         T3CON+0, 7 
;MyProject.c,310 :: 		T3CON.TMR3CS = 0;                         //OSCILADOR INTERNO (FOSC/4)
	BCF         T3CON+0, 1 
;MyProject.c,311 :: 		T3CON.T1CKPS0 = 1;
	BSF         T3CON+0, 4 
;MyProject.c,312 :: 		T3CON.T1CKPS1 = 1;                        //PREESCALADOR 1:8
	BSF         T3CON+0, 5 
;MyProject.c,314 :: 		TMR3L = 0x85;
	MOVLW       133
	MOVWF       TMR3L+0 
;MyProject.c,315 :: 		TMR3H = 0xFD;
	MOVLW       253
	MOVWF       TMR3H+0 
;MyProject.c,317 :: 		}
L_PicInit557:
;MyProject.c,319 :: 		RCON.IPEN = 1;                            //ACTIVAR NIVELES DE INTERRUPCION
	BSF         RCON+0, 7 
;MyProject.c,320 :: 		INTCON.PEIE = 1;                          //ACTIVAR INTERRUPCIONES PERIFERICAS
	BSF         INTCON+0, 6 
;MyProject.c,321 :: 		INTCON.GIE = 1;                           //ACTIVAR INTERRUPCIONES GLOBALES
	BSF         INTCON+0, 7 
;MyProject.c,322 :: 		INTCON.TMR0IE = 1;                        //ACTIVA INTERRUPCION POR DESBORDE
	BSF         INTCON+0, 5 
;MyProject.c,323 :: 		INTCON2.TMR0IP = 0;                       //INTERRUPCION BAJA PRIORIDAD
	BCF         INTCON2+0, 2 
;MyProject.c,324 :: 		INTCON3.TMR1IE = 1;                       //HABILITA INTERRUPCION POR DESBORDE DEL TEMPORIZADOR 1
	BSF         INTCON3+0, 0 
;MyProject.c,325 :: 		IPR1.TMR1IP = 1;                          //INTERRUPCION DE ALTA PRIORIDAD
	BSF         IPR1+0, 0 
;MyProject.c,326 :: 		PIE2.TMR3IE = 1;
	BSF         PIE2+0, 1 
;MyProject.c,327 :: 		IPR2.TMR3IP = 1;
	BSF         IPR2+0, 1 
;MyProject.c,331 :: 		PIE1.RCIE = 1;                            //HABILITA INTECCUPCION POR RECEPCION DE USART
	BSF         PIE1+0, 5 
;MyProject.c,332 :: 		IPR1.RCIP = 1;                            //INTERRUCION DE ALTA PRIORIDAD
	BSF         IPR1+0, 5 
;MyProject.c,335 :: 		UART1_Init(BAUDIOS);                      //INICIA COMUNICAICON RS232 A 9600 BAUDIOS
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;MyProject.c,336 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_PicInit558:
	DECFSZ      R13, 1, 1
	BRA         L_PicInit558
	DECFSZ      R12, 1, 1
	BRA         L_PicInit558
	DECFSZ      R11, 1, 1
	BRA         L_PicInit558
	NOP
	NOP
;MyProject.c,338 :: 		Soft_UART_Init(&PORTC, 1, 0, 9600, 0);
	MOVLW       PORTC+0
	MOVWF       FARG_Soft_UART_Init_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Soft_UART_Init_port+1 
	MOVLW       1
	MOVWF       FARG_Soft_UART_Init_rx_pin+0 
	CLRF        FARG_Soft_UART_Init_tx_pin+0 
	MOVLW       128
	MOVWF       FARG_Soft_UART_Init_baud_rate+0 
	MOVLW       37
	MOVWF       FARG_Soft_UART_Init_baud_rate+1 
	MOVLW       0
	MOVWF       FARG_Soft_UART_Init_baud_rate+2 
	MOVWF       FARG_Soft_UART_Init_baud_rate+3 
	CLRF        FARG_Soft_UART_Init_inverted+0 
	CALL        _Soft_UART_Init+0, 0
;MyProject.c,341 :: 		Bandera.SensorU = false, Bandera.SensorD = false, Bandera.SensorT = false, Bandera.SensorC = false, Bandera.SensorO = false, Bandera.SensorS = false;
	CLRF        _Bandera+9 
	CLRF        _Bandera+10 
	CLRF        _Bandera+11 
	CLRF        _Bandera+12 
	CLRF        _Bandera+13 
	CLRF        _Bandera+14 
;MyProject.c,342 :: 		Bandera.Par1 = false, Bandera.Par2 = false, Bandera.Par3 = false, Bandera.Par4 = false, Bandera.Par5 = false, Bandera.Par6 = false, Bandera.Par7 = false, Bandera.Par8 = false, Bandera.Par9 = false;
	CLRF        _Bandera+0 
	CLRF        _Bandera+1 
	CLRF        _Bandera+2 
	CLRF        _Bandera+3 
	CLRF        _Bandera+4 
	CLRF        _Bandera+5 
	CLRF        _Bandera+6 
	CLRF        _Bandera+7 
	CLRF        _Bandera+8 
;MyProject.c,343 :: 		Desborde.SensorU = 0, Desborde.SensorD = 0, Desborde.SensorT = 0, Desborde.SensorC = 0, Desborde.SensorO = 0, Desborde.SensorS = 0;
	CLRF        _Desborde+18 
	CLRF        _Desborde+19 
	CLRF        _Desborde+20 
	CLRF        _Desborde+21 
	CLRF        _Desborde+22 
	CLRF        _Desborde+23 
	CLRF        _Desborde+24 
	CLRF        _Desborde+25 
	CLRF        _Desborde+26 
	CLRF        _Desborde+27 
	CLRF        _Desborde+28 
	CLRF        _Desborde+29 
;MyProject.c,344 :: 		Desborde.Par1 = 0, Desborde.Par2 = 0, Desborde.Par3 = 0, Desborde.Par4 = 0, Desborde.Par5 = 0, Desborde.Par6 = 0, Desborde.Par7 = 0, Desborde.Par8 = 0, Desborde.Par9 = 0;
	CLRF        _Desborde+0 
	CLRF        _Desborde+1 
	CLRF        _Desborde+2 
	CLRF        _Desborde+3 
	CLRF        _Desborde+4 
	CLRF        _Desborde+5 
	CLRF        _Desborde+6 
	CLRF        _Desborde+7 
	CLRF        _Desborde+8 
	CLRF        _Desborde+9 
	CLRF        _Desborde+10 
	CLRF        _Desborde+11 
	CLRF        _Desborde+12 
	CLRF        _Desborde+13 
	CLRF        _Desborde+14 
	CLRF        _Desborde+15 
	CLRF        _Desborde+16 
	CLRF        _Desborde+17 
;MyProject.c,346 :: 		BLOQUEOACTIVO = 1;
	BSF         PORTC+0, 3 
;MyProject.c,347 :: 		delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_PicInit559:
	DECFSZ      R13, 1, 1
	BRA         L_PicInit559
	DECFSZ      R12, 1, 1
	BRA         L_PicInit559
	DECFSZ      R11, 1, 1
	BRA         L_PicInit559
	NOP
	NOP
;MyProject.c,348 :: 		BLOQUEOACTIVO = 0;
	BCF         PORTC+0, 3 
;MyProject.c,350 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;MyProject.c,351 :: 		}
L_end_PicInit:
	RETURN      0
; end of _PicInit

_TX_MSTR:

;MyProject.c,363 :: 		short TX_MSTR(){
;MyProject.c,364 :: 		short m = 0;
;MyProject.c,365 :: 		if(cuentaUSART == periodoUSART){
	MOVF        _cuentaUSART+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_TX_MSTR560
;MyProject.c,366 :: 		memset(confirmacionEsclavo, 0, sizeof(confirmacionEsclavo));
	MOVLW       _confirmacionEsclavo+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_confirmacionEsclavo+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       3
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,367 :: 		if(UART1_Tx_Idle() == true){
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_TX_MSTR561
;MyProject.c,368 :: 		UART1_Write_Text(solicitudCuenta);
	MOVLW       _solicitudCuenta+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_solicitudCuenta+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,369 :: 		if((bufferRecepcionEsclavo[4] != checksum[5]) & !conexionHabilitada){
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	BTFSC       _checksum+5, 7 
	MOVLW       255
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TX_MSTR2425
	MOVF        _checksum+5, 0 
	XORWF       _bufferRecepcionEsclavo+4, 0 
L__TX_MSTR2425:
	MOVLW       0
	BTFSS       STATUS+0, 2 
	MOVLW       1
	MOVWF       R1 
	MOVF        _conexionHabilitada+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_MSTR562
;MyProject.c,370 :: 		posteDesc = true;
	MOVLW       1
	MOVWF       _posteDesc+0 
;MyProject.c,371 :: 		afterReset = true;
	MOVLW       1
	MOVWF       _afterReset+0 
;MyProject.c,372 :: 		checksum[0] = 1;
	MOVLW       1
	MOVWF       _checksum+0 
;MyProject.c,373 :: 		checksum[1] = 2;
	MOVLW       2
	MOVWF       _checksum+1 
;MyProject.c,374 :: 		checksum[2] = 3;
	MOVLW       3
	MOVWF       _checksum+2 
;MyProject.c,375 :: 		conexionHabilitada = false;
	CLRF        _conexionHabilitada+0 
;MyProject.c,376 :: 		}
	GOTO        L_TX_MSTR563
L_TX_MSTR562:
;MyProject.c,378 :: 		bufferRecepcionEsclavo[4] = 0;
	CLRF        _bufferRecepcionEsclavo+4 
;MyProject.c,379 :: 		checksum[5] = 10;
	MOVLW       10
	MOVWF       _checksum+5 
;MyProject.c,380 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;MyProject.c,381 :: 		posteDesc = false;
	CLRF        _posteDesc+0 
;MyProject.c,382 :: 		conexionHabilitada = false;
	CLRF        _conexionHabilitada+0 
;MyProject.c,383 :: 		if(afterReset){
	MOVF        _afterReset+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_MSTR564
;MyProject.c,384 :: 		afterReset = false;
	CLRF        _afterReset+0 
;MyProject.c,385 :: 		asm reset;
	RESET
;MyProject.c,386 :: 		}
L_TX_MSTR564:
;MyProject.c,387 :: 		}
L_TX_MSTR563:
;MyProject.c,388 :: 		cuentaUSART = 0;
	CLRF        _cuentaUSART+0 
;MyProject.c,389 :: 		}
L_TX_MSTR561:
;MyProject.c,390 :: 		}
L_TX_MSTR560:
;MyProject.c,391 :: 		if(!posteDesc){
	MOVF        _posteDesc+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_TX_MSTR565
;MyProject.c,392 :: 		if(banderaRx){
	MOVF        _banderaRx+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_MSTR566
;MyProject.c,393 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;MyProject.c,394 :: 		guardadoSlvSuben = eepromLeeNumero(0x0900, 2);
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _guardadoSlvSuben+0 
	MOVF        R1, 0 
	MOVWF       _guardadoSlvSuben+1 
;MyProject.c,395 :: 		recSlvSuben = 0;
	CLRF        _recSlvSuben+0 
	CLRF        _recSlvSuben+1 
;MyProject.c,396 :: 		recSlvsuben |= bufferRecepcionEsclavo[6] << 8;
	MOVF        _bufferRecepcionEsclavo+6, 0 
	MOVWF       R5 
	CLRF        R4 
	MOVF        R4, 0 
	MOVWF       _recSlvSuben+0 
	MOVF        R5, 0 
	MOVWF       _recSlvSuben+1 
;MyProject.c,397 :: 		recSlvSuben |= bufferRecepcionEsclavo[5];
	MOVF        _bufferRecepcionEsclavo+5, 0 
	IORWF       R4, 0 
	MOVWF       R6 
	MOVF        R5, 0 
	MOVWF       R7 
	MOVLW       0
	IORWF       R7, 1 
	MOVF        R6, 0 
	MOVWF       _recSlvSuben+0 
	MOVF        R7, 0 
	MOVWF       _recSlvSuben+1 
;MyProject.c,398 :: 		if(recSlvSuben != guardadoSlvSuben){
	MOVF        R7, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TX_MSTR2426
	MOVF        R0, 0 
	XORWF       R6, 0 
L__TX_MSTR2426:
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_MSTR567
;MyProject.c,399 :: 		eepromEscribeNumero(0x0900, bufferRecepcionEsclavo[5], 1);
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        _bufferRecepcionEsclavo+5, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,400 :: 		eepromEscribeNumero(0x0901, bufferRecepcionEsclavo[6], 1);
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        _bufferRecepcionEsclavo+6, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,401 :: 		}
L_TX_MSTR567:
;MyProject.c,402 :: 		guardadoSlvBajan = eepromLeeNumero(0x0700, 2);
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _guardadoSlvBajan+0 
	MOVF        R1, 0 
	MOVWF       _guardadoSlvBajan+1 
;MyProject.c,403 :: 		recSlvBajan = 0;
	CLRF        _recSlvBajan+0 
	CLRF        _recSlvBajan+1 
;MyProject.c,404 :: 		recSlvBajan |= bufferRecepcionEsclavo[8] << 8;
	MOVF        _bufferRecepcionEsclavo+8, 0 
	MOVWF       R5 
	CLRF        R4 
	MOVF        R4, 0 
	MOVWF       _recSlvBajan+0 
	MOVF        R5, 0 
	MOVWF       _recSlvBajan+1 
;MyProject.c,405 :: 		recSlvBajan |= bufferRecepcionEsclavo[7];
	MOVF        _bufferRecepcionEsclavo+7, 0 
	IORWF       R4, 0 
	MOVWF       R6 
	MOVF        R5, 0 
	MOVWF       R7 
	MOVLW       0
	IORWF       R7, 1 
	MOVF        R6, 0 
	MOVWF       _recSlvBajan+0 
	MOVF        R7, 0 
	MOVWF       _recSlvBajan+1 
;MyProject.c,406 :: 		if(recSlvBajan != guardadoSlvBajan){
	MOVF        R7, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TX_MSTR2427
	MOVF        R0, 0 
	XORWF       R6, 0 
L__TX_MSTR2427:
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_MSTR568
;MyProject.c,407 :: 		eepromEscribeNumero(0x0700, bufferRecepcionEsclavo[7], 1);
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       7
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        _bufferRecepcionEsclavo+7, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,408 :: 		eepromEscribeNumero(0x0701, bufferRecepcionEsclavo[8], 1);
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       7
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        _bufferRecepcionEsclavo+8, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,409 :: 		}
L_TX_MSTR568:
;MyProject.c,410 :: 		totalVerdadero = eepromLeeNumero(0x0005, 2);
	MOVLW       5
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _totalVerdadero+0 
	MOVF        R1, 0 
	MOVWF       _totalVerdadero+1 
;MyProject.c,412 :: 		totalCalculado = (eepromLeeNumero(0x0000, 2)+eepromLeeNumero(0x0003, 2)+eepromLeeNumero(0x0900, 2)+eepromLeeNumero(0x0700, 2))/2;
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__TX_MSTR+0 
	MOVF        R1, 0 
	MOVWF       FLOC__TX_MSTR+1 
	MOVF        R2, 0 
	MOVWF       FLOC__TX_MSTR+2 
	MOVF        R3, 0 
	MOVWF       FLOC__TX_MSTR+3 
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__TX_MSTR+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__TX_MSTR+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__TX_MSTR+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__TX_MSTR+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__TX_MSTR+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__TX_MSTR+1, 1 
	MOVF        R2, 0 
	ADDWFC      FLOC__TX_MSTR+2, 1 
	MOVF        R3, 0 
	ADDWFC      FLOC__TX_MSTR+3, 1 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__TX_MSTR+0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	ADDWFC      FLOC__TX_MSTR+1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	ADDWFC      FLOC__TX_MSTR+2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	ADDWFC      FLOC__TX_MSTR+3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R1 
	MOVF        R6, 0 
	MOVWF       R2 
	MOVF        R7, 0 
	MOVWF       R3 
	MOVF        R8, 0 
	MOVWF       R4 
	RRCF        R4, 1 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R4, 7 
	BTFSC       R4, 6 
	BSF         R4, 7 
	MOVF        R1, 0 
	MOVWF       _totalCalculado+0 
	MOVF        R2, 0 
	MOVWF       _totalCalculado+1 
;MyProject.c,413 :: 		if(totalCalculado != totalVerdadero){
	MOVF        R2, 0 
	XORWF       _totalVerdadero+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TX_MSTR2428
	MOVF        _totalVerdadero+0, 0 
	XORWF       R1, 0 
L__TX_MSTR2428:
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_MSTR569
;MyProject.c,415 :: 		eepromEscribeNumero(0x0005, totalCalculado, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        _totalCalculado+0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVF        _totalCalculado+1, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,416 :: 		}
L_TX_MSTR569:
;MyProject.c,431 :: 		recBloq = eepromLeeNumero(0x000C, 1);
	MOVLW       12
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _recBloq+0 
;MyProject.c,432 :: 		if(bufferRecepcionEsclavo[2] != recBloq){
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TX_MSTR2429
	MOVF        R0, 0 
	XORWF       _bufferRecepcionEsclavo+2, 0 
L__TX_MSTR2429:
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_MSTR570
;MyProject.c,433 :: 		eepromEscribeNumero(0x000C, bufferRecepcionEsclavo[2], 1);
	MOVLW       12
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        _bufferRecepcionEsclavo+2, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,434 :: 		bloqEsclavo = eepromLeeNumero(0x000C, 1);
	MOVLW       12
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bloqEsclavo+0 
;MyProject.c,435 :: 		}
L_TX_MSTR570:
;MyProject.c,436 :: 		if(bufferRecepcionEsclavo[3]){
	MOVF        _bufferRecepcionEsclavo+3, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_MSTR571
;MyProject.c,437 :: 		desbordoGPS = bufferRecepcionEsclavo[3];
	MOVF        _bufferRecepcionEsclavo+3, 0 
	MOVWF       _desbordoGPS+0 
	MOVLW       0
	MOVWF       _desbordoGPS+1 
;MyProject.c,438 :: 		}
L_TX_MSTR571:
;MyProject.c,439 :: 		memset(bufferRecepcionEsclavo[3],0,sizeof(bufferRecepcionEsclavo));
	MOVF        _bufferRecepcionEsclavo+3, 0 
	MOVWF       FARG_memset_p1+0 
	MOVLW       0
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       10
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,440 :: 		banderaRx = false;
	CLRF        _banderaRx+0 
;MyProject.c,441 :: 		}
L_TX_MSTR566:
;MyProject.c,442 :: 		}
L_TX_MSTR565:
;MyProject.c,443 :: 		}
L_end_TX_MSTR:
	RETURN      0
; end of _TX_MSTR

_TX_SLV:

;MyProject.c,445 :: 		void TX_SLV(){
;MyProject.c,446 :: 		if(EnvioCuenta){
	MOVF        _EnvioCuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_TX_SLV572
;MyProject.c,447 :: 		short i=0;
	CLRF        TX_SLV_i_L1+0 
;MyProject.c,448 :: 		bufferEnvioEsclavo[0] = eepromLeeNumero(0x0009, 1);
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bufferEnvioEsclavo+0 
;MyProject.c,449 :: 		bufferEnvioEsclavo[1] = eepromLeeNumero(0x000A, 1);
	MOVLW       10
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bufferEnvioEsclavo+1 
;MyProject.c,450 :: 		bufferEnvioEsclavo[2] = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bufferEnvioEsclavo+2 
;MyProject.c,451 :: 		bufferEnvioEsclavo[3] = desbordoGPS_SLV;
	MOVF        _desbordoGPS_SLV+0, 0 
	MOVWF       _bufferEnvioEsclavo+3 
;MyProject.c,452 :: 		bufferEnvioEsclavo[4] = bufferEnvioEsclavo[0] + bufferEnvioEsclavo[1] + bufferEnvioEsclavo[2];
	MOVF        _bufferEnvioEsclavo+1, 0 
	ADDWF       _bufferEnvioEsclavo+0, 0 
	MOVWF       R0 
	MOVF        _bufferEnvioEsclavo+2, 0 
	ADDWF       R0, 0 
	MOVWF       _bufferEnvioEsclavo+4 
;MyProject.c,453 :: 		bufferEnvioEsclavo[5] = eepromLeeNumero(0x0000, 1);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bufferEnvioEsclavo+5 
;MyProject.c,454 :: 		bufferEnvioEsclavo[6] = eepromLeeNumero(0x0001, 1);
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bufferEnvioEsclavo+6 
;MyProject.c,455 :: 		bufferEnvioEsclavo[7] = eepromLeeNumero(0x0003, 1);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bufferEnvioEsclavo+7 
;MyProject.c,456 :: 		bufferEnvioEsclavo[8] = eepromLeeNumero(0x0004, 1);
	MOVLW       4
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bufferEnvioEsclavo+8 
;MyProject.c,457 :: 		desbordoGPS_SLV = 0;
	CLRF        _desbordoGPS_SLV+0 
	CLRF        _desbordoGPS_SLV+1 
;MyProject.c,458 :: 		for( i=0 ; i<9; i++){
	CLRF        TX_SLV_i_L1+0 
L_TX_SLV573:
	MOVLW       128
	XORWF       TX_SLV_i_L1+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       9
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TX_SLV574
;MyProject.c,459 :: 		if(UART1_Tx_Idle() == true){
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_TX_SLV576
;MyProject.c,460 :: 		UART1_Write(bufferEnvioEsclavo[i]);
	MOVLW       _bufferEnvioEsclavo+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_bufferEnvioEsclavo+0)
	MOVWF       FSR0H 
	MOVF        TX_SLV_i_L1+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       TX_SLV_i_L1+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,461 :: 		delay_ms(5);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_TX_SLV577:
	DECFSZ      R13, 1, 1
	BRA         L_TX_SLV577
	DECFSZ      R12, 1, 1
	BRA         L_TX_SLV577
	NOP
;MyProject.c,462 :: 		}
L_TX_SLV576:
;MyProject.c,458 :: 		for( i=0 ; i<9; i++){
	INCF        TX_SLV_i_L1+0, 1 
;MyProject.c,463 :: 		}
	GOTO        L_TX_SLV573
L_TX_SLV574:
;MyProject.c,464 :: 		if(UART1_Tx_Idle() == true){
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_TX_SLV578
;MyProject.c,465 :: 		UART1_Write_Text("C.");
	MOVLW       ?lstr121_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr121_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,466 :: 		}
L_TX_SLV578:
;MyProject.c,467 :: 		EnvioCuenta = false;
	CLRF        _EnvioCuenta+0 
;MyProject.c,468 :: 		}
L_TX_SLV572:
;MyProject.c,469 :: 		}
L_end_TX_SLV:
	RETURN      0
; end of _TX_SLV

_serialTxWioLTE:

;MyProject.c,471 :: 		void serialTxWioLTE(){
;MyProject.c,473 :: 		if(desbordoGPS >= periodoEnvioGPS){
	MOVLW       0
	SUBWF       _desbordoGPS+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__serialTxWioLTE2432
	MOVLW       180
	SUBWF       _desbordoGPS+0, 0 
L__serialTxWioLTE2432:
	BTFSS       STATUS+0, 0 
	GOTO        L_serialTxWioLTE579
;MyProject.c,476 :: 		if(posteDesc){
	MOVF        _posteDesc+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_serialTxWioLTE580
;MyProject.c,477 :: 		BLOQUEOACTIVO = 1;
	BSF         PORTC+0, 3 
;MyProject.c,478 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_serialTxWioLTE581:
	DECFSZ      R13, 1, 1
	BRA         L_serialTxWioLTE581
	DECFSZ      R12, 1, 1
	BRA         L_serialTxWioLTE581
	DECFSZ      R11, 1, 1
	BRA         L_serialTxWioLTE581
	NOP
	NOP
;MyProject.c,479 :: 		BLOQUEOACTIVO = 0;
	BCF         PORTC+0, 3 
;MyProject.c,480 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_serialTxWioLTE582:
	DECFSZ      R13, 1, 1
	BRA         L_serialTxWioLTE582
	DECFSZ      R12, 1, 1
	BRA         L_serialTxWioLTE582
	DECFSZ      R11, 1, 1
	BRA         L_serialTxWioLTE582
	NOP
	NOP
;MyProject.c,481 :: 		BLOQUEOACTIVO = 1;
	BSF         PORTC+0, 3 
;MyProject.c,482 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_serialTxWioLTE583:
	DECFSZ      R13, 1, 1
	BRA         L_serialTxWioLTE583
	DECFSZ      R12, 1, 1
	BRA         L_serialTxWioLTE583
	DECFSZ      R11, 1, 1
	BRA         L_serialTxWioLTE583
	NOP
	NOP
;MyProject.c,483 :: 		BLOQUEOACTIVO = 0;
	BCF         PORTC+0, 3 
;MyProject.c,484 :: 		}
L_serialTxWioLTE580:
;MyProject.c,485 :: 		memset(envioSerialGPS, 0, sizeof(envioSerialGPS));
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       45
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,487 :: 		strcpy(envioSerialGPS, commAT);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       _commAT+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(_commAT+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;MyProject.c,489 :: 		memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,490 :: 		inttostrwithzeros(lecturaTablaPVerdaderos, envioGPS);
	MOVF        _lecturaTablaPVerdaderos+0, 0 
	MOVWF       FARG_IntToStrWithZeros_input+0 
	MOVF        _lecturaTablaPVerdaderos+1, 0 
	MOVWF       FARG_IntToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_IntToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_IntToStrWithZeros_output+1 
	CALL        _IntToStrWithZeros+0, 0
;MyProject.c,491 :: 		for(l=0 ; l<4 ; l++){
	CLRF        _l+0 
L_serialTxWioLTE584:
	MOVLW       128
	XORWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE585
;MyProject.c,492 :: 		auxEnvioGPS[l] = envioGPS[l+2];
	MOVLW       _auxEnvioGPS+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FSR1H 
	MOVF        _l+0, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	ADDWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _envioGPS+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_envioGPS+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,491 :: 		for(l=0 ; l<4 ; l++){
	INCF        _l+0, 1 
;MyProject.c,493 :: 		}
	GOTO        L_serialTxWioLTE584
L_serialTxWioLTE585:
;MyProject.c,494 :: 		strcat(envioSerialGPS, auxEnvioGPS);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,496 :: 		strcat(envioSerialGPS, ",");
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr122_MyProject+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr122_MyProject+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,499 :: 		memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,500 :: 		pasajerosSubenM = eepromLeeNumero(0x0000, 2);
	CLRF        FARG_eepromLeeNumero_registro+0 
	CLRF        FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosSubenM+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosSubenM+1 
;MyProject.c,501 :: 		inttostrWithZeros(pasajerosSubenM, envioGPS);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStrWithZeros_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_IntToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_IntToStrWithZeros_output+1 
	CALL        _IntToStrWithZeros+0, 0
;MyProject.c,502 :: 		for(l=0 ; l<4 ; l++){
	CLRF        _l+0 
L_serialTxWioLTE587:
	MOVLW       128
	XORWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE588
;MyProject.c,503 :: 		auxEnvioGPS[l] = envioGPS[l+2];
	MOVLW       _auxEnvioGPS+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FSR1H 
	MOVF        _l+0, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	ADDWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _envioGPS+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_envioGPS+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,502 :: 		for(l=0 ; l<4 ; l++){
	INCF        _l+0, 1 
;MyProject.c,504 :: 		}
	GOTO        L_serialTxWioLTE587
L_serialTxWioLTE588:
;MyProject.c,505 :: 		strcat(envioSerialGPS, auxEnvioGPS);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,507 :: 		strcat(envioSerialGPS, ",");
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr123_MyProject+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr123_MyProject+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,509 :: 		memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,511 :: 		pasajerosBajanM = eepromLeeNumero(0x0003, 2);
	MOVLW       3
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosBajanM+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosBajanM+1 
;MyProject.c,513 :: 		inttostrWithZeros(pasajerosBajanM, envioGPS);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStrWithZeros_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_IntToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_IntToStrWithZeros_output+1 
	CALL        _IntToStrWithZeros+0, 0
;MyProject.c,514 :: 		for(l=0 ; l<4 ; l++){
	CLRF        _l+0 
L_serialTxWioLTE590:
	MOVLW       128
	XORWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE591
;MyProject.c,515 :: 		auxEnvioGPS[l] = envioGPS[l+2];
	MOVLW       _auxEnvioGPS+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FSR1H 
	MOVF        _l+0, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	ADDWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _envioGPS+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_envioGPS+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,514 :: 		for(l=0 ; l<4 ; l++){
	INCF        _l+0, 1 
;MyProject.c,516 :: 		}
	GOTO        L_serialTxWioLTE590
L_serialTxWioLTE591:
;MyProject.c,517 :: 		strcat(envioSerialGPS, auxEnvioGPS);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,519 :: 		strcat(envioSerialGPS, ",");
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr124_MyProject+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr124_MyProject+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,521 :: 		memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,522 :: 		if(posteDesc){
	MOVF        _posteDesc+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_serialTxWioLTE593
;MyProject.c,523 :: 		strcat(envioSerialGPS, posteDesconectado);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _posteDesconectado+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_posteDesconectado+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,524 :: 		}
	GOTO        L_serialTxWioLTE594
L_serialTxWioLTE593:
;MyProject.c,528 :: 		pasajerosSubenE = eepromLeeNumero(0x0900, 2);
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       9
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosSubenE+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosSubenE+1 
;MyProject.c,529 :: 		inttostrWithZeros(pasajerosSubenE, envioGPS);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStrWithZeros_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_IntToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_IntToStrWithZeros_output+1 
	CALL        _IntToStrWithZeros+0, 0
;MyProject.c,530 :: 		for(l=0 ; l<4 ; l++){
	CLRF        _l+0 
L_serialTxWioLTE595:
	MOVLW       128
	XORWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE596
;MyProject.c,531 :: 		auxEnvioGPS[l] = envioGPS[l+2];
	MOVLW       _auxEnvioGPS+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FSR1H 
	MOVF        _l+0, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	ADDWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _envioGPS+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_envioGPS+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,530 :: 		for(l=0 ; l<4 ; l++){
	INCF        _l+0, 1 
;MyProject.c,532 :: 		}
	GOTO        L_serialTxWioLTE595
L_serialTxWioLTE596:
;MyProject.c,533 :: 		strcat(envioSerialGPS, auxEnvioGPS);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,534 :: 		}
L_serialTxWioLTE594:
;MyProject.c,536 :: 		strcat(envioSerialGPS, ",");
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr125_MyProject+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr125_MyProject+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,538 :: 		memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,539 :: 		if(posteDesc){
	MOVF        _posteDesc+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_serialTxWioLTE598
;MyProject.c,540 :: 		strcat(envioSerialGPS, posteDesconectado);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _posteDesconectado+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_posteDesconectado+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,541 :: 		}
	GOTO        L_serialTxWioLTE599
L_serialTxWioLTE598:
;MyProject.c,543 :: 		pasajerosBajanE = eepromLeeNumero(0x0700, 2);
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       7
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       2
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _pasajerosBajanE+0 
	MOVF        R1, 0 
	MOVWF       _pasajerosBajanE+1 
;MyProject.c,544 :: 		inttostrWithZeros(pasajerosbajanE, envioGPS);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStrWithZeros_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_IntToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_IntToStrWithZeros_output+1 
	CALL        _IntToStrWithZeros+0, 0
;MyProject.c,545 :: 		for(l=0 ; l<4 ; l++){
	CLRF        _l+0 
L_serialTxWioLTE600:
	MOVLW       128
	XORWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE601
;MyProject.c,546 :: 		auxEnvioGPS[l] = envioGPS[l+2];
	MOVLW       _auxEnvioGPS+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FSR1H 
	MOVF        _l+0, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	ADDWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _envioGPS+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_envioGPS+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,545 :: 		for(l=0 ; l<4 ; l++){
	INCF        _l+0, 1 
;MyProject.c,547 :: 		}
	GOTO        L_serialTxWioLTE600
L_serialTxWioLTE601:
;MyProject.c,548 :: 		strcat(envioSerialGPS, auxEnvioGPS);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,549 :: 		}
L_serialTxWioLTE599:
;MyProject.c,551 :: 		strcat(envioSerialGPS, ",");
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr126_MyProject+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr126_MyProject+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,553 :: 		memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,554 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,555 :: 		if(cuentaBloqueo > auxCuentaBloqueo){
	MOVLW       128
	XORWF       R0, 0 
	MOVWF       R4 
	MOVLW       128
	XORWF       _cuentaBloqueo+0, 0 
	SUBWF       R4, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE603
;MyProject.c,556 :: 		wordtostrWithZeros(cuentaBloqueo, envioGPS);
	MOVF        _cuentaBloqueo+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVLW       0
	BTFSC       _cuentaBloqueo+0, 7 
	MOVLW       255
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;MyProject.c,557 :: 		}
	GOTO        L_serialTxWioLTE604
L_serialTxWioLTE603:
;MyProject.c,559 :: 		wordtostrWithZeros(auxCuentaBloqueo, envioGPS);
	MOVF        _auxCuentaBloqueo+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVLW       0
	BTFSC       _auxCuentaBloqueo+0, 7 
	MOVLW       255
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;MyProject.c,560 :: 		}
L_serialTxWioLTE604:
;MyProject.c,561 :: 		wordtostrWithZeros(auxCuentaBloqueo, envioGPS);
	MOVF        _auxCuentaBloqueo+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVLW       0
	BTFSC       _auxCuentaBloqueo+0, 7 
	MOVLW       255
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;MyProject.c,562 :: 		for(l=0 ; l<3 ; l++){
	CLRF        _l+0 
L_serialTxWioLTE605:
	MOVLW       128
	XORWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE606
;MyProject.c,563 :: 		auxEnvioGPS[l] = envioGPS[l+2];
	MOVLW       _auxEnvioGPS+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FSR1H 
	MOVF        _l+0, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	ADDWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _envioGPS+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_envioGPS+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,562 :: 		for(l=0 ; l<3 ; l++){
	INCF        _l+0, 1 
;MyProject.c,564 :: 		}
	GOTO        L_serialTxWioLTE605
L_serialTxWioLTE606:
;MyProject.c,565 :: 		strcat(envioSerialGPS, auxEnvioGPS);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,567 :: 		strcat(envioSerialGPS, ",");
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr127_MyProject+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr127_MyProject+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,569 :: 		memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,570 :: 		bloqEsclavo = eepromLeeNumero(0x000C, 1);
	MOVLW       12
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _bloqEsclavo+0 
;MyProject.c,571 :: 		if(bufferRecepcionEsclavo[2] > bloqEsclavo){
	MOVLW       128
	BTFSC       R0, 7 
	MOVLW       127
	MOVWF       R4 
	MOVLW       128
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__serialTxWioLTE2433
	MOVF        _bufferRecepcionEsclavo+2, 0 
	SUBWF       R0, 0 
L__serialTxWioLTE2433:
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE608
;MyProject.c,572 :: 		wordtostrWithZeros(bufferRecepcionEsclavo[2], envioGPS);
	MOVF        _bufferRecepcionEsclavo+2, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVLW       0
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;MyProject.c,573 :: 		}
	GOTO        L_serialTxWioLTE609
L_serialTxWioLTE608:
;MyProject.c,575 :: 		wordtostrWithZeros(bloqEsclavo, envioGPS);
	MOVF        _bloqEsclavo+0, 0 
	MOVWF       FARG_WordToStrWithZeros_input+0 
	MOVLW       0
	BTFSC       _bloqEsclavo+0, 7 
	MOVLW       255
	MOVWF       FARG_WordToStrWithZeros_input+1 
	MOVLW       _envioGPS+0
	MOVWF       FARG_WordToStrWithZeros_output+0 
	MOVLW       hi_addr(_envioGPS+0)
	MOVWF       FARG_WordToStrWithZeros_output+1 
	CALL        _WordToStrWithZeros+0, 0
;MyProject.c,576 :: 		}
L_serialTxWioLTE609:
;MyProject.c,577 :: 		for(l=0 ; l<3 ; l++){
	CLRF        _l+0 
L_serialTxWioLTE610:
	MOVLW       128
	XORWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE611
;MyProject.c,578 :: 		auxEnvioGPS[l] = envioGPS[l+2];
	MOVLW       _auxEnvioGPS+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FSR1H 
	MOVF        _l+0, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	ADDWF       _l+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _envioGPS+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_envioGPS+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,577 :: 		for(l=0 ; l<3 ; l++){
	INCF        _l+0, 1 
;MyProject.c,579 :: 		}
	GOTO        L_serialTxWioLTE610
L_serialTxWioLTE611:
;MyProject.c,580 :: 		strcat(envioSerialGPS, auxEnvioGPS);
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,581 :: 		memset(auxEnvioGPS, 0, sizeof(auxEnvioGPS));
	MOVLW       _auxEnvioGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_auxEnvioGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       5
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,584 :: 		strcat(envioSerialGPS, ",");
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr128_MyProject+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr128_MyProject+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,586 :: 		strcat(envioSerialGPS, "0,\r\n");
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr129_MyProject+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr129_MyProject+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;MyProject.c,587 :: 		for(l=0; l<strlen(envioSerialGPS); l++){
	CLRF        _l+0 
L_serialTxWioLTE613:
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	BTFSC       _l+0, 7 
	MOVLW       127
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__serialTxWioLTE2434
	MOVF        R0, 0 
	SUBWF       _l+0, 0 
L__serialTxWioLTE2434:
	BTFSC       STATUS+0, 0 
	GOTO        L_serialTxWioLTE614
;MyProject.c,588 :: 		Soft_UART_Write(envioSerialGPS[l]);
	MOVLW       _envioSerialGPS+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FSR0H 
	MOVF        _l+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       _l+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;MyProject.c,587 :: 		for(l=0; l<strlen(envioSerialGPS); l++){
	INCF        _l+0, 1 
;MyProject.c,589 :: 		}
	GOTO        L_serialTxWioLTE613
L_serialTxWioLTE614:
;MyProject.c,590 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;MyProject.c,591 :: 		lcd_out(1,1,envioSerialGPS);
	MOVLW       1
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;MyProject.c,593 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_lcd_cmd_comando+0 
	CALL        _lcd_cmd+0, 0
;MyProject.c,594 :: 		memset(envioSerialGPS, 0, sizeof(envioSerialGPS));
	MOVLW       _envioSerialGPS+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_envioSerialGPS+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       45
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MyProject.c,595 :: 		desbordoGPS = 0;
	CLRF        _desbordoGPS+0 
	CLRF        _desbordoGPS+1 
;MyProject.c,596 :: 		}
L_serialTxWioLTE579:
;MyProject.c,597 :: 		}
L_end_serialTxWioLTE:
	RETURN      0
; end of _serialTxWioLTE

_RX_PIC_PIC:

;MyProject.c,603 :: 		void RX_PIC_PIC(){
;MyProject.c,604 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_RX_PIC_PIC616
;MyProject.c,605 :: 		if(k < 10){
	MOVLW       128
	XORWF       _k+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       10
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_RX_PIC_PIC617
;MyProject.c,606 :: 		if(k == 9){
	MOVF        _k+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_RX_PIC_PIC618
;MyProject.c,607 :: 		UART1_Read_Text(confirmacionEsclavo, ".", 2);
	MOVLW       _confirmacionEsclavo+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_confirmacionEsclavo+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr130_MyProject+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr130_MyProject+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       2
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;MyProject.c,608 :: 		if(!strcmp(confirmacionEsclavo, "C")){
	MOVLW       _confirmacionEsclavo+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_confirmacionEsclavo+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr131_MyProject+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr131_MyProject+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_RX_PIC_PIC619
;MyProject.c,609 :: 		conexionHabilitada = true;
	MOVLW       1
	MOVWF       _conexionHabilitada+0 
;MyProject.c,610 :: 		}
	GOTO        L_RX_PIC_PIC620
L_RX_PIC_PIC619:
;MyProject.c,612 :: 		conexionHabilitada = false;
	CLRF        _conexionHabilitada+0 
;MyProject.c,613 :: 		}
L_RX_PIC_PIC620:
;MyProject.c,614 :: 		}
	GOTO        L_RX_PIC_PIC621
L_RX_PIC_PIC618:
;MyProject.c,616 :: 		bufferRecepcionEsclavo[k] = UART1_Read();
	MOVLW       _bufferRecepcionEsclavo+0
	MOVWF       FLOC__RX_PIC_PIC+0 
	MOVLW       hi_addr(_bufferRecepcionEsclavo+0)
	MOVWF       FLOC__RX_PIC_PIC+1 
	MOVF        _k+0, 0 
	ADDWF       FLOC__RX_PIC_PIC+0, 1 
	MOVLW       0
	BTFSC       _k+0, 7 
	MOVLW       255
	ADDWFC      FLOC__RX_PIC_PIC+1, 1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__RX_PIC_PIC+0, FSR1
	MOVFF       FLOC__RX_PIC_PIC+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,617 :: 		checksum[k] = bufferRecepcionEsclavo[k];
	MOVLW       _checksum+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_checksum+0)
	MOVWF       FSR1H 
	MOVF        _k+0, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       _k+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       _bufferRecepcionEsclavo+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_bufferRecepcionEsclavo+0)
	MOVWF       FSR0H 
	MOVF        _k+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       _k+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,618 :: 		}
L_RX_PIC_PIC621:
;MyProject.c,619 :: 		k = k++;
	INCF        _k+0, 1 
;MyProject.c,620 :: 		if(k > 9){
	MOVLW       128
	XORLW       9
	MOVWF       R0 
	MOVLW       128
	XORWF       _k+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_RX_PIC_PIC622
;MyProject.c,621 :: 		k = 0;
	CLRF        _k+0 
;MyProject.c,622 :: 		checksum[5] = checksum[0] + checksum[1] + checksum[2];
	MOVF        _checksum+1, 0 
	ADDWF       _checksum+0, 0 
	MOVWF       R0 
	MOVF        _checksum+2, 0 
	ADDWF       R0, 0 
	MOVWF       _checksum+5 
;MyProject.c,623 :: 		banderaRx = true;
	MOVLW       1
	MOVWF       _banderaRx+0 
;MyProject.c,624 :: 		}
L_RX_PIC_PIC622:
;MyProject.c,625 :: 		}
L_RX_PIC_PIC617:
;MyProject.c,626 :: 		}
L_RX_PIC_PIC616:
;MyProject.c,627 :: 		if(!MSTR){
	BTFSC       PORTD+0, 2 
	GOTO        L_RX_PIC_PIC623
;MyProject.c,628 :: 		UART1_Read_Text(solicitudMaestro, ".", 2);
	MOVLW       _solicitudMaestro+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_solicitudMaestro+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr132_MyProject+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr132_MyProject+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       2
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;MyProject.c,629 :: 		if(!strcmp(solicitudMaestro, "C")){
	MOVLW       _solicitudMaestro+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_solicitudMaestro+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr133_MyProject+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr133_MyProject+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_RX_PIC_PIC624
;MyProject.c,630 :: 		EnvioCuenta = true;
	MOVLW       1
	MOVWF       _EnvioCuenta+0 
;MyProject.c,631 :: 		}
L_RX_PIC_PIC624:
;MyProject.c,632 :: 		if(!strcmp(solicitudMaestro, "R")){
	MOVLW       _solicitudMaestro+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_solicitudMaestro+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr134_MyProject+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr134_MyProject+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_RX_PIC_PIC625
;MyProject.c,633 :: 		banderaReset =  true;
	MOVLW       1
	MOVWF       _banderaReset+0 
;MyProject.c,634 :: 		}
L_RX_PIC_PIC625:
;MyProject.c,635 :: 		}
L_RX_PIC_PIC623:
;MyProject.c,636 :: 		}
L_end_RX_PIC_PIC:
	RETURN      0
; end of _RX_PIC_PIC

_SENSADO:

;MyProject.c,645 :: 		void SENSADO(){
;MyProject.c,647 :: 		if(Bandera.SensorU & !Bandera.Par1){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        _Bandera+9, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO626
;MyProject.c,648 :: 		sensorBloqueo();
	CALL        _sensorBloqueo+0, 0
;MyProject.c,649 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO627
;MyProject.c,650 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,651 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,652 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,653 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,654 :: 		}
L_SENSADO627:
;MyProject.c,655 :: 		}
L_SENSADO626:
;MyProject.c,656 :: 		if(Bandera.SensorD & !Bandera.Par1){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        _Bandera+10, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO628
;MyProject.c,657 :: 		sensorBloqueoD();
	CALL        _sensorBloqueoD+0, 0
;MyProject.c,658 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO629
;MyProject.c,659 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,660 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,661 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,662 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,663 :: 		}
L_SENSADO629:
;MyProject.c,664 :: 		}
L_SENSADO628:
;MyProject.c,665 :: 		if(Bandera.SensorT & !Bandera.par2){
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        _Bandera+11, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO630
;MyProject.c,666 :: 		sensorBloqueoT();
	CALL        _sensorBloqueoT+0, 0
;MyProject.c,667 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO631
;MyProject.c,668 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,669 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,670 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,671 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,672 :: 		}
L_SENSADO631:
;MyProject.c,673 :: 		}
L_SENSADO630:
;MyProject.c,674 :: 		if(Bandera.SensorC & !Bandera.Par2){
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        _Bandera+12, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO632
;MyProject.c,675 :: 		sensorBloqueoC();
	CALL        _sensorBloqueoC+0, 0
;MyProject.c,676 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO633
;MyProject.c,677 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,678 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,679 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,680 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,681 :: 		}
L_SENSADO633:
;MyProject.c,682 :: 		}
L_SENSADO632:
;MyProject.c,683 :: 		if(Bandera.SensorO & !Bandera.Par3){
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        _Bandera+13, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO634
;MyProject.c,684 :: 		sensorBloqueoO();
	CALL        _sensorBloqueoO+0, 0
;MyProject.c,685 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO635
;MyProject.c,686 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,687 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,688 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,689 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,690 :: 		}
L_SENSADO635:
;MyProject.c,691 :: 		}
L_SENSADO634:
;MyProject.c,692 :: 		if(Bandera.SensorS & !Bandera.Par3){
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        _Bandera+14, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO636
;MyProject.c,693 :: 		sensorBloqueoS();
	CALL        _sensorBloqueoS+0, 0
;MyProject.c,694 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO637
;MyProject.c,695 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,696 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,697 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,698 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,699 :: 		}
L_SENSADO637:
;MyProject.c,700 :: 		}
L_SENSADO636:
;MyProject.c,701 :: 		if(!Bandera.SensorU & !Bandera.SensorD & !Bandera.SensorT & !Bandera.SensorC & !Bandera.SensorO & !Bandera.SensorS & !Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par9){
	MOVF        _Bandera+9, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _Bandera+10, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+11, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+12, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+13, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+14, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO638
;MyProject.c,702 :: 		sensorNoBloqueo();
	CALL        _sensorNoBloqueo+0, 0
;MyProject.c,703 :: 		return;
	GOTO        L_end_SENSADO
;MyProject.c,704 :: 		}
L_SENSADO638:
;MyProject.c,705 :: 		if(Bandera.Par1 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       _Bandera+0, 0 
	MOVWF       R1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO639
;MyProject.c,706 :: 		sensorBloqueoPar1();
	CALL        _sensorBloqueoPar1+0, 0
;MyProject.c,707 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO640
;MyProject.c,708 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,709 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,710 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,711 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,712 :: 		}
L_SENSADO640:
;MyProject.c,713 :: 		}
L_SENSADO639:
;MyProject.c,714 :: 		if(Bandera.Par2 & !Bandera.Par1 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       _Bandera+1, 0 
	MOVWF       R1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO641
;MyProject.c,715 :: 		sensorBloqueoPar2();
	CALL        _sensorBloqueoPar2+0, 0
;MyProject.c,716 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO642
;MyProject.c,717 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,718 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,719 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,720 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,721 :: 		}
L_SENSADO642:
;MyProject.c,722 :: 		}
L_SENSADO641:
;MyProject.c,723 :: 		if(Bandera.Par3 & !Bandera.Par2 & !Bandera.Par1 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       _Bandera+2, 0 
	MOVWF       R1 
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO643
;MyProject.c,724 :: 		sensorBloqueoPar3();
	CALL        _sensorBloqueoPar3+0, 0
;MyProject.c,725 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO644
;MyProject.c,726 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,727 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,728 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,729 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,730 :: 		}
L_SENSADO644:
;MyProject.c,731 :: 		}
L_SENSADO643:
;MyProject.c,732 :: 		if(Bandera.Par4 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par1 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       _Bandera+3, 0 
	MOVWF       R1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO645
;MyProject.c,733 :: 		sensorBloqueoPar4();
	CALL        _sensorBloqueoPar4+0, 0
;MyProject.c,734 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO646
;MyProject.c,735 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,736 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,737 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,738 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,739 :: 		}
L_SENSADO646:
;MyProject.c,740 :: 		}
L_SENSADO645:
;MyProject.c,741 :: 		if(Bandera.Par6& !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par1 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       _Bandera+5, 0 
	MOVWF       R1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO647
;MyProject.c,742 :: 		sensorBloqueoPar6();
	CALL        _sensorBloqueoPar6+0, 0
;MyProject.c,743 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO648
;MyProject.c,744 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,745 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,746 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,747 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,748 :: 		}
L_SENSADO648:
;MyProject.c,749 :: 		}
L_SENSADO647:
;MyProject.c,750 :: 		if(Bandera.Par7 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par1 & !Bandera.Par8 & !Bandera.Par9){
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       _Bandera+6, 0 
	MOVWF       R1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+8, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO649
;MyProject.c,751 :: 		sensorBloqueoPar7();
	CALL        _sensorBloqueoPar7+0, 0
;MyProject.c,752 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO650
;MyProject.c,753 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,754 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,755 :: 		eepromEscribeNumero(0x000B, auxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,756 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,757 :: 		}
L_SENSADO650:
;MyProject.c,758 :: 		}
L_SENSADO649:
;MyProject.c,759 :: 		if(Bandera.Par9 & !Bandera.Par2 & !Bandera.Par3 & !Bandera.Par4 & !Bandera.Par5 & !Bandera.Par6 & !Bandera.Par7 & !Bandera.Par8 & !Bandera.Par1){
	MOVF        _Bandera+1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       _Bandera+8, 0 
	MOVWF       R1 
	MOVF        _Bandera+2, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+3, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+4, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+5, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+6, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       R1, 1 
	MOVF        _Bandera+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO651
;MyProject.c,760 :: 		sensorBloqueoPar9();
	CALL        _sensorBloqueoPar9+0, 0
;MyProject.c,761 :: 		if(cuenta){
	MOVF        _cuenta+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SENSADO652
;MyProject.c,762 :: 		auxCuentaBloqueo = eepromLeeNumero(0x000B, 1);
	MOVLW       11
	MOVWF       FARG_eepromLeeNumero_registro+0 
	MOVLW       0
	MOVWF       FARG_eepromLeeNumero_registro+1 
	MOVLW       1
	MOVWF       FARG_eepromLeeNumero_BYTES+0 
	CALL        _eepromLeeNumero+0, 0
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,763 :: 		auxCuentaBloqueo++;
	INCF        R0, 1 
	MOVF        R0, 0 
	MOVWF       _auxCuentaBloqueo+0 
;MyProject.c,764 :: 		eepromEscribeNumero(0x000B, AuxcuentaBloqueo, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	MOVF        R0, 0 
	MOVWF       FARG_eepromEscribeNumero_Dato+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_eepromEscribeNumero_Dato+1 
	MOVWF       FARG_eepromEscribeNumero_Dato+2 
	MOVWF       FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,765 :: 		cuenta = false;
	CLRF        _cuenta+0 
;MyProject.c,766 :: 		}
L_SENSADO652:
;MyProject.c,767 :: 		}
L_SENSADO651:
;MyProject.c,768 :: 		}
L_end_SENSADO:
	RETURN      0
; end of _SENSADO

_desbordoTemporizadorCero:

;MyProject.c,776 :: 		void desbordoTemporizadorCero(){
;MyProject.c,778 :: 		if(INTCON.TMR0IF && INTCON.TMR0IE){
	BTFSS       INTCON+0, 2 
	GOTO        L_desbordoTemporizadorCero655
	BTFSS       INTCON+0, 5 
	GOTO        L_desbordoTemporizadorCero655
L__desbordoTemporizadorCero664:
;MyProject.c,780 :: 		cuentaUSART = cuentaUSART++;
	INCF        _cuentaUSART+0, 1 
;MyProject.c,781 :: 		desbordoGPS = desbordoGPS++;
	INFSNZ      _desbordoGPS+0, 1 
	INCF        _desbordoGPS+1, 1 
;MyProject.c,782 :: 		conexionPoste = conexionPoste++;
	INCF        _conexionPoste+0, 1 
;MyProject.c,783 :: 		if(comienzaContarAtasco){
	MOVF        _comienzaContarAtasco+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_desbordoTemporizadorCero656
;MyProject.c,784 :: 		cuentaAtasco++;
	INCF        _cuentaAtasco+0, 1 
;MyProject.c,785 :: 		}
L_desbordoTemporizadorCero656:
;MyProject.c,793 :: 		bloqueos(SENSOR1, SENSOR2, SENSOR3, SENSOR4, SENSOR5, SENSOR6, &cuentaBloqueo);
	MOVLW       0
	BTFSC       PORTB+0, 4 
	MOVLW       1
	MOVWF       FARG_bloqueos_SENSOR1+0 
	MOVLW       0
	BTFSC       PORTD+0, 4 
	MOVLW       1
	MOVWF       FARG_bloqueos_SENSOR2+0 
	MOVLW       0
	BTFSC       PORTB+0, 2 
	MOVLW       1
	MOVWF       FARG_bloqueos_SENSOR3+0 
	MOVLW       0
	BTFSC       PORTB+0, 3 
	MOVLW       1
	MOVWF       FARG_bloqueos_SENSOR4+0 
	MOVLW       0
	BTFSC       PORTB+0, 0 
	MOVLW       1
	MOVWF       FARG_bloqueos_SENSOR5+0 
	MOVLW       0
	BTFSC       PORTB+0, 1 
	MOVLW       1
	MOVWF       FARG_bloqueos_SENSOR6+0 
	MOVLW       _cuentaBloqueo+0
	MOVWF       FARG_bloqueos_cuentaBloqueo+0 
	MOVLW       hi_addr(_cuentaBloqueo+0)
	MOVWF       FARG_bloqueos_cuentaBloqueo+1 
	CALL        _bloqueos+0, 0
;MyProject.c,795 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;MyProject.c,798 :: 		TMR0L = 0x69;                             //1 segundo para el desbordo del contador
	MOVLW       105
	MOVWF       TMR0L+0 
;MyProject.c,799 :: 		TMR0H = 0x67;
	MOVLW       103
	MOVWF       TMR0H+0 
;MyProject.c,800 :: 		}
L_desbordoTemporizadorCero655:
;MyProject.c,801 :: 		}
L_end_desbordoTemporizadorCero:
	RETURN      0
; end of _desbordoTemporizadorCero

_resetCuentas:

;MyProject.c,810 :: 		void resetCuentas(){
;MyProject.c,812 :: 		short l = 0;
	CLRF        resetCuentas_l_L0+0 
;MyProject.c,814 :: 		if(RESET_BOTON | resetWioLTE){
	CLRF        R0 
	BTFSC       PORTD+0, 1 
	INCF        R0, 1 
	MOVF        _resetWioLTE+0, 0 
	IORWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_resetCuentas657
;MyProject.c,815 :: 		if(MSTR){
	BTFSS       PORTD+0, 2 
	GOTO        L_resetCuentas658
;MyProject.c,816 :: 		if(UART1_Tx_Idle() == true){
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_resetCuentas659
;MyProject.c,817 :: 		UART1_Write_Text(solicitudReset);
	MOVLW       _solicitudReset+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_solicitudReset+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,818 :: 		}
L_resetCuentas659:
;MyProject.c,819 :: 		eepromEscribeNumero(0x0000, 0x0000, 2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,820 :: 		eepromEscribeNumero(0x0003, 0x0000, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,821 :: 		eepromEscribeNumero(0x0005, 0x0000, 2);
	MOVLW       5
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,822 :: 		eepromEscribeNumero(0x0007, 0x0000, 2);
	MOVLW       7
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,823 :: 		eepromEscribeNumero(0x0009, 0x0000, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,824 :: 		eepromEscribeNumero(0x000B, 0x00, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,825 :: 		eepromEscribeNumero(0x000C, 0x00, 1);
	MOVLW       12
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,826 :: 		}
L_resetCuentas658:
;MyProject.c,827 :: 		for(l = 0; l < 8; l++){
	CLRF        resetCuentas_l_L0+0 
L_resetCuentas660:
	MOVLW       128
	XORWF       resetCuentas_l_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       8
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_resetCuentas661
;MyProject.c,828 :: 		Soft_UART_Write(respuestaReset[l]);
	MOVLW       _respuestaReset+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_respuestaReset+0)
	MOVWF       FSR0H 
	MOVF        resetCuentas_l_L0+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       resetCuentas_l_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;MyProject.c,827 :: 		for(l = 0; l < 8; l++){
	INCF        resetCuentas_l_L0+0, 1 
;MyProject.c,829 :: 		}
	GOTO        L_resetCuentas660
L_resetCuentas661:
;MyProject.c,830 :: 		soft_UART_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;MyProject.c,831 :: 		soft_UART_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_Soft_UART_Write_udata+0 
	CALL        _Soft_UART_Write+0, 0
;MyProject.c,832 :: 		resetWioLTE = false;
	CLRF        _resetWioLTE+0 
;MyProject.c,833 :: 		}
L_resetCuentas657:
;MyProject.c,834 :: 		}
L_end_resetCuentas:
	RETURN      0
; end of _resetCuentas

_resetSLV:

;MyProject.c,836 :: 		void resetSLV(){
;MyProject.c,837 :: 		if(banderaReset){
	MOVF        _banderaReset+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_resetSLV663
;MyProject.c,838 :: 		eepromEscribeNumero(0x0000, 0x0000, 2);
	CLRF        FARG_eepromEscribeNumero_Registro+0 
	CLRF        FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,839 :: 		eepromEscribeNumero(0x0003, 0x0000, 2);
	MOVLW       3
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,840 :: 		eepromEscribeNumero(0x0009, 0x0000, 2);
	MOVLW       9
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       2
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,841 :: 		eepromEscribeNumero(0x000B, 0x00, 1);
	MOVLW       11
	MOVWF       FARG_eepromEscribeNumero_Registro+0 
	MOVLW       0
	MOVWF       FARG_eepromEscribeNumero_Registro+1 
	CLRF        FARG_eepromEscribeNumero_Dato+0 
	CLRF        FARG_eepromEscribeNumero_Dato+1 
	CLRF        FARG_eepromEscribeNumero_Dato+2 
	CLRF        FARG_eepromEscribeNumero_Dato+3 
	MOVLW       1
	MOVWF       FARG_eepromEscribeNumero_BYTES+0 
	CALL        _eepromEscribeNumero+0, 0
;MyProject.c,842 :: 		banderaReset = false;
	CLRF        _banderaReset+0 
;MyProject.c,843 :: 		}
L_resetSLV663:
;MyProject.c,844 :: 		}
L_end_resetSLV:
	RETURN      0
; end of _resetSLV

_indicadorSensores:

;MyProject.c,846 :: 		void indicadorSensores(){
;MyProject.c,847 :: 		estado1 = SENSOR1;
	MOVLW       0
	BTFSC       PORTB+0, 4 
	MOVLW       1
	MOVWF       _estado1+0 
;MyProject.c,848 :: 		estado2 = SENSOR2;
	MOVLW       0
	BTFSC       PORTD+0, 4 
	MOVLW       1
	MOVWF       _estado2+0 
;MyProject.c,849 :: 		estado3 = SENSOR3;
	MOVLW       0
	BTFSC       PORTB+0, 2 
	MOVLW       1
	MOVWF       _estado3+0 
;MyProject.c,850 :: 		estado4 = SENSOR4;
	MOVLW       0
	BTFSC       PORTB+0, 3 
	MOVLW       1
	MOVWF       _estado4+0 
;MyProject.c,851 :: 		estado5 = SENSOR5;
	MOVLW       0
	BTFSC       PORTB+0, 0 
	MOVLW       1
	MOVWF       _estado5+0 
;MyProject.c,852 :: 		estado6 = SENSOR6;
	MOVLW       0
	BTFSC       PORTB+0, 1 
	MOVLW       1
	MOVWF       _estado6+0 
;MyProject.c,854 :: 		bytetostr(estado1, aux1);
	MOVF        _estado1+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _Aux1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_Aux1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;MyProject.c,855 :: 		bytetostr(estado2, aux2);
	MOVF        _estado2+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _Aux2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_Aux2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;MyProject.c,856 :: 		bytetostr(estado3, aux3);
	MOVF        _estado3+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _Aux3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_Aux3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;MyProject.c,857 :: 		bytetostr(estado4, aux4);
	MOVF        _estado4+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _Aux4+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_Aux4+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;MyProject.c,858 :: 		bytetostr(estado5, aux5);
	MOVF        _estado5+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _Aux5+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_Aux5+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;MyProject.c,859 :: 		bytetostr(estado6, aux6);
	MOVF        _estado6+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _Aux6+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_Aux6+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;MyProject.c,861 :: 		lcd_out(1,5,aux1);
	MOVLW       1
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       5
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _Aux1+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_Aux1+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;MyProject.c,862 :: 		lcd_outConst(1,5,"1:");
	MOVLW       1
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       5
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_135_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_135_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_135_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;MyProject.c,863 :: 		lcd_out(1,1,aux2);
	MOVLW       1
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _Aux2+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_Aux2+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;MyProject.c,864 :: 		lcd_outConst(1,1,"2:");
	MOVLW       1
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_136_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_136_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_136_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;MyProject.c,865 :: 		lcd_out(2,5,aux3);
	MOVLW       2
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       5
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _Aux3+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_Aux3+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;MyProject.c,866 :: 		lcd_outConst(2,5,"3:");
	MOVLW       2
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       5
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_137_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_137_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_137_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;MyProject.c,867 :: 		lcd_out(2,1,aux4);
	MOVLW       2
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _Aux4+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_Aux4+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;MyProject.c,868 :: 		lcd_outConst(2,1,"4:");
	MOVLW       2
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_138_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_138_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_138_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;MyProject.c,869 :: 		lcd_out(4,5,aux5);
	MOVLW       4
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       5
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _Aux5+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_Aux5+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;MyProject.c,870 :: 		lcd_outConst(4,5,"5:");
	MOVLW       4
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       5
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_139_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_139_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_139_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;MyProject.c,871 :: 		lcd_out(4,1,aux6);
	MOVLW       4
	MOVWF       FARG_lcd_out_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_out_col+0 
	MOVLW       _Aux6+0
	MOVWF       FARG_lcd_out_texto+0 
	MOVLW       hi_addr(_Aux6+0)
	MOVWF       FARG_lcd_out_texto+1 
	CALL        _lcd_out+0, 0
;MyProject.c,872 :: 		lcd_outConst(4,1,"6:");
	MOVLW       4
	MOVWF       FARG_lcd_outConst_fila+0 
	MOVLW       1
	MOVWF       FARG_lcd_outConst_col+0 
	MOVLW       ?lstr_140_MyProject+0
	MOVWF       FARG_lcd_outConst_texto+0 
	MOVLW       hi_addr(?lstr_140_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+1 
	MOVLW       higher_addr(?lstr_140_MyProject+0)
	MOVWF       FARG_lcd_outConst_texto+2 
	CALL        _lcd_outConst+0, 0
;MyProject.c,873 :: 		}
L_end_indicadorSensores:
	RETURN      0
; end of _indicadorSensores

_MASTER:

;MyProject.c,876 :: 		void MASTER(){
;MyProject.c,878 :: 		resetCuentas();
	CALL        _resetCuentas+0, 0
;MyProject.c,881 :: 		SENSADO();
	CALL        _SENSADO+0, 0
;MyProject.c,884 :: 		TX_MSTR();
	CALL        _TX_MSTR+0, 0
;MyProject.c,887 :: 		indicadorSensores();
	CALL        _indicadorSensores+0, 0
;MyProject.c,891 :: 		serialTxWioLTE();
	CALL        _serialTxWioLTE+0, 0
;MyProject.c,893 :: 		}
L_end_MASTER:
	RETURN      0
; end of _MASTER

_SLV:

;MyProject.c,895 :: 		void SLV(){
;MyProject.c,896 :: 		resetSLV();
	CALL        _resetSLV+0, 0
;MyProject.c,897 :: 		SENSADO();
	CALL        _SENSADO+0, 0
;MyProject.c,898 :: 		TX_SLV();
	CALL        _TX_SLV+0, 0
;MyProject.c,899 :: 		indicadorSensores();
	CALL        _indicadorSensores+0, 0
;MyProject.c,900 :: 		}
L_end_SLV:
	RETURN      0
; end of _SLV
