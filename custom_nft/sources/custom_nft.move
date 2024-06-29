/// Module: custom_nft
module custom_nft::custom_nft {
  use sui::coin::{Self, Coin};
  use sui::event;
  use sui::url::{Self, Url};
  use std::string;
  use sui::object::{Self, ID, UID};
  use sui::transfer;
  use sui::tx_context::{Self, TxContext};

    // Witness,for more info https://examples.sui.io/patterns/witness.html 

  public struct DevNetNFT has key, store {
        id: UID,
        /// Name for the token
        name: string::String,
        /// Description of the token
        description: string::String,
        /// URL for the token
        url: Url,

        amount: u64,
        // TODO: allow custom attributes
    }
    public struct MintNFTEvent has copy, drop {
        // The Object ID of the NFT
        object_id: ID,
        // The creator of the NFT
        creator: address,
        // The name of the NFT
        name: string::String,
    }

    public struct BalanceChecked has store,copy,drop {
        owner: address,
        amount: u64,
    }
    
    /// # Returns
    /// - The balance amount of the specified coin type.
    public entry fun check_balance<T>(coin: &mut Coin<T>, 
     name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
    ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx);
        // let user_balance = coin::balance_mut(coin);
        let amount = coin::value(coin);


        let nft = DevNetNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url),
            amount: amount
        };

        //  event::emit(MintNFTEvent {
        //     object_id: object::uid_to_inner(&nft.id),
        //     creator: sender,
        //     name: nft.name,
        // });
        
        // // Emit an event with the balance information
        // event::emit(BalanceChecked {
        //     owner: sender,
        //     amount
        // });
        transfer::public_transfer(nft, sender);

    }

}
