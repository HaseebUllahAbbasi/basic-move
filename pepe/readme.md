# Puneet Coin

Commands to make coin and publish

```sh
  sui move new puneet
  sui move build
  sui client new-env --alias devnet --rpc https://fullnode devnet.sui.io:443
  sui client switch --env devnet
  sui client publish --gas-budget 100000000 . --skip-dependency-verification

```

ObjectType: 0x2::coin::TreasuryCap<0xd12d15756d8ea23d4ff1c9aea7d3ba1baddf5b9e8aa3a913cad8ab2977710108::pepe::PEPE
  