module flash_adc
(
	input vin, output T_1, T_2, T_3, T_4, T_5, T_6, T_7, Y1, Y2, Y3
	);
	
	//wire a,b,c,d,e,f,g;
	//Instantiating TIQ comparators
	
	FLASH_ADC_SYM_1 FA_1(
		.VIN(vin),
		.TIQ_1(T_1)
	);
	
	FLASH_ADC_SYM_2 FA_2(
		.VIN(vin),
		.TIQ_2(T_2)
	);
	
	FLASH_ADC_SYM_3 FA_3(
		.VIN(vin),
		.TIQ_3(T_3)
	);
	
	FLASH_ADC_SYM_4 FA_4(
		.VIN(vin),
		.TIQ_4(T_4)
	);
	
	FLASH_ADC_SYM_5 FA_5(
		.VIN(vin),
		.TIQ_5(T_5)
	);
	
	FLASH_ADC_SYM_6 FA_6(
		.VIN(vin),
		.TIQ_6(T_6)
	);
	
	FLASH_ADC_SYM_7 FA_7(
		.VIN(vin),
		.TIQ_7(T_7)
	);
	
	priority_encoder PE(
	.IN1(T_1),
	.IN2(T_2),
	.IN3(T_3),
	.IN4(T_4),
	.IN5(T_5),
	.IN6(T_6),
	.IN7(T_7),
	.O3(Y3),
	.O2(Y2),
	.O1(Y1)
	);

endmodule
