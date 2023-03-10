# AddressBitMap

Alot of contracts make the mistake of using `address=>uint256` when they could otherwise use `address=>bool`. In scenarios when the value of the mapping can only ever equal 1 or zero, it saves around ~75 gas to use `bool` instead. Using a Bitmap is also possible but the key must be a `uint256` so we must cast the `address` as such to set a bit for it. When using the Bitmap approach the gas savings are only about 35 gas to retrieve the value.

### Removing the counter

In a scenario where a counter is needed, the Bitmap option is better because we can simply use `popCount` to get the number of bits set in the map. The problem however is that in the case of minting, most base contracts already provide a method to retireve this number. In the case of ERC721A, a `totalMinted` method is provided that omits the need for using a Bitmap popcount to retrieve the number minted counter. In that scenario using `uint256=>bool` would be better. Otherwise we would save 20,000 gas by removing the counter state variable and the writes to it during the transaction.

