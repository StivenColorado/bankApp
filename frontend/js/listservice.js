var notyf = new Notyf();
import CONFIG from './config.js'


document.addEventListener("DOMContentLoaded", () => {
    // Obtener el valor de 'opcionSeleccionada' desde localStorage
    const opcionSeleccionada = localStorage.getItem('opcionSeleccionada');

    if (opcionSeleccionada) {
        // Hacer una solicitud POST al servidor para obtener los servicios según la opción seleccionada
        fetch(`${CONFIG.API_BASE_URL}obtener_lista_opciones.php`, {
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
                        // console.log(servicio);
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
                            // console.log("Servicio seleccionado:", opcionServicio);

                            // aqui va la peticion para traer si la atencion es por parte del sistema o por parte de un asesor
                            fetch(`${CONFIG.API_BASE_URL}get_opcion.php`, {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/json",
                                },
                                body: JSON.stringify({
                                    id_opcion: opcionServicio
                                })
                            })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error("Error en la red: " + response.statusText);
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    // Muestra la respuesta del servidor
                                    // console.log(data);
                                    if (data.status === "success") {
                                        // console.log(data.data.atencion);
                                        // Aquí puedes manejar la respuesta exitosa, como guardar en localStorage o redirigir
                                        localStorage.setItem('opcionServicio', opcionServicio);
                                        // Verificar si servicio.atencion es 'asesor' o 'sistema'
                                        if (data.data.atencion === "asesor") {
                                            localStorage.setItem("asesor_o_sistema", data.data.atencion)
                                            notyf.success("Pronto seras atentido por un asesor")
                                            notyf.success("Imprime tu turno y toma asiento")
                                            setInterval(() => {
                                                window.location.href = "../pages/turnocreado.html";
                                            }, 3000);
                                        } else if (data.data.atencion === "sistema") {
                                            localStorage.setItem("asesor_o_sistema", data.data.atencion)
                                            window.location.href = `../pages/guide.html?opcion=${opcionSeleccionada}`;
                                        }
                                        // location.href = "../pages/services.html";
                                    } else {
                                        // Maneja el error según el mensaje recibido
                                        alert(data.message);
                                        // location.href = "../pages/services.html";
                                    }
                                })
                                .catch(error => {
                                    console.error("Error en la solicitud:", error);
                                    alert("Hubo un problema con la solicitud.");
                                });


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
