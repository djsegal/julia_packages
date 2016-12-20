if defined? Rack::Cors
  Rails.configuration.middleware.insert_before 0, Rack::Cors do
    allow do
      origins %w[
        https://juliaobserver.com
         http://juliaobserver.com
        https://www.juliaobserver.com
         http://www.juliaobserver.com
        https://d7edrf0ezfn0g.cloudfront.net
         http://d7edrf0ezfn0g.cloudfront.net
      ]
      resource '/assets/*'
    end
  end
end
