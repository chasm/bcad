BCAuto.Residence = DS.Model.extend({
  addressLineOne: DS.attr('string'),
  addressLineTwo: DS.attr('string'),
  city: DS.attr('string'),
  zipCode: DS.attr('string'),
  fromMonth: DS.attr('number'),
  fromYear: DS.attr('number'),
  toMonth: DS.attr('number'),
  toYear: DS.attr('number'),
  monthlyRentOrMortgate: DS.attr('number'),
  isOwner: DS.attr('boolean'),
  
  user: DS.belongsTo('BCAuto.Applicant')
});

