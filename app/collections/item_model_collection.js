define(function(require, exports, module){
    var Backbone = require('backbone');
    var ItemModel = require('models/item_model');

    module.exports = Backbone.Collection.extend({
        model: ItemModel
    });
});