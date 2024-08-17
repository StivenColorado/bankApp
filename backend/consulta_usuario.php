<?php
include 'cors.php'; 

// conexión a la base de datos
include 'conexion.php'; 

// Verificar si la solicitud es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener el contenido JSON de la solicitud
    $data = json_decode(file_get_contents('php://input'), true);

    // Verificar si la decodificación fue exitosa
    if (json_last_error() === JSON_ERROR_NONE) {
        // Extraer las claves de interés
        $nombre = isset($data['nombre']) ? $data['nombre'] : null;
        $cedula = isset($data['cedula']) ? $data['cedula'] : null;

        // Verificar si los datos requeridos están presentes
        if ($cedula) {
     // if ($nombre && $cedula) {
            // Preparar la consulta para verificar la cédula
            $stmt = $conn->prepare("SELECT * FROM cliente WHERE cedula = ?");
            $stmt->bind_param("s", $cedula);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                // Obtener toda la información del cliente
                $cliente = $result->fetch_assoc();

                // Responder con los datos del cliente
                $response = array(
                    "status" => "success",
                    "message" => "La cédula está registrada.",
                    "data" => $cliente
                );
            } else {
                $response = array("status" => "error", "message" => "La cédula no está registrada.");
            }
            $stmt->close();
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

// Cerrar la conexión
$conn->close();
?>
