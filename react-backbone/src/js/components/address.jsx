App.Components = App.Components || {};

// Address component
Address = Backbone.React.Component.extend({

    render: function() {

        var model = new App.Models.Address(this.props);

        if( model.get('phone') ) {
            var phone = "has phone";
        }

        return (
            <div className="address-card col-md-6">
                <h3 className="type">{model.get('type')}</h3>
                <img className="map" src={model.address_map()} />
                <h3 className="name">{model.get('name')}</h3>
                <div className="address">
                    <span className="company">{model.get('company')}</span>
                    <span className="street">{model.get('street')}</span>
                    <span className="city">{model.get('city')},</span>
                    <span className="state">{model.get('state')}</span>
                    <span className="zip">{model.get('zip')}</span>
                </div>
                <a className="phone">{model.get('phone')}</a>
            </div>
        );
    }
});
