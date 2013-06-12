require 'bcrypt'

database = database || Ashikawa::Core::Database.new do |config|
  config.url = "http://localhost:8529"
end

database["admins"].delete
database["applicants"].delete
database["automobiles"].delete
database["employers"].delete
database["logins"].delete
database["photos"].delete
database["registrants"].delete
database["residences"].delete
database["solicitations"].delete
database["telephones"].delete

chas_id = SecureRandom.uuid
weston_id = SecureRandom.uuid
applicant1_id = SecureRandom.uuid
applicant2_id = SecureRandom.uuid

pass1 = "12345"
salt1 = BCrypt::Engine.generate_salt
fish1 = BCrypt::Engine.hash_secret(pass1, salt1)

pass2 = "34567"
salt2 = BCrypt::Engine.generate_salt
fish2 = BCrypt::Engine.hash_secret(pass2, salt2)

pass3 = "56789"
salt3 = BCrypt::Engine.generate_salt
fish3 = BCrypt::Engine.hash_secret(pass3, salt3)

pass4 = "78901"
salt4 = BCrypt::Engine.generate_salt
fish4 = BCrypt::Engine.hash_secret(pass4, salt4)

tel1_id = SecureRandom.uuid
tel2_id = SecureRandom.uuid
tel3_id = SecureRandom.uuid
tel4_id = SecureRandom.uuid

log1_id = SecureRandom.uuid
log2_id = SecureRandom.uuid
log3_id = SecureRandom.uuid
log4_id = SecureRandom.uuid
log5_id = SecureRandom.uuid
log6_id = SecureRandom.uuid

reg1_id = SecureRandom.uuid
reg2_id = SecureRandom.uuid
reg3_id = SecureRandom.uuid
reg4_id = SecureRandom.uuid
reg5_id = SecureRandom.uuid
reg6_id = SecureRandom.uuid

auto1_id = SecureRandom.uuid
auto2_id = SecureRandom.uuid
auto3_id = SecureRandom.uuid
auto4_id = SecureRandom.uuid
auto5_id = SecureRandom.uuid
auto6_id = SecureRandom.uuid
auto7_id = SecureRandom.uuid
auto8_id = SecureRandom.uuid
auto9_id = SecureRandom.uuid
auto10_id = SecureRandom.uuid
auto11_id = SecureRandom.uuid
auto12_id = SecureRandom.uuid

photo1_id = SecureRandom.uuid
photo2_id = SecureRandom.uuid
photo3_id = SecureRandom.uuid
photo4_id = SecureRandom.uuid
photo5_id = SecureRandom.uuid
photo6_id = SecureRandom.uuid
photo7_id = SecureRandom.uuid
photo8_id = SecureRandom.uuid
photo9_id = SecureRandom.uuid

sol1_id = SecureRandom.uuid
sol2_id = SecureRandom.uuid
sol3_id = SecureRandom.uuid

emp1_id = SecureRandom.uuid
emp2_id = SecureRandom.uuid
emp3_id = SecureRandom.uuid
emp4_id = SecureRandom.uuid
emp5_id = SecureRandom.uuid
emp6_id = SecureRandom.uuid

res1_id = SecureRandom.uuid
res2_id = SecureRandom.uuid
res3_id = SecureRandom.uuid
res4_id = SecureRandom.uuid
res5_id = SecureRandom.uuid
res6_id = SecureRandom.uuid

database["admins"].create_document({
  _key: chas_id,
  name_first: "Charles",
  name_middle: "F",
  name_last: "Munat",
  email: "chas@munat.com",
  is_superuser: true,
  salt: salt1,
  fish: fish1,
  created_at: DateTime.now.iso8601
})

database["admins"].create_document({
  _key: weston_id,
  name_first: "Weston",
  name_last: "Sanaee",
  email: "westonsanaee@gmail.com",
  is_superuser: false,
  salt: salt2,
  fish: fish2,
  created_at: DateTime.now.iso8601
})

