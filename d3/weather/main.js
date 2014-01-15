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

    var line = d3.svg.line()
        .x(function(d){ return x(d.CST) })
        .y(function(d){ return y(d['Mean TemperatureF']) })

    // Guts

    var self = this;

    this.e = new Eventer;

    this.init = function() {
        this.e.subscribe( 'load', this.getData );
        this.e.subscribe( 'data', this.draw );

        this.e.publish( 'load' );
    };

    this.getData = function() {
        d3.csv('data.csv', function(error, data){
            data.forEach(function(d){
                d.CST = parseDate(d.CST);
                d['Mean TemperatureF'] = +d['Mean TemperatureF'];
            });

            self.e.publish( 'data', [ data ] );
        })
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
            .attr('d', line)
    };

    this.init.apply( this, arguments );
};

new Graph;
