module lcd_ctrl(clk, reset, datain, cmd, cmd_valid, dataout, output_valid, busy);
input           clk;
input           reset;
input   [7:0]   datain;
input   [2:0]   cmd;
input           cmd_valid;

output  [8:0]   dataout;
output          output_valid;
output          busy;

reg [7:0] dataout ;
reg output_valid ;
reg busy ;
reg [5:0] ctr ;
reg [2:0] cmdReg ;
reg [7:0] image [0:5][0:5] ;
reg [3:0] tmp ;
wire [5:0] standardIndex ;
reg [2:0] co [0:1] ;


//Reset
always@(reset) begin
    dataout <= 8'd0 ;
    output_valid <= 1'd0 ;
    busy <= 1'd0 ;
    ctr <= 6'd0 ;
    tmp <= 4'd0 ;
    co[0] <= 3'd2 ;
    co[1] <= 3'd2 ;
end
  
always @(posedge clk) begin
    if(cmd_valid == 1) begin
        cmdReg <= cmd ;
    end
end

always @(posedge clk) begin
    if(cmd == 3'd0 || cmdReg == 3'd0) begin
        ctr <= ctr + 6'd1 ;
        busy <= 1 ;
    end
    else if (cmd == 3'd1 || cmdReg == 3'd1) begin
        ctr <= ctr + 6'd1 ;
        busy <= 1 ;
    end
    else if(cmd == 3'd2 || cmdReg == 3'd2) begin
        ctr <= ctr + 6'd1 ;
        busy <= 1 ;
    end
    else if(cmd == 3'd3 || cmdReg == 3'd3) begin
        ctr <= ctr + 6'd1 ;
        busy <= 1 ;
    end
    else if(cmd == 3'd4 || cmdReg == 3'd4) begin
        ctr <= ctr + 6'd1 ;
        busy <= 1 ;
    end
    else if(cmd == 3'd5 || cmdReg == 3'd5) begin
        ctr <= ctr + 6'd1 ;
        busy <= 1 ;
    end


    if(cmdReg == 3'd0) begin
        if(ctr == 6'd0) begin
            output_valid <= 0 ;
        end
    end
    else if(cmdReg == 3'd1) begin
        if(ctr == 6'd0) begin
            output_valid <= 0 ;
        end
    end
    else if(cmdReg == 3'd2) begin
        if(ctr == 6'd0) begin
            output_valid <= 0 ;
        end
    end
    else if(cmdReg == 3'd3) begin
        if(ctr == 6'd0) begin
            output_valid <= 0 ;
        end
    end
    else if(cmdReg == 3'd4) begin
        if(ctr == 6'd0) begin
            output_valid <= 0 ;
        end
    end
    else if(cmdReg == 3'd5) begin
        if(ctr == 6'd0) begin
            output_valid <= 0 ;
        end
    end

end

always @(posedge clk) begin
    if(cmdReg == 3'd0) begin
        if(ctr == 6'd10) begin
            ctr <= 6'd0 ;
            busy <= 0 ;
        end
    end
    else if(cmdReg == 3'd1) begin
        if(ctr == 6'd46) begin
            ctr <= 6'd0 ;
            busy <= 0 ;
        end
    end
    else if(cmdReg == 3'd2) begin
        if(ctr == 6'd10) begin
            ctr <= 6'd0 ;
            busy <= 0 ;
        end
    end
    else if(cmdReg == 3'd3) begin
        if(ctr == 6'd10) begin
            ctr <= 6'd0 ;
            busy <= 0 ;
        end
    end
    else if(cmdReg == 3'd4) begin
        if(ctr == 6'd10) begin
            ctr <= 6'd0 ;
            busy <= 0 ;
        end
    end
    else if(cmdReg == 3'd5) begin
        if(ctr == 6'd10) begin
            ctr <= 6'd0 ;
            busy <= 0 ;
        end
    end
    
end

always @(posedge clk ) begin
    if(cmdReg == 3'd0) begin
        //不確定ctr條件要設為多少
        if(ctr == 6'd2) begin
            output_valid <= 1 ;
        end
    end 
    else if(cmdReg == 3'd1) begin
        if(ctr == 6'd38) begin
            output_valid <= 1 ;
        end
    end
    else if(cmdReg == 3'd2) begin
        if(ctr == 6'd2) begin
            output_valid <= 1 ;
        end
    end 
    else if(cmdReg == 3'd3) begin
        if(ctr == 6'd2) begin
            output_valid <= 1 ;
        end
    end
    else if(cmdReg == 3'd4) begin
        if(ctr == 6'd2) begin
            output_valid <= 1 ;
        end
    end
    else if(cmdReg == 3'd5) begin
        if(ctr == 6'd2) begin
            output_valid <= 1 ;
        end
    end
end

assign standardIndex = ctr - 6'd1 ;

always @(posedge clk) begin
    if(cmdReg == 3'd1) begin
        tmp <= ctr - 4'd1 ;
        image[standardIndex/6][standardIndex%6] = datain ;
    end
end

always @(posedge clk) begin
    if(cmdReg == 3'd1) begin
        co[0] <= 3'd2 ;
        co[1] <= 3'd2 ;
        case (ctr)
            6'd38: dataout <= image[co[0]][co[1]] ;
            6'd39: dataout <= image[co[0]][co[1]+1] ;
            6'd40: dataout <= image[co[0]][co[1]+2] ;
            6'd41: dataout <= image[co[0]+1][co[1]] ;
            6'd42: dataout <= image[co[0]+1][co[1]+1] ;
            6'd43: dataout <= image[co[0]+1][co[1]+2] ;
            6'd44: dataout <= image[co[0]+2][co[1]] ;
            6'd45: dataout <= image[co[0]+2][co[1]+1] ;
            6'd46: dataout <= image[co[0]+2][co[1]+2] ;
            //default: 
        endcase
    end
    else if(cmdReg == 3'd0) begin
        case (ctr)
            6'd2: dataout <= image[co[0]][co[1]] ;
            6'd3: dataout <= image[co[0]][co[1]+1] ;
            6'd4: dataout <= image[co[0]][co[1]+2] ;
            6'd5: dataout <= image[co[0]+1][co[1]] ;
            6'd6: dataout <= image[co[0]+1][co[1]+1] ;
            6'd7: dataout <= image[co[0]+1][co[1]+2] ;
            6'd8: dataout <= image[co[0]+2][co[1]] ;
            6'd9: dataout <= image[co[0]+2][co[1]+1] ;
            6'd10: dataout <= image[co[0]+2][co[1]+2] ;
            //default: 
        endcase
    end
    else if (cmdReg == 3'd2) begin
        if(co[1] < 3 && ctr == 6'd1) begin
            co[1] <= co[1] + 3'd1 ;
        end
        case (ctr)
            6'd2: dataout <= image[co[0]][co[1]] ;
            6'd3: dataout <= image[co[0]][co[1]+1] ;
            6'd4: dataout <= image[co[0]][co[1]+2] ;
            6'd5: dataout <= image[co[0]+1][co[1]] ;
            6'd6: dataout <= image[co[0]+1][co[1]+1] ;
            6'd7: dataout <= image[co[0]+1][co[1]+2] ;
            6'd8: dataout <= image[co[0]+2][co[1]] ;
            6'd9: dataout <= image[co[0]+2][co[1]+1] ;
            6'd10: dataout <= image[co[0]+2][co[1]+2] ;
        endcase
    end
    else if (cmdReg == 3'd3) begin
        if(co[1] > 0 && ctr == 6'd1) begin
            co[1] <= co[1] - 3'd1 ;
        end
        case (ctr)
            6'd2: dataout <= image[co[0]][co[1]] ;
            6'd3: dataout <= image[co[0]][co[1]+1] ;
            6'd4: dataout <= image[co[0]][co[1]+2] ;
            6'd5: dataout <= image[co[0]+1][co[1]] ;
            6'd6: dataout <= image[co[0]+1][co[1]+1] ;
            6'd7: dataout <= image[co[0]+1][co[1]+2] ;
            6'd8: dataout <= image[co[0]+2][co[1]] ;
            6'd9: dataout <= image[co[0]+2][co[1]+1] ;
            6'd10: dataout <= image[co[0]+2][co[1]+2] ;
        endcase
    end
    else if (cmdReg == 3'd4) begin
        if(co[0] > 0 && ctr == 6'd1) begin
            co[0] <= co[0] - 3'd1 ;
        end
        case (ctr)
            6'd2: dataout <= image[co[0]][co[1]] ;
            6'd3: dataout <= image[co[0]][co[1]+1] ;
            6'd4: dataout <= image[co[0]][co[1]+2] ;
            6'd5: dataout <= image[co[0]+1][co[1]] ;
            6'd6: dataout <= image[co[0]+1][co[1]+1] ;
            6'd7: dataout <= image[co[0]+1][co[1]+2] ;
            6'd8: dataout <= image[co[0]+2][co[1]] ;
            6'd9: dataout <= image[co[0]+2][co[1]+1] ;
            6'd10: dataout <= image[co[0]+2][co[1]+2] ;
        endcase
    end
    else if (cmdReg == 3'd5) begin
        if(co[0] < 3 && ctr == 6'd1) begin
            co[0] <= co[0] + 3'd1 ;
        end
        case (ctr)
            6'd2: dataout <= image[co[0]][co[1]] ;
            6'd3: dataout <= image[co[0]][co[1]+1] ;
            6'd4: dataout <= image[co[0]][co[1]+2] ;
            6'd5: dataout <= image[co[0]+1][co[1]] ;
            6'd6: dataout <= image[co[0]+1][co[1]+1] ;
            6'd7: dataout <= image[co[0]+1][co[1]+2] ;
            6'd8: dataout <= image[co[0]+2][co[1]] ;
            6'd9: dataout <= image[co[0]+2][co[1]+1] ;
            6'd10: dataout <= image[co[0]+2][co[1]+2] ;
        endcase
    end
end

endmodule



//改100~138之間的ctr條件
//
