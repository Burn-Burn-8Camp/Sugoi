CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'      # required
  config.fog_credentials = {
    provider: 'AWS',      # required
    aws_access_key_id: ENV["aws_access_key_id"],                        
    aws_secret_access_key: ENV["aws_secret_access_key"],                        
    host: ENV["host"], 
    region: ENV["region"]
  }
  config.fog_directory  = ENV["fog_directory"]     # required
  config.fog_public = true
  # optional, defaults to {}
end