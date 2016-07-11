OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '669387803208484', '5f32d51f274ba47c88eb7cdb07b03781'
end