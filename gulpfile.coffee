gulp = require 'gulp'
{log,color} = require 'gulp-util'
clean = require 'gulp-clean'
modernizr = require 'gulp-modernizr'
uglify = require 'gulp-uglify'

args = require('minimist')(process.argv.slice 2)

flatten = (arr) ->  [].concat.apply([], arr)

config =
  clean:
    default:
      docpad: ['.docpad.db','out']
      bower: ['bower_components','./src/raw/vendor']
    production:
      node: ['node_modules']

isProduction = args.production

gulp.task 'clean', ->
  sources = flatten(globs for k,globs of config.clean.default)
  if isProduction
    productionSources = flatten(globs for k,globs of config.clean.production)
    sources = sources.concat(productionSources)
  gulp
    .src(sources, read: false)
    .pipe clean()

gulp.task 'modernizr', ->
  #modernizr.build {options:['load'],'feature-detects':['test/css/fontface']}, (result)->
  #  console.log(result.code) # full source
  #  console.log(result.min) # minfied output

  #.pipe uglify()
  customizrOpts =
    options:['setClasses','load']
    tests:['test/css/fontface']

  modernizrFilename = 'modernizr-custom.min.js'
  gulp.src ['out/js/*.js',"!#{modernizrFilename}"]
    .pipe modernizr(modernizrFilename,customizrOpts)
    .pipe uglify()
    .pipe gulp.dest('out/js')


gulp.task 'default', ->
  #place code for your default task here
  log "config: #{JSON.stringify(config,null,'\t')}"

###
test : Modernizr.mq('(only all)'),
    nope : ['js/libs/respond.min.js']

// Based on default settings on http://modernizr.com/download/
    "options" : [
        "setClasses",
        "addTest",
        "html5printshiv",
        "testProp",
        "fnBind"
    ],
###

###
TODO

add a task to generate custom modernizr
add a task to generate custom bootstrap
add a task to browserify css and javascript
use modernizr to first try to load bootstrap and jquery or zope from cdn and fallback to local files

add a task to use bower to install vendor bower_components
vendor.min.js --> all vendor assets
vendor.min.css --> all vendor css

app.min.js --> all app js
app.min.css --> all app css
###
