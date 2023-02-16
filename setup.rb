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

  def setup_credentials
    if ENV['GITLAB_URL'].nil?
      url = get_input("Please enter the Gitlab URL (for example https://gitlab.com/api/v4):")
      write_to_env_file('GITLAB_URL', url)
    end

    if ENV['GITLAB_TOKEN'].nil?
      token = get_input("Please enter the Gitlab TOKEN (generate it on https://gitlab.trainline.tools/-/profile/personal_access_tokens)")
      write_to_env_file('GITLAB_TOKEN', token)
    end
  end

  def setup_users
    while get_letter_input("Do you want to find devs? (y/n)") == 'y'
      user = get_input("Type his name:")
      puts GitlabService.fetch_user(user).to_h
    end

    if get_letter_input("Do you want to setup the devs? (y/n)") == 'y'
      users_list = get_input_list("Please type the Gitlab usernames (separated by ','):")
      users = GitlabService.fetch_users(users_list)
      write_to_env_file('GITLAB_DEV_IDS', users.to_s)
    end
  end

  def run
    setup_credentials

    return puts "Please run setup again" if ENV['GITLAB_TOKEN'].nil?

    setup_users
  end

  module_function :run, :setup_credentials, :setup_users
end

Setup.run
