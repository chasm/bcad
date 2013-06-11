BCAuto.RegistrantsController = Ember.ObjectController.extend({
  sortProperties: [ 'expiresAt' ],
  sortAscending: true,

  setupController: function(controller) {
    controller.set('model', BCAuto.Registrant.find());
  },
  
  removeRegistrant: function (registrant) {
    registrant.deleteRecord();
    registrant.save();
  },
  
  purgeExpired: function() {
    var now = moment();
    
    this.get('model').forEach(function(registrant) {
      try {
        if (registrant.get('expiresAt') < now) {
          registrant.deleteRecord();
          registrant.save();
        }
      } catch (e) {}
    })
  }
});