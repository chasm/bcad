Ember.Handlebars.registerBoundHelper('date', function(d) {
  return moment(d).format('MMMM Do YYYY');
});

Ember.Handlebars.registerBoundHelper('datetime', function(dt) {
  return moment(dt).format('hh:mm A, DD MMMM');
});

Ember.Handlebars.registerBoundHelper('currency', function(money) {
  return numeral(money).format('$0,0[.]00');
});

Ember.Handlebars.registerBoundHelper('toTitleCase', function(str) {
  return str.replace(/\w*/g, function(txt) {
    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
  });
});

Ember.Handlebars.registerBoundHelper('convertToYesNo', function(bln) {
  switch (bln) {
  case undefined:
    return new Ember.Handlebars.SafeString('<span class="n_a">n/a</span>');
  case true:
    return new Ember.Handlebars.SafeString('<span class="yes">Yes</span>');
  default:
    return new Ember.Handlebars.SafeString('<span class="no">No</span>');
  }
});