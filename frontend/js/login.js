let form = document.getElementById("formulario_consulta");

form.addEventListener("submit", (e) => {
    e.preventDefault(); // Evita la recarga del formulario

    // Verifica si existe 'cliente' en localStorage
    localStorage.clear('cliente')
    let cliente = localStorage.getItem('cliente');
    let tipo_cliente = cliente ? true : false; // Define si el cliente existe (true o false)

    // Crea un objeto FormData a partir del formulario
    let formData = new FormData(form);

    // Convierte FormData a un objeto JSON y agrega tipo_cliente
    let data = {};
    formData.forEach((value, key) => {
        data[key] = value;
    });

    // Añade el valor de tipo_cliente al objeto data
    data.tipo_cliente = tipo_cliente;

    console.log(data);

    // Envía los datos al servidor en formato JSON
    fetch("http://localhost/bankApp/backend/consulta_usuario.php", { // Asegúrate de usar la ruta correcta
        method: "POST",
        headers: {
            'Content-Type': 'application/json', // Especifica que estamos enviando JSON
        },
        body: JSON.stringify(data) // Convierte el objeto a una cadena JSON
    })
    .then(response => {
        // Verifica si la respuesta es correcta
        if (!response.ok) {
            throw new Error("Error en la red: " + response.statusText);
        }
        return response.json(); // Parsear la respuesta JSON
    })
    .then(data => {
        // Muestra la respuesta del servidor
        console.log(data);
        if (data.status === "success") {
            alert(data.message); // Muestra mensaje de éxito
    
            // Guarda el objeto 'data.data' en localStorage
            localStorage.setItem('cliente', JSON.stringify(data.data));
            // redirigir a pagina de opciones
            location.href = "../pages/services.html"
        } else {
            alert(data.message); // Muestra mensaje de error
            location.href = "../pages/services.html"
        }
    })
    .catch(error => {
        console.error("Error en la solicitud:", error);
        alert("Hubo un problema con la solicitud.");
    });
});
