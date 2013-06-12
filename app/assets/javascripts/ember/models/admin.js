BCAuto.Admin = DS.Model.extend({
  nameFirst: DS.attr('string'),
  nameMiddle: DS.attr('string'),
  nameLast: DS.attr('string'),
  email: DS.attr('string'),
  isSuperuser: DS.attr('boolean'),
  
  name: function() {
    return [this.get('nameFirst'), this.get('nameMiddle'), this.get('nameLast')].compact().join(" ");
  }.property('nameFirst', 'nameMiddle', 'nameLast')
});

