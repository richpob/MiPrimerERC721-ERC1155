# Galería de Arte Digital & Juego de Cartas Coleccionables en Blockchain

## Descripción

Este repositorio contiene dos proyectos basados en contratos inteligentes para la creación de una Galería de Arte Digital y un Juego de Cartas Coleccionables utilizando la tecnología blockchain. Estos proyectos aprovechan los estándares ERC-721 y ERC-1155 para representar obras de arte únicas y cartas coleccionables respectivamente.

### Galería de Arte Digital

La Galería de Arte Digital permite a artistas acuñar sus obras como NFTs únicos y ofrecerlos en un mercado digital. Cada obra puede ser autenticada, comprada, vendida o prestada a través de contratos inteligentes, garantizando la seguridad y la transparencia.

### Juego de Cartas Coleccionables

El Juego de Cartas Coleccionables utiliza tokens ERC-1155 para representar tanto cartas únicas como elementos fungibles dentro del juego. Los jugadores pueden coleccionar, intercambiar y utilizar estas cartas en duelos o torneos, creando una experiencia de juego dinámica y enriquecedora.

## Características Principales

- **Autenticidad y Propiedad**: Los NFTs garantizan la autenticidad y propiedad exclusiva de las obras de arte y las cartas coleccionables.
- **Interoperabilidad**: Ambos proyectos están diseñados para ser interoperables con otros mercados y juegos basados en NFT.
- **Transparencia**: Todas las transacciones son transparentes y verificables en la blockchain.

## Cómo Empezar

Para desplegar y probar los contratos inteligentes en una red Ethereum local, sigue estos pasos:

1. Clona este repositorio.
2. Instala las dependencias con `npm install`.
3. Ejecuta una red Ethereum local utilizando Ganache.
4. Despliega los contratos con Truffle utilizando `truffle migrate`.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas contribuir, por favor haz un fork del repositorio, crea tu feature branch, y envía un pull request.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT - vea el archivo [LICENSE.md](LICENSE) para más detalles.

# Proyecto ERC-721 y ERC-1155
Crear contratos inteligentes para estándares ERC-721 y ERC-1155, paso a describir los caso de uso.

## ERC-721: Token No Fungible para una Galería de Arte Digital
El estándar ERC-721 es ideal para representar activos únicos. En nuestro caso, podríamos implementar un contrato para una galería de arte digital, donde cada obra es única.

**Funciones Personalizadas:**
- **exhibirObra:** Permite mostrar la obra en una galería virtual durante un tiempo determinado.
- **transferirPropiedad:** Permite al propietario transferir la obra sin cambiar de dueño, ideal para préstamos a museos.

## Caso de Uso:
Artistas pueden acuñar sus obras como tokens únicos y coleccionistas pueden adquirir y prestar estas obras a galerías virtuales.
## Código fuente ERC721
```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MiToken is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    // Estructura para gestionar la exhibición de obras
    struct Exhibicion {
        uint256 tiempoInicio;
        uint256 duracion;
        string galeriaVirtual;
    }

    // Mapping de tokenId a su exhibición
    mapping(uint256 => Exhibicion) public exhibiciones;

    constructor() ERC721("MiArteDigital", "MAD") {}

    // Función para acuñar un nuevo token
    function acunar(address destinatario, string memory tokenURI) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(destinatario, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    // Función para establecer la exhibición de una obra
    function exhibirObra(uint256 tokenId, uint256 duracion, string memory galeriaVirtual) public {
        require(ownerOf(tokenId) == msg.sender, "No eres el propietario de la obra");
        exhibiciones[tokenId] = Exhibicion(block.timestamp, duracion, galeriaVirtual);
    }

    // Función para transferir la propiedad sin cambiar el dueño
    function transferirPropiedad(uint256 tokenId, address nuevoPropietario) public {
        require(ownerOf(tokenId) == msg.sender, "No eres el propietario de la obra");
        // Asumimos que transferirPropiedad es similar a permitir a otro usuario administrar el token sin transferir la propiedad completa
        // Esta función necesita una lógica de negocio más detallada dependiendo del caso de uso específico
        approve(nuevoPropietario, tokenId);
    }
}
```
## Implementación del contrato ERC721
### Creación Contrato
 - **URL TX :** https://sepolia.etherscan.io/tx/0x706aa7a8850d3b467c0397f3101762c3bd46acb0577ad1ce0942bc75c0025517
 - **URL Contrato:** https://sepolia.etherscan.io/address/0x22357389d9b8e177a8fc924d85d8f64640fcaad3
### Acuñar primera Obra
 - TX : https://sepolia.etherscan.io/tx/0xa47cc8d6813a4461e2069e120fa8f58e8464dbf6b52ec22a751c989c88c09fa4
 - Contrato: https://sepolia.etherscan.io/token/0xf1ea1a551d25428d135ee9a3fd20adb061d07c77
 - JSON:
