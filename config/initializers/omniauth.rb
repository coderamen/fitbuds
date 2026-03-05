Rails.application.config.middleware.use OmniAuth::Builder do
  begin
    require 'omniauth-facebook'

    app_key = ENV['FACEBOOK_APP_KEY'].to_s
    app_secret = ENV['FACEBOOK_APP_SECRET'].to_s

    if !app_key.empty? && !app_secret.empty?
      provider :facebook, app_key, app_secret
    end
  rescue StandardError => e
    Rails.logger.warn("OmniAuth Facebook disabled: #{e.class}: #{e.message}") if defined?(Rails.logger)
  end
end
