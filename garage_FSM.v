module garage_FSM #(
    parameter 
    IDLE =3'b100,
    Mv_UP=3'b010,
    Mv_Dn=3'b001
) (
    input UP_MAX,DN_MAX,
          Activate,

    input clk,rst,

    output reg UP_M, DN_M
);

reg[2:0] present_state;

reg[2:0] next_state;

always @(posedge clk or negedge rst) begin
    if (rst) begin
        present_state<=next_state;
    end

    else
    present_state<=IDLE;
    
end


always @(*) begin

    case (present_state)
        IDLE:
        begin
            UP_M=0;
            DN_M=0;
            if(!Activate)
            begin
                next_state=IDLE;
                
            end

            else
            begin
                if(DN_MAX && !UP_MAX)
                  begin
                    next_state=Mv_UP;
                    
                  end
                
                else if( !DN_MAX && UP_MAX )
                begin
                    next_state=Mv_Dn;
                    
                end
            end
        end

        Mv_UP:
        begin
            UP_M=1;
            DN_M=0;
            if(UP_MAX)
            begin
                
                next_state=IDLE;
            end

            else
            begin
                
                next_state=Mv_UP;
            end

        end

        Mv_Dn:
        begin
            UP_M=0;
            DN_M=1;
            if(DN_MAX)
            begin
                
                next_state=IDLE;
            end

            else
            begin
                
                next_state=Mv_Dn;
            end
        end

        default: 
        begin
            next_state=IDLE;
            UP_M=0;
            DN_M=0;
        end
    endcase
    
end


endmodule