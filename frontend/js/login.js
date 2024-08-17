let form = document.getElementById("formulario_consulta");

form.addEventListener("submit", (e) => {
    e.preventDefault(); // Evita la recarga del formulario

    // Crea un objeto FormData a partir del formulario
    let formData = new FormData(form);

    // Convierte FormData a un objeto JSON
    let data = {};
    formData.forEach((value, key) => {
        data[key] = value;
    });

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

            // Recupera y muestra el objeto almacenado para verificación
            // let cliente = localStorage.getItem('cliente');
            // console.log(JSON.parse(cliente)); // Convierte la cadena JSON de vuelta a un objeto
        } else {
            alert(data.message); // Muestra mensaje de error
        }
    })
    
    .catch(error => {
        console.error("Error en la solicitud:", error);
        alert("Hubo un problema con la solicitud.");
    });
});
