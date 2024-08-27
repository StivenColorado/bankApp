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
        $id_opcion = isset($data['id_opcion']) ? $data['id_opcion'] : null;

        // Verificar si los datos requeridos están presentes
        if ($id_opcion) {
            // Preparar la consulta para verificar el id_opcion
            $stmt = $conn->prepare("SELECT * FROM opciones WHERE id = ?");
            $stmt->bind_param("i", $id_opcion);  // Cambié "s" a "i" ya que id_opcion probablemente es un entero
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                // Obtener toda la información de la opción
                $opcion = $result->fetch_assoc();

                // Responder con los datos de la opción
                $response = array(
                    "status" => "success",
                    "message" => "ID de opción correcto.",
                    "data" => $opcion
                );
            } else {
                $response = array("status" => "error", "message" => "La opción no está registrada.");
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
?>
