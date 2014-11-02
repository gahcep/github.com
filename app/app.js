define(function(require, exports, module){
    var $ = require('jquery');

    var AppView = require('views/app_view');

    $(function(){
        window.application = new AppView();
    });
});