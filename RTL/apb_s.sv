module apb_s
  (
    input pclk,
    input presetn,
    input [31:0] paddr,
    input psel,
    input penable,
    input [7:0] pwdata,
    input pwrite,
    
    output reg [7:0] prdata,
    output reg pready,
    output reg pslverr
);
  
  localparam [1:0] idle=0, write=1, read=2;
  reg [7:0] mem[16];
  reg [1:0] state, nstate;
  integer i;
  
  bit addr_err; // address range error
  bit addv_err; // invalid (X/Z) address value
  bit data_err; // invalid (X/Z) data value
  
  // state register
  always @(posedge pclk or negedge presetn) begin
    if(!presetn) // reset is low
      state <= idle;
    else
      state <= nstate;
  end
  
  // next state and outputs
  always @(*) begin
    case(state)
      idle: begin
        prdata = 8'h00;
        pready = 1'b0;
        
        if(psel && pwrite)
          nstate = write;
        else if(psel==1'b1 && pwrite==1'b0)
          nstate = read;
        else
          nstate = idle;
      end
      
     
      write: begin
        if(psel==1'b1 && penable==1'b1) begin
          if(!addr_err && !addv_err && !data_err) begin
            pready = 1'b1;
            //mem[paddr] = pwdata;
            nstate = idle;
          end 
          
          else begin
            nstate = idle;
            pready = 1'b1;
          end
        
        end
      end
      
      
      read: begin
        if(psel && penable) begin
          if(!addr_err && !addv_err && !data_err) begin
            pready = 1'b1;
            prdata = mem[paddr];
            nstate = idle;
          end 
          else begin
            pready = 1'b1;
            prdata = 8'h00;
            nstate = idle;
          end
        
          
        end
      end
      
      default: begin
        nstate = idle;
        prdata = 8'h00;
        pready = 1'b0;
      end
    endcase
  end
  
   always @(posedge pclk or negedge presetn)
begin
    if(!presetn)
    begin
         for(i=0; i<16; i=i+1)
            mem[i] <= 8'h00;
    end
    else
    begin
        if(state == write &&
           psel &&
           penable &&
           !addr_err &&
           !addv_err &&
           !data_err)
        begin
            mem[paddr[3:0]] <= pwdata;
        end
    end
end
      
  
  // check unknown address values
  reg av_t = 0;
  always @(*) begin
    if(paddr >= 0)  // reduction XOR detects X/Z
      av_t = 1'b0;
    else
      av_t = 1'b1;
  end
  
  // check unknown data values
  reg dv_t = 0;
  always @(*) begin
    if(pwdata >= 0)
      dv_t = 1'b0;
    else
      dv_t = 1'b1;
  end
  
  // error detection logic
  assign addr_err = ((nstate==write || nstate==read) && (paddr > 15)) ? 1'b1 : 1'b0;
  assign addv_err = ((nstate==write || nstate==read)) ? av_t : 1'b0;
  assign data_err = ((nstate==write || nstate==read)) ? dv_t : 1'b0;
  
  assign pslverr = (psel && penable) ? (addv_err || addr_err || data_err) : 1'b0;

endmodule
