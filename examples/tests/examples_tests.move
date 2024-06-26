/*
#[test_only]
module examples::examples_tests {
    // uncomment this line to import the module
    // use examples::examples;

    const ENotImplemented: u64 = 0;

    #[test]
    fun test_examples() {
        // pass
    }

    #[test, expected_failure(abort_code = ::examples::examples_tests::ENotImplemented)]
    fun test_examples_fail() {
        abort ENotImplemented
    }
}
*/
module examples::test_simple_nft {
    use examples::simple_nft::{Self, Num, NumIssuerCap, MAX_SUPPLY, ETooManyNums};
    use sui::object::UID;
    use sui::tx_context::{TxContext, Self};
    use sui::test_scenario::{Self, TestScenario};

    public entry fun test_init(ctx: &mut TxContext) {
        // Test initialization of NumIssuerCap
        let scenario = TestScenario::new(ctx);
        let admin = scenario.create_account();

        simple_nft::init(scenario.tx_context(&admin));

        // Assume we have a way to fetch the created NumIssuerCap (not shown here)
        // Add checks to validate NumIssuerCap properties
        // let issuer_cap = // ... fetch the created NumIssuerCap ...
        // assert!(issuer_cap.supply == 0, "Initial supply should be 0");
        // assert!(issuer_cap.issued_counter == 0, "Initial issued_counter should be 0");
    }

    public entry fun test_mint(ctx: &mut TxContext) {
        // Test minting Num NFTs
        let scenario = TestScenario::new(ctx);
        let admin = scenario.create_account();

        simple_nft::init(scenario.tx_context(&admin));
        // Assume we have a way to fetch the created NumIssuerCap (not shown here)
        // let mut issuer_cap = // ... fetch the created NumIssuerCap ...

        for i in 0..MAX_SUPPLY {
            let nft = simple_nft::mint(&mut issuer_cap, scenario.tx_context(&admin));
            // Add checks to validate minted Num NFT properties
            // assert!(nft.n == i, "Minted Num should have the correct value");
        }

        // Test exceeding the maximum supply
        let result = move_to_test!(simple_nft::mint(&mut issuer_cap, scenario.tx_context(&admin)));
        assert!(result.is_err() && result.unwrap_err().code == ETooManyNums, "Minting beyond MAX_SUPPLY should fail");
    }

    public entry fun test_burn(ctx: &mut TxContext) {
        // Test burning Num NFTs
        let scenario = TestScenario::new(ctx);
        let admin = scenario.create_account();

        simple_nft::init(scenario.tx_context(&admin));
        // Assume we have a way to fetch the created NumIssuerCap (not shown here)
        // let mut issuer_cap = // ... fetch the created NumIssuerCap ...

        let nft = simple_nft::mint(&mut issuer_cap, scenario.tx_context(&admin));
        simple_nft::burn(&mut issuer_cap, nft);

        // Add checks to validate NumIssuerCap properties after burning
        // assert!(issuer_cap.supply == 0, "Supply should be 0 after burning the only NFT");
    }
}

