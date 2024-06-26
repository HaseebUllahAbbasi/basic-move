        // transfer::transfer(issuer_cap, tx_context::sender(ctx))

module examples::simple_nft {

    use sui::transfer;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};

    // NFT struct
    public struct Num has key, store {
        id: UID,
        n: u64
    }

    // Issuer capability struct
    public struct NumIssuerCap has key {
        id: UID,
        supply: u64,
        issued_counter: u64,
    }

    const MAX_SUPPLY: u64 = 10;
    const ETooManyNums: u64 = 0;

    #[allow(unused_function)]
    fun init(ctx: &mut TxContext) {
        let issuer_cap = NumIssuerCap {
            id: object::new(ctx),
            supply: 0,
            issued_counter: 0,
        };
        transfer::share_object(issuer_cap);
    }

    public fun mint(cap: &mut NumIssuerCap, ctx: &mut TxContext): Num {
        let n = cap.issued_counter;
        cap.issued_counter = n + 1;
        cap.supply = cap.supply + 1;
        assert!(cap.supply <= MAX_SUPPLY, ETooManyNums);
        Num { id: object::new(ctx), n }
    }

    public fun burn(cap: &mut NumIssuerCap, nft: Num) {
        let Num { id, n: _ } = nft;
        cap.supply = cap.supply - 1;
        object::delete(id);
    }

    // Function to transfer the NFT to another address
    public entry fun transfer_nft(nft: Num, recipient: address, ctx: &mut TxContext) {
        transfer::transfer(nft, recipient);
    }

    // New function to allow anyone to mint an NFT
    public entry fun custom_mint(cap: &mut NumIssuerCap, ctx: &mut TxContext) {
        // Increment issued_counter and supply
        let n = cap.issued_counter;
        cap.issued_counter = n + 1;
        cap.supply = cap.supply + 1;
        assert!(cap.supply <= MAX_SUPPLY, ETooManyNums);

        // Create and mint the NFT
        let id = object::new(ctx);
        let nft = Num { id, n: cap.issued_counter };
        
        // Transfer the NFT to the minter
        transfer::transfer(nft, tx_context::sender(ctx));
    }
}
