<?php 
include("cors.php");
include("conexion.php");

// Verificar si la solicitud es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener el contenido JSON de la solicitud
    $data = json_decode(file_get_contents('php://input'), true);

    // Verificar si la decodificación fue exitosa
    if (json_last_error() === JSON_ERROR_NONE) {
        // Extraer las claves de interés
        $codigo_servicio = isset($data['codigo_servicio']) ? $data['codigo_servicio'] : null;

        // Verificar si los datos requeridos están presentes
        if ($codigo_servicio) {
            // Consulta para obtener los registros de la tabla opciones
            $stmt = $conn->prepare("SELECT * FROM opciones WHERE id = ?");
            $stmt->bind_param("i", $codigo_servicio);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                // Obtener la información de la opción
                $opcion = $result->fetch_assoc();
                
                // Consulta para obtener los registros de la tabla respuestas según el código de la opción
                $stmt_respuestas = $conn->prepare("SELECT * FROM respuestas WHERE codigo_opcion = ?");
                $stmt_respuestas->bind_param("i", $codigo_servicio);
                $stmt_respuestas->execute();
                $result_respuestas = $stmt_respuestas->get_result();

                $respuestas = array();

                while ($respuesta = $result_respuestas->fetch_assoc()) {
                    // Obtener el id de la respuesta
                    $respuesta_id = $respuesta['id'];

                    // Consulta para obtener los registros de la tabla detalle_respuestas según el id de la respuesta
                    $stmt_detalle = $conn->prepare("SELECT * FROM detalle_respuestas WHERE codigo_respuesta = ?");
                    $stmt_detalle->bind_param("i", $respuesta_id);
                    $stmt_detalle->execute();
                    $result_detalle = $stmt_detalle->get_result();

                    $detalles = array();

                    while ($detalle = $result_detalle->fetch_assoc()) {
                        $detalles[] = $detalle;
                    }

                    // Añadir los detalles al objeto respuesta
                    $respuesta['detalles'] = $detalles;

                    $respuestas[] = $respuesta;
                }

                $response = array(
                    "status" => "success",
                    "respuestas" => $respuestas,
                );
            } else {
                $response = array("status" => "error", "message" => "No se encontró la opción especificada.");
            }

            $stmt->close();
            $stmt_respuestas->close();
        } else {
            $response = array("status" => "error", "message" => "Datos incompletos.");
        }
    } else {
        $response = array("status" => "error", "message" => "Error al decodificar JSON.");
    }
} else {
    $response = array("status" => "error", "message" => "Método no permitido.");
}

// Enviar la respuesta en formato JSON
echo json_encode($response);

$conn->close();
?>
