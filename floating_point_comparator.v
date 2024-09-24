////////////////////////////////////////////////////////////////////////////////////////
// File: floating_point_comparator.v
////////////////////////////////////////////////////////////////////////////////////////
// Autor:     Kelvin Thomas Yllahuamán Bonifas
// Email:     k.thomas.yb17@gmail.com
////////////////////////////////////////////////////////////////////////////////////////
// History:
// Versión 1.0 (21/03/2024) /(dd/mmm/yyyy) Kelvin Thomas Yllahuamán Bonifas
////////////////////////////////////////////////////////////////////////////////////////
// Description:
// This top comparator circuit receives 2 input numbers in IEEE 754 standar.
////////////////////////////////////////////////////////////////////////////////////////

module floating_point_comparator#(
	parameter WIDTH = 32
	)(
	input wire [WIDTH - 1:0]a,b,
	output reg greater, less, equal
	);
	

localparam FRACTION_WIDTH = 22;
localparam ZERO_FRACTION = 23'b00000000000000000000000;

wire sign_a, sign_b;
wire [WIDTH - 2: FRACTION_WIDTH + 1] exponent_a, exponent_b;
wire [FRACTION_WIDTH: 0] fraction_a, fraction_b;

assign sign_a = a[WIDTH -1];
assign sign_b = b[WIDTH -1];
assign exponent_a = a[WIDTH -2:FRACTION_WIDTH + 1];
assign exponent_b = b[WIDTH -2:FRACTION_WIDTH + 1];
assign fraction_a = a[FRACTION_WIDTH:0];
assign fraction_b = b[FRACTION_WIDTH:0];

wire [2:0] sign_comparison;

sign_comparator sign_comp_inst (
	.x(sign_a),
	.y(sign_b),
	.sign_comparison(sign_comparison)
	);

	
always@(*) begin

	if (((exponent_a == 8'hFF) && (fraction_a != ZERO_FRACTION)) || ((exponent_b == 8'hFF) && (fraction_b == ZERO_FRACTION))) begin
		//If a or b is a NaN number
		greater = 0;
		less = 0;
		equal = 0;
	end else begin 	
		if (sign_comparison == 3'b010) begin 
			//Starting to compare sign  
			greater = 1;
			less = 0;
			equal = 0;
		end else if (sign_comparison == 3'b001) begin
			greater = 0;
			less = 1;
			equal = 0;
		end else begin
			if (sign_a == 0) begin
				//Equal sign 0, starting to compare exponent 
				if (exponent_a > exponent_b) begin
					greater = 1;
					less = 0;
					equal = 0;
				end else if (exponent_a < exponent_b) begin	
					greater = 0;
					less = 1;
					equal = 0;
				end else begin
					//Equal sign 0, equal exponent, starting to compare fraction 
					if (fraction_a > fraction_b) begin
						greater = 1;
						less = 0;
						equal = 0;
					end else if (fraction_a < fraction_b) begin
						greater = 0;
						less = 1;
						equal = 0;
					end else if (fraction_a == fraction_b) begin
						greater = 0;
						less = 0;
						equal = 1;
					end else begin
						greater = 0;
						less = 0;
						equal = 0;
					end
				end
			end else begin 

				//Equal sign 1, starting to compare exponent 
				if (exponent_a > exponent_b) begin
					greater = 0;
					less = 1;
					equal = 0;
				end else if (exponent_a < exponent_b) begin	
					greater = 1;
					less = 0;
					equal = 0;
				end else begin
					//Equal sign 0, equal exponent, starting to compare fraction 
					if (fraction_a > fraction_b) begin
						greater = 0;
						less = 1;
						equal = 0;
					end else if (fraction_a < fraction_b) begin
						greater = 1;
						less = 0;
						equal = 0;
					end else if (fraction_a == fraction_b) begin
						greater = 0;
						less = 0;
						equal = 1;
					end else begin
						greater = 0;
						less = 0;
						equal = 0;
					end
				end		
			end	
		end
	end	
end


endmodule










