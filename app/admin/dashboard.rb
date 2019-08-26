ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Næste event' do
          para "Næste event er #{current_user.domain_admin? ? current_user.educational_domain.events.upcoming.first&.pretty_display : Event.upcoming.first&.pretty_display}"
        end
      end

      column do
        panel 'Users' do
          para "Der er #{current_user.domain_admin? ? current_user.educational_domain.users.count : User.count} bruger med adgang."
        end
      end

      column do
        panel 'Domæner og Studier' do
          para "Der er i alt #{EducationalDomain.count - 1} studier aktive på rusling.dk"
        end
      end
    end
  end
end
