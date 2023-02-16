require 'dotenv'
require 'gitlab'
require 'json'
require 'parallel'

Dotenv.load

class GitlabService
  class << self
    AUTHOR_IDS = JSON.parse(ENV['GITLAB_DEV_IDS'] || '[]')

    Gitlab.configure do |config|
      config.endpoint       = ENV['GITLAB_URL']
      config.private_token  = ENV['GITLAB_TOKEN']
    end

    def list_users
      [0, 1, 2].map do |page|
        Gitlab.users(page:, per_page: 100).map do |u|
          [u.id, u.name]
        end
      end.flatten
    end

    def fetch_users(usernames)
      usernames.map do |username|
        search_result = Gitlab.user_search(username)

        raise "User #{username} not found!" if search_result.empty?

        search_result[0]["id"]
      end.compact
    end

    def fetch_sample_merge_request
      Gitlab.user_merge_requests(state: :opened, scope: :all, author_id: 787).sample
    end

    def fetch_merge_requests
      Parallel.map(AUTHOR_IDS, in_threads: 5) do |author_id|
        Gitlab.user_merge_requests(state: :opened, scope: :all, author_id:)
      end.flatten
    end
  end
end
