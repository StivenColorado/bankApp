<?php
// Incluir archivos de configuración y conexión
include 'cors.php';
include 'conexion.php';

// Habilitar la visualización de errores para depuración
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Array de respuesta
$response = array();

// Verificar si la solicitud es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener los datos enviados en formato JSON
    $data = json_decode(file_get_contents("php://input"), true);

    // Verificar que el codigo_servicio_opcion esté presente en la solicitud
    if (isset($data['codigo_servicio_opcion'])) {
        $codigo_servicio_opcion = $data['codigo_servicio_opcion'];

        // Preparar la consulta SQL para obtener el turno basado en codigo_servicio_opcion
        $stmt = $conn->prepare("SELECT * FROM turnos WHERE codigo_servicio_opcion = ?");
        $stmt->bind_param("i", $codigo_servicio_opcion);

        // Ejecutar la consulta
        if ($stmt->execute()) {
            // Obtener el resultado
            $result = $stmt->get_result();

            // Verificar si se encontraron registros
            if ($result->num_rows > 0) {
                $turnos = array();

                // Obtener todos los datos del turno y almacenarlos en un array
                while ($row = $result->fetch_assoc()) {
                    $turnos[] = $row;
                }

                // Preparar la respuesta con éxito y los datos encontrados
                $response = array(
                    "status" => "success",
                    "message" => "Turnos encontrados",
                    "data" => $turnos
                );
            } else {
                // No se encontraron turnos con el codigo_servicio_opcion dado
                $response = array(
                    "status" => "error",
                    "message" => "No se encontraron turnos con el código proporcionado"
                );
            }
        } else {
            // Error al ejecutar la consulta
            $response = array(
                "status" => "error",
                "message" => "Error al ejecutar la consulta: " . $stmt->error
            );
        }

        // Cerrar la declaración
        $stmt->close();
    } else {
        // Responder con un mensaje de error si faltan datos
        $response = array(
            "status" => "error",
            "message" => "Código de servicio no proporcionado."
        );
    }
} else {
    // Responder con un mensaje de error si no es una solicitud POST
    $response = array(
        "status" => "error",
        "message" => "Método no permitido."
    );
}

// Enviar la respuesta en formato JSON
echo json_encode($response);

// Cerrar la conexión
$conn->close();
?>
