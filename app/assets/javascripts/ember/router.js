BCAuto.Router.map(function() {
  this.resource('automobiles', function() {
    this.route('new');
    this.route('detail', { path: ':automobile_id' });
    this.route('edit', { path: ':automobile_id/edit' });
  });

  this.resource('registrants', function() {
    this.route('new');
    this.route('detail', { path: ':registrant_id' });
    this.route('edit', { path: ':registrant_id/edit' });
  });
  
  this.resource('solicitations', function() {
    this.route('new');
    this.route('detail', { path: ':solicitation_id' });
    this.route('edit', { path: ':solicitation_id/edit' });
  });

  this.resource('applicants', function() {
    this.route('new');
    this.route('detail', { path: ':applicant_id' });
    this.route('edit', { path: ':applicant_id/edit' });
  });
  
  this.route('profile');
});

BCAuto.Router.reopen({
  location: 'history'
});


BCAuto.IndexRoute = Ember.Route.extend({
  activate: function() {
    document.title = "Bridge City Automotive";
  }
});


BCAuto.AutomobilesRoute = Ember.Route.extend({
  activate: function() {
    document.title = "Autos :: Bridge City Automotive";
  },
  model: function() {
    return BCAuto.Automobile.find();
  }
});

BCAuto.AutomobilesIndexRoute = Ember.Route.extend({
  model: function() {
    return BCAuto.Automobile.find();
  }
});

BCAuto.RegistrantsRoute = Ember.Route.extend({
  activate: function() {
    document.title = "Registrants :: Bridge City Automotive";
  },
  model: function() {
    return BCAuto.Registrant.find();
  }
});

BCAuto.SolicitationsRoute = Ember.Route.extend({
  activate: function() {
    document.title = "Credit Apps :: Bridge City Automotive";
  },
  model: function() {
    return BCAuto.Solicitation.find();
  }
});

BCAuto.ApplicantsRoute = Ember.Route.extend({
  activate: function() {
    document.title = "Applicants :: Bridge City Automotive";
  },
  model: function() {
    return BCAuto.Applicant.find();
  }
});