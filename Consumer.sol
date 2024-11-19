// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "./Oracle.sol";
// El contrato del Consumidor reenvía la solicitud del usuario al contrato de Oracle y devuelve el resultado.
contract Consumer {
    Oracle public oracle;

    event WeatherRequested(address indexed user, bytes32 queryId, string query);//WeatherRequested: registra la solicitud meteorológica del usuario, incluida la dirección del usuario, el ID de la consulta y el contenido de la consulta.
    event WeatherReceived(address indexed user, string weatherData);//Tiempo recibido: registra los datos meteorológicos recibidos por el usuario.

    constructor(address oracleAddress) {
        oracle = Oracle(oracleAddress);
    }

    function requestWeather(string calldata location) external payable {////El usuario inicia una consulta meteorológica. Genere un queryId único según la ubicación y la marca de tiempo. Llame al método requestOracleData de Oracle para enviar una solicitud.
        bytes32 queryId = keccak256(abi.encodePacked(location, block.timestamp));
        oracle.requestOracleData{value: msg.value}(queryId, location);
        emit WeatherRequested(msg.sender, queryId, location);
    }

    function fetchWeather(bytes32 queryId) external {////Obtener resultados de consultas de Oracle. Si no se ha devuelto el resultado, se lanza una excepción que indica "datos no disponibles". Si tiene éxito, se activa el evento WeatherReceived.
        string memory response = oracle.getResponse(queryId);
        require(bytes(response).length > 0, "Data no available");
        emit WeatherReceived(msg.sender, response);
    }
}
