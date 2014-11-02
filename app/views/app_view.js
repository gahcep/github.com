define(function(require, exports, module){
    var $ = require('jquery');
    var Backbone = require('backbone');

    var ItemView = require('views/item_view');
    var ItemModelCollection = require('collections/item_model_collection');

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
