//
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
	
	reg [15:0] q_2d [15:0]; //2-d q
    wire [2:0] nghbr_num [255:0];
    integer idx_i_d,idx_i_u,idx_j_r,idx_j_l,i,j;

	always begin
		for ( i = 0; i<16 ; i = i+1) begin
			for (j = 0;j<16 ; j= j+1) begin
				idx_i_u = (i == 0) ? i-1+16 :i-1; //up idx
                idx_i_d = (i == 15)? i+1-16 :i+1; //down idx
                idx_j_l = (j == 0) ? j-1+16 :j-1; //left idx
                idx_j_r = (j == 15)? j+1-16 :j+1; //right idx
                nghbr_num[i*16+j] = q_2d[idx_i_u][idx_j_l] + q_2d[idx_i_u][j  ] + q_2d[idx_i_u][idx_j_r]
                                +   q_2d[i      ][idx_j_l]                      + q_2d[i      ][idx_j_r]
                                +   q_2d[idx_i_d][idx_j_l] + q_2d[idx_i_d][j  ] + q_2d[idx_i_d][idx_j_r];
			end
		end
	end

	always @ (posedge clk) begin
		if(load) begin:init
            for(i = 0 ; i < 16 ; i = i + 1) begin
                for(j = 0 ; j < 16 ; j = j + 1) begin
                    q_2d[i][j]    <=  data[i*16+j];
                end
            end
        end
        else begin:set_val
            for(i = 0 ; i < 16 ; i = i + 1) begin
                for(j = 0 ; j < 16 ; j = j + 1) begin
                    if(nghbr_num[i*16+j] < 2)
                        q_2d[i][j]      <=  1'b0;
                    else if (nghbr_num[i*16+j] > 3)
                        q_2d[i][j]      <=  1'b0;
                    else if (nghbr_num[i*16+j] == 3)
                        q_2d[i][j]      <=  1'b1;
                    else
                        q_2d[i][j]      <=  q_2d[i][j];
                end
            end
        end
    end
