BCAuto.Photo = DS.Model.extend({
  fileName: DS.attr('string'),
  
  automobile: DS.belongsTo('BCAuto.Automobile')
});
