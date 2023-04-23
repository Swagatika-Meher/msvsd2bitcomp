module priority_encoder
             ( input IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7,  
               input en,
               output O1, O2, O3
               );  
  
assign en=1;
assign O3=IN4 | IN5 | IN6 | IN7 &en;            //MSB
assign O2=IN2 | IN3 | IN6 | IN7 &en;
assign O1=IN1 | IN3 | IN5 | IN7 &en;            //LSB
endmodule
