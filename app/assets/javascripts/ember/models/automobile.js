BCAuto.Automobile = DS.Model.extend({
  stockNumber: DS.attr('string'),
  year: DS.attr('number'),
  make: DS.attr('string'),
  model: DS.attr('string'),
  color: DS.attr('string'),
  style: DS.attr('string'),
  price: DS.attr('number'),
  status: DS.attr('string'),
  doors: DS.attr('number'),
  displacement: DS.attr('number'),
  cylinders: DS.attr('number'),
  mileage: DS.attr('number'),
  carfax: DS.attr('boolean'),
  lowMiles: DS.attr('boolean'),
  fullyServiced: DS.attr('boolean'),
  tiltSteering: DS.attr('boolean'),
  telescopingSteering: DS.attr('boolean'),
  powerSteering: DS.attr('boolean'),
  powerWindows: DS.attr('boolean'),
  powerLocks: DS.attr('boolean'),
  powerMirrors: DS.attr('boolean'),
  powerBrakes: DS.attr('boolean'),
  antilockBrakes: DS.attr('boolean'),
  allWheelDrive: DS.attr('boolean'),
  alloyWheels: DS.attr('boolean'),
  automatic: DS.attr('boolean'),
  cruiseControl: DS.attr('boolean'),
  airConditioning: DS.attr('boolean'),
  autoClimateControl: DS.attr('boolean'),
  dualZone: DS.attr('boolean'),
  am: DS.attr('boolean'),
  fm: DS.attr('boolean'),
  cd: DS.attr('boolean'),
  mp3: DS.attr('boolean'),
  leather: DS.attr('boolean'),
  heatedSeatsFront: DS.attr('boolean'),
  heatedSeatsRear: DS.attr('boolean'),
  roofRack: DS.attr('boolean'),
  runningBoards: DS.attr('boolean'),
  towPackage: DS.attr('boolean'),
  recentBrakes: DS.attr('boolean'),
  recentTires: DS.attr('boolean'),
  recentPaint: DS.attr('boolean'),
  recentTimingBelt: DS.attr('boolean'),
  specialFeatures: DS.attr('string'),
  niceToHave: DS.attr('string'),
  extras: DS.attr('string'),
  
  photos: DS.hasMany('BCAuto.Photo'),
  registrants: DS.hasMany('BCAuto.Registrant'),
  solicitations: DS.hasMany('BCAuto.Solicitation'),
  
  name: function() {
    return [this.get('year'), this.get('make'), this.get('model')].compact().join(" ");
  }.property('year', 'make', 'model')
});
