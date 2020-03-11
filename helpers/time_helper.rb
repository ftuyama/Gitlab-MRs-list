def calculate_time_ago(time)
  seconds_ago = Time.now - Time.parse(time)
  hours_ago = (seconds_ago % 86400 / 3600).to_i
  days_ago = (seconds_ago / 86400).to_i

  (days_ago > 0 ? "#{days_ago}d " : "") + (hours_ago > 0 ? "#{hours_ago}h " : "") + "ago"
end
