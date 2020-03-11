require 'sinatra'
require 'pry'
require 'json'
require_relative 'helpers/gitlab.rb'

Tilt.register Tilt::ERBTemplate, 'html.erb'
set :port, 4000

get '/' do
  'Hello world'
end

get '/users' do
  fetch_users.to_s
end

get '/mr' do
  fetch_sample_merge_request.to_hash.to_json
end

get '/gitlab' do
  erb :mrs, locals: { merge_requests: fetch_merge_requests }
end

get '*' do
  'Not found'
end
