begin
  require 'sinatra'
  require 'omniauth'
  require 'omniauth-smailex'
rescue LoadError
  require 'rubygems'
  require 'sinatra'
  require 'omniauth'
  require 'omniauth-smailex'
end

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :smailex,
      ENV['CLIENT_ID'],
      ENV['CLIENT_SECRET'],
      {
        :client_options => {
          :site => 'http://localhost.smailex.com:8088'
        }
      }
end

get '/' do
  <<-HTML
  <a href='/auth/smailex'>Sign in with Smailex</a>
  HTML
end

get '/auth/:name/callback' do
  auth = request.env['omniauth.auth']
  puts auth

  # do whatever you want with the information!
  <<-HTML
  <h1>Authenticated with Smailex!</h1>
  <p>Email: #{auth["info"]["email"]}</p>
  <p>Name: #{auth["info"]["name"]}</p>
  HTML
end
