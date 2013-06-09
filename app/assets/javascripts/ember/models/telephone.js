BCAuto.Telephone = DS.Model.extend({
  digits: DS.attr('string'),
  usage: DS.attr('string'),
  user: DS.belongsTo('BCAuto.User')
});

BCAuto.Telephone.FIXTURES = [
  {
    id: "df9e8fee-24d8-4522-8796-d2b297c2adf0",
    digits: "2069253872",
    usage: "mobile",
    user_id: "e26e9579-d5f3-4d14-b137-05e50abcce45"
  },
  {
    id: "88f8fe3f-0c42-4573-ae0f-c10bb9eaca1a",
    digits: "2069253873",
    usage: "fax",
    user_id: "e26e9579-d5f3-4d14-b137-05e50abcce45"
  },
  {
    id: "3cc02a4f-1d3c-40f8-86b6-f259246df05f",
    digits: "5037215646",
    usage: "mobile",
    user_id: "f4f06596-2a3f-4bc1-8075-2a0ad048359a"
  },
  {
    id: "5b15043c-d0e8-4f98-a602-af8fb58408dd",
    digits: "2229074456",
    usage: "mobile",
    user_id: "30344903-3aaa-4134-9400-dd8916e1406a"
  },
  {
    id: "c543bf61-396e-4e42-82bb-45899c81afe2",
    digits: "2129937123",
    usage: "mobile",
    user_id: "3ea4f0d9-2da1-4038-afc1-95028d323ae6"
  },
];