.include "m64def.inc"

.org 0x0000
jmp main
 
.ORG 0X0002
JMP EXT_INT0_ISR           

.ORG 0X0004
JMP EXT_INT1_ISR                  

.ORG 0X0014
JMP T2_OV_ISR

.org 0x0050
;=======================================================================================
main :
LDI R20 , LOW(RAMEND)
OUT SPL , R20
LDI R20 , HIGH(RAMEND)
OUT SPH , R20           ; set stack pointer
;=======================================================================================
LDI R20    , 0X0A
STS EICRA  , R20		; falling edge for intrupt 0,1
LDI R20    , 0X03
OUT EIMSK  , R20		; Set intrupts
;=======================================================================================
LDI R20   , 56
OUT TCNT2 , R20			; Start timer from 56
LDI R20   , 0X05                 
OUT TCCR2 , R20         ; Set the prescaler
LDI R20   , 0X40
OUT TIMSK , R20         ; Turn on Timer2
;=======================================================================================
LDI R20   , 0X00
OUT DDRA  , R20			;Set input Port A      
OUT DDRC  , R20         ;Set input Port C            
LDI R20   , 0X0FF
OUT DDRE  , R20			;Set output Port E
OUT PORTE , R20         ;Write 0xFF in Port E
CBI DDRD  , 0  
CBI DDRD  , 1			;Set input bit 0,1 Port D
SBI DDRD  , 2  
SBI DDRD  , 3
SBI DDRD  , 4			;Set output bit 2,3,4 Port D
SBI PORTD , 0
SBI PORTD , 1   
SBI PORTD , 2  
SBI PORTD , 3
SBI PORTD , 4		    ;Write 1 in Port D
LDI R20   , 0X0FF
OUT PORTC , R20			;Write 1 in Port C
;=======================================================================================
LDI R16   , 5           ;Set for wining time 
LDI R17   , 0X0FF		;Set for intrupt condition
CLR R27					;Set for intrupt condition
LDI R18   , 1           ;Set for intrupt1    
CLR R21                 ;Timer counter 200ms          
CLR R22					;win counter
CLR R23	
LDI R30 ,0X0FF                        
SEI
;========================================================================================
GAME:   
          CALL SHART    ;Int0 check for player B start
		  CALL DARYAFT
		  CALL DARYAFT
		  CALL DARYAFT
		  CALL DARYAFT  ;Get input from Player A
		  CALL SHART    ;Int0 check for player A end

		  MOV   R19   ,R30		;Hold Player A inputs
		  LDI   R30   ,0X0FF 
		  MOV   R24   ,R23      ;Counting Player A inputs
		  CLR   R23   
          CALL  SHART
		  CBI   PORTD ,4        ;Turn on Yellow LED              
          CLR   R21
          LDI   R20   ,56       ;Set counter again
          OUT   TCNT2 ,R20

		  CALL DARYAFT         
		  CALL DARYAFT
		  CALL DARYAFT
		  CALL DARYAFT          ;Get input from player B
		  CPI   R21   , 51      ;Counting 10s
          BRCC  END             ;End game after 10s
		  CALL  SHART
		  SBI   PORTD , 4       ;Turn off Yellow LED B
          MOV   R29   , R30     ;Hold player B inputs
		  LDI   R30   ,0X0FF    ;Reset R30 for next round
		  MOV   R25   , R23     ;Counting Player B inputs
		  CLR   R23   
		  CP    R25   , R24     ;First check
		  BRNE  GHERMEZ
		  CP    R19   , R29     ;Second check
		  BREQ  SABZ
;=======================================================================================
GHERMEZ:  
		 CBI PORTD , 2			;Torn on RED LED
		 CALL DELAY3s  
		 SBI PORTD , 2			;Turn off RED LED
		 LDI R16   , 5
         LDI R18   , 1          ;Ready for intrupt1
		 CLR R23
		 LDI R17   , 0X0FF
         CLR R27                ;Ready for next round
		 JMP GAME

SABZ :   
         CBI  PORTD  ,3         ;Turn on GREEN LED
         CALL DELAY5s
         SBI  PORTD  ,3		    ;Turn off GREEN LED
		 INC  R22               ;Counting number of player B wins 
		 STS  0X6400 ,R22
         DEC  R16				;For decrement 1s
	  	 CPI  R16    ,1
		 BREQ END
	     LDI  R17    ,0X0FF
         CLR  R27
         LDI  R18    ,1 
		 CLR  R23
		 SBI  PORTD  ,4
         JMP  GAME
;=======================================================================================
END:    
         LDI R16     ,5
         LDI R18     ,1 
		 CLR R23
		 LDI R17     ,0X0FF
         CLR R27
		 SBI PORTD   , 4
	     JMP GAME;
;=======================================================================================
T2_OV_ISR: 
         LDI R20    ,56
		 OUT TCNT2  ,R20
		 INC R21             ;Counter of 200ms
         RETI
;=======================================================================================
EXT_INT0_ISR:
		 COM R17
		 RETI 
				 
EXT_INT1_ISR:    
         CLR R18
         RETI
;=======================================================================================             
SHART: 
	     CP    R17  , R27
	     BRNE  SHART
		 COM   R27
		 RET
;=======================================================================================
DARYAFT:             
        SHART1:   
		    CPI   R21   , 51	;Counting for 10s
            BRCC  END 
	        CPI   R18   , 0
	        BRNE  SHART1      
		  	INC   R23
	   	    CPI   R23 , 5      
			BRCC  BAZGASHT      
            IN    R20  , PINA   ;Get number for turn on LED 
  		    CPI   R20  , 1
		    BREQ  LED1
            CPI   R20  , 2
	        BREQ  LED2
            CPI   R20  , 3
	        BREQ  LED3
	        CPI   R20  , 4
	        BREQ  LED4
			DEC R23
		    JMP BAZGASHT

BAZGASHT:    LDI R18   ,1
             RETI
;=======================================================================================
LED1:       
             CBI PORTE  , 0
             IN  R30    , PINC
			 ANDI R30   ,0X0FF
             CALL DELAY1s
		     SBI PORTE  , 0
		     JMP BAZGASHT

LED2:        CBI PORTE  , 1
             IN  R30    , PINC
			 ANDI R30   ,0X0FF
             CALL DELAY1s
		     SBI PORTE  , 1
		     JMP BAZGASHT

LED3:        CBI PORTE  , 2
             IN  R30    , PINC
			 ANDI R30   ,0X0FF
             CALL DELAY1s
	         SBI PORTE  , 2
	         JMP BAZGASHT

LED4:        CBI PORTE  , 3
             IN  R30    , PINC
			 ANDI R30   ,0X0FF
             CALL DELAY1s
		     SBI PORTE  , 3

;=======================================================================================
DELAY1s:  SEI                     
          CLR    R21
          LDI    R20     , 56
          OUT    TCNT2   , R20  
CPAGAIN1: CP     R21     , R16
          BRNE   CPAGAIN1
		  CLI
          RET

DELAY3s:                         
          CLR    R21
          LDI    R20     , 56
          OUT    TCNT2   , R20    
CPAGAIN3: CPI    R21     , 15
          BRNE   CPAGAIN3
          RET

DELAY5s:                         
          CLR    R21
          LDI    R20     , 56
          OUT    TCNT2   , R20  
CPAGAIN5: CPI    R21     , 25
          BRNE   CPAGAIN5
          RET
