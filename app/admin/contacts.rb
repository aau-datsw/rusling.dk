ActiveAdmin.register Contact do
  includes :educational_domain

  permit_params do
    permitted = %i[name number email description image]
    permitted << :educational_domain_id if current_user.system_admin?
    permitted
  end

  form do |f|
    inputs 'Menu' do
      if current_user.system_admin?
        f.input :educational_domain, as: :select, collection: EducationalDomain.all, include_blank: false
      end

      f.input :name
      f.input :number
      f.input :email
      f.input :description
      f.input :image
    end

    actions
  end

  index do
    selectable_column
    column :name
    column :email

    column :educational_domain if current_user.system_admin?
    actions
  end

  scope_to(if: -> { current_user.domain_admin? }) do
    current_user.educational_domain
  end
end
