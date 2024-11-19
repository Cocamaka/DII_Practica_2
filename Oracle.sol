// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

// El contrato de Oracle gestiona la solicitud y registra los datos devueltos por el servidor.

import "./IERC1154.sol";

contract Oracle is IERC1154 {
    address public server; 
    mapping(bytes32 => string) public responses; 
    //servidor: registra la dirección del servidor. Solo los servidores autorizados pueden devolver datos.
    //respuestas: guarda los datos devueltos por el servidor a través de queryId.

    event RequestSent(bytes32 queryId, string query);
    event ResponseReceived(bytes32 queryId, string response);
    //RequestSent: registra eventos de solicitud de datos.
    //RespuestaRecibida: registra el evento de datos devuelto por el servidor.

    modifier onlyServer() {
        require(msg.sender == server, "Not authorized");//Restringe el método respondToQuery para que solo sea llamado por la dirección del servidor
        _;
    }

    constructor(address _server) {
        server = _server;
    }

    function requestOracleData(bytes32 queryId, string calldata query) external payable override {
        emit RequestSent(queryId, query);
    }//requestOracleData: recibe la solicitud de datos y activa el evento RequestSent. El contenido de la consulta y el ID se notifican al servidor.

    function respondToQuery(bytes32 queryId, string calldata response) external override onlyServer {
        responses[queryId] = response;
        emit ResponseReceived(queryId, response);
    }//respondToQuery: el servidor devuelve el resultado, guarda los datos en el mapeo de respuestas y activa el evento ResponseReceived.

    function getResponse(bytes32 queryId) external view returns (string memory) {
        return responses[queryId];
    }//getResponse: permite que otros contratos o usuarios lean los resultados de la consulta.
}

