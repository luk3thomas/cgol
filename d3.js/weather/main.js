var eventer = new Eventer;
var margin = 50;
var width = window.innerWidth - 100,
    height = window.innerHeight - 300;

var Graph = function() {

    // Setup

    var svg = d3.select('#pie').append('svg')
            .attr( 'width', width )
            .attr( 'height', height )
        .append('g')

    var parseDate = d3.time.format('%Y-%m-%d').parse;

    var x = d3.time.scale()
        .range([0, width]);

    var y = d3.scale.linear()
        .range([height, 0]);

    var xAxis = d3.svg.axis()
        .scale(x)
        .orient('bottom');

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient('left');

    var line = d3.svg.area()
        .x(function(d){ return x(d.CST) })
        .y(function(d){ return y(d['Mean TemperatureF']) })
        .y0(height)
        .interpolate('basis');

    var defs = d3.select('svg').append('defs');

    // Add gradients
    var gradient1 = defs.append('linearGradient')
        .attr('id', 'gradient1')
        .attr('x1', '0%')
        .attr('y1', '0%')
        .attr('x2', '0%')
        .attr('y2', '100%');

    gradient1.append('stop')
        .attr('class', 'blueGradient1')
        .attr('offset', '0%');

    gradient1.append('stop')
        .attr('class', 'blueGradient2')
        .attr('offset', '100%');

    // Guts

    var self = this;

    this.e = new Eventer;

    this.init = function() {
        this.e.subscribe( 'load', this.getData );
        this.e.subscribe( 'store', this.store );
        this.e.subscribe( 'store', this.createLinks );
        this.e.subscribe( 'listen', this.listen );
        this.e.subscribe( 'setYear', this.setYear );
        this.e.subscribe( 'update', this.update );
        this.e.subscribe( 'draw', this.draw );

        this.e.publish( 'load' );
    };

    this.listen = function() {
        var links = document.querySelectorAll('a');
        _.each( links, function(l) {
            l.addEventListener( 'click', function() {
                self.e.publish( 'setYear', [ +this.innerHTML ] )
            });
        })
    };

    this.setYear = function( year ) {
        var days = _.filter( self.data, function(d) {
            return d.CST.getFullYear() == year;
        });
        self.e.publish( 'update', [ days ] );
    };

    this.createLinks = function( data ) {
        var links = _.chain(data)
            .map( function(d) { return d.CST.getFullYear() } )
            .uniq()
            .map( function(d) { return '<a class="year" href="#">' + d + '</a>' } )
            .value();

        var div = document.getElementById('links');
        div.innerHTML = links.join('');

        self.e.publish( 'listen' );
    };

    this.store = function( data ) {
        self.data = data;
        self.e.publish( 'draw', [ data ] );
    };

    this.getData = function() {
        d3.csv('data.csv', function(error, data){
            data.forEach(function(d){
                d.CST = parseDate(d.CST);
                d['Mean TemperatureF'] = +d['Mean TemperatureF'];
            });

            self.e.publish( 'store', [ data ] );
        })
    };

    this.update = function( data ) {
        x.domain(d3.extent( data, function(d) { return d.CST } ));
        console.log(d3.extent( data, function(d) { return d.CST } ));

        svg.select('.x.axis')
            .transition()
            .call(xAxis);

        svg.select('.line')
            .datum(data)
            .transition()
            .attr('d', line)
    };

    this.draw = function( data ) {
        y.domain(d3.extent( data, function(d) { return d['Mean TemperatureF'] } ));
        x.domain(d3.extent( data, function(d) { return d.CST } ));

        svg.append('g')
            .attr('class', 'x axis')
            .attr('transform', 'translate(0, ' + (height) + ')')
            .call(xAxis);

        svg.append('g')
            .attr('class', 'y axis')
            .call(yAxis);

        svg.append('path')
            .datum(data)
            .attr('class', 'line')
            .attr('fill', 'url(#gradient1)')
            .attr('d', line)
    };

    this.init.apply( this, arguments );
};

new Graph;
