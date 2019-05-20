ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel "Generate Bills" do
          para "hello"
        end
      end

      column do
        panel "Pay Bills" do
          para "no bill 4 me"
        end
      end

      column do
        panel "Pay Bills" do
          para "no bill 4 me"
        end
      end
    end
  end
end
