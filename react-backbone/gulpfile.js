var gulp       = require('gulp')
    , less     = require('gulp-less')
    , plumber  = require('gulp-plumber')
    , jshint   = require('gulp-jshint')
    , jade     = require('gulp-jade')
    , concat   = require('gulp-concat')
    , react    = require('gulp-react')
    , gulpif   = require('gulp-if')
    , reload   = require('gulp-livereload');

var cfg = {

    files: {

        less: [
            'src/less/vendor/**',
            'src/less/theme/_*.less',
            'src/less/theme/layout.less',
            'src/less/theme/**'
        ],

        js: [
            'src/js/vendor/jquery.js',
            'src/js/vendor/react*',
            'src/js/vendor/underscore.js',
            'src/js/vendor/backbone.js',
            'src/js/vendor/backbone*',
            'src/js/environment.js',
            'src/js/models/**/*.js',
            'src/js/collections/**/*.js',
            'src/js/components/**/*.jsx',
            'src/js/**/*.js',
        ],

        jade: [
            'src/jade/*.jade'
        ],

        static: [
            'src/api/**'
        ]
    },

    dist: {

        css: {
            name: 'main.css',
            dir: './build/css/'
        },

        js: {
            name: 'main.js',
            dir: './build/js/'
        },

        static: {
            dir: './build/'
        },


        jade: {
            dir: './build/'
        }
    }
};

gulp.task('stylesheets', function() {
    gulp.src(cfg.files.less)
        .pipe(plumber())
        .pipe(concat(cfg.dist.css.name))
        .pipe(less())
        .pipe(gulp.dest(cfg.dist.css.dir));
});

gulp.task('javascripts', function() {

    // move plain js
    gulp.src(cfg.files.js)
        .pipe(plumber())
        // process jsx
        .pipe(gulpif(/jsx$/, react()))
        .pipe(concat(cfg.dist.js.name))
        .pipe(gulp.dest(cfg.dist.js.dir));

    // js hint
    gulp.src(cfg.files.js.concat('!./src/js/vendor/**'))
        .pipe(plumber())
        .pipe(gulpif(/js$/, jshint()))
        .pipe(jshint.reporter('default'));
});

gulp.task('html', function() {
    gulp.src(cfg.files.jade)
        .pipe(plumber())
        .pipe(jade({ pretty: true }))
        .pipe(gulp.dest(cfg.dist.jade.dir));
});

gulp.task('static', function() {
    gulp.src(cfg.files.static, {base: './src/'})
        .pipe(gulp.dest(cfg.dist.static.dir));
});

gulp.task('watch', function(){
    var server = reload();
    gulp.watch(cfg.files.jade,     ['html']);
    gulp.watch(cfg.files.less,     ['stylesheets']);
    gulp.watch(cfg.files.js,       ['javascripts']);
    gulp.watch(cfg.files.static,   ['static']);
    gulp.watch('./build/**')
        .on('change', function(file){ server.changed(file.path) })
});

gulp.task('build', ['stylesheets', 'javascripts', 'html', 'static']);
gulp.task('default', ['build', 'watch']);