```JSON
{
  "name": "Arte Digital #1",
  "description": "Una pieza única de arte digital en la colección MiToken",
  "image": "https://mipagina.com/imagenes/arte-digital-1.png",
  "attributes": [
    {
      "trait_type": "Rareza",
      "value": "Extremadamente raro"
    },
    {
      "trait_type": "Artista",
      "value": "Juan Pérez"
    }
  ]
}
```
 - Primer Arte 
    - ![image](https://github.com/richpob/MiPrimerERC721-ERC1155/assets/133718913/86debbae-5fbb-4fc9-a32f-5be4735928fa)
 - Import NTF en Metamask
    - ![image](https://github.com/richpob/MiPrimerERC721-ERC1155/assets/133718913/56f2b3e7-24bb-4df6-9be1-6f1f27381c45)
 - Verificación y Uso de Contrato en Etherscan:
 - ![image](https://github.com/richpob/MiPrimerERC721-ERC1155/assets/133718913/21f41565-fff5-429f-a3a6-67f0d780a7af)


## ERC-1155: Token Multiuso para un Juego de Cartas Coleccionables
El estándar ERC-1155 permite crear tokens tanto fungibles como no fungibles. Podemos utilizarlo para un juego de cartas coleccionables, donde las cartas comunes son fungibles y las raras no fungibles.

**Funciones Personalizadas de Ejempl: (NO IMPLEMENTADO)**
 - **combinarCartas:** Permite combinar cartas específicas para crear una nueva de mayor rareza.
 - **intercambiarCartas:** Facilita el intercambio entre jugadores directamente en el contrato.

**Caso de Uso:**
Jugadores pueden coleccionar, intercambiar y combinar cartas para mejorar sus mazos y competir en torneos.

**Consideraciones Finales**
Implementar estos contratos requeriría un conocimiento profundo de Solidity y los estándares de tokens de Ethereum. Las funciones personalizadas añaden complejidad y flexibilidad a los usos tradicionales, enriqueciendo las posibilidades de interacción entre usuarios y tokens.

## Código fuente ERC721
```solidity
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

```

## Implementación del contrato ERC1155
### Creación Contrato
 - **URL TX :** [https://sepolia.etherscan.io/tx/0xc2ba63f4ee2190524a561c41821e6032e951106122b42eadc628cfa73c5dbd8d](https://sepolia.etherscan.io/tx/0x99cfc00f94121c79d167781e0b4ba0f0fc4ed1d8e328d665ac41a7566dbd241e)
 - **URL Contrato:** [https://sepolia.etherscan.io/address/0x9f6743ed369e17f896f30db160e5ade629ac7300](https://sepolia.etherscan.io/address/0xd7170fa57f99c0ea02afad5486b0214433f1a3e7)
 - **URL de TX creacion de carta:** https://sepolia.etherscan.io/tx/0x7a75b309ebada9e2e98e72b1f0f02f38b9a5861518124dd20b4cfb89483ccd4f
 - Implementacion en Remix
 - ![image](https://github.com/richpob/MiPrimerERC721-ERC1155/assets/133718913/a9d8dff7-9635-4019-bac2-93ea323c1b05)
 - Cuenta en metamask con NTF
 - ![image](https://github.com/richpob/MiPrimerERC721-ERC1155/assets/133718913/1e38fb75-1d14-41f1-8ce6-0256fea544e4)

## Contrato de Interacción: Plataforma de Intercambio y Exhibición
Este contrato inteligente facilitaría la interacción entre los dos anteriores, permitiendo a los usuarios intercambiar obras de arte por cartas coleccionables y viceversa.
### Funciones:
 - intercambioArtePorCartas: Permite a un usuario ofrecer una obra de arte a cambio de cartas específicas.
 - intercambioCartasPorArte: Permite a un usuario ofrecer cartas a cambio de una obra de arte específica.
### Caso de Uso:
Crea un ecosistema donde coleccionistas de arte y jugadores de cartas coleccionables pueden interactuar, intercambiando activos de una manera segura y verificable.

## Código fuente ERC721
```solidity
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
```
## Implementación del contrato interralacion
### Creación Contrato
 - **URL TX :** https://sepolia.etherscan.io/tx/0x2c3e2163136b5d087a3640a66088e38b952a803c216e24beb70112276382a14f
 - **URL Contrato:** https://sepolia.etherscan.io/address/0xc081fc9fc6d191154987a0b00e8bc01cfb270efb
 - **Remix Implementacion**
![image](https://github.com/richpob/MiPrimerERC721-ERC1155/assets/133718913/120a6c05-b6e8-4306-a27d-f7ed8af08a84)
 - Detalles del contrato:
![image](https://github.com/richpob/MiPrimerERC721-ERC1155/assets/133718913/4f5feafd-eac0-4037-8667-06ff9d67962a)

