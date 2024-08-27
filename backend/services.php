<?php
include 'cors.php'; 
include 'conexion.php'; 

// Inicializar un array para la respuesta
$response = array();

// Obtener el valor de tipo_cliente de la solicitud GET
$tipo_cliente = isset($_GET['tipo_cliente']) ? $_GET['tipo_cliente'] : 'no_registrado';

// Preparar la consulta SQL basada en el valor de tipo_cliente
$query = "SELECT * FROM servicios WHERE tipo_servicio = '$tipo_cliente'";

$result = $conn->query($query);

// Verificar si hay registros
if ($result->num_rows > 0) {
    $servicios = array();

    // Obtener todos los registros como un array asociativo
    while($row = $result->fetch_assoc()) {
        $servicios[] = $row;
    }

    // Enviar la respuesta con los datos
    $response = array("status" => "success", "data" => $servicios);
} else {
    // Si no hay registros, enviar un mensaje de error
    $response = array("status" => "error", "message" => "No hay servicios disponibles.");
}

// Enviar la respuesta en formato JSON
echo json_encode($response);

// Cerrar la conexión
$conn->close();
?>
