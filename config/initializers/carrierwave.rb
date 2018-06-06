CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAIRLTKEXLGRRVX65Q',
    aws_secret_access_key: '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',
    region:                'us-east-2'
  }
  config.fog_directory  = 'footprints-public'
  config.fog_public     = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
