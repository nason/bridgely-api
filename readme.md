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

If the frontend is served from the public folder, disable CORS headers. Otherwise, leave them on and whitelist trusted origins

### Database creation
<tt>rake db:schema:load</tt>

### Database initialization
<tt>rake db:seed</tt>

### Services (job queues, cache servers, search engines, etc.)
Coming soon!

### Deployment instructions
<tt>rake figaro:heroku</tt> to push environment variables to Heroku
