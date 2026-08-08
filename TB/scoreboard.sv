class scoreboard;
    
    transaction tr;
    mailbox #(transaction) mbx;
    event nextsco;
    
    bit [7:0] pwdata[16]='{default:0};
    bit [7:0] rdata;
    int err=0;
    
    function new(mailbox #(transaction) mbx);
      this.mbx=mbx;
    endfunction
    
    task run();
      forever begin
        mbx.get(tr);
        tr.display("SCO");
        
        if((tr.pwrite==1'b1) && (tr.pslverr==1'b0))//write access
          begin
            pwdata[tr.paddr]=tr.pwdata;
            $display("[SCO]:data stored data:%0d , addr=%0d",tr.pwdata,tr.paddr);
          end
        
        else if((tr.pwrite==1'b0) && (tr.pslverr==1'b0))//read access
          begin
            rdata=pwdata[tr.paddr];
            if(tr.prdata==rdata)
              $display("[SCO]:data matched");
            else
              begin
                err++;
                $display("data mismatched");
              end
          end
        
        else if(tr.pslverr==1'b1)
          begin
            $display("[SCO]: SLV error detected");
          end
        $display("-------------------");
        ->nextsco;
        
      end
      
    endtask
    
  endclass
      
