module programCounter #(parameter size, parameter addsize = $clog2(size)) 
	(input logic clk, n_rst, input logic [addsize-1:0] newCount,
	 output logic [addsize-1:0] PCaddress);

logic [addsize-1:0] count = 0;

assign PCaddress = count;

always_ff @(posedge clk, negedge n_rst)
begin
	if(!n_rst)
		count <= '0;
	else
		count <= newCount;//the counting is done in the branch controller.
end

endmodule