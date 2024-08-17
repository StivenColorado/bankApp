// Esperar a que el DOM esté completamente cargado
document.addEventListener("DOMContentLoaded", () => {
    client_name = JSON.parse(localStorage.getItem("cliente"))
    name_container = document.querySelector("#nombre-cliente").textContent = "- " +client_name.nombre
    // Hacer una solicitud GET al servidor para obtener los servicios
    fetch("http://localhost/bankApp/backend/services.php") // Cambia esta URL a la correcta
        .then(response => response.json())
        .then(data => {
            if (data.status === "success") {
                // Seleccionar el contenedor principal
                const container = document.querySelector(".container-options");

                // Definir los colores de fondo disponibles
                const backgroundColors = [
                    "bg-[#C79BE2]/50", // Color 1
                    "bg-[#A8E2F4]/50", // Color 2
                    "bg-[#578AA7]/50", // Color 3
                    "bg-[#8BE0EC]/50"  // Color 4
                ];

                // Recorrer cada servicio y crear un elemento HTML para cada uno
                data.data.forEach((servicio) => {
                    // Seleccionar un color de fondo al azar
                    const randomColor = backgroundColors[Math.floor(Math.random() * backgroundColors.length)];

                    // Crear el div principal para cada opción
                    const optionDiv = document.createElement("div");
                    optionDiv.className = `option relative w-64 h-[230px] ${randomColor} border border-gray-200 rounded-lg shadow-md p-4 flex flex-col items-center justify-center cursor-pointer hover:border-2 hover:border-green-800`;
                    optionDiv.setAttribute("data-option", servicio.id); // Asignar servicio.id

                    // Crear el icono de alerta
                    const iconDiv = document.createElement("div");
                    iconDiv.className = "absolute -top-3 -left-3 w-12 h-12 bg-white border-2 border-black text-black rounded-full flex items-center justify-center text-xl";
                    iconDiv.textContent = servicio.icono;

                    // Crear el contenedor de texto
                    const textDiv = document.createElement("div");
                    textDiv.className = "text-center";

                    // Título del servicio
                    const title = document.createElement("h3");
                    title.className = "text-lg font-semibold mb-2";
                    title.textContent = servicio.nombre; // Cambia 'nombre' al campo adecuado

                    // Descripción del servicio
                    const description = document.createElement("p");
                    description.textContent = servicio.descripcion; // Cambia 'descripcion' al campo adecuado

                    // Crear el enlace
                    const link = document.createElement("a");
                    link.className = "px-6 py-2 font-bold rounded-full text-black cursor-pointer";
                    link.href = "./listservice.html";
                    link.textContent = "Ingresa aquí ->";

                    // Añadir los elementos al contenedor de texto
                    textDiv.appendChild(title);
                    textDiv.appendChild(description);

                    // Añadir los elementos al div principal
                    optionDiv.appendChild(iconDiv);
                    optionDiv.appendChild(textDiv);
                    optionDiv.appendChild(link);

                    // Añadir el div principal al contenedor padre
                    container.appendChild(optionDiv);
                });

                // Añadir el evento click a todas las opciones
                document.querySelectorAll('.option').forEach(option => {
                    option.addEventListener('click', function () {
                        // Obtener el valor de data-option (que ahora es servicio.id)
                        const valor = this.getAttribute('data-option');

                        // Guardar el valor en localStorage
                        localStorage.setItem('opcionSeleccionada', valor);

                        // Mostrar una alerta para confirmar la selección (opcional)
                        alert('Opción seleccionada: ' + valor);

                        // Redirigir a otra página
                        window.location.href = '../pages/listservice.html';
                    });
                });
            } else {
                console.error("Error al obtener los servicios:", data.message);
            }
        })
        .catch(error => {
            console.error("Error en la solicitud:", error);
        });
});
