
path = require 'path'

module.exports = (grunt)->
    'use strict'

    grunt.initConfig
      clean:
        docpad: ['.docpad.db','out']
        bower: ['bower_components','./src/raw/vendor']
        node: ['node_modules']
      bower:
        #target:
            #rjsConfig: 'app/config.js'
            #options:
                #exclude: ['modernizr', 'sass-bootstrap', 'qtip2']
        install:
          options:
            targetDir: './src/raw/vendor'
            layout: (type, component) -> path.join(component,type)
            install: true
            verbose: false
            cleanTargetDir: true
            cleanBowerDir: false
            bowerOptions: {}
      favicons:
        options:
            html: 'src/partials/favicon.html',
            HTMLPrefix: "/images/favicons/"
        icons:
          src: 'src/raw/images/site-icon.png'
          dest: 'src/raw/images/favicons/'
      concat:
        vendor:
          css:
            src:  ['src/raw/vendor/src/css/**']
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
      modernizr:
        dist:
          devFile : './bower_components/modernizr/modernizr.js',
          outputFile: './out/js/modernizr-custom.min.js',
          extra:
            shiv: true
            printshiv: false
            load: true
            mq: false
            cssclasses: true
          extensibility:
            addtest: false
            prefixed: false
            teststyles: false
            testprops: false
            testallprops: false
            hasevents: false
            prefixes: false
            domprefixes: false
          uglify: true
          # Define any tests you want to implicitly include.
          tests: []
          # By default, this task will crawl your project for references to Modernizr tests.
          # Set to false to disable.
          parseFiles: true
          # When parseFiles = true, this task will crawl all *.js, *.css, *.scss files, except files that are in node_modules/.
          # You can override this by defining a 'files' array below.
          files:
            src: ['./out/**']
          # When parseFiles = true, matchCommunityTests = true will attempt to
          # match user-contributed tests.
          matchCommunityTests: false
          # Have custom Modernizr tests? Add paths to their location here.
          customTests: []

    grunt.loadNpmTasks 'grunt-bower-task'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-favicons'

    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-assets-versioning'

    grunt.loadNpmTasks 'grunt-modernizr'

    #grunt.loadNpmTasks 'grunt-bower-requirejs'

    grunt.registerTask 'default',''
    grunt.registerTask 'assets', ['concat:css', 'cssmin:css', 'concat:js', 'uglify:js']




