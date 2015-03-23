'use-strict'

gulp = require('gulp')
$ = require('gulp-load-plugins')()

gulp.task 'compileJade', ->

  gulp.src('./templates/*.jade')
    .pipe $.jade()
    .pipe gulp.dest('./dist/')

gulp.task 'compileMarkdown', ->
  return

gulp.task 'build', ['compileJade', 'compileMarkdown'], ->
  return

gulp.task 'serve', ['build'], ->
  return

gulp.task 'server', ->
  console.warn 'The \'serve\' task should be used instead.'
  gulp.start 'serve'
  return

gulp.task 'default', ['serve']