database["applicants"].create_document({
  _key: applicant1_id,
  name_first: "Tom",
  name_middle: "T",
  name_last: "Tomorrow",
  email: "tom@munat.com",
  salt: salt3,
  fish: fish3,
  created_at: DateTime.now.iso8601,
  telephone_ids: [ tel1_id, tel2_id ],
  login_ids: [ log1_id, log2_id, log3_id, log4_id ],
  solicitation_ids: [ sol1_id, sol2_id ],
  employer_ids: [ emp1_id, emp2_id, emp3_id ],
  residence_ids: [ res1_id, res2_id ]
})

database["applicants"].create_document({
  _key: applicant2_id,
  name_first: "Sam",
  name_middle: "S",
  name_last: "Stone",
  email: "sam@munat.com",
  salt: salt4,
  fish: fish4,
  created_at: DateTime.now.iso8601,
  telephone_ids: [ tel3_id, tel4_id ],
  login_ids: [ log5_id, log6_id ],
  solicitation_ids: [ sol3_id ],
  employer_ids: [ emp4_id, emp5_id, emp6_id ],
  residence_ids: [ res3_id, res4_id, res5_id, res6_id ]
})

database["telephones"].create_document({
  _key: tel1_id,
  digits: "206 925 3872",
  usage: "voip",
  applicant_id: applicant1_id
})

database["telephones"].create_document({
  _key: tel2_id,
  digits: "44 74 5656 3724",
  usage: "mobile",
  applicant_id: applicant1_id
})

database["telephones"].create_document({
  _key: tel3_id,
  digits: "503 555 7890",
  usage: "work",
  applicant_id: applicant2_id
})

database["telephones"].create_document({
  _key: tel4_id,
  digits: "503 555 7324",
  usage: "mobile",
  applicant_id: applicant2_id
})

database["logins"].create_document({
  _key: log1_id,
  loggedInAt: DateTime.new(2013,4,27).iso8601,
  loggedOutAt: DateTime.new(2013,4,28).iso8601,
  ip_address: "127.0.0.1",
  referer: "http://localhost:3000/login",
  session: "87cb339ec4903977d02a8cfe466e8d12",
  user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31",
  applicant_id: applicant1_id
})

database["logins"].create_document({
  _key: log2_id,
  loggedInAt: DateTime.new(2013,4,28).iso8601,
  loggedOutAt: DateTime.new(2013,4,29).iso8601,
  ip_address: "127.0.0.1",
  referer: "http://localhost:3000/login",
  session: "87cb339ec4903977d02a8cfe466e8d12",
  user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31",
  applicant_id: applicant1_id
})

database["logins"].create_document({
  _key: log3_id,
  loggedInAt: DateTime.new(2013,4,29).iso8601,
  loggedOutAt: DateTime.new(2013,4,30).iso8601,
  ip_address: "127.0.0.1",
  referer: "http://localhost:3000/login",
  session: "87cb339ec4903977d02a8cfe466e8d12",
  user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31",
  applicant_id: applicant1_id
})

database["logins"].create_document({
  _key: log4_id,
  loggedInAt: Date.new(2013,4,30).iso8601,
  ip_address: "127.0.0.1",
  referer: "http://localhost:3000/login",
  session: "14cb339ec4903977d02a8cfe466e8d12",
  user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31",
  applicant_id: applicant1_id
})

database["logins"].create_document({
  _key: log5_id,
  loggedInAt: DateTime.new(2013,4,30).iso8601,
  ip_address: "127.0.0.1",
  referer: "http://localhost:3000/login",
  session: "99cb339ec4903977d02a8cfe466e8d12",
  user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31",
  applicant_id: applicant2_id
})

database["logins"].create_document({
  _key: log6_id,
  loggedInAt: DateTime.new(2013,4,30).iso8601,
  ip_address: "127.0.0.1",
  referer: "http://localhost:3000/login",
  session: "99cb339ec4903977d02a8cfe466e8d12",
  user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31",
  applicant_id: applicant2_id
})

database["registrants"].create_document({
  _key: reg1_id,
  email: "abby@munat.com",
  expires_at: (DateTime.now.yesterday).iso8601,
  automobile_id: auto1_id
})

