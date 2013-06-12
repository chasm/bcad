BCAuto.Login = DS.Model.extend({
  session: DS.attr('string'),
  ipAddress: DS.attr('string'),
  userAgent: DS.attr('string'),
  referer: DS.attr('string'),
  loggedInAt: DS.attr('date'),
  loggedOutAt: DS.attr('date'),
  
  user: DS.belongsTo('BCAuto.Applicant')
});
