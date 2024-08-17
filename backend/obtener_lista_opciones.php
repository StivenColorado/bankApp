<?php
include 'cors.php'; 
include 'conexion.php'; 

// Inicializar un array para la respuesta
$response = array();

// Obtener los datos enviados en formato JSON
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['codigo_servicio'])) {
    $codigo_servicio = $data['codigo_servicio'];

    // Consulta para obtener el nombre del servicio desde la tabla 'servicios'
    $stmt_service = $conn->prepare("SELECT nombre FROM servicios WHERE id = ?");
    $stmt_service->bind_param("i", $codigo_servicio);
    $stmt_service->execute();
    $result_service = $stmt_service->get_result();

    if ($result_service->num_rows > 0) {
        // Obtener el nombre del servicio
        $service_name = $result_service->fetch_assoc()['nombre'];
    } else {
        // Si no se encuentra el servicio, devolver un error
        $response = array("status" => "error", "message" => "No se encontró el servicio.");
        echo json_encode($response);
        exit();
    }

    // Cerrar la consulta de servicios
    $stmt_service->close();

    // Consulta para obtener los registros de la tabla 'opciones' según el codigo_servicio
    $stmt = $conn->prepare("SELECT * FROM opciones WHERE codigo_servicio = ?");
    $stmt->bind_param("i", $codigo_servicio);
    $stmt->execute();
    $result = $stmt->get_result();

    // Verificar si hay registros
    if ($result->num_rows > 0) {
        $servicios = array();

        // Obtener todos los registros como un array asociativo
        while($row = $result->fetch_assoc()) {
            $servicios[] = $row;
        }

        // Incluir el nombre del servicio en la respuesta junto con los datos
        $response = array("status" => "success", "service_name" => $service_name, "data" => $servicios);
    } else {
        // Si no hay registros, enviar un mensaje de error
        $response = array("status" => "error", "message" => "No hay servicios registrados para esta opción.");
    }

    // Cerrar la declaración
    $stmt->close();
} else {
    // Si no se recibe la opción, enviar un mensaje de error
    $response = array("status" => "error", "message" => "No se recibió el código del servicio.");
}

// Enviar la respuesta en formato JSON
echo json_encode($response);

// Cerrar la conexión
$conn->close();
?>
