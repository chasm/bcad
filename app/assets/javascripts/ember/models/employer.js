BCAuto.Employer = DS.Model.extend({
  nameOfCompany: DS.attr('string'),
  phoneNumber: DS.attr('string'),
  email: DS.attr('string'),
  webSiteUrl: DS.attr('string'),
  city: DS.attr('string'),
  zipCode: DS.attr('string'),
  jobTitle: DS.attr('string'),
  nameOfSupervisor: DS.attr('string'),
  fromMonth: DS.attr('number'),
  fromYear: DS.attr('number'),
  toMonth: DS.attr('number'),
  toYear: DS.attr('number'),
  monthlyPayBeforeTaxes: DS.attr('number'),
  
  user: DS.belongsTo('BCAuto.User')
});

