OmniAuth.config.full_host = 'https://rusling.dk'
OmniAuth.config.logger = Rails.logger if Rails.env.development?
OmniAuth.config.failure_raise_out_environments = ['development', 'staging', 'production']

Rails.application.config.middleware.use OmniAuth::Builder do
  idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
  provider :developer unless Rails.env.production?
  provider :github,   ENV.fetch('GITHUB_KEY', ''),   ENV.fetch('GITHUB_SECRET', ''), scope: 'user,user:email'
  provider :facebook, ENV.fetch('FACEBOOK_KEY', ''), ENV.fetch('FACEBOOK_SECRET', '')

  provider(
    :saml,
    {
      issuer: ENV.fetch('AAU_SAML_ISSUER', '')
    }.merge(
      idp_metadata_parser.parse_remote_to_hash(
        "https://adfs.srv.aau.dk/federationmetadata/2007-06/federationmetadata.xml"
      )
    )
  )
end
