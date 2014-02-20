
path = require 'path'

module.exports = (grunt)->
    'use strict'

    grunt.initConfig
      bower:
        #target:
            #rjsConfig: 'app/config.js'
            #options:
                #exclude: ['modernizr', 'sass-bootstrap', 'qtip2']
        install:
          options:
            targetDir: './src/raw/vendor'
            layout: (type, component) ->
                realType=type
                minSuffix = type.indexOf('-min')
                minified = false
                if minSuffix != -1
                    realType = type.substring(0,minSuffix)
                    minified = true
                return path.join(component,realType)
            install: true
            verbose: false
            cleanTargetDir: true
            cleanBowerDir: false
            bowerOptions: {}
      clean:
        docpad: ['.docpad.db','out']
        bower: ['bower_components','./src/raw/vendor']
        node: ['node_modules']
      favicons:
        options:
            html: 'src/partials/favicon.html',
            HTMLPrefix: "/images/favicons/"
        icons:
          src: 'src/raw/images/site-icon.png'
          dest: 'src/raw/images/favicons/'
      concat:
        css:
          src: ['out/css/*','!all.css']
          dest: 'out/css/all.css'
        js:
          src: ['out/js/*','!all.js']
          dest: 'out/js/all.js'
      cssmin:
        css:
          src: 'out/css/all.css'
          dest: 'out/css/all.min.css'
      uglify:
        js:
          files:
            'out/js/all.js': ['out/js/all.js']

    grunt.loadNpmTasks 'grunt-bower-task'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-favicons'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    #grunt.loadNpmTasks 'grunt-bower-requirejs'

    grunt.registerTask('default','')
    grunt.registerTask('assets', ['concat:css', 'cssmin:css', 'concat:js', 'uglify:js']);




