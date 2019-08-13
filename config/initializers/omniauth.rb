OmniAuth.config.full_host = 'https://rusling.dk'
OmniAuth.config.logger = Rails.logger if Rails.env.development?
OmniAuth.config.failure_raise_out_environments = %w[development staging production]

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

  begin
    data = idp_metadata_parser.parse_remote_to_hash(
      "https://adfs.srv.aau.dk/federationmetadata/2007-06/federationmetadata.xml"
    ).merge({
      issuer: Rails.application.credentials.aau_saml_issuer,
      name_identifier_format: "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified",
    })
    puts Rails.application.credentials.aau_saml_issuer
    puts Rails.application.credentials.aau_saml_issuer
    puts Rails.application.credentials.aau_saml_issuer
    puts Rails.application.credentials.aau_saml_issuer

    provider(
      :saml,
      data
    )
  rescue SocketError => _e
    # Do nothing, adfs is not available currently.
    # TODO: Implement filebased-cache for restarts where adfs may be down, etc.
    #       This is a hack because I'm on an airplane currently, which is great, but no real internet to sync this stuff.
  end
end
