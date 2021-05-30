module clockgenerator #(parameter period) (output logic clk, n_rst);
initial
begin
	n_rst = '1;
	#1ns n_rst = '0;
	#1ns n_rst = '1;
	clk = '1;
	forever #period clk = ~clk;
end
endmodule
