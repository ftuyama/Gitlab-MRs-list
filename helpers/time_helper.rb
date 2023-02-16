module TimeHelper
  def calculate_time_ago(time)
    seconds_ago = Time.now - Time.parse(time)
    hours_ago = (seconds_ago % 86400 / 3600).to_i
    days_ago = (seconds_ago / 86400).to_i

    time_ago = ""
    time_ago += "#{days_ago}d " if days_ago > 0
    time_ago += "#{hours_ago}h " if hours_ago > 0
    time_ago += time_ago.empty? ? "now" : "ago"

    time_ago
  end
end
