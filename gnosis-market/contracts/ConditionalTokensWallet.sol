pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./IERC1155.sol";
import "./IConditionalTokens.sol";

contract ConditionalTokensWallet is IERC1155TokenReceiver {

    constructor(
        address _dai,
        address _conditionalTokens,
        address _oracle,
        address admin
    ) public {
        dai = IERC20(_dai);
        conditionalTokens = IConditionalTokens(_conditionalTokens);
        oracle = _oracle;
        admin = msg.sender;
    }

    function redeemTokens(
        bytes32 conditionId,
        uint[] calldata indexSets
    ) external {
        conditionalTokens.redeemPositions(
            dai,
            bytes32(0),
            conditionId,
            indexSets
        );
    }

    function transferDai(address to, uint amount) external {
        require(msg.sender == admin, "only admin");
        dai.tranfer(to, amount);
    }

    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    )
        external
        returns(bytes4) {
            return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
    }

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    )
        external
        returns(bytes4) {
            return bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"));
    }


}
