App.Models = App.Models || {};

App.Models.Address = Backbone.Model.extend({

    // route for saving
    url: function() {
        this.id ? '/api/address/' + this.id : '/api/address';
    },

    // default attributes for a model
    defaults: {
        name    : '',
        company : '',
        street  : '',
        city    : '',
        state   : '',
        type    : '',
        phone   : ''
    },

    // Validate the model before saving
    validate: function() {
    },

    // uri encode a group of attrs
    encode_attrs: function(attrs) {
        return _.map(attrs, function(d){ return this.encode(d); }, this).join('');
    },

    // uri encode a single attr
    encode: function(attr) {
        return encodeURIComponent(' ' + (this.get(attr) || '') + ' ');
    },

    // generate a google map images of the address
    address_map: function() {
        return [
            'http://maps.googleapis.com/maps/api/staticmap?center=',
            this.encode_attrs(['street', 'city', 'state', 'zip']),
            '&zoom=15&size=600x300&sensor=false'
        ].join('');
    }
});
