BCAuto.User = DS.Model.extend({
  nameFirst: DS.attr('string'),
  nameMiddle: DS.attr('string'),
  nameLast: DS.attr('string'),
  email: DS.attr('string'),
  isAdmin: DS.attr('boolean'),
  
  telephones: DS.hasMany('BCAuto.Telephone'),
  logins: DS.hasMany('BCAuto.Login'),
  employers: DS.hasMany('BCAuto.Employer'),
  residences: DS.hasMany('BCAuto.Residence'),
  solicitations: DS.hasMany('BCAuto.Solicitation'),
  
  name: function() {
    return [this.get('nameFirst'), this.get('nameMiddle'), this.get('nameLast')].compact().join(" ");
  }.property('nameFirst', 'nameMiddle', 'nameLast')
});

