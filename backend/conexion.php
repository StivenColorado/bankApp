<?php
// Configuración de los datos de conexión
$servername = "localhost";  
$username = "root";        
$password = "";             
$dbname = "bankapp_db";           

// Crear la conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Comprobar la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}
//echo "Conexión exitosa";
?>
