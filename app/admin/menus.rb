ActiveAdmin.register Menu do
  includes :educational_domain

  permit_params do
    permitted = [:name, items_attributes: [:link, :name, :image_url, :description]]
    permitted << :educational_domain_id if current_user.system_admin?
    permitted
  end

  form do |f|
    inputs 'Menu' do
      f.input :name
      f.has_many :items, new_record: false, heading: 'Menu Items' do |g|
        g.input :link, label: 'link', placeholder: 'link', hint: false
        g.input :name, label: 'name', placeholder: 'name', hint: false
        g.input :image_url, label: 'image_url', placeholder: 'image_url', hint: false
        g.input :description, label: 'description', placeholder: 'description', hint: false
      end
    end

    actions
  end

  index do
    selectable_column
    column :name

    column :educational_domain if current_user.system_admin?
    actions
  end

  scope_to(if: -> { current_user.domain_admin? }) do
    current_user.educational_domain
  end
end
