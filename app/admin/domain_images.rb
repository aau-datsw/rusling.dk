ActiveAdmin.register DomainImage do
  includes :educational_domain

  permit_params do
    permitted = %i[name image]
    permitted << :educational_domain_id if current_user.system_admin?
    permitted
  end

  form do |f|
    inputs 'Menu' do
      f.input :educational_domain, as: :select, collection: EducationalDomain.all, include_blank: false if current_user.system_admin?

      f.input :name
      f.input :image, as: :file
    end

    actions
  end

  index do
    selectable_column
    column :name
    column :image do |di|
      image_tag di.image.variant(resize: "200x200")
    end

    column :educational_domain if current_user.system_admin?
    actions
  end
  show do
    attributes_table do
      row :name
      row :url do |di|
        rails_blob_url(di.image)
      end
      row :image do |di|
        image_tag domain_image.image.variant(resize: "200x200")
      end
    end
  end
  scope_to(if: -> { current_user.domain_admin? }) do
    current_user.educational_domain
  end
end
