function abrirYImprimir(url) {
    // Crear y mostrar el iframe invisible
    var iframe = $('#iframeImpresion');
    
    // Cargar la página en el iframe
    iframe.attr('src', url);
    
    // Esperar a que el contenido del iframe esté cargado
    iframe.on('load', function() {
        // Ejecutar la función de impresión dentro del iframe
        iframe[0].contentWindow.print();
    });
}