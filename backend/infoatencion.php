<?php
// Incluir archivos de configuración y conexión
include 'cors.php';
include 'conexion.php';

// Habilitar la visualización de errores para depuración (opcional en producción)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Establecer la cabecera de la respuesta como JSON
header('Content-Type: application/json');

// Preparar la respuesta
$response = array();

// Verificar si la solicitud es GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Consultar los turnos activos
    $query_turnos = "SELECT * FROM turnos WHERE estado = 'activo' ORDER BY fecha_hora ASC";
    $result_turnos = $conn->query($query_turnos);

    if ($result_turnos) {
        $turnos = array();
        
        while ($row_turno = $result_turnos->fetch_assoc()) {
            $codigo_servicio_opcion = $row_turno['codigo_servicio_opcion'];

            // Consultar la tabla servicios_opciones con el codigo_servicio_opcion
            $query_servicios_opciones = "SELECT * FROM servicios_opciones WHERE id = '$codigo_servicio_opcion'";
            $result_servicios_opciones = $conn->query($query_servicios_opciones);

            if ($result_servicios_opciones) {
                $servicios_opciones = $result_servicios_opciones->fetch_assoc();

                $codigo_servicio = $servicios_opciones['codigo_servicio'];
                $codigo_opcion = $servicios_opciones['codigo_opcion'];
                $codigo_cliente = $servicios_opciones['codigo_cliente'];

                // Consultar la tabla servicios con el codigo_servicio
                $query_servicios = "SELECT * FROM servicios WHERE id = '$codigo_servicio'";
                $result_servicios = $conn->query($query_servicios);
                $servicio = $result_servicios ? $result_servicios->fetch_assoc() : array();

                // Consultar la tabla opciones con el codigo_opcion
                $query_opciones = "SELECT * FROM opciones WHERE id = '$codigo_opcion'";
                $result_opciones = $conn->query($query_opciones);
                $opcion = $result_opciones ? $result_opciones->fetch_assoc() : array();

                // Consultar la tabla cliente con el codigo_cliente
                $query_cliente = "SELECT * FROM cliente WHERE id = '$codigo_cliente'";
                $result_cliente = $conn->query($query_cliente);
                $cliente = $result_cliente ? $result_cliente->fetch_assoc() : array();

                // Agregar los datos del turno junto con los datos de servicios_opciones, servicios, opciones, y cliente
                $turnos[] = array(
                    'turno' => $row_turno,
                    'servicios_opciones' => $servicios_opciones,
                    'servicio' => $servicio,
                    'opcion' => $opcion,
                    'cliente' => $cliente
                );
            } else {
                $turnos[] = array(
                    'turno' => $row_turno,
                    'servicios_opciones' => array(),
                    'servicio' => array(),
                    'opcion' => array(),
                    'cliente' => array()
                );
            }
        }

        $response = array(
            "status" => "success",
            "data" => $turnos
        );
    } else {
        // Error en la consulta
        $response = array(
            "status" => "error",
            "message" => "Error en la consulta de turnos: " . $conn->error
        );
    }
} else {
    // Solicitud no válida
    $response = array(
        "status" => "error",
        "message" => "Método no permitido. Use GET."
    );
}

// Enviar la respuesta en formato JSON
echo json_encode($response);

// Cerrar la conexión
$conn->close();
?>
