; Utilities used for making the processor do nothing. 

delay_10us    psha
              lda #7
dly_lp1:      deca
              bne dly_lp1              
              pula
              rts

delay_100us    psha
              lda #10
dly_lp2:      jsr delay_10us
              deca
              bne dly_lp2              
              pula
              rts

delay_1ms    psha
              lda #10
dly_lp3:      jsr delay_100us
              deca
              bne dly_lp3              
              pula
              rts

delay_100ms    psha
              lda #100
dly_lp4:      jsr delay_1ms
              deca
              bne dly_lp4              
              
              pula
              rts

delay_1s    psha
              lda #10
dly_lp5:      jsr delay_100ms
              deca
              bne dly_lp5              
              pula
              rts

DELAY_HXMS   
             
             cphx #0
             beq zro
dly_lp6:     
             jsr delay_1ms
             decx
             bne dly_lp6
             
             pshh
             pulx
             tstx
             beq zro
             decx
             pshx
             pulh
             ldx #$ff
             bne dly_lp6
zro             
             rts
             
