OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '669387803208484', '5f32d51f274ba47c88eb7cdb07b03781'
end

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do   
	provider :google_oauth2,
	'539989673347-jkog6n55f70h97dmt9bec8vks57fh6g0.apps.googleusercontent.com',
	'sXofKYIZqXJ8eg8ZI8qcVAAv'
end
