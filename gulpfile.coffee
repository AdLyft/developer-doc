'use-strict'

gulp = require('gulp')
$ = require('gulp-load-plugins')()

console.log $

gulp.task 'build', ->

  gulp.src('./templates/*.jade')
    .pipe $.jade()
    .pipe gulp.dest('./dist/')
