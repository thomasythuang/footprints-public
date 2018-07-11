CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Footprints::Application.config.s3['access_key'],
    aws_secret_access_key: Footprints::Application.config.s3['secret_access_key'],
    region:                'us-east-2'
  }
  config.fog_directory  = 'footprints-public'
  config.fog_public     = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
