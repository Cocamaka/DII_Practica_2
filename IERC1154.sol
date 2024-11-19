// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

//ERC-1154 define una interfaz estándar para que la utilice Oracle. 
//Esta interfaz es la interfaz estándar de los contratos de Oracle y define los métodos principales de solicitud y respuesta de datos.

interface IERC1154 {
    function requestOracleData(bytes32 queryId, string calldata query) external payable;
    function respondToQuery(bytes32 queryId, string calldata response) external;
}

