var notyf = new Notyf();
import CONFIG  from "./config.js";

// Esperar a que el DOM esté completamente cargado (si es necesario)
document.addEventListener("DOMContentLoaded", () => {
    // Obtener los datos de localStorage
    const cliente = JSON.parse(localStorage.getItem('cliente'));
    const opcionSeleccionada = localStorage.getItem('opcionSeleccionada');
    const opcionServicio = localStorage.getItem('opcionServicio');

    // Verificar que los datos necesarios están disponibles
    if (cliente && opcionSeleccionada && opcionServicio) {
        const id_cliente = cliente.id; // Suponiendo que el objeto cliente tiene una propiedad id

        // Crear el objeto con los datos a enviar
        const dataToSend = {
            codigo_cliente: id_cliente,
            codigo_opcion: opcionServicio,
            codigo_servicio: opcionSeleccionada
        };

        // Enviar los datos al servidor
        fetch(`${CONFIG.API_BASE_URL}registro_atencion_sistema.php`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(dataToSend)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Error en la red: " + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                // Manejar la respuesta del servidor
                if (data.status === "success") {
                    console.log("Registro creado exitosamente.");
                    console.log(data)
                    localStorage.setItem("codigo_servicio_opcion", data.codigo_servicio_opcion)
                    // Aquí puedes agregar lógica adicional en caso de éxito
                } else {
                    console.error("Error al crear el registro: " + data.message);
                    // Aquí puedes agregar lógica adicional en caso de error
                }
            })
            .catch(error => {
                console.error("Error en la solicitud:", error);
                notyf.error("Hubo un problema con la solicitud.");
            });
    } else {
        console.error("Datos necesarios no disponibles en localStorage.");
        alert("No se encontraron datos necesarios en localStorage.");
        location.href = "../index.html"
    }
});
