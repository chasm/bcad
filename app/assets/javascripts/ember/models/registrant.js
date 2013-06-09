BCAuto.Registrant = DS.Model.extend({
  email: DS.attr('string'),
  code: DS.attr('string'),
  expiresAt: DS.attr('date'),
  automobile: DS.belongsTo('BCAuto.Automobile'),
  
  name: function() {
    return this.get('email') + ": " + moment(this.get('expiresAt')).format("D MMM");
  }.property('email', 'expiresAt')
});

BCAuto.Registrant.FIXTURES = [
  {
    id: "cb78e755-20b7-4c59-a4ce-8283112515cb",
    email: "joe@example.com",
    expiresAt: new Date(),
    automobile_id: "399dff7a-090f-4217-a81d-a11aec35f02b"
  },
  {
    id: "fe9c14c7-b4a2-4ea6-ba80-83919a1f3af7",
    email: "sam@example.com",
    expiresAt: new Date(),
    automobile_id: "76ec35b4-1092-4c86-ad5e-91a870426996"
  },
  {
    id: "da23a92c-8dc8-45a6-b78f-4dc20715db53",
    email: "bob@example.com",
    expiresAt: new Date(),
    automobile_id: "4b3ebf42-d50c-4cb5-b57e-701461d4800d"
  },
  {
    id: "4d3468bb-d4d8-4158-bcb4-2e37447b1858",
    email: "tom@example.com",
    expiresAt: new Date(),
    automobile_id: "29c0a8c3-0fe1-48b0-8e13-c30a506ab13b"
  },
  {
    id: "514b5b79-6279-451d-9e2e-bff34774814b",
    email: "tim@example.com",
    expiresAt: new Date(),
    automobile_id: "ac36598b-a2df-4c04-b3c3-014259eac64f"
  },
  {
    id: "0c7e0193-e61a-4dae-b2e0-ab941a677338",
    email: "stu@example.com",
    expiresAt: new Date(),
    automobile_id: "399dff7a-090f-4217-a81d-a11aec35f02b"
  }
];