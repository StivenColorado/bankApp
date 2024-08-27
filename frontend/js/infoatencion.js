
var notyf = new Notyf({
    position: {
        x: 'right',
        y: 'top'
    }
});

import CONFIG from './config.js'
document.addEventListener("DOMContentLoaded", () => {
    const turnosList = document.getElementById('turnos-list');
    const btn_update_status = document.querySelector(".btn-set-status");
    let turnoid;

    const fetchTurnos = () => {
        fetch(`${CONFIG.API_BASE_URL}infoatencion.php`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error en la red: ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                console.log(data);
                if (data.status === 'success') {
                    turnosList.innerHTML = ''; // Limpiar lista previa
                    turnosList.innerHTML = `
                <h1 class="text-xl font-semibold mb-4">Lista de Turnos</h1>`
                    let oldestTurno = null;

                    data.data.forEach(item => {
                        const { turno, servicios_opciones, servicio, opcion, cliente } = item;

                        // Crear el contenedor principal del turno
                        const turnoDiv = document.createElement('div');
                        turnoDiv.className = 'flex flex-col bg-white p-6 rounded-lg shadow-md mb-4 w-[50%]';

                        // Encabezado con el icono y el nombre del servicio
                        const headerDiv = document.createElement('div');
                        headerDiv.className = 'flex items-center mb-4';

                        const iconoSpan = document.createElement('span');
                        iconoSpan.className = 'text-3xl mr-3';
                        iconoSpan.textContent = servicio.icono || '🔔';

                        const servicioNombre = document.createElement('h2');
                        servicioNombre.className = 'text-xl font-semibold';
                        servicioNombre.textContent = servicio.nombre || 'Servicio desconocido';

                        headerDiv.appendChild(iconoSpan);
                        headerDiv.appendChild(servicioNombre);

                        // Información del turno
                        const infoDiv = document.createElement('div');
                        infoDiv.className = 'grid grid-cols-2 gap-4';

                        const turnoId = createInfoItem('Número de Turno', turno.id);
                        const fechaHora = createInfoItem('Fecha y Hora', formatoFecha(turno.fecha_hora));
                        const opcionNombre = createInfoItem('Opción', opcion.nombre || 'No disponible');
                        const clienteNombre = createInfoItem('Cliente', cliente.nombre || 'No disponible');
                        const clienteCedula = createInfoItem('Cédula', cliente.cedula || 'No disponible');
                        const clienteCorreo = createInfoItem('Correo', cliente.correo || 'No disponible');

                        infoDiv.appendChild(turnoId);
                        infoDiv.appendChild(fechaHora);
                        infoDiv.appendChild(opcionNombre);
                        infoDiv.appendChild(clienteNombre);
                        infoDiv.appendChild(clienteCedula);
                        infoDiv.appendChild(clienteCorreo);

                        // Agregar elementos al contenedor principal
                        turnoDiv.appendChild(headerDiv);
                        turnoDiv.appendChild(infoDiv);

                        // Agregar el contenedor del turno a la lista principal
                        turnosList.appendChild(turnoDiv);

                        // Determinar el turno con la fecha más antigua
                        const fechaActual = new Date(turno.fecha_hora);
                        if (!oldestTurno || fechaActual < new Date(oldestTurno.fecha_hora)) {
                            oldestTurno = { turno, servicio, opcion, cliente, fecha_hora: turno.fecha_hora };
                        }
                    });

                    // Asignar información de la fecha más antigua a la maqueta
                    if (oldestTurno) {
                        document.querySelector('.lastest-name').textContent = oldestTurno.cliente.nombre || 'Nombre no disponible';
                        document.querySelector('.lastest-age').textContent = oldestTurno.cliente.edad || 'Edad no disponible';
                        document.querySelector('.lastest-type-client').textContent = oldestTurno.cliente.tipo_cliente || 'Tipo no disponible';
                        document.querySelector('.lastest-id-client').textContent = oldestTurno.cliente.cedula || 'Cédula no disponible';
                        document.querySelector('.lastest-id-number').textContent = '#id : ' + oldestTurno.turno.id;
                        turnoid = oldestTurno.turno.id;
                    }
                } else {
                    console.error('Error:', data.message);
                    turnosList.innerHTML = '<p class="text-red-500">Error al cargar los turnos.</p>';
                }
            })
            .catch(error => {
                console.error('Error en la solicitud:', error);
                turnosList.innerHTML = '<p class="text-red-500">Error en la solicitud.</p>';
            });
    };

    // Función auxiliar para crear elementos de información
    const createInfoItem = (label, value) => {
        const itemDiv = document.createElement('div');

        const labelP = document.createElement('p');
        labelP.className = 'text-gray-600';
        labelP.textContent = label;

        const valueP = document.createElement('p');
        valueP.className = 'text-black font-medium';
        valueP.textContent = value;

        itemDiv.appendChild(labelP);
        itemDiv.appendChild(valueP);

        return itemDiv;
    };

    // Función auxiliar para formatear la fecha y hora
    const formatoFecha = (fechaHora) => {
        const fecha = new Date(fechaHora);
        return fecha.toLocaleString('es-ES', {
            dateStyle: 'short',
            timeStyle: 'short'
        });
    };

    // Inicializar la carga de turnos
    fetchTurnos();

    // Actualizar la lista de turnos cada cierto tiempo (opcional)
    // setInterval(fetchTurnos, 30000); // Actualiza cada 30 segundos

    btn_update_status.addEventListener("click", () => {
        // console.log("se presiono el boton, el id a enviar es: " + turnoid)

        fetch(`${CONFIG.API_BASE_URL}actualizar_estado_turno.php`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ "id_turno": turnoid })
        })
            .then(response => {
                // console.log("Respuesta del servidor recibida (crearturno.php).");
                if (!response.ok) {
                    throw new Error("Error en la red: " + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                // Manejar la respuesta del servidor
                if (data.status === "success") {
                    notyf.success(data.message);
                    fetchTurnos();
                } else {
                    console.error("Error al crear el turno: " + data.message);
                    notyf.error(data.message);
                }
            })
            .catch(error => {
                console.error("Error en la solicitud al crear turno:", error);
                alert("Hubo un problema con la solicitud de creación de turno.");
            });
    })

});
