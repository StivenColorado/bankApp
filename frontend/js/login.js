import CONFIG from './config.js';

var notyf = new Notyf({
    position: {
        x: 'right',
        y: 'top'
    }
});

let form = document.getElementById("formulario_consulta");
localStorage.clear();

form.addEventListener("submit", (e) => {
    e.preventDefault(); // Evita la recarga del formulario

    let formData = new FormData(form);
    let data = {};
    formData.forEach((value, key) => {
        data[key] = value;
    });

    // Verificar si el usuario existe
    fetch(`${CONFIG.API_BASE_URL}consulta_usuario.php`, {
        method: "POST",
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ cedula: data.cedula }) // Solo se envía la cédula
    })
        .then(response => {
            if (!response.ok) {
                throw new Error("Error en la red: " + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            if (data.status === "success") {
                // Usuario encontrado, guardar en localStorage y redirigir
                notyf.success(data.message);
                localStorage.setItem('cliente', JSON.stringify(data.data));
                localStorage.setItem('token', data.token); // Guardar el token en localStorage
                setTimeout(() => {
                    location.href = "../pages/services.html";
                }, 2000);
            } else {
                // Usuario no encontrado, registrar nuevo cliente
                fetch(`${CONFIG.API_BASE_URL}registrar_cliente.php`, {
                    method: "POST",
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${localStorage.getItem('token')}` // Enviar el token en la cabecera
                    },
                    body: JSON.stringify({ cedula: formData.get('cedula') })
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("Error en la red: " + response.statusText);
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data.status === "success") {
                            // Nuevo cliente registrado, guardar en localStorage y redirigir
                            notyf.success(data.message);
                            localStorage.setItem('cliente', JSON.stringify({
                                id: data.id,
                                cedula: formData.get('cedula'),
                                nombre: "anonimo",
                                rol: "no_registrado",
                                correo: "anonimo@gmail.com",
                                edad: 18
                            }));
                            setTimeout(() => {
                                location.href = "../pages/services.html";
                            }, 2000);
                        } else {
                            // Mostrar error en el registro del cliente
                            notyf.error(data.message);
                        }
                    })
                    .catch(error => {
                        console.error("Error en la solicitud:", error);
                        alert("Hubo un problema con la solicitud.");
                    });
            }
        })
        .catch(error => {
            console.error("Error en la solicitud:", error);
            alert("Hubo un problema con la solicitud.");
        });
});
