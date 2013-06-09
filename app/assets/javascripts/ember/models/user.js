BCAuto.User = DS.Model.extend({
  nameFirst: DS.attr('string'),
  nameMiddle: DS.attr('string'),
  nameLast: DS.attr('string'),
  email: DS.attr('string'),
  isAdmin: DS.attr('boolean'),
  telephones: DS.hasMany('BCAuto.Telephone'),
  logins: DS.hasMany('BCAuto.Login'),
  solicitations: DS.hasMany('BCAuto.Solicitation'),
  
  name: function() {
    return [this.get('nameFirst'), this.get('nameMiddle'), this.get('nameLast')].compact().join(" ");
  }.property('nameFirst', 'nameMiddle', 'nameLast')
});

BCAuto.User.FIXTURES = [
  {
    id: "e26e9579-d5f3-4d14-b137-05e50abcce45",
    nameFirst: "Chas.",
    nameLast: "Munat",
    email: "chas@munat.com",
    isAdmin: true,
    telephone_ids: [
      "df9e8fee-24d8-4522-8796-d2b297c2adf0",
      "88f8fe3f-0c42-4573-ae0f-c10bb9eaca1a"
    ],
    login_ids: [
      "7b3aab31-897c-4fcb-be9a-45180e3461d9",
      "cc2f03cb-96b3-452b-8a40-0b9d55157925",
      "d0d55694-4b2c-473b-b0ec-37e6c58e36e2"
    ]
  },
  {
    id: "f4f06596-2a3f-4bc1-8075-2a0ad048359a",
    nameFirst: "Betty",
    nameLast: "Boop",
    email: "betty@example.com",
    isAdmin: false,
    telephone_ids: [ "3cc02a4f-1d3c-40f8-86b6-f259246df05f" ],
    login_ids: [ "c73fe329-58c7-4d6b-8817-d50084af02af" ],
    solicitation_ids: [ "efc2b1b7-a74b-45cd-800b-46b171184c09" ]
  },
  {
    id: "30344903-3aaa-4134-9400-dd8916e1406a",
    nameFirst: "Sally",
    nameLast: "Smithers",
    email: "sally@example.com",
    isAdmin: false,
    telephone_ids: [ "5b15043c-d0e8-4f98-a602-af8fb58408dd" ],
    login_ids: [ "8a6412bb-8987-42cc-9361-922dbb1c62d7" ],
    solicitation_ids: [ "9f7a9b01-43be-4f69-a5be-718f810d87b3" ]
  },
  {
    id: "3ea4f0d9-2da1-4038-afc1-95028d323ae6",
    nameFirst: "Janey",
    nameLast: "Johnson",
    email: "janey@example.com",
    isAdmin: false,
    telephone_ids: [ "c543bf61-396e-4e42-82bb-45899c81afe2" ],
    login_ids: [ "0480f215-8ded-4552-a86b-b8ad8b141ee4" ],
    solicitation_ids: [ "57694ead-972f-4fca-9e93-f941f13c9114" ]
  }
];