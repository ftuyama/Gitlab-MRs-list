module InputHelper
  def prompt_input(string)
    puts string if !string.empty?
  end

  def get_input(string = "")
    prompt_input(string)
    gets.chomp
  end

  def get_input_list(string = "")
    prompt_input(string)
    get_input.split(',')
  end

  def get_letter_input(string = "")
    prompt_input(string)
    gets.chomp.downcase
  end

  def write_to_env_file(env_variable, env_value)
    # Append content to a file
    File.open(".env", "a+") do |f|
      f.write("#{env_variable}='#{env_value}'\n")
    end
  end
end
