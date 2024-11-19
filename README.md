El objetivo principal de este código es implementar un sistema interactivo descentralizado dentro y fuera de la cadena para obtener datos meteorológicos en tiempo real.
aprobar:
Solicitud de usuario → Procesamiento de contrato de consumo de datos → Reenvío de solicitudes de Oracle → Adquisición de datos fuera de la cadena del servidor → Respuesta de Oracle → Proceso para que los usuarios obtengan resultados

Los contratos de Oracle gestionan la lógica de consultas y respuestas en cadena.
El contrato de Consumo es el responsable de la gestión de transferencias y solicitudes.
El contrato de usuario proporciona una interfaz de usuario simplificada.
El servidor es responsable de interactuar con las API fuera de la cadena para lograr la integración de datos dentro y fuera de la cadena. (servidor no completado)


Acciones del usuario:
- El usuario llama al método queryWeather(ubicación).
- La solicitud se remite al contrato del Consumidor.
Operaciones de contrato de consumo:
- Generar queryId y llamar a requestOracleData de Oracle.
- Oracle activa el evento RequestSent.
Operaciones del servidor fuera de la cadena:
- Obtener información de la consulta después de escuchar el evento RequestSent.
- Llame a la API meteorológica para obtener datos.
- Llame al método respondToQuery de Oracle para devolver datos a la cadena.
Operaciones de contrato de Oracle:
- Guardar los resultados devueltos en las respuestas.
- Activar evento de respuesta recibida.
El usuario obtiene resultados:
- El usuario llama a getWeather(queryId).
- El consumidor lee datos de Oracle y los devuelve al usuario.
