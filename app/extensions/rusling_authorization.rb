class RuslingAuthorization < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    return true if user.system_admin?

    if subject.is_a?(::User)
      return true if subject == user
    end

    if subject.is_a?(::EducationalDomain)
      return true if subject == user.educational_domain
    end

    if subject.is_a?(::Event)
      if action == :create
        true
      end

      return true if subject.educational_domain == user.educational_domain
    end

    if subject.is_a?(::Page)
      if action == :create
        true
      end

      return true if subject.educational_domain == user.educational_domain
    end

    if subject.is_a?(::Menu)
      return true if subject.educational_domain == user.educational_domain
    end

    if subject.is_a?(::Sponsor)
      if action == :create
        true
      end

      return true if subject.educational_domain == user.educational_domain
    end

    if subject.is_a?(::Contact)
      if action == :create
        true
      end

      return true if subject.educational_domain == user.educational_domain
    end

    if subject.is_a?(::ActiveAdmin::Page)
      return action == :read if subject.name == 'Dashboard'
    end

    return action.in?([:read, :create]) if [Event, Page, Menu, Sponsor, Contact].include?(subject)
    return action.in?([:read]) if [User, EducationalDomain].include?(subject)

    false
  end
end
