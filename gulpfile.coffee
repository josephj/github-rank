gulp = require 'gulp'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
livereload = require 'gulp-livereload'
watch = require 'gulp-watch'
karma = require 'gulp-karma'

gulp.task 'build', ->
  gulp.src('public/javascripts/*.coffee')
    .pipe(coffeelint())
    .pipe(coffee())
    .pipe(gulp.dest('public/javascripts/'))

gulp.task 'watch', ->
  watch glob: 'public/javascripts/*.coffee', (files) ->
    files.pipe(coffee()).pipe(gulp.dest('public/javascripts/'))
  gulp.src ['public/javascripts/*.js', 'public/stylesheets/*.css', 'views/*.ejs']
    .pipe(watch())
    .pipe(livereload())

gulp.task 'test', ->
  files = [
    'public/javascripts/controllers.coffee'
    'test/unit/*.coffee'
  ]
  gulp.src(files)
    .pipe karma
      configFile: 'karma.conf.js'
      action: 'run'

gulp.task 'default', ->
  gulp.run('build')
