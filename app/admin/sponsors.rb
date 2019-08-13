ActiveAdmin.register Sponsor do
  includes :educational_domain

  permit_params do
    permitted = %i[name logo]
    permitted << :educational_domain_id if current_user.system_admin?
    permitted
  end

  form do |f|
    inputs 'Menu' do
      f.input :educational_domain, as: :select, collection: EducationalDomain.all, include_blank: false if current_user.system_admin?

      f.input :name
      f.input :logo, as: :file
    end

    actions
  end

  index do
    selectable_column
    column :name
    column :logo

    column :educational_domain if current_user.system_admin?
    actions
  end

  scope_to(if: -> { current_user.domain_admin? }) do
    current_user.educational_domain
  end
end
