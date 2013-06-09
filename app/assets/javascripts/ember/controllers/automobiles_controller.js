BCAuto.AutomobilesController = Ember.ArrayController.extend({
  currentStatus: 'available',
  
  caption: function() {
    switch (this.get('currentStatus')) {
      case 'available':
        return 'Autos for sale';
      case 'available':
        return 'Autos pending';
      case 'available':
        return 'Autos sold';
      default:
        return 'Autos';
    }
  }.property('available')
});
