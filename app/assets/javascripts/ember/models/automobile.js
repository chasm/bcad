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

BCAuto.Automobile.FIXTURES = [
  {
    id: "4b3ebf42-d50c-4cb5-b57e-701461d4800d",
    stockNumber: "12345",
    year: 1979,
    make: "BMW",
    model: "2002tii",
    color: "Green",
    style: "sedan",
    price: 6000,
    status: "available",
    doors: 4
  },
  {
    id: "29c0a8c3-0fe1-48b0-8e13-c30a506ab13b",
    stockNumber: "53645",
    year: 1990,
    make: "Mercedes Benz",
    model: "650SL",
    color: "Silver Gray",
    style: "sedan",
    price: 55000,
    status: "available",
    doors: 4
  },
  {
    id: "399dff7a-090f-4217-a81d-a11aec35f02b",
    stockNumber: "98365",
    year: 1999,
    make: "Chevrolet",
    model: "Camaro",
    color: "Fire Engine Red",
    style: "sports car",
    price: 22000,
    status: "available",
    doors: 2,
    solicitation_ids: [ "efc2b1b7-a74b-45cd-800b-46b171184c09" ]
  },
  {
    id: "76ec35b4-1092-4c86-ad5e-91a870426996",
    stockNumber: "15243",
    year: 2005,
    make: "Dodge",
    model: "RAM",
    color: "White",
    style: "pickup truck",
    price: 18000,
    status: "available",
    doors: 4
  },
  {
    id: "ac36598b-a2df-4c04-b3c3-014259eac64f",
    stockNumber: "22354",
    year: 2012,
    make: "Jeep",
    model: "Cherokee",
    color: "Brown and White",
    style: "sports utility vehicle",
    price: 12000,
    status: "available",
    doors: 2,
    solicitation_ids: [ "57694ead-972f-4fca-9e93-f941f13c9114" ]
  },
  {
    id: "56f25d84-1210-4611-adf0-c339ee106fb3",
    stockNumber: "87352",
    year: 2009,
    make: "Volkswagen",
    model: "Golf",
    color: "Black",
    style: "sedan",
    price: 8000,
    status: "available",
    doors: 5
  },
  {
    id: "aabd3e52-02fb-4b4f-a817-b58065921da9",
    stockNumber: "98365",
    year: 2003,
    make: "Ferrari",
    model: "Testarossa",
    color: "Ferrari Red",
    style: "sports car",
    price: 100000,
    status: "available",
    doors: 2,
    solicitation_ids: [ "9f7a9b01-43be-4f69-a5be-718f810d87b3" ]
  },
  {
    id: "ca08f70e-7ef4-41d4-86ec-e9cd86d34ade",
    stockNumber: "22311",
    year: 2001,
    make: "Aston Martin",
    model: "Lagonda",
    color: "Silver and Black",
    style: "sedan",
    price: 120000,
    status: "pending",
    doors: 4
  },
  {
    id: "4692bc2d-9472-4c46-8282-96e62625f256",
    stockNumber: "65437",
    year: 2013,
    make: "BMW",
    model: "Mini Cooper",
    color: "Blue",
    style: "mini",
    price: 21500,
    status: "pending",
    doors: 2
  },
  {
    id: "d824d04d-a384-4b00-bb34-30f388304e99",
    stockNumber: "98376",
    year: 2006,
    make: "Pontiac",
    model: "Firebird",
    color: "Candy Apple Red",
    style: "sports car",
    price: 27000,
    status: "sold",
    doors: 2
  },
  {
    id: "a0aca655-c72e-48a9-8ac8-f6797d3e0191",
    stockNumber: "65376",
    year: 1972,
    make: "Oldsmobile",
    model: "442",
    color: "Beige and Brown",
    style: "sedan",
    price: 43000,
    status: "sold",
    doors: 2
  },
  {
    id: "be8741b7-295a-4c0b-9eac-e24d93c2a83e",
    stockNumber: "26345",
    year: 2008,
    make: "Cadillac",
    model: "Fleetwood",
    color: "Pink",
    style: "sedan",
    price: 33000,
    status: "sold",
    doors: 4
  }
];
