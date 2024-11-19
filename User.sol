// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

/// El contrato de Usuario permite a los usuarios consultar el clima y obtener los resultados del contrato de Consumidor.

import "./Consumer.sol";

contract User {
    Consumer public consumer;

    constructor(address consumerAddress) {
        consumer = Consumer(consumerAddress);
    }

    function queryWeather(string calldata location) external payable {//Los usuarios llaman a este método para enviar consultas meteorológicas. La solicitud se remitirá al contrato del Consumidor, y también se remitirá la tarifa pagada por el usuario.

        consumer.requestWeather{value: msg.value}(location);
    }

    function getWeather(bytes32 queryId) external {//Obtener resultados de consulta del contrato del Consumidor.
        consumer.fetchWeather(queryId);
    }
}

