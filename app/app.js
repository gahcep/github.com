define(function(require, exports, module){
    var $ = require('jquery');
    var _ = require('underscore');
    var Backbone = require('backbone');

    var itemTmpl = _.template('<header><%= model.get("content") %></header>');

    var ItemView = Backbone.View.extend({

        tagName: "li",

        template: itemTmpl,

        events: {},

        initialize: function(){
            if (!this.model){
                throw new Error('Provide a model for the view');
            }
        },

        render: function(){
            this.$el.html(this.template(this));
            return this.$el;
        }

    });

    var ItemModel = Backbone.Model.extend({
        defaults: {
            content: "This is a test for Backbone.js"
        },

        validate: function(attributes){
            console.log("Validating attrs: " + attributes.toJSON());
        },

        initialize: function(){
            console.log("Initialized ItemView model");
        }
    });

    var ItemModelCollection = Backbone.Collection.extend({
        model: ItemModel
    });

    // Main view for APP
    module.exports = Backbone.View.extend({

        el:$('#container'),

        initialize: function(){
            this.collection = new ItemModelCollection();
            this.listenTo( this.collection, 'add', this.renderItem );
            console.log("initialize");
        },

        events: {
            'click' : 'createItem'

        },

        renderItem: function(model){
            model.view = new ItemView({ model: model });
            this.$('#list').prepend( model.view.render() );
            this.$('#count').text(this.collection.length);
        },

        createItem: function(){
            event.preventDefault();

            // Create a new Comment Model with the data in the form
            var item = {

            };
            // The `validate` option ensures that empty comments aren't added
            this.collection.add( item );
        }

    });
});
