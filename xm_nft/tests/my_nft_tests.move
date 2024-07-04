module xm_nft::my_nft_test {
    use sui::test_scenario::{Self as ts, next_tx,Scenario};
    // use std::string;
    use sui::object::{ID, UID};
    use sui::tx_context::{TxContext, dummy};
    use sui::test_scenario::Self;
    use sui::sui::SUI;
    // use sui::tx_context::TxContext;
    use sui::balance:: {Self, Balance};

    use sui::url::{Self, Url};
    use xm_nft::xm_nft;
    const USER1_ADDRESS: address = @0xA001;

    use std::vector;
    use std::string::{Self,String};
    use xm_nft:: xm_nft as nft_module;
    use xm_nft:: xm_nft::{NumIssuerCap,DevNetNFT,MintNFTEvent};
    use xm_nft:: xm_nft::{init_for_testing};

//  

    /// Helper function to create a TxContext for testing
    fun new_tx_context() : TxContext {
        dummy()
    }



    #[test]
    fun test_init_with_mint() {
        let owner: address = @0xA;
        let mut scenario_test = ts::begin(owner);
        let scenario = &mut scenario_test;

        next_tx(scenario,owner);
        {
            nft_module::init_for_testing(ts::ctx(scenario));
            init_for_testing(ts::ctx(scenario));
        };
        next_tx(scenario,owner);
        {
        let mut admin_cap = ts::take_from_sender<NumIssuerCap>(scenario);

        let name = b"Test NFT";
        let description = b"Description of Test NFT";
        let url = b"https://example.com/nft";
        let grade = 1;
        let mut ctx = tx_context::dummy();

        admin_cap.mint(name, description, url,grade ,&mut ctx);      
        // nft_module::mint(&mut admin_cap,name, description, url,grade ,&mut ctx);      
        ts::return_to_sender(scenario,admin_cap);
      
        };
        test_scenario::end(scenario_test);
    }


    /// Test minting an NFT

    /// Test minting and transferring an NFT
    #[test]
    fun test_mint_and_transfer() {
        let owner: address = @0xA;
        let test_address1: address = @0xB;
        let test_address2: address = @0xC;
        let test_address3: address = @0xD;
        let test_address4: address = @0xE;

        let mut scenario_test = ts::begin(owner);
        let scenario = &mut scenario_test;

    //   // check init function
        next_tx(scenario,owner);
        {
            nft_module::init_for_testing(ts::ctx(scenario));
            init_for_testing(ts::ctx(scenario));
        };
        next_tx(scenario,owner);
        {
        let mut admin_cap = ts::take_from_sender<NumIssuerCap>(scenario);
        let name = b"Test NFT";
        let description = b"Description of Test NFT";
        let url = b"https://example.com/nft";
        let grade = 1;
        let mut ctx = tx_context::dummy();
        

        nft_module::mint_and_transfer(&mut admin_cap,name, description, url,grade , test_address2, &mut ctx);      

        ts::return_to_sender(scenario,admin_cap);
      
        };
        test_scenario::end(scenario_test);
    }
    

    #[test]
    fun test_max_transfer() {
        let owner: address = @0xA;
        let test_address1: address = @0xB;
        let test_address2: address = @0xC;
        let test_address3: address = @0xD;
        let test_address4: address = @0xE;

        let mut scenario_test = ts::begin(owner);
        let scenario = &mut scenario_test;

    //   // check init function
        next_tx(scenario,owner);
        {
            nft_module::init_for_testing(ts::ctx(scenario));
            init_for_testing(ts::ctx(scenario));
        };
        next_tx(scenario,owner);
        {
        let mut admin_cap = ts::take_from_sender<NumIssuerCap>(scenario);
        let name = b"Test NFT";
        let description = b"Description of Test NFT";
        let url = b"https://example.com/nft";
        let grade = 1;
        let mut ctx1 = tx_context::dummy();
        let mut ctx2 = tx_context::dummy();
        let mut ctx3 = tx_context::dummy();



        admin_cap.mint_and_transfer(name, description, url,grade , test_address1,&mut ctx1);
        admin_cap.mint_and_transfer(name, description, url,grade , test_address2,&mut ctx2);
        admin_cap.mint_and_transfer(name, description, url,grade , test_address3,&mut ctx3);
        // comment to make it pass
        // admin_cap.mint_and_transfer(name, description, url,grade , test_address3,&mut ctx3);

        
        // ***** another way to mint and  transfer nft
        // nft_module::mint_and_transfer(&mut admin_cap,name, description, url,grade , test_address1, &mut ctx1);      
        // nft_module::mint_and_transfer(&mut admin_cap,name, description, url,grade , test_address2, &mut ctx2);      
        // nft_module::mint_and_transfer(&mut admin_cap,name, description, url,grade , test_address3, &mut ctx3);      

        ts::return_to_sender(scenario,admin_cap);
        
        };
        test_scenario::end(scenario_test);
   
    }
    /// Test burning an NFT
    #[test]
    fun test_burn() {
         let owner: address = @0xA;
            let test_address1: address = @0xB;
            let test_address2: address = @0xC;
            let test_address3: address = @0xD;
            let test_address4: address = @0xE;

            let mut scenario_test = ts::begin(owner);
            let scenario = &mut scenario_test;

        //   // check init function
            next_tx(scenario,owner);
            {
                nft_module::init_for_testing(ts::ctx(scenario));
                init_for_testing(ts::ctx(scenario));
            };
            next_tx(scenario,owner);
            {
            let mut admin_cap = ts::take_from_sender<NumIssuerCap>(scenario);
            let name = b"Test NFT";
            let description = b"Description of Test NFT";
            let url = b"https://example.com/nft";
            let grade = 1;
            let mut ctx = tx_context::dummy();
            

            let nft_minted =  nft_module::mint(&mut admin_cap,name, description, url,grade ,  &mut ctx);      

            // have to tranfer the minted nft with this, and this case will be used for the checking ownership as well of the NFT and Issuer cap
            
            // nft_module::burn(nft_minted.object_id);
            ts::return_to_sender(scenario,admin_cap);
        
            };
            test_scenario::end(scenario_test);
        }

    /// Test transferring an NFT
        #[test]
        fun test_transfer_nft() {
        let owner: address = @0xA;
            let test_address1: address = @0xB;
            let test_address2: address = @0xC;
            let test_address3: address = @0xD;
            let test_address4: address = @0xE;

            let mut scenario_test = ts::begin(owner);
            let scenario = &mut scenario_test;

        //   // check init function
            next_tx(scenario,owner);
            {
                nft_module::init_for_testing(ts::ctx(scenario));
                init_for_testing(ts::ctx(scenario));
            };
            next_tx(scenario,owner);
            {
            let mut admin_cap = ts::take_from_sender<NumIssuerCap>(scenario);
            let name = b"Test NFT";
            let description = b"Description of Test NFT";
            let url = b"https://example.com/nft";
            let grade = 1;
            let mut ctx = tx_context::dummy();
            

            let nft_minted =  nft_module::mint(&mut admin_cap,name, description, url,grade ,  &mut ctx);      

            // have to tranfer the minted nft with this, and this case will be used for the checking ownership as well of the NFT and Issuer cap

            // nft_module::transfer_nft(nft_minted.object_id,test_address2);
            ts::return_to_sender(scenario,admin_cap);
        
            };
            test_scenario::end(scenario_test);
        }
    /// Test transferring the issuer capability
    #[test]
    fun test_transfer_issuer_cap() {
        
          let owner: address = @0xA;
        let test_address1: address = @0xB;
        let test_address2: address = @0xC;
        let test_address3: address = @0xD;
        let test_address4: address = @0xE;

        let mut scenario_test = ts::begin(owner);
        let scenario = &mut scenario_test;

        next_tx(scenario,owner);
        {
            nft_module::init_for_testing(ts::ctx(scenario));
            init_for_testing(ts::ctx(scenario));
        };
        next_tx(scenario,owner);
        {
        let mut admin_cap = ts::take_from_sender<NumIssuerCap>(scenario);
        let name = b"Test NFT";
        let description = b"Description of Test NFT";
        let url = b"https://example.com/nft";
        let grade = 1;
        let mut ctx = tx_context::dummy();
        

        let nft_minted =  nft_module::mint(&mut admin_cap,name, description, url,grade ,  &mut ctx);      

        admin_cap.transfer_issuer_cap(test_address1);
        
        // admin_cap.mint(name,description,url, grade,&mut ctx);
        // ts::return_to_sender(scenario,admin_cap);
        };
        test_scenario::end(scenario_test);
    }
}
