<?php
include 'cors.php'; 

// conexión a la base de datos
include 'conexion.php'; 

// Inicializar un array para la respuesta
$response = array();

// Preparar la consulta para obtener todos los registros de la tabla 'servicios'
$query = "SELECT * FROM servicios";
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
    $response = array("status" => "error", "message" => "No hay servicios registrados.");
}

// Enviar la respuesta en formato JSON
echo json_encode($response);

// Cerrar la conexión
$conn->close();
?>
