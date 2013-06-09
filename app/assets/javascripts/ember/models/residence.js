BCAuto.Residence = DS.Model.extend({
  addressLineOne: DS.attr('string'),
  addressLineTwo: DS.attr('string'),
  city: DS.attr('string'),
  zipCode: DS.attr('string'),
  fromMonth: DS.attr('string'),
  fromYear: DS.attr('number'),
  toMonth: DS.attr('string'),
  toYear: DS.attr('number'),
  monthlyRentOrMortgate: DS.attr('number'),
  isOwner: DS.attr('boolean'),
  solicitation: DS.belongsTo('BCAuto.Solicitation')
});

BCAuto.Residence.FIXTURES = [
  {
    id: "11551a48-ff60-4624-9c8e-f5b21f228385",
    addressLineOne: "312 Elm St.",
    city: "Portland",
    zipCode: "97209",
    fromMonth: 1,
    fromYear: 1985,
    toMonth: 10,
    toYear: 2011,
    monthlyRentOrMortgate: 1590,
    isOwner: false,
    solicitation_id: "efc2b1b7-a74b-45cd-800b-46b171184c09"
  },
  {
    id: "72e368b9-df53-4cf0-8b9b-516132846702",
    addressLineOne: "11001 Manchester Ave. S.",
    addressLineTwo: "Apt. 1123",
    city: "Portland",
    zipCode: "97219",
    fromMonth: 10,
    fromYear: 2011,
    monthlyRentOrMortgate: 2100,
    isOwner: false,
    solicitation_id: "efc2b1b7-a74b-45cd-800b-46b171184c09"
  },
  {
    id: "40182ac2-67fd-4ef9-8543-88d4f3b16f64",
    addressLineOne: "222-A Jones Road",
    city: "Portland",
    zipCode: "97212",
    fromMonth: 4,
    fromYear: 2003,
    toMonth: 6,
    toYear: 2010,
    monthlyRentOrMortgate: 1100,
    isOwner: false,
    solicitation_id: "9f7a9b01-43be-4f69-a5be-718f810d87b3"
  },
  {
    id: "00726c6c-8959-4bab-8a2c-11981d79cfae",
    addressLineOne: "75 Main Ct.",
    city: "Portland",
    zipCode: "97203",
    fromMonth: 6,
    fromYear: 2010,
    monthlyRentOrMortgate: 1745,
    isOwner: true,
    solicitation_id: "9f7a9b01-43be-4f69-a5be-718f810d87b3"
  },
  {
    id: "8d046a1d-dffd-4d64-a60f-c047e4b8e9cd",
    addressLineOne: "518 George Ln.",
    city: "Portland",
    zipCode: "97206",
    fromMonth: 4,
    fromYear: 2007,
    toMonth: 6,
    toYear: 2008,
    monthlyRentOrMortgate: 925,
    isOwner: false,
    solicitation_id: "57694ead-972f-4fca-9e93-f941f13c9114"
  },
  {
    id: "",
    addressLineOne: "88 S. Samuels St.",
    city: "Portland",
    zipCode: "97211",
    fromMonth: 6,
    fromYear: 2008,
    monthlyRentOrMortgate: 1200,
    isOwner: false,
    solicitation_id: "57694ead-972f-4fca-9e93-f941f13c9114"
  }
];