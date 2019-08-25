ActiveAdmin.register Menu do
  includes :educational_domain

  permit_params do
    permitted = [:name, menu_items_attributes: [:link, :name, :image_url, :description, :position, :overlay_color, :text_color, :_destroy, :id]]
    permitted << :educational_domain_id if current_user.system_admin?
    permitted
  end

  form do |f|
    inputs 'Menu' do
      f.input :name
      f.has_many :menu_items, allow_destroy: true, sortable: :position do |g|
        g.input :link
        g.input :name
        g.input :image_url
        g.input :description
        g.input :text_color
        g.input :overlay_color
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
