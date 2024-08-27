<?php
require_once 'src/JWT.php'; // Asegúrate de que esta línea apunta a tu autoload

use \Firebase\JWT\JWT;

include 'cors.php'; 
include 'conexion.php';

$secret_key = "your_secret_key";
$algorithm = 'HS256'; 

// Verificar el token en la cabecera Authorization
$headers = apache_request_headers();
if (isset($headers['Authorization'])) {
    $authHeader = $headers['Authorization'];
    $token = str_replace("Bearer ", "", $authHeader);

    try {
        $decoded = JWT::decode($token, $secret_key, $algorithm);
        // Token válido, continuar con la lógica de tu aplicación
    } catch (Exception $e) {
        $response = array("status" => "error", "message" => "Token inválido.");
        echo json_encode($response);
        exit();
    }
} else {
    $response = array("status" => "error", "message" => "Token no proporcionado.");
    echo json_encode($response);
    exit();
}
?>
