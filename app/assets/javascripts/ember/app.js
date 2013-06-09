//= require_self
//= require ./models/automobile
//= require ./models/employer
//= require ./models/login
//= require ./models/photo
//= require ./models/registrant
//= require ./models/residence
//= require ./models/solicitation
//= require ./models/store
//= require ./models/telephone
//= require ./models/user
//= require ./controllers/application_controller
//= require ./controllers/automobiles_controller
//= require ./controllers/registrants_controller
//= require ./controllers/solicitations_controller
//= require ./controllers/users_controller
//= require ./views/topbar_view
//= require ./router

BCAuto = Ember.Application.create({
  LOG_TRANSITIONS: true
});
