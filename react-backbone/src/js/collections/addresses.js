App.Collections = App.Collections || {};

App.Collections.Addresses = Backbone.Collection.extend({
    model: App.Models.Address,
    url: '/api/addresses.json',
    initialize: function() {
        this.fetch();
    },
    parse: function(resp) {
        return _.map(resp, function(d){ return new this.model(d) }, this)
    }
});
