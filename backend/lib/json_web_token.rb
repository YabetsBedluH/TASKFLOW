# backend/lib/json_web_token.rb

class JsonWebToken
  # defines This sets a constant SECRET_KEY that holds a private key used to sign and verify the tokens.
  SECRET_KEY = Rails.application.secret_key_base
  # defines the encode method and payload is the data you want to put it maybe id.
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    # use jwt to encode the 
    JWT.encode(payload, SECRET_KEY)
  end
  # this line makes sure the encoded token is decode 
  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(body)
  rescue
    nil
  end
end
