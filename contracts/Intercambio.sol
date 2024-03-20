// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MiPrimerERC721.sol";
import "./MiPrimerERC1155.sol";

contract Intercambio {
    MiToken arteDigital;
    MiJuegoDeCartas juegoDeCartas;

    constructor(address _arteDigital, address _juegoDeCartas) {
        arteDigital = MiToken(_arteDigital);
        juegoDeCartas = MiJuegoDeCartas(_juegoDeCartas);
    }

    // Ejemplo de función de intercambio
    function intercambiarNFTporTokens(uint256 _tokenId, uint256 _idCarta, uint256 _cantidad) public {
        require(arteDigital.ownerOf(_tokenId) == msg.sender, "No eres el propietario del NFT");
        arteDigital.transferFrom(msg.sender, address(this), _tokenId);
        juegoDeCartas.acunar(msg.sender, _idCarta, _cantidad, "");
        // Aquí se deberían añadir más controles y lógica de negocio según sea necesario
    }
}
