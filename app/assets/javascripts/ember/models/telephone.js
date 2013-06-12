BCAuto.Telephone = DS.Model.extend({
  digits: DS.attr('string'),
  usage: DS.attr('string'),
  
  user: DS.belongsTo('BCAuto.Applicant')
});
