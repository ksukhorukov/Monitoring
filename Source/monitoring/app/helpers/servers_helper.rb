module ServersHelper
  require 'digest/sha1'

  def generate_api_key
    Digest::SHA1.hexdigest(rand(Time.now.to_i).to_s)
  end

end
