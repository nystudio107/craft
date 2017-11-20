if ('serviceWorker' in navigator) {
    window.addEventListener('load', function() {
        navigator.serviceWorker.register('/sw.js', {
            scope: "/"
        }).then(function(registration) {
            // Registration was successful
            console.log('ServiceWorker registration successful with scope: ', registration.scope);
            // Trim the caches on load
            navigator.serviceWorker.controller && navigator.serviceWorker.controller.postMessage({
                command: "trimCaches"
            });
       }).catch(function(err) {
            // registration failed :(
            console.log('ServiceWorker registration failed: ', err);
        });
    });
}
