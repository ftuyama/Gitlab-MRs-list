require 'pry'
require 'colorize'
require_relative 'helpers/gitlab'
require_relative 'helpers/time_helper'

module Terminal
  extend TimeHelper

  SEPARATOR = ('-' * 100).yellow

  def mergeable(merge_request)
    merge_request &&
      !merge_request.has_conflicts &&
      !merge_request.work_in_progress &&
      merge_request.merge_status == 'can_be_merged' &&
      merge_request.blocking_discussions_resolved
  end

  def label_format(labels)
    labels.map do |label|
      "[#{label}]".light_magenta
    end.join
  end

  def run
    previous_author = nil
    merge_requests = GitlabService.fetch_merge_requests

    merge_requests.each do |merge_request|
      if previous_author != merge_request.author.username
        previous_author = merge_request.author.username
        puts SEPARATOR
      end

      upvotes = merge_request.upvotes > 0 ? "#{merge_request.upvotes}★".cyan : ''
      mergeable = mergeable(merge_request) ? '✓'.green : '✗'.red
      labels = merge_request.labels
      time_ago = calculate_time_ago(merge_request.created_at)

      puts """    #{merge_request.web_url.cyan}
        #{merge_request.author.username.blue} - #{merge_request.title}
        #{mergeable} #{merge_request.user_notes_count}C    #{time_ago}  #{upvotes}     #{label_format(labels)}
      """
    end

    puts SEPARATOR
  end

  module_function :run, :mergeable, :label_format
end

Terminal.run
