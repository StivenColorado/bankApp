import CONFIG from './config.js'

// variable globla para obtener el codigo de servico 
let codigo_servicio_global;

// Esperar a que el DOM esté completamente cargado
document.addEventListener("DOMContentLoaded", () => {
    // console.log("DOM completamente cargado.");

    // Obtener los datos de localStorage
    const cliente = JSON.parse(localStorage.getItem('cliente'));
    const opcionSeleccionada = localStorage.getItem('opcionSeleccionada');
    const opcionServicio = localStorage.getItem('opcionServicio');

    // Asignar el valor de `opcionServicio` a `codigo_servicio_global`
    codigo_servicio_global = opcionServicio; // Asumiendo que el valor se obtiene de opcionServicio

    // Verificar que `codigo_servicio_global` tenga un valor válido
    if (!codigo_servicio_global) {
        console.error("Código de servicio global no está definido.");
        return;
    }

    // Añadir el evento click al botón con id `to_home_turno`
    document.querySelector("#to_home_turno").addEventListener("click", () => {
        // console.log("Botón clicado. Realizando consulta...");

        // Hacer la consulta al servidor usando fetch
        fetch(`${CONFIG.API_BASE_URL}get_turno.php`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ codigo_servicio_opcion: codigo_servicio_global })
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Error en la red: " + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                // console.log("Respuesta del servidor:", data);
                if (data.status === "success") {
                    // console.log("Datos recibidos:", data.data);

                    // Verificar si `data.data` es un array
                    if (Array.isArray(data.data)) {
                        // Crear un nuevo contenido HTML para imprimir
                        let printContent = `
                       <html>
                        <head>
                            <title>cliente_${data.data[0].id}</title>
                            <script src="https://cdn.tailwindcss.com"></script>
                            <style>
                                @page {
                                    size: 60mm 50mm; /* Tamaño de la página a 4 cm x 5 cm */
                                    margin: 5mm; /* Márgenes de 5 mm */
                                }
                                body {
                                    font-family: Arial, sans-serif;
                                    margin: 0;
                                    padding: 0;
                                }
                                .print-container {
                                    display: flex;
                                    flex-direction: column;
                                    align-items: center;
                                    justify-content: center;
                                    height: 100%;
                                    width: 100%;
                                    text-align: center;
                                    padding: 5mm;
                                    box-sizing: border-box; /* Asegura que el padding se incluya en el tamaño total */
                                       background:transparent;
                                        background-image:url('../img/ticket.png');
                                        object-fit:contain;
                                        background-size: 100% 100%;
                                    }

                                .print-container p {
                                    margin: 1mm 0; /* Espacio entre los párrafos */
                                    font-size: 1em; /* Tamaño de fuente para los párrafos */
                                }
                                .print-container hr {
                                    border: 0;
                                    border-top: 1px solid #000;
                                    margin: 2mm 0; /* Espacio alrededor de la línea horizontal */
                                }
                            </style>
                        </head>
                        <body>
                            <div class="print-container">
                                ${data.data.map(turno => `
                                    <p style="font-size: 1em;"><span style="font-weight:bold;"> Turno #</span>  ${turno.id}</p>
                                    <div class="flex flex-row w-full text-center justify-center items-center">
                                        <p style="font-size: .2em;"><span style="font-weight:bold;"> Código Servicio</span> #${turno.codigo_servicio_opcion}</p>
                                        <p style="font-size: .2em;"><span style="font-weight:bold;"> Fecha: </span> ${turno.fecha_hora}</p>
                                    </div>
                                    <p style="font-size: .8em;"><span style="font-weight:bold;"> Estado</span> ${turno.estado}</p>
                                    <hr>
                                `).join('')}
                            </div>
                        </body>
                        </html>

                    `;

                        // Crear una ventana emergente para la impresión
                        let printWindow = window.open('', '', 'height=400,width=500');
                        printWindow.document.write(printContent);
                        printWindow.document.close();
                        printWindow.focus();
                        printWindow.print();
                        // printWindow.close();
                        localStorage.clear()
                        location.href = "../index.html"
                    } else {
                        console.error("Formato de datos incorrecto. Esperaba un array.");
                    }
                } else {
                    console.error("Error en los datos:", data.message);
                }
            })
            .catch(error => {
                console.error("Error en la solicitud:", error);
            });
    });


    // Verificar que los datos necesarios están disponibles
    if (cliente && opcionSeleccionada && opcionServicio) {
        // console.log("Datos encontrados en localStorage:", { cliente, opcionSeleccionada, opcionServicio });

        const id_cliente = parseInt(cliente.id); // Suponiendo que el objeto cliente tiene una propiedad id

        // Crear el objeto con los datos a enviar
        const dataToSend = {
            codigo_cliente: id_cliente,
            codigo_opcion: opcionServicio,
            codigo_servicio: opcionSeleccionada
        };
        // console.log("Datos a enviar al servidor (registro_atencion_sistema.php):", dataToSend);

        // Enviar los datos al servidor
        fetch(`${CONFIG.API_BASE_URL}registro_atencion_sistema.php`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(dataToSend)
        })
            .then(response => {
                // console.log("Respuesta del servidor recibida.");
                if (!response.ok) {
                    throw new Error("Error en la red: " + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                // console.log("Respuesta JSON del servidor:", data);

                // Manejar la respuesta del servidor
                if (data.status === "success") {
                    // console.log("Registro creado exitosamente en registro_atencion_sistema.php.");
                    // console.log("Código de servicio opción recibido:", data.codigo_servicio_opcion);
                    codigo_servicio_global = data.codigo_servicio_opcion
                    const dataCrearTurno = {
                        codigo_servicio_opcion: data.codigo_servicio_opcion
                    };
                    // console.log("Datos a enviar al servidor (crearturno.php):", dataCrearTurno);

                    // REGISTRAR TURNO
                    fetch(`${CONFIG.API_BASE_URL}crearturno.php`, {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify(dataCrearTurno)
                    })
                        .then(response => {
                            // console.log("Respuesta del servidor recibida (crearturno.php).");
                            if (!response.ok) {
                                throw new Error("Error en la red: " + response.statusText);
                            }
                            return response.json();
                        })
                        .then(data => {
                            // console.log("Respuesta JSON del servidor (crearturno.php):", data);

                            // Manejar la respuesta del servidor
                            if (data.status === "success") {
                                // console.log("Turno creado exitosamente.");
                                // console.log("Datos del turno:", data);
                            } else {
                                console.error("Error al crear el turno: " + data.message);
                                // Aquí puedes agregar lógica adicional en caso de error
                            }
                        })
                        .catch(error => {
                            console.error("Error en la solicitud al crear turno:", error);
                            alert("Hubo un problema con la solicitud de creación de turno.");
                        });
                } else {
                    console.error("Error al crear el registro en registro_atencion_sistema.php: " + data.message);
                    // Aquí puedes agregar lógica adicional en caso de error
                }
            })
            .catch(error => {
                console.error("Error en la solicitud de registro de atención:", error);
                alert("Hubo un problema con la solicitud de registro de atención.");
            });
    } else {
        console.error("Datos necesarios no disponibles en localStorage.");
        alert("No se encontraron datos necesarios en localStorage.");
        location.href = "../index.html";
    }
});
