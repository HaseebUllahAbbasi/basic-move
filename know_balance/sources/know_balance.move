/*
/// Module: know_balance
module know_balance::know_balance {

}
*/
module know_balance::know_balance {
    use sui::coin::{Self, Coin};
    use sui::event;

    // Witness,for more info https://examples.sui.io/patterns/witness.html 

    public struct BalanceChecked has store,copy,drop {
        owner: address,
        amount: u64,
    }
    
    /// # Returns
    /// - The balance amount of the specified coin type.
    public entry fun check_balance<T>(coin: &mut Coin<T>, ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx);
        // let user_balance = coin::balance_mut(coin);
        let amount = coin::value(coin);
        
        // Emit an event with the balance information
        event::emit(BalanceChecked {
            owner: sender,
            amount
        })
        
        
    }

}