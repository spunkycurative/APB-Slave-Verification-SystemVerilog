module apb_s_assertions(apb_if vif);
  
  property p_enable_after_psel;
    @(posedge vif.pclk)
    disable iff(!vif.presetn)
    vif.penable |-> vif.psel;
  endproperty
  
  assert property(p_enable_after_psel)
    else
      $error("PENABLE asserted before PSEL");

    
    property p_pready_with_transaction;
      @(posedge vif.pclk)
      disable iff(!vif.presetn)
      vif.pready |-> (vif.penable && vif.psel);
    endproperty
    
    assert property(p_pready_with_transaction)
      else
        $error("PREADY asserted outside APB transaction");

      
      property p_paddr_stable;
        @(posedge vif.pclk)
        disable iff(!vif.presetn)
        (vif.penable && vif.psel)|-> $stable(vif.paddr);
      endproperty
      
      assert property(p_paddr_stable)
        else
          $error("Address changed during access");

        
          property p_data_stable;
          @(posedge vif.pclk)
          disable iff(!vif.presetn)
            (vif.psel && vif.penable && vif.pwrite) |-> $stable(vif.pwdata);
        endproperty
        
        assert property(p_data_stable)
          else
            $error("Write data changed during transaction");

          
          property p_slverr_valid;
            @(posedge vif.pclk)
            disable iff(!vif.presetn)
            vif.pslverr |-> (vif.psel && vif.penable);
          endproperty
          
          assert property(p_slverr_valid)
            else
              $error("PSLVERR occure outside transaction");
            
            
         property p_write_complete;
           @(posedge vif.pclk)
           disable iff(!vif.presetn)
           (vif.psel && !vif.penable && vif.pwrite) |=> (vif.psel && vif.penable && vif.pready);          
         endproperty
            
            assert property(p_write_complete)
              else
                $error("Write transaction not completed");
              
              
         property p_read_complete;
           @(posedge vif.pclk)
           disable iff(!vif.presetn)
           (vif.psel && !vif.penable && !vif.pwrite) |=> (vif.psel && vif.penable && vif.pready);
         endproperty
              
              assert property(p_read_complete)
                else
                  $error("Read transaction not completed");
                
              
         property p_setup_to_access;
           @(posedge vif.pclk)
           disable iff(!vif.presetn)
           (vif.psel && !vif.penable) |=> (vif.psel && vif.penable);
         endproperty
                
                assert property(p_setup_to_access)
                  else
                    $error("APB setup phase did not transition to access phase");
                  
                
         property p_pready_deassert;
           @(posedge vif.pclk)
           disable iff(vif.presetn)
           vif.pready |=> !vif.pready;
         endproperty
                  
                  assert property(p_pready_deassert)
                    else
                      $error("PREADY did not deassert after transaction");
                
endmodule
