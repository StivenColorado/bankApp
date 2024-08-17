<?php
// Configuración de los datos de conexión
$servername = "localhost";  // Cambia esto si tu servidor de base de datos no está en el mismo servidor que tu archivo PHP
$username = "root";         // Cambia esto por tu nombre de usuario de la base de datos
$password = "";             // Cambia esto por tu contraseña de la base de datos, déjalo vacío si no tienes contraseña
$dbname = "bankapp_db";           // Cambia esto por el nombre de tu base de datos

// Crear la conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Comprobar la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}
//echo "Conexión exitosa";
?>
