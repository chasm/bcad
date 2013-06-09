BCAuto.Solicitation = DS.Model.extend({
  driversLicenseNumber: DS.attr('string'),
  dateOfBirth: DS.attr('date'),
  socialSecurityNumber: DS.attr('string'),
  loanAmount: DS.attr('number'),
  salesPerson: DS.attr('string'),
  authorized: DS.attr('boolean'),
  status: DS.attr('string'),
  employers: DS.hasMany('BCAuto.Employer'),
  residences: DS.hasMany('BCAuto.Residence'),
  user: DS.belongsTo('BCAuto.User'),
  automobile: DS.belongsTo('BCAuto.Automobile'),
  
  name: function() {
    return [this.get('salesPerson'), numeral(this.get('loanAmount')).format('$0,0[.]00')].compact().join(" ");
  }.property('salesPerson', 'loanAmount')
});

BCAuto.Solicitation.FIXTURES = [
  {
    id: "efc2b1b7-a74b-45cd-800b-46b171184c09",
    driversLicenseNumber: "XYZ4433",
    dateOfBirth: new Date(1994,3,15),
    socialSecurityNumber: "221773456",
    loanAmount: 22000,
    salesPerson: "John Doe",
    authorized: true,
    status: "new",
    employer_ids: [
      "876f37e8-f0bf-4ae0-ac31-edc88f71e8e8",
      "f35e9717-aa6e-413c-8009-5bd562d0a293"
    ],
    residence_ids: [
      "11551a48-ff60-4624-9c8e-f5b21f228385",
      "72e368b9-df53-4cf0-8b9b-516132846702"
    ],
    user_id: "f4f06596-2a3f-4bc1-8075-2a0ad048359a",
    automobile_id: "399dff7a-090f-4217-a81d-a11aec35f02b"
  },
  {
    id: "9f7a9b01-43be-4f69-a5be-718f810d87b3",
    driversLicenseNumber: "YZX7731",
    dateOfBirth: new Date(1976,6,4),
    socialSecurityNumber: "872334765",
    loanAmount: 91000,
    salesPerson: "John Doe",
    authorized: true,
    status: "pending",
    employer_ids: [
      "a0362641-56d8-431d-a687-87fe28301545",
      "1f28263c-cf4b-4b3f-8a45-fa91d507c1ec"
    ],
    residence_ids: [
      "40182ac2-67fd-4ef9-8543-88d4f3b16f64",
      "00726c6c-8959-4bab-8a2c-11981d79cfae"
    ],
    user_id: "30344903-3aaa-4134-9400-dd8916e1406a",
    automobile_id: "aabd3e52-02fb-4b4f-a817-b58065921da9"
  },
  {
    id: "57694ead-972f-4fca-9e93-f941f13c9114",
    driversLicenseNumber: "JZY4688",
    dateOfBirth: new Date(1984,7,8),
    socialSecurityNumber: "921178623",
    loanAmount: 12000,
    salesPerson: "John Doe",
    authorized: true,
    status: "approved",
    employer_ids: [
      "02f00560-ecd0-44a0-a64c-a1725569b8a8",
      "ba0ad2b1-bac8-407f-b653-62953da13e75"
    ],
    residence_ids: [
      "8d046a1d-dffd-4d64-a60f-c047e4b8e9cd",
      "e76ca818-4b14-47fa-9818-1102650d734a"
    ],
    user_id: "3ea4f0d9-2da1-4038-afc1-95028d323ae6",
    automobile_id: "ac36598b-a2df-4c04-b3c3-014259eac64f"
  }
];