# Bridgely API

_This is a work in progress!_

Environment variables must be configured for Bridgely-API to communicate with Twilio:

1. Create a new application.yml file in the config folder - 'touch config/application.yml'

2. Add application configuration variables here, as shown below:
  <tt>TWILIO_SID: "123abc"</tt>
  <tt>TWILIO_AUTH_TOKEN: "abc123"</tt>
  * Note: you can group these in test, development, and production if you need

### Ruby version
4.0.0

### Configuration
<tt>bundle install</tt>

### Database creation
<tt>rake db:migrate</tt>
-or-
<tt>rake db:schema:load</tt>

### Database initialization
<tt>rake db:seed</tt>

### Services (job queues, cache servers, search engines, etc.)
Coming soon!

### Deployment instructions
<tt>rake figaro:heroku</tt> to push environment variables to Heroku
