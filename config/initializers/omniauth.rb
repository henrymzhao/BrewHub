OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '669387803208484', '5f32d51f274ba47c88eb7cdb07b03781'
  provider :google_oauth2, '646725351046-2hhcmosk3vsdl97lq7csfgk6gbtpl2bu.apps.googleusercontent.com', 'wsxaPh_nMJdSStzanrD40Wlq', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
