require 'dotenv'
require 'gitlab'
require 'json'
require 'parallel'

Dotenv.load
AUTHOR_IDS = JSON.parse(ENV['GITLAB_TEAM_IDS'])

Gitlab.configure do |config|
  config.endpoint       = ENV['GITLAB_URL']
  config.private_token  = ENV['GITLAB_TOKEN']
end

def fetch_users
  [0, 1, 2, 3, 4, 5, 6].map do |page|
    Gitlab.users(page: page, per_page: 5000).map do |u|
      [u.id, u.name]
    end
  end.flatten
end

def fetch_sample_merge_request
  Gitlab.user_merge_requests(state: :opened, scope: :all, author_id: 787).sample
end

def fetch_merge_requests
  Parallel.map(AUTHOR_IDS, in_threads: 5) do |author_id|
    Gitlab.user_merge_requests(state: :opened, scope: :all, author_id: author_id)
  end.flatten
end
