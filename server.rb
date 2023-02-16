require 'sinatra'
require 'pry'
require 'json'
require_relative 'helpers/gitlab'

Tilt.register Tilt::ERBTemplate, 'html.erb'
set :port, 4000

get '/' do
  erb :index
end

get '/users' do
  erb :users, locals: { users: GitlabService.list_users }
end

get '/mr' do
  erb :mr, locals: { merge_request: GitlabService.fetch_sample_merge_request }
end

get '/mrs' do
  erb :mrs, locals: { merge_requests: GitlabService.fetch_merge_requests }
end

get '/mr.json' do
  GitlabService.fetch_sample_merge_request.to_hash.to_json
end

get '*' do
  'Not found'
end
