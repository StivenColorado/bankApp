document.addEventListener("DOMContentLoaded", () => {
    // Obtener el valor de 'opcionSeleccionada' desde localStorage
    const opcionSeleccionada = localStorage.getItem('opcionSeleccionada');

    if (opcionSeleccionada) {
        console.log(opcionSeleccionada);
        // Hacer una solicitud POST al servidor para obtener los servicios según la opción seleccionada
        fetch("http://localhost/bankApp/backend/obtener_lista_opciones.php", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ codigo_servicio: opcionSeleccionada })
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === "success") {
                    const container_service_name = document.querySelector(".titulo-servicio").textContent = data.service_name
                    // Seleccionar el contenedor principal donde se añadirán las opciones
                    const container = document.querySelector(".container-options");

                    // Recorrer cada servicio y crear un elemento HTML para cada uno
                    data.data.forEach((servicio) => {
                        console.log(servicio);
                        // Crear el div principal para cada opción
                        const serviceDiv = document.createElement("div");
                        serviceDiv.className = "mb-4";

                        // Crear el contenedor de la opción
                        const optionContainer = document.createElement("div");
                        optionContainer.className = "bg-white w-full px-8 py-4 border border-gray-300 rounded-full shadow-sm flex items-center justify-between hover:shadow-lg hover:cursor-pointer";
                        optionContainer.setAttribute("opcion_servicio", servicio.id);

                        // Crear el span para el nombre del servicio
                        const serviceName = document.createElement("span");
                        serviceName.className = "text-gray-700";
                        serviceName.textContent = servicio.nombre; // Cambia 'nombre' al campo adecuado

                        // Crear el icono SVG
                        const serviceIcon = document.createElement("div");
                        serviceIcon.className = "w-5 h-5 text-gray-500";
                        serviceIcon.innerHTML = `
                        <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    `;

                        // Añadir el nombre y el icono al contenedor de la opción
                        optionContainer.appendChild(serviceName);
                        optionContainer.appendChild(serviceIcon);

                        // Añadir el contenedor de la opción al div principal
                        serviceDiv.appendChild(optionContainer);

                        // Añadir el div principal al contenedor padre
                        container.appendChild(serviceDiv);

                        // Agregar evento de clic para cada opción
                        optionContainer.addEventListener("click", () => {
                            const opcionServicio = optionContainer.getAttribute("opcion_servicio");
                            console.log("Servicio seleccionado:", opcionServicio);

                            // Verificar si servicio.atencion es 'asesor' o 'sistema'
                            if (servicio.atencion === "asesor") {
                                // Redirigir a la página de asesor
                                window.location.href = "../pages/infoatencion.html";
                            } else if (servicio.atencion === "sistema") {
                                // Redirigir a la página de sistema
                                window.location.href = "../pages/turnocreado.html";
                            }
                        });
                    });
                } else {
                    console.error("Error al obtener los servicios:", data.message);
                    const container = document.querySelector(".container-options");
                    container.innerHTML += `
                <h1 class="text-center w-full">${data.message}</h1>
                `;
                }
            })
            .catch(error => {
                console.error("Error en la solicitud:", error);
            });
    } else {
        console.error("No se encontró la opción seleccionada en localStorage.");
    }
});