database["registrants"].create_document({
  _key: reg2_id,
  email: "benjamin@munat.com",
  expires_at: (DateTime.now.yesterday).iso8601,
  automobile_id: auto1_id
})

database["registrants"].create_document({
  _key: reg3_id,
  email: "carol@munat.com",
  expires_at: (DateTime.now).iso8601,
  automobile_id: auto1_id
})

database["registrants"].create_document({
  _key: reg4_id,
  email: "dave@munat.com",
  expires_at: (DateTime.now.tomorrow).iso8601,
  automobile_id: auto2_id
})

database["registrants"].create_document({
  _key: reg5_id,
  email: "ellen@munat.com",
  expires_at: (DateTime.now.tomorrow).iso8601,
  automobile_id: auto2_id
})

database["registrants"].create_document({
  _key: reg6_id,
  email: "frank@munat.com",
  expires_at: (DateTime.now.tomorrow).iso8601,
  automobile_id: auto3_id
})

database["automobiles"].create_document({
  _key: auto1_id,
  stock_number: "12345",
  year: 1979,
  make: "BMW",
  model: "2002tii",
  color: "Green",
  style: "sedan",
  price: 6000,
  status: "available",
  doors: 4,
  registrant_ids: [ reg1_id, reg2_id, reg3_id ],
  photo_ids: [ photo1_id, photo2_id, photo3_id ]
})

database["automobiles"].create_document({
  _key: auto2_id,
  stock_number: "22311",
  year: 2001,
  make: "Aston Martin",
  model: "Lagonda",
  color: "Silver and Black",
  style: "sedan",
  price: 120000,
  status: "pending",
  doors: 4,
  registrant_ids: [ reg4_id, reg5_id ],
  photo_ids: [ photo4_id, photo5_id, photo6_id ],
  solicitation_ids: [ sol1_id ]
})

database["automobiles"].create_document({
  _key: auto3_id,
  stock_number: "26345",
  year: 2008,
  make: "Cadillac",
  model: "Fleetwood",
  color: "Pink",
  style: "sedan",
  price: 33000,
  status: "sold",
  doors: 4,
  registrant_ids: [ reg6_id ],
  photo_ids: [ photo7_id, photo8_id, photo9_id ],
  solicitation_ids: [ sol2_id, sol3_id ]
})

database["automobiles"].create_document({
  _key: auto4_id,
  stock_number: "53645",
  year: 1990,
  make: "Mercedes Benz",
  model: "650SL",
  color: "Silver Gray",
  style: "sedan",
  price: 55000,
  status: "available",
  doors: 4
})

database["automobiles"].create_document({
  _key: auto5_id,
  stock_number: "98365",
  year: 1999,
  make: "Chevrolet",
  model: "Camaro",
  color: "Fire Engine Red",
  style: "sports car",
  price: 22000,
  status: "available",
  doors: 2
})

database["automobiles"].create_document({
  _key: auto6_id,
  stock_number: "15243",
  year: 2005,
  make: "Dodge",
  model: "RAM",
  color: "White",
  style: "pickup truck",
  price: 18000,
  status: "available",
  doors: 4
})

database["automobiles"].create_document({
  _key: auto7_id,
  stock_number: "22354",
  year: 2012,
  make: "Jeep",
  model: "Cherokee",
  color: "Brown and White",
  style: "sports utility vehicle",
  price: 12000,
  status: "available",
  doors: 2
})

database["automobiles"].create_document({
  _key: auto8_id,
  stock_number: "87352",
  year: 2009,
  make: "Volkswagen",
  model: "Golf",
  color: "Black",
  style: "sedan",
  price: 8000,
  status: "available",
  doors: 5
})

database["automobiles"].create_document({
  _key: auto9_id,
  stock_number: "98365",
  year: 2003,
  make: "Ferrari",
  model: "Testarossa",
  color: "Ferrari Red",
  style: "sports car",
  price: 100000,
  status: "available",
  doors: 2
})

database["automobiles"].create_document({
  _key: auto10_id,
  stock_number: "65437",
  year: 2013,
  make: "BMW",
  model: "Mini Cooper",
  color: "Blue",
  style: "mini",
  price: 21500,
  status: "pending",
  doors: 2
})

