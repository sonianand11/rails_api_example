# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    
    if Rails.env.development? || Rails.env.test?
      origins "*"
    else
      # TODO: set the origins to allow accessing resources in production
      # origins 'https://my-app.com', 'another-trusted-comain.com'
    end

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
    # resource '/users',
    #   headers: :any,
    #   methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end