# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = V1::Admin::User.create( {name: 'Admin User', email: 'michael@nason.us', password: 'test_password' } )
admin.update_attribute( :admin, true )

forus = V1::Admin::Company.create(
  name: 'ForUs',
  account_sid: TWILIO_SID,
  settings: { account_phone_number: '+15106069589' }
)

forus_employee = V1::Employee.create( {name: 'Michael Nason', phone: '+18179929364', company_id: forus.id } )

hr = V1::Admin::Company.create(
  name: 'HackReactor',
  account_sid: 'AC5482b1ad8f317075aaa8dd8f6f7ca76e',
  settings: { account_phone_number: '+17864310738' }
)