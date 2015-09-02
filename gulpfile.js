var gulp = require('gulp');
var concat = require('gulp-concat');

gulp.task('default', function(){
  gulp.src(['src/preamble.q', 'src/util.q', 'src/*.q', 'src/postamble.q'])
  .pipe(concat('qdash.q'))
  .pipe(gulp.dest('./'));
});

gulp.task('test', function(){
  console.log('The test suite is not yet implemented.');
});
