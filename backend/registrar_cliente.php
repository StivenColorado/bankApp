<?php
// Incluir archivos de configuración y conexión
include 'cors.php';
include 'conexion.php';

// Habilitar la visualización de errores para depuración
error_reporting(E_ALL);
ini_set('display_errors', 1);

$response = array();

$data = json_decode(file_get_contents("php://input"), true);

// Verificar si la solicitud es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener los datos enviados en formato JSON

    // Verificar que el dato requerido está presente
    if (isset($data['cedula'])) {
        // Asignar los valores a variables
        $cedula = $data['cedula'];

        // Preparar la consulta para insertar el registro en la tabla 'cliente'
        $stmt = $conn->prepare("INSERT INTO cliente (rol, correo, edad, nombre, cedula) VALUES (?, ?, ?, ?, ?)");
        
        // Verificar si la preparación de la consulta fue exitosa
        if ($stmt) {
            // Asignar los valores a los parámetros de la consulta
            $rol = "no_registrado";
            $correo = "anonimo@gmail.com";
            $edad = 18;
            $nombre = "anonimo";
            $stmt->bind_param("ssisi", $rol, $correo, $edad, $nombre, $cedula);

            // Ejecutar la consulta y verificar si fue exitosa
            if ($stmt->execute()) {
                // Obtener el ID del último registro insertado
                $last_id = $stmt->insert_id;
                $response = array("status" => "success", "message" => "Bienvenido!, gracias por acceder a nuestros productos", "id" => $last_id);
            } else {
                // Error al ejecutar la consulta
                $response = array("status" => "error", "message" => "Error al registrar al cliente anónimo: " . $stmt->error);
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
