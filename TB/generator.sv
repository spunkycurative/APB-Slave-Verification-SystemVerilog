 class generator;
      transaction tr;
      mailbox #(transaction)mbx;
      int count=0;//no. of random stimuli
      event nextdrv;
      event nextsco;
      event done;
      
      function new(mailbox #(transaction)mbx);
        this.mbx=mbx;
        //tr=new();
      endfunction
      
      task run();
        //-------------------------------------------
        //TEST 1: Write address 5=100
        //-------------------------------------------
        
        tr=new();
        tr.paddr=5;
        tr.pwdata=100;
        tr.pwrite=1;
        
        mbx.put(tr);
        
        tr.display("GEN");
        @(nextdrv);
        @(nextsco);
        
        //--------------------------------------------
        //TEST 2:Read address 5
        //--------------------------------------------
        
        tr=new();
        tr.paddr=5;
        tr.pwrite=0;
        
        mbx.put(tr);
        tr.display("GEN");
        @(nextdrv);
        @(nextsco);
        
        //--------------------------------------------
        //TEST 3: Write address 7=55
        //--------------------------------------------
        
        tr=new();
        tr.paddr=7;
        tr.pwdata=55;
        tr.pwrite=1;
        
        mbx.put(tr);
        tr.display("GEN");
        @(nextdrv);
        @(nextsco);
        
        //--------------------------------------------
        //TEST 4: Read address 7
        //--------------------------------------------
        
        tr=new();
        tr.paddr=7;
        tr.pwrite=0;
        
        mbx.put(tr);
        tr.display("GEN");
        @(nextdrv);
        @(nextsco);
        
        //---------------------------------------------
        //TEST 5: Overwrite address 7=200
        //---------------------------------------------
        
        tr=new();
        tr.paddr=7;
        tr.pwdata=200;
        tr.pwrite=1;
        
        mbx.put(tr);
        tr.display("GEN");
        @(nextdrv);
        @(nextsco);
        
        //----------------------------------------------
        //TEST 6: Read address
        //----------------------------------------------
        
        tr=new();
        tr.paddr=7;
        tr.pwrite=0;
        
        mbx.put(tr);
        tr.display("GEN");
        @(nextdrv);
        @(nextsco);
        
        //----------------------------------------------
        //TEST 7: Random stress test
        //----------------------------------------------
            
        
        repeat(200)
          begin
            tr=new();
            assert(tr.randomize()) else $error("randomization failed");
            mbx.put(tr);
            tr.display("GEN");
            @(nextdrv);
            @(nextsco);
          end
        ->done;
      endtask      
      
    endclass
