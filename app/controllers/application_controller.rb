class ApplicationController < ActionController::Base
  include AuthenticationHelper
  helper :all

  # protect_from_forgery with: :exception
  before_action :set_domain
  before_action :set_locale

private

  def set_domain
    @domain = EducationalDomain.find_by(domain: request.host) || EducationalDomain.default_domain
  end

  def set_locale
    I18n.locale = @domain&.locale&.to_sym || :en
  end
end
