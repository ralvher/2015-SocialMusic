if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAIMHLP4NDGMRJJYTQ'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['socialmusic']
  end
end