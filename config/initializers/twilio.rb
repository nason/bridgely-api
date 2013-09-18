# Load Twilio account keys from environment variables, in this case we are using Figaro to set them.

Twilio.sid =        ENV["TWILIO_SID"]
Twilio.auth_token = ENV["TWILIO_AUTH_TOKEN"]

# Alternatively, this could look like:
# Twilio.sid =        Figaro.env.twilio_sid
# Twilio.auth_token = Figaro.env.twilio_auth_token