require.config({

    urlArgs: "bust=" +  (new Date()).getTime(),

    //enforceDefine: true,

    waitSeconds: 20,

    deps: ['app'],

    //baseUrl: "../bower_modules",

    paths: {
        jquery: "../bower_modules/jquery/dist/jquery",
        backbone: "../bower_modules/backbone/backbone",
        underscore: "../bower_modules/underscore/underscore"
    },

    /*
        From [http://requirejs.org/docs/api.html]:

        Remember: only use shim config for non-AMD scripts,
        scripts that do not already call define(). The shim
        config will not work correctly if used on AMD scripts,
        in particular, the exports and init config will not
        be triggered, and the deps config will be confusing
        for those cases
     */
    shim: {

        underscore: {
            deps: []
            //,exports: "_"
        },

        backbone: {
            // The following dependencies should be loaded prior to
            deps: ["jquery", "underscore"]

            // Once loaded, use the global 'Backbone' as the module name
            //,exports: "Backbone"
        }
    }
});
