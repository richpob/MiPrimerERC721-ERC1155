// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";


contract MiJuegoDeCartas is ERC1155 {
    constructor() ERC1155("https://drive.google.com/file/d/1GbVSyfOsSj-UjmTRaUyDsaR7FTDTvhij/view?usp=drive_link") {}

    function acunar(address account, uint256 id, uint256 amount, bytes memory data) public  {
        _mint(account, id, amount, data);
    }

    function acunarLote(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public  {
        _mintBatch(to, ids, amounts, data);
    }
}
