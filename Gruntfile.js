
var path = require('path');

module.exports = function( grunt ) {
    'use strict';

    grunt.initConfig({
      bower: {
        install: {
          options: {
            targetDir: './src/files/vendor',
            layout: function(type, component) {
                var realType=type;
                var minSuffix = type.indexOf('-min');
                var minified = false;
                if(minSuffix!=-1){
                    realType = type.substring(0,minSuffix);
                    minified = true;
                }
                return path.join(component,realType);
            },
            install: true,
            verbose: false,
            cleanTargetDir: true,
            cleanBowerDir: false,
            bowerOptions: {}
          }
        }
      },
      clean: {
        docpad: ['.docpad.db','out'],
        bower: ['bower_components','./src/files/vendor'],
        node: ['node_modules']
      }
    });

    grunt.loadNpmTasks('grunt-bower-task');
    grunt.loadNpmTasks('grunt-contrib-clean');

    grunt.registerTask('default','');
};
