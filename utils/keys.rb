require 'json'
require 'pry'

def flatten_hash(hash)
  hash.each_with_object({}) do |(k, v), h|
    if v.is_a? Hash
      flatten_hash(v).map do |h_k, h_v|
        h["#{k}.#{h_k}".to_sym] = h_v
      end
    else
      h[k] = v
    end
  end
end

file = File.read(ENV['GREP_FILE'])
locales = JSON.parse(file)
flat_locales = flatten_hash(locales)

keys = flat_locales.select do |_, locale|
  locale.include? ENV['EXP']
end.keys

puts keys
