//= require cable
//= require_self
//= require_tree .

(function() {
  this.App = {};

  App.cable = ActionCable.createConsumer();
    
}).call(this);