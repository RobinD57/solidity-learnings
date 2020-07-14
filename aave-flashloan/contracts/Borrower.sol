pragma solidity ^0.5.0;

import "https://github.com/aave/aave-protocol/blob/master/contracts/configuration/LendingPoolAddressesProvider.sol";
import "https://github.com/aave/aave-protocol/blob/master/contracts/lendingpool/LendingPool.sol";
import "https://github.com/aave/aave-protocol/blob/master/contracts/flashloan/base/FlashLoanReceiverBase.sol";

contract Borrower is FlashLoanReceiverBase {
  LendingPoolAddressProvider provider;
  address dai;

  constructor(address _provider, address _dai) FlashLoanReceiverBase(_provider) public {
    provider = LendingPoolAddressProvider(_provider);
    dai = _dai;
  }

  function startLoan(uint amount, bytes calldata _params) external {
    LendingPool lendingPool = LendingPool(provider.getLendingPool());
    lendingPool.flashLoan(address(this), dai, amount, _params);
  }

  function executeOperation(address _reserve, uint amount, uint fee, bytes memory _params) external {
     // fill in body
     transferFundsBackToPoolInternal(_reserve, amount + fee)
  }
}
