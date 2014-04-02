App.Components = App.Components || {};

// Addresses component
App.Components.Addresses = Backbone.React.Component.extend({

    createAddress: function(address) {
        return <Address model={address} />;
    },

    render: function() {
        console.log(this.props.collection);

        return (
            <div className='row'>
                {this.props.collection.map(this.createAddress)}
            </div>
        );
    }
});
