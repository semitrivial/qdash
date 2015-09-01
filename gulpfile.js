var gulp = require('gulp');
var concat = require('gulp-concat');

gulp.task('default', function(){
  gulp.src(['src/base.q', 'src/util.q', 'src/*.q'])
  .pipe(concat('qdash.q'))
  .pipe(gulp.dest('./'));
});

gulp.task('test', function(){
  console.log('The test suite is not yet implemented.');
});
