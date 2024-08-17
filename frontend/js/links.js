// archivo para rutas, para detectar eventos de click en un boton y redireccionar

window.addEventListener('DOMContentLoaded', () => {
    // definiendo botones
    let btn_index = document.querySelector('button[name="index_consulte_aqui"]')
    let btn_form = document.querySelector('button[name="form_continuar"]')

    presionar(btn_index, 'pages/form')
    // presionar(btn_form,'services')
})



const presionar = (boton, url) => {
  if(boton){
    boton.addEventListener('click', () => {
        window.location.href = `${url}.html`
    })
  }
}