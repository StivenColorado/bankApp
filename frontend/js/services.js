 // Añadir el evento click a todas las opciones
 document.querySelectorAll('.option').forEach(option => {
    option.addEventListener('click', function () {
        // Obtener el valor de data-option
        const valor = this.getAttribute('data-option');

        // Guardar el valor en localStorage
        localStorage.setItem('opcionSeleccionada', valor);

        // Mostrar una alerta para confirmar la selección (opcional)
        alert('Opción seleccionada: ' + valor);

        // Aquí puedes ejecutar cualquier otra acción, por ejemplo, redirigir a otra página
        window.location.href = '../pages/listservice.html'
    });
});
