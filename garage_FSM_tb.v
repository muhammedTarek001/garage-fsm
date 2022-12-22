`timescale 1ns/1ns

module garage_FSM_tb #(
    parameter 
    IDLE =3'b100,
    Mv_UP=3'b010,
    Mv_Dn=3'b001
)();

reg up_max_tb,dn_max_tb, activate_tb;

reg clk_tb,rst_tb;

wire up_m_tb, dn_m_tb;

garage_FSM u0 (
    .UP_MAX(up_max_tb),
    .DN_MAX(dn_max_tb),
    .Activate(activate_tb),
    .clk(clk_tb),
    .rst(rst_tb),
    .UP_M(up_m_tb),
    .DN_M(dn_m_tb)
);

always #10 clk_tb=~clk_tb;


initial 
begin
    $dumpfile("garage.vcd");
    $dumpvars;

    clk_tb=0;
    rst_tb=0; //reseting system
    
    #6
    
    dn_max_tb=1;                            //t=6
    up_max_tb=0;    
    activate_button;  //openinning the door  //t=36
    #10                                      //t=46
    activate_button;                         //t=76
    #10                                      //t=46
    activate_button; 








end

task activate_button;

begin
    rst_tb=1;
    activate_tb=1;
    #10
    

    if(up_m_tb && !dn_m_tb && u0.present_state==Mv_UP)
    begin
    $display("operation succeds,the door is opening !!");
    up_max_tb=1;
    dn_max_tb=0;

    activate_tb=0;
    #20
    
    if (u0.present_state == IDLE && !up_m_tb && !dn_m_tb) 
    begin
        $display("the door is completely opened !!"); 
    end
    
    end

    else if(dn_m_tb && !up_m_tb && u0.present_state==Mv_Dn)
    begin
    $display("operation succeds,the door is closing !!");
    dn_max_tb=1;
    up_max_tb=0;
    
    activate_tb=0;
    #20

    if(u0.present_state == IDLE && !up_m_tb && !dn_m_tb)
      begin
        $display("the door is completely closed");         
      end
    end
    
   
    
end

endtask


endmodule