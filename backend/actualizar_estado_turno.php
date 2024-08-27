<?php
// Incluir archivos de configuración y conexión
include 'cors.php';
include 'conexion.php';

// Verificar si la solicitud es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener los datos enviados en formato JSON
    $data = json_decode(file_get_contents("php://input"), true);

    // Verificar que todos los datos requeridos están presentes
    if (isset($data['id_turno'])) {
        // Asignar los valores a variables
        $id_turno = $data['id_turno'];

        // Preparar la consulta para insertar el registro en la tabla 'turnos'
        $stmt = $conn->prepare("UPDATE turnos SET estado = 'atendido' WHERE id = ?");
        
        // Verificar si la preparación de la consulta fue exitosa
        if ($stmt) {
            $stmt->bind_param("i", $id_turno);

            // Ejecutar la consulta y verificar si fue exitosa
            if($stmt->execute()){
                // Obtener el ID del último registro insertado
                $response = array("status" => "success", "message" => "Turno Atendido correctamente");
            } else {
                // Error al ejecutar la consulta
                $response = array("status" => "error", "message" => "Error al crear el turno: " . $stmt->error);
            }
            
            // Cerrar la declaración
            $stmt->close();
        } else {
            // Error al preparar la consulta
            $response = array("status" => "error", "message" => "Error al preparar la consulta: " . $conn->error);
        }
    } else {
        // Responder con un mensaje de error si faltan datos
        $response = array("status" => "error", "message" => "Datos incompletos.");
    }
} else {
    // Responder con un mensaje de error si no es una solicitud POST
    $response = array("status" => "error", "message" => "Método no permitido.");
}

// Enviar la respuesta en formato JSON
echo json_encode($response);

// Cerrar la conexión
$conn->close();
?>
