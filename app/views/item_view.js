define(function(require, exports, module){
    var Backbone = require('backbone');

    // Example usage of Handlebars.runtime/amd
    //var HandlebarsRuntimeEnv = require('handlebars.runtime');
    //var Handlebars = HandlebarsRuntimeEnv.default;

    // Example usage of Handlebars.amd
    //var HandlebarsEnv = require('handlebars');
    //var Handlebars = HandlebarsEnv.default;

    var item_list_tmpl = require('hbs!templates/item_list_tmpl');

    module.exports = Backbone.View.extend({

        tagName: "li",

        events: {},

        initialize: function(){
            if (!this.model){
                throw new Error('Provide a model for the view');
            }
        },

        render: function(){
            // Load the compiled HTML into the Backbone "el"
            this.$el.html(item_list_tmpl(this.model.toJSON()));

            //var template = _.template('<header><%= model.get("content") %></header>');
            //this.$el.html(template(this));
            return this.$el;
        }

    });
});
