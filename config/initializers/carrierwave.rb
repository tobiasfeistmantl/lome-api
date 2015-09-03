CarrierWave.configure do |config|
	if Rails.env.production?
		config.fog_directory = ENV["AWS_BUCKET"]
		config.fog_credentials = {
			provider: 'AWS',
			aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
			aws_secret_access_key: ENV["AWS_SECRECT_ACCESS_KEY"],
			region: ENV["AWS_REGION"],
			host: ENV["AWS_HOST"],
			endpoint: ENV["AWS_ENDPOINT"]
		}

		config.storage = :fog
	else
		config.storage = :file
	end

	if Rails.env.test?
		config.enable_processing = false
	end
end