Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # for react and vite to send requests
    origins 'http://localhost:3000', 'http://localhost:5173'
    #allowsthe response for all routes or api calls
    resource '*',
      headers: :any,
      expose: ['Authorization'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
      #head for preflight requests
      #head for checking resourese sataus
  end
end
