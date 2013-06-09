# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

database = database || Ashikawa::Core::Database.new do |config|
  config.url = "http://localhost:8529"
end

database["automobiles"].delete
database["employers"].delete
database["logins"].delete
database["photos"].delete
database["registrants"].delete
database["residences"].delete
database["solicitations"].delete
database["telephones"].delete
database["users"].delete

chas = database["users"].create_document({
  _key: SecureRandom.uuid,
  name_first: "Charles",
  name_middle: "F",
  name_last: "Munat",
  email: "chas@munat.com",
  created_at: DateTime.now.to_json
})

weston = database["users"].create_document({
  _key: SecureRandom.uuid,
  name_first: "Weston",
  name_last: "Sanaee",
  email: "westonsanaee@gmail.com",
  created_at: DateTime.now.to_json
})

t1 = database[:telephones].create_document({
  _key: SecureRandom.uuid,
  digits: "206 925 3872",
  usage: "voip",
  user_id: chas.key
})

t2 = database[:telephones].create_document({
  _key: SecureRandom.uuid,
  digits: "44 74 5656 3724",
  usage: "mobile",
  user_id: chas.key
})

l1 = database[:logins].create_document({
  _key: SecureRandom.uuid,
  loggedInAt: DateTime.new(2013,4,27).to_json,
  loggedOutAt: DateTime.new(2013,4,28).to_json,
  user_id: chas.key
})

l2 = database[:logins].create_document({
  _key: SecureRandom.uuid,
  loggedInAt: DateTime.new(2013,4,28).to_json,
  loggedOutAt: DateTime.new(2013,4,29).to_json,
  user_id: chas.key
})

l3 = database[:logins].create_document({
  _key: SecureRandom.uuid,
  loggedInAt: DateTime.new(2013,4,29).to_json,
  loggedOutAt: DateTime.new(2013,4,30).to_json,
  user_id: chas.key
})

l4 = database[:logins].create_document({
  _key: SecureRandom.uuid,
  loggedInAt: Date.new(2013,4,30).to_json,
  user_id: chas.key
})

l5 = database[:logins].create_document({
  _key: SecureRandom.uuid,
  loggedInAt: DateTime.new(2013,4,30).to_json,
  user_id: chas.key
})

l6 = database[:logins].create_document({
  _key: SecureRandom.uuid,
  loggedInAt: DateTime.new(2013,4,30).to_json,
  user_id: chas.key
})

puts weston.check_if_persisted

chas["telephone_ids"] = [ t1.key, t2.key ]
chas["login_ids"] = [ l1.key, l2.key, l3.key, l4.key, l5.key, l6.key ]
chas.save