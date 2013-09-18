# Load Twilio account keys from environment variables, in this case we are using Figaro to set them.
# Run rake firago:heroku to push kets to heroku

twilio_sid =        ENV["TWILIO_SID"]
twilio_auth_token = ENV["TWILIO_AUTH_TOKEN"]

# Instantiate twilio client

@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_auth_token

# Alternatively, this could look like:
# Twilio.sid =        Figaro.env.twilio_sid
# Twilio.auth_token = Figaro.env.twilio_auth_token