database["automobiles"].create_document({
  _key: auto11_id,
  stock_number: "98376",
  year: 2006,
  make: "Pontiac",
  model: "Firebird",
  color: "Candy Apple Red",
  style: "sports car",
  price: 27000,
  status: "sold",
  doors: 2
})

database["automobiles"].create_document({
  _key: auto12_id,
  stock_number: "65376",
  year: 1972,
  make: "Oldsmobile",
  model: "442",
  color: "Beige and Brown",
  style: "sedan",
  price: 43000,
  status: "sold",
  doors: 2
})

database["photos"].create_document({
  _key: photo1_id,
  photo: "#{photo1_id}.png",
  automobile_id: auto1_id
})

database["photos"].create_document({
  _key: photo2_id,
  photo: "#{photo2_id}.png",
  automobile_id: auto1_id
})

database["photos"].create_document({
  _key: photo3_id,
  photo: "#{photo3_id}.png",
  automobile_id: auto1_id
})

database["photos"].create_document({
  _key: photo4_id,
  photo: "#{photo4_id}.png",
  automobile_id: auto2_id
})

database["photos"].create_document({
  _key: photo5_id,
  photo: "#{photo5_id}.png",
  automobile_id: auto2_id
})

database["photos"].create_document({
  _key: photo6_id,
  photo: "#{photo6_id}.png",
  automobile_id: auto2_id
})

database["photos"].create_document({
  _key: photo7_id,
  photo: "#{photo7_id}.png",
  automobile_id: auto3_id
})

database["photos"].create_document({
  _key: photo8_id,
  photo: "#{photo8_id}.png",
  automobile_id: auto3_id
})

database["photos"].create_document({
  _key: photo9_id,
  photo: "#{photo9_id}.png",
  automobile_id: auto3_id
})

database["solicitations"].create_document({
  _key: sol1_id,
  drivers_license_number: "XYZ4433",
  date_of_birth: Date.new(1994,3,15).iso8601,
  social_security_number: "221773456",
  loan_amount: 22000,
  sales_person: "John Doe",
  authorized: true,
  status: "new",
  applicant_id: applicant1_id,
  automobile_id: auto2_id
})

database["solicitations"].create_document({
  _key: sol2_id,
  drivers_license_number: "YZX7731",
  date_of_birth: Date.new(1976,6,4).iso8601,
  social_security_number: "872334765",
  loan_amount: 91000,
  sales_person: "John Doe",
  authorized: true,
  status: "pending",
  applicant_id: applicant1_id,
  automobile_id: auto3_id
})

database["solicitations"].create_document({
  _key: sol3_id,
  drivers_license_number: "JZY4688",
  date_of_birth: Date.new(1984,7,8).iso8601,
  social_security_number: "921178623",
  loan_amount: 12000,
  sales_person: "John Doe",
  authorized: true,
  status: "approved",
  applicant_id: applicant2_id,
  automobile_id: auto3_id
})

database["employers"].create_document({
  _key: emp1_id,
  name_of_company: "Bob's Tires",
  phone_number: "5037214466",
  email: "bob@tires.com",
  web_site_url: "tires.com",
  city: "Portland",
  zip_code: "97211",
  job_title: "Tire guy",
  name_of_supervisor: "Bob Tired",
  from_month: 7,
  from_year: 2010,
  to_month: 9,
  to_year: 2011,
  monthly_pay_before_taxes: 3400,
  applicant_id: applicant1_id
})

database["employers"].create_document({
  _key: emp2_id,
  name_of_company: "Joe's Burgers",
  phone_number: "5032327742",
  email: "joe@burger.com",
  web_site_url: "burger.com",
  city: "Portland",
  zip_code: "97212",
  job_title: "Burger Master",
  name_of_supervisor: "Joe Berger",
  from_month: 7,
  from_year: 2010,
  to_month: 9,
  to_year: 2011,
  monthly_pay_before_taxes: 3400,
  applicant_id: applicant1_id
})

