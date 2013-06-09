BCAuto.Login = DS.Model.extend({
  session: DS.attr('string'),
  ipAddress: DS.attr('string'),
  userAgent: DS.attr('string'),
  referer: DS.attr('string'),
  loggedInAt: DS.attr('date'),
  loggedOutAt: DS.attr('date'),
  user: DS.belongsTo('BCAuto.User')
});

BCAuto.Login.FIXTURES = [
  {
    id: "7b3aab31-897c-4fcb-be9a-45180e3461d9",
    loggedInAt: new Date(2013,4,27),
    loggedOutAt: new Date(2013,4,28),
    user_id: "e26e9579-d5f3-4d14-b137-05e50abcce45"
  },
  {
    id: "cc2f03cb-96b3-452b-8a40-0b9d55157925",
    loggedInAt: new Date(2013,4,28),
    loggedOutAt: new Date(2013,4,29),
    user_id: "e26e9579-d5f3-4d14-b137-05e50abcce45"
  },
  {
    id: "d0d55694-4b2c-473b-b0ec-37e6c58e36e2",
    loggedInAt: new Date(2013,4,29),
    loggedOutAt: new Date(2013,4,30),
    user_id: "e26e9579-d5f3-4d14-b137-05e50abcce45"
  },
  {
    id: "c73fe329-58c7-4d6b-8817-d50084af02af",
    loggedInAt: new Date(2013,4,30),
    user_id: "f4f06596-2a3f-4bc1-8075-2a0ad048359a"
  },
  {
    id: "8a6412bb-8987-42cc-9361-922dbb1c62d7",
    loggedInAt: new Date(2013,4,30),
    user_id: "30344903-3aaa-4134-9400-dd8916e1406a"
  },
  {
    id: "0480f215-8ded-4552-a86b-b8ad8b141ee4",
    loggedInAt: new Date(2013,4,30),
    user_id: "3ea4f0d9-2da1-4038-afc1-95028d323ae6"
  }
];