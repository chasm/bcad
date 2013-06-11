BCAuto.Registrant = DS.Model.extend({
  email: DS.attr('string'),
  expiresAt: DS.attr('date'),
  
  automobile: DS.belongsTo('BCAuto.Automobile'),
  
  name: function() {
    return this.get('email') + ": " + moment(this.get('expiresAt')).format("D MMM h:mm");
  }.property('email', 'expiresAt')
});
