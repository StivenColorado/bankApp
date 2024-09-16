import CONFIG from './config.js'

document.addEventListener("DOMContentLoaded", () => {

    let btn_guide = document.querySelector("#to-home-button").addEventListener("click", (e) => {
        localStorage.clear()
        location.href = "../index.html"
    })

    // Extraer el valor de opcionServicio desde localStorage
    const opcionServicio = parseInt(localStorage.getItem('opcionServicio'))
    // console.log(opcionServicio)
    if (opcionServicio) {
        // Realizar la petición fetch
        fetch(`${CONFIG.API_BASE_URL}guide.php`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                codigo_servicio: opcionServicio,
            })
        })
            .then(response => response.json())
            .then(data => {
                respuestas = data.respuestas[0]

                // console.log(respuestas)
                // console.log(respuestas.detalles[0])
                if (data.status === "success") {
                    // Estructura HTML para opciones y respuestas
                    const container = document.querySelector('.container-options-respuestas');

                    // Título y descripción (obtenidos de la tabla opciones)
                    const titulo = respuestas.titulo; // Ejemplo de campo de la tabla opciones
                    const descripcion = respuestas.descripcion; // Ejemplo de campo de la tabla opciones

                    // Estructura del título y la descripción
                    container.innerHTML = `
                    <div class="w-full mb-4">
                        <h1 class="text-4xl md:text-4xl font-bold text-[#5A1B77] mb-2 title-option">${titulo}</h1>
                        <p class="text-gray-700 description-option">${descripcion}</p>
                    </div>
                    <div class="w-full flex flex-col space-y-4 main-container-respuestas"></div>
                `;

                    // Contenedor para respuestas dinámicas
                    const respuestasContainer = container.querySelector('.main-container-respuestas');

                    // Recorrer cada respuesta y construir su estructura
                    let index = respuestas.detalles.length - 1
                    // console.log("lengt detalles: " + index)

                    for (let i = 0; i <= index; i++) {
                        respuestasContainer.innerHTML += `
                            <div class="bg-white px-8 py-4 shadow-sm flex flex-col items-center justify-between round-lg">
                                <span class="text-gray-700 w-full font-bold title-answer">${respuestas.detalles[i].titulo}</span>
                                <span class="text-gray-700 w-full title-answer">${respuestas.detalles[i].descripcion}</span>
                            </div>
                        `;
                    }

                } else {
                    console.error("Error al obtener los datos:", data.message);
                }
            })
            .catch(error => {
                console.error("Error en la solicitud:", error);
            });
    } else {
        console.error("No se encontró el valor de opcionServicio en localStorage.");
    }
});
