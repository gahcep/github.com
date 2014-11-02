define(function(require, exports, module){
    var _ = require('underscore');
    var Backbone = require('backbone');

    module.exports = Backbone.View.extend({

        tagName: "li",

        events: {},

        initialize: function(){
            if (!this.model){
                throw new Error('Provide a model for the view');
            }
        },

        render: function(){
            var template = _.template('<header><%= model.get("content") %></header>');
            this.$el.html(template(this));
            return this.$el;
        }

    });
});
