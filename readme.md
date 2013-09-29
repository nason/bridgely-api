# Bridgely API

_This is a work in progress!_

This is the backend API for [Bridgely](https://github.com/nason/bridgely/).

Environment variables must be configured for Bridgely-API to communicate with Twilio:

1. Create a new application.yml file in the config folder - 'touch config/application.yml'

2. Add application configuration variables here, as shown below:
  <tt>TWILIO_SID: "123abc"</tt>
  <tt>TWILIO_AUTH_TOKEN: "abc123"</tt>
  <tt>TWILIO_APP_SID: "a1b2c3"</tt>
  * Note: you will need to create a Twilio app with the SMS status and SMS inbound URLs configured to point to your deployment.
  
  * You can group these envirionments in test, development, and production if you need

### Ruby version
2.0.0

### Dependencies
- Rails 4
- Rails-API
- Active Model Serializers
- Twilio-Ruby
- Devise
- BCrypt-Ruby
- Figaro
- PostgreSQL

### Configuration
<tt>bundle install</tt>

If the frontend is served from the public folder you can disable CORS headers. Otherwise, leave them on and whitelist trusted origins in <tt>app/application_controller.rb</tt>

Update <tt>db/seeds.rb</tt> to setup your admin user, and any companies or company users you may need to import.

Bridgely API creates a Twilio subaccount for each company. If you need to transfer a number, you'll need to open <tt>rails console</tt> and [follow Twilio's excellent documentation](https://www.twilio.com/docs/api/rest/subaccounts#exchanging-numbers).

### Database creation
<tt>rake db:schema:load</tt>

### Database initialization
<tt>rake db:seed</tt>

### Services (job queues, cache servers, search engines, etc.)
Coming soon!

### Deployment instructions
Make sure your environment variables are set, and <tt>rails server</tt>. You can <tt>rake figaro:heroku</tt> to push environment variables to Heroku.

*SSL is highly reccomended.* You'll have to configure that on your own...

Your Twilio account must be verified and funded in order for this API to send or receive any messages, or to create any subaccounts. See [Twilio's pricing page](https://www.twilio.com/sms/pricing) for information on operating costs.

