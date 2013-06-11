BCAuto.Solicitation = DS.Model.extend({
  driversLicenseNumber: DS.attr('string'),
  dateOfBirth: DS.attr('date'),
  socialSecurityNumber: DS.attr('string'),
  loanAmount: DS.attr('number'),
  salesPerson: DS.attr('string'),
  authorized: DS.attr('boolean'),
  status: DS.attr('string'),
  
  user: DS.belongsTo('BCAuto.User'),
  automobile: DS.belongsTo('BCAuto.Automobile'),
  
  name: function() {
    return [this.get('salesPerson'), numeral(this.get('loanAmount')).format('$0,0[.]00')].compact().join(" ");
  }.property('salesPerson', 'loanAmount')
});

