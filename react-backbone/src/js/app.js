var c = new App.Collections.Addresses();
setTimeout(function(){

    var addresses = new App.Components.Addresses({
        el: $('#addresses'),
        collection: c.models
    });

    addresses.mount();
}, 300);