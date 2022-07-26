pragma solidity >=0.6.0;

import "forge-std/Test.sol";

contract BlockNumberExample {
    uint256 public lastBlockNumber;

    function updateBlockNumber() external {
        require(block.number > lastBlockNumber, "Cant update same block twice");
        lastBlockNumber = block.number;
    }
}
contract BlockNumberScript is Script {
    function run() public {
        vm.startBroadcast();
        BlockNumberExample blockNumberExample = new BlockNumberExample();
        blockNumberExample.updateBlockNumber();
        vm.roll(block.number + 1);
        // This transaction will succeed in the initial run but revert in the "On-Chain simulation"
        blockNumberExample.updateBlockNumber();
        vm.stopBroadcast();
    }
}
