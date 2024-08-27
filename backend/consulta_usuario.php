<?php
require_once 'src/JWT.php'; // Asegúrate de que esta línea apunta a tu autoload

use \Firebase\JWT\JWT;

include 'cors.php'; 
include 'conexion.php';

$secret_key = "your_secret_key";
$algorithm = 'HS256'; 
// Verificar si la solicitud es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    if (json_last_error() === JSON_ERROR_NONE) {
        $cedula = isset($data['cedula']) ? $data['cedula'] : null;

        if ($cedula) {
            $stmt = $conn->prepare("SELECT * FROM cliente WHERE cedula = ?");
            $stmt->bind_param("s", $cedula);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $cliente = $result->fetch_assoc();

                // Crear payload y token JWT
                $payload = array(
                    "id" => $cliente['id'],
                    "iat" => time(),
                    "exp" => time() + (60 * 60) // Expira en 1 hora
                );

                $jwt = JWT::encode($payload, $secret_key, $algorithm);
                $response = array(
                    "status" => "success",
                    "message" => "La cédula está registrada.",
                    "data" => $cliente,
                    "token" => $jwt // Incluir el token en la respuesta
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

echo json_encode($response);
$conn->close();
?>
