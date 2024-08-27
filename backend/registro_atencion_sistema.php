<?php
// Incluir archivos de configuración y conexión
include 'cors.php';
include 'conexion.php';

// Verificar si la solicitud es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener los datos enviados en formato JSON
    $data = json_decode(file_get_contents("php://input"), true);

    // Verificar que todos los datos requeridos están presentes
    if (isset($data['codigo_cliente']) && isset($data['codigo_opcion']) && isset($data['codigo_servicio'])) {
        // Asignar los valores a variables
        $codigo_cliente = $data['codigo_cliente'];
        $codigo_opcion = $data['codigo_opcion'];
        $codigo_servicio = $data['codigo_servicio'];

        // Obtener la fecha y hora actual
        $fecha_hora_actual = date('Y-m-d H:i:s');

        // Preparar la consulta para insertar el registro en la tabla 'servicios_opciones'
        $stmt = $conn->prepare("INSERT INTO servicios_opciones (codigo_cliente, codigo_opcion, codigo_servicio, fecha_hora) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("iiis", $codigo_cliente, $codigo_opcion, $codigo_servicio, $fecha_hora_actual);

        // Ejecutar la consulta y verificar si fue exitosa
        if ($stmt->execute()) {
            // Responder con éxito
            $sentencia = $conn->prepare("SELECT * FROM servicios_opciones WHERE codigo_servicio = ? AND codigo_opcion = ? AND fecha_hora >= NOW() - INTERVAL 30 MINUTE ORDER BY fecha_hora DESC LIMIT 1 ");
            $sentencia->bind_param("ii", $codigo_servicio, $codigo_opcion);

            if ($sentencia->execute()) {
                $resultado =  $sentencia->get_result();
                if ($resultado->num_rows > 0) {
                    $registro = $resultado->fetch_assoc();
                    $codigo_servicio_opcion = $registro["id"];
                    $fecha_hora = $registro["fecha_hora"];

                    $response = array("status" => "success", "message" => "Registro creado exitosamente.", "codigo_servicio_opcion" => $codigo_servicio_opcion, "fecha_hora" => $fecha_hora);
                } else {
                    // Si no se encuentra el servicio, devolver un error
                    $response = array("status" => "error", "message" => "No se encontró el id asociado.",);
                    echo json_encode($response);
                    exit();
                }
            }
        } else {
            // Responder con un mensaje de error
            $response = array("status" => "error", "message" => "Error al crear el registro.");
        }

        // Cerrar la declaración
        $stmt->close();
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
