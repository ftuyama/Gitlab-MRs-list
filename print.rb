require 'colorize'
require_relative 'helpers/gitlab.rb'
require_relative 'helpers/time_helper.rb'

merge_requests = fetch_merge_requests
previous_author = nil
separator = ('-' * 100).yellow

merge_requests.each do |merge_request|
  if previous_author != merge_request.author.username
    previous_author = merge_request.author.username
    puts separator
  end

  upvotes = merge_request.upvotes > 0 ? "#{merge_request.upvotes}★".cyan : ''
  mergeable = merge_request.merge_status == 'can_be_merged' ? '✓'.green : '✗'.red
  time_ago = calculate_time_ago(merge_request.created_at)

  puts """    #{merge_request.web_url.cyan}
    #{merge_request.author.username.blue} - #{merge_request.title}
    #{mergeable} #{merge_request.user_notes_count}C    #{time_ago}  #{upvotes}
  """
end

puts separator
