document.addEventListener('DOMContentLoaded', () => {
    // Obtén referencia al input y al contenedor del pad numérico
    const input = document.getElementById('cedula');
    input.focus(); // Establece el foco en el input al cargar la página
    const numPad = document.querySelector('.num-pad');

    // Función para actualizar el input según el valor del botón

    const updateInput = (value) => {
        if (value === 'C') {
            input.value = '';
        } else if (value === 'backspace') {
            input.value = input.value.slice(0, -1);
        input.focus(); // Mantener el foco en el input después de actualizar su valor

        } else {
            input.value += value;
        }
        input.focus(); // Mantener el foco en el input después de actualizar su valor
    };

    // Agrega un manejador de eventos para los clics en los botones numéricos
    numPad.addEventListener('click', (event) => {
        if (event.target.tagName === 'BUTTON') {
            const buttonValue = event.target.textContent.trim();

            updateInput(buttonValue);
        }
    });
});
