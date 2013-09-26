# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# NOTE THESE ARE FOR TESTING AND NEED TO BE UPDATED BEFORE GOING TO PRODUCTION

admin = V1::Admin::User.create( {name: 'Admin User', email: 'michael@nason.us', password: 'test_password' } )
admin.update_attribute( :admin, true )

user1 = V1::Admin::User.new( {name: 'David ForUs', email: 'forus@nason.us', password: 'test_password' } )
user1.create_company({
  name: 'ForUs',
  account_sid: TWILIO_SID,
  settings:{
    autoresponder: 'Thanks for joining the [company] mobile directory, [name]! Visit [link] to get started',
    responder_link_root: 'www.forusall.com',
    account_phone_number: '+15106069589'
  }
})
user1.save

user2 = V1::Admin::User.new( {name: 'Michael Reactor', email: 'hr@nason.us', password: 'test_password' } )
user2.create_company(
  name: 'Hack Reactor',
  account_sid: HR_SUB_SID,
  settings: {
    autoresponder: 'Thanks for joining the [company] mobile directory, [name]! Visit [link] to get started',
    responder_link_root: 'www.hackreactor.com',
    account_phone_number: '+17864310738'
  }
)
user2.save