require 'digest/sha1'
require_relative '../config'

def digest(api_key, params = {})
  query_string = ''
  params.keys.sort.each do |key|
    query_string += key.to_s + '=' + params[key].to_s + '&'
  end
  query_string.chop!
  hashkey = Digest::SHA1.hexdigest (query_string + '&' + api_key)
end

