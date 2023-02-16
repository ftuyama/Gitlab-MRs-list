require 'dotenv'
require 'pry'
require_relative 'helpers/input_helper'
require_relative 'helpers/gitlab'

Dotenv.load

module Setup
  extend InputHelper

  GITLAB_CONFIG = %w[
    GITLAB_URL
    GITLAB_TOKEN
    GITLAB_DEV_IDS
  ]

  def run
    if ENV['GITLAB_URL'].nil?
      puts "Please enter the Gitlab URL (for example https://gitlab.com/api/v4):"
      write_to_env_file('GITLAB_URL', get_input)
    end

    if ENV['GITLAB_TOKEN'].nil?
      puts "Please enter the Gitlab TOKEN (generate it on https://gitlab.trainline.tools/-/profile/personal_access_tokens)"
      write_to_env_file('GITLAB_TOKEN', get_input)
    end

    if ENV['GITLAB_DEV_IDS'].nil?
      return puts "Please run setup again" if ENV['GITLAB_TOKEN'].nil?

      puts "Please type the Gitlab usernames (separated by ','):"
      users = GitlabService.fetch_users(get_input_list)
      write_to_env_file('GITLAB_DEV_IDS', users.to_s)
    end
  end

  module_function :run
end

Setup.run
