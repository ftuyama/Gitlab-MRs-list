module InputHelper
  def get_input
    gets.chomp
  end

  def get_input_list
    get_input.split(',')
  end

  def get_letter_input
    gets.chomp.downcase
  end

  def write_to_env_file(env_variable, env_value)
    # Append content to a file
    File.open(".env", "a+") do |f|
      f.write("#{env_variable}='#{env_value}'\n")
    end
  end
end
