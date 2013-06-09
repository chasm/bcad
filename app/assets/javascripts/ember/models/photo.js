BCAuto.Photo = DS.Model.extend({
  fileName: DS.attr('string'),
  automobile: DS.belongsTo('BCAuto.Automobile')
});

BCAuto.Photo.FIXTURES = [
  {
    id: "3e3b2597-33bd-4902-985f-3a81dfad68f2",
    fileName: "fjj.png",
    automobile_id: "4b3ebf42-d50c-4cb5-b57e-701461d4800d"
  },
  {
    id: "a8d3ae95-92f0-4335-8185-c2371f5fcf52",
    fileName: "fre.png",
    automobile_id: "4b3ebf42-d50c-4cb5-b57e-701461d4800d"
  },
  {
    id: "5bb0708c-e341-47a9-8940-b67146cd4ad7",
    fileName: "ubr.png",
    automobile_id: "4b3ebf42-d50c-4cb5-b57e-701461d4800d"
  },
  {
    id: "d1e42f6f-6f0f-45dd-b32d-7987ac72812e",
    fileName: "dgr.png",
    automobile_id: "29c0a8c3-0fe1-48b0-8e13-c30a506ab13b"
  },
  {
    id: "a8e96a40-486a-44d9-87ec-a688ffdddb9b",
    fileName: "jtn.png",
    automobile_id: "29c0a8c3-0fe1-48b0-8e13-c30a506ab13b"
  },
  {
    id: "0007d9b7-5fc6-409d-b951-87e649eda052",
    fileName: "gsr.png",
    automobile_id: "29c0a8c3-0fe1-48b0-8e13-c30a506ab13b"
  },
  {
    id: "f578dfd9-2981-4e5d-9b50-01c9f9bb5e29",
    fileName: "fnr.png",
    automobile_id: "399dff7a-090f-4217-a81d-a11aec35f02b"
  },
  {
    id: "e48653ec-0ffb-42d1-89dc-92eb10274fff",
    fileName: "iyj.png",
    automobile_id: "399dff7a-090f-4217-a81d-a11aec35f02b"
  }
];