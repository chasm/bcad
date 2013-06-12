//= require_self
//= require ./helpers
//= require ./models/admin
//= require ./models/applicant
//= require ./models/automobile
//= require ./models/employer
//= require ./models/login
//= require ./models/photo
//= require ./models/registrant
//= require ./models/residence
//= require ./models/solicitation
//= require ./models/store
//= require ./models/telephone
//= require ./controllers/admins_controller
//= require ./controllers/applicants_controller
//= require ./controllers/application_controller
//= require ./controllers/automobiles_controller
//= require ./controllers/registrants_controller
//= require ./controllers/solicitations_controller
//= require ./views/topbar_view
//= require ./router

Ember.TextSupport.reopen({
  attributeBindings: ["required"]
})

BCAuto = Ember.Application.create({
  LOG_TRANSITIONS: true
});
