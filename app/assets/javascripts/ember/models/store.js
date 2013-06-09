BCAuto.Store = DS.Store.extend({
  revision: 13,
  adapter: DS.RESTAdapter
});

DS.RESTAdapter.reopen({
  namespace: 'api'
});

// BCAuto.LSAdapter = DS.LSAdapter.extend({
//   namespace: 'bcauto-emberjs'
// });