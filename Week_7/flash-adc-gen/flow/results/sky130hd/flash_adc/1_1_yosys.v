/* Generated by Yosys 0.26+53 (git sha1 8216b23fb, clang 10.0.0-4ubuntu1 -fPIC -Os) */

module flash_adc(vin, T_1, T_2, T_3, T_4, T_5, T_6, T_7, Y1, Y2, Y3);
  output T_1;
  wire T_1;
  output T_2;
  wire T_2;
  output T_3;
  wire T_3;
  output T_4;
  wire T_4;
  output T_5;
  wire T_5;
  output T_6;
  wire T_6;
  output T_7;
  wire T_7;
  output Y1;
  wire Y1;
  output Y2;
  wire Y2;
  output Y3;
  wire Y3;
  input vin;
  wire vin;
  sky130_fd_sc_hd__or4_1 _0_ (
    .A(T_2),
    .B(T_3),
    .C(T_6),
    .D(T_7),
    .X(Y2)
  );
  sky130_fd_sc_hd__or4_1 _1_ (
    .A(T_6),
    .B(T_7),
    .C(T_4),
    .D(T_5),
    .X(Y3)
  );
  sky130_fd_sc_hd__or4_1 _2_ (
    .A(T_3),
    .B(T_7),
    .C(T_5),
    .D(T_1),
    .X(Y1)
  );
  FLASH_ADC_SYM_1 FA_1 (
    .TIQ_1(T_1),
    .VIN(vin)
  );
  FLASH_ADC_SYM_2 FA_2 (
    .TIQ_2(T_2),
    .VIN(vin)
  );
  FLASH_ADC_SYM_3 FA_3 (
    .TIQ_3(T_3),
    .VIN(vin)
  );
  FLASH_ADC_SYM_4 FA_4 (
    .TIQ_4(T_4),
    .VIN(vin)
  );
  FLASH_ADC_SYM_5 FA_5 (
    .TIQ_5(T_5),
    .VIN(vin)
  );
  FLASH_ADC_SYM_6 FA_6 (
    .TIQ_6(T_6),
    .VIN(vin)
  );
  FLASH_ADC_SYM_7 FA_7 (
    .TIQ_7(T_7),
    .VIN(vin)
  );
endmodule
