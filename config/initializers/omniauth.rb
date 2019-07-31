OmniAuth.config.full_host = 'https://rusling.dk'
OmniAuth.config.logger = Rails.logger if Rails.env.development?
OmniAuth.config.failure_raise_out_environments = ['development', 'staging', 'production']

Rails.application.config.middleware.use OmniAuth::Builder do
  idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
  provider :developer unless Rails.env.production?
  provider(
    :github,
    Rails.application.credentials.dig(:login_credentials, :github, :key),
    Rails.application.credentials.dig(:login_credentials, :github, :key),
    scope: 'user,user:email'
  )
  provider(
    :facebook,
    Rails.application.credentials.dig(:login_credentials, :facebook, :key),
    Rails.application.credentials.dig(:login_credentials, :facebook, :key)
  )

  provider(
    :saml,
    idp_metadata_parser.parse_remote_to_hash(
      "https://adfs.srv.aau.dk/federationmetadata/2007-06/federationmetadata.xml"
    ).merge({
      issuer: Rails.application.credentials.aau_saml_issuer,
      name_identifier_format: "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified",
    })
  )
end
