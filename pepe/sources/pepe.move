module pepe::pepe {
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::balance::{Self, Balance};
    use sui::url::{Self, Url};
    use sui::pay;
    use std::vector;

    use sui::tx_context::{Self, TxContext};

    // Name matches the module name, but in UPPERCASE
    struct PEPE has drop {}

    // Module initializer is called once on module publish.
    // A treasury cap is sent to the publisher, who then controls minting and burning.
    // #[allow(lint(share_owned))]
    fun init(witness: PEPE, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<PEPE>(
            witness,
            9,
            b"Pepe",
            b"Pepe",
            b"Lets create a great coin to trade with",
            option::some<Url>(url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/53255366?v=4")),
            ctx
        );
        let initial_supply = 100_000_000_000_000;
        coin::mint_and_transfer(&mut treasury_cap, initial_supply, tx_context::sender(ctx), ctx);
        
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    public entry fun transfer(
        coins: coin::Coin<PEPE>, recipient: address, ctx: &mut TxContext
    ) {
        transfer::public_transfer(coins, recipient);
    }
    
    public entry fun mint(
        treasury_cap: &mut coin::TreasuryCap<PEPE>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }

    public entry fun burn(
        treasury_cap: &mut coin::TreasuryCap<PEPE>, coin: coin::Coin<PEPE>
    ) {
        coin::burn(treasury_cap, coin);
    }
    


}