database["employers"].create_document({
  _key: emp3_id,
  name_of_company: "Pete's Pizzas",
  phone_number: "5036663457",
  email: "pete@pizza.com",
  web_site_url: "pizza.com",
  city: "Portland",
  zip_code: "97212",
  job_title: "Tosser",
  name_of_supervisor: "Pete Peetzer",
  from_month: 7,
  from_year: 2010,
  to_month: 9,
  to_year: 2011,
  monthly_pay_before_taxes: 3400,
  applicant_id: applicant1_id
})

database["employers"].create_document({
  _key: emp4_id,
  name_of_company: "Betty's Bowling",
  phone_number: "5039872345",
  email: "betty@bowling.com",
  web_site_url: "bowling.com",
  city: "Portland",
  zip_code: "97212",
  job_title: "Pin Setter",
  name_of_supervisor: "Betty Boling",
  from_month: 7,
  from_year: 2010,
  to_month: 9,
  to_year: 2011,
  monthly_pay_before_taxes: 3400,
  applicant_id: applicant2_id
})

database["employers"].create_document({
  _key: emp5_id,
  name_of_company: "Tom's Tourniquets",
  phone_number: "5037435656",
  email: "tom@tourniquets.com",
  web_site_url: "tourniquets.com",
  city: "Portland",
  zip_code: "97212",
  job_title: "Top Twister",
  name_of_supervisor: "Tom Turnikit",
  from_month: 7,
  from_year: 2010,
  to_month: 9,
  to_year: 2011,
  monthly_pay_before_taxes: 3400,
  applicant_id: applicant2_id
})

database["employers"].create_document({
  _key: emp6_id,
  name_of_company: "Pedro's Pets",
  phone_number: "5036549876",
  email: "pedro@pets.com",
  web_site_url: "pets.com",
  city: "Portland",
  zip_code: "97212",
  job_title: "Personal Petter",
  name_of_supervisor: "Pedro Pett",
  from_month: 7,
  from_year: 2010,
  to_month: 9,
  to_year: 2011,
  monthly_pay_before_taxes: 3400,
  applicant_id: applicant2_id
})

database["residences"].create_document({
  _key: res1_id,
  address_line_one: "312 Elm St.",
  city: "Portland",
  zip_code: "97209",
  from_month: 1,
  from_year: 1985,
  to_month: 10,
  to_year: 2011,
  monthly_rent_or_mortgage: 1590,
  is_owner: false,
  applicant_id: applicant1_id
})

database["residences"].create_document({
  _key: res2_id,
  address_line_one: "11001 Manchester Ave. S.",
  address_line_two: "Apt. 1123",
  city: "Portland",
  zip_code: "97219",
  from_month: 10,
  from_year: 2011,
  monthly_rent_or_mortgage: 2100,
  is_owner: false,
  applicant_id: applicant1_id
})

database["residences"].create_document({
  _key: res3_id,
  address_line_one: "222-A Jones Road",
  city: "Portland",
  zip_code: "97212",
  from_month: 4,
  from_year: 2003,
  to_month: 6,
  to_year: 2010,
  monthly_rent_or_mortgage: 1100,
  is_owner: false,
  applicant_id: applicant2_id
})

database["residences"].create_document({
  _key: res4_id,
  id: "00726c6c-8959-4bab-8a2c-11981d79cfae",
  address_line_one: "75 Main Ct.",
  city: "Portland",
  zip_code: "97203",
  from_month: 6,
  from_year: 2010,
  monthly_rent_or_mortgage: 1745,
  is_owner: true,
  applicant_id: applicant2_id
})

database["residences"].create_document({
  _key: res5_id,
  address_line_one: "518 George Ln.",
  city: "Portland",
  zip_code: "97206",
  from_month: 4,
  from_year: 2007,
  to_month: 6,
  to_year: 2008,
  monthly_rent_or_mortgage: 925,
  is_owner: false,
  applicant_id: applicant2_id
})

database["residences"].create_document({
  _key: res6_id,
  address_line_one: "88 S. Samuels St.",
  city: "Portland",
  zip_code: "97211",
  from_month: 6,
  from_year: 2008,
  monthly_rent_or_mortgage: 1200,
  is_owner: false,
  applicant_id: applicant2_id
})






