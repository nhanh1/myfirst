OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '851294125202-t0eb9ef60fkoum72ml3r282i1j0kc54h.apps.googleusercontent.com', 'UHVPrwSb1zYIDMFphnzdXSCT', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end