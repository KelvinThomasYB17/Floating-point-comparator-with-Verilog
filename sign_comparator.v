////////////////////////////////////////////////////////////////////////////////////////
// File: sign_comparator.v
////////////////////////////////////////////////////////////////////////////////////////
// Autor:     Kelvin Thomas Yllahuamán Bonifas
// Email:     k.thomas.yb17@gmail.com
////////////////////////////////////////////////////////////////////////////////////////
// History:
// Versión 1.0 (21/03/2024) /(dd/mmm/yyyy) Kelvin Thomas Yllahuamán Bonifas
////////////////////////////////////////////////////////////////////////////////////////
// Description:
// This subcircuit only receives the most significant bit from the two numbers to compare
//	which is the greater. The most significant bit in IEEE 754 is the sign of the number.
////////////////////////////////////////////////////////////////////////////////////////

module sign_comparator(
	input wire x,y,
	output reg [2:0] sign_comparison);
	
always@(*) begin
//1 is negative sign, 0 is positive sign in IEEE 754
	if (x < y) begin 
		sign_comparison = 3'b010;
	end else if (x > y) begin   
		sign_comparison = 3'b001;
	end else if (x == y) begin 
		sign_comparison = 3'b100;
	end else begin 
		sign_comparison = 3'b000;
	end
end

endmodule
