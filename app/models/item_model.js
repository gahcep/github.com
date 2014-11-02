define(function(require, exports, module){

    var Backbone = require('backbone');

    module.exports = Backbone.Model.extend({
        defaults: {
            content: "This is a test for Backbone.js"
        },

        validate: function(attributes){
            console.log("Validating attributes: " + attributes.toJSON());
        },

        initialize: function(){
            console.log("Initialized ItemView model");
        }
    });
});