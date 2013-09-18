# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = V1::Admin::User.create( {name: 'Admin User', email: 'michael@nason.us', password: 'test_password' } )
admin.update_attribute( :admin, true )
