BCAuto.Store = DS.Store.extend({
  revision: 13,
  adapter: DS.JESTAdapter
});

DS.JESTAdapter.reopen({
  namespace: 'api'
});

// BCAuto.LSAdapter = DS.LSAdapter.extend({
//   namespace: 'bcauto-emberjs'
// });