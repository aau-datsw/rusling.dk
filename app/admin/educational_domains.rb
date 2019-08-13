ActiveAdmin.register EducationalDomain do
  permit_params :primary_menu_id, :default_page_id, :name, :domain, :primary_color, :secondary_color, educations: []
  includes :primary_menu, :default_page

  form title: 'Side' do |f|
    inputs 'Siden' do
      f.input :default_page, as: :select, collection: f.object.pages.pluck(:title, :id), include_blank: false
      f.input :name
      f.input :domain
      f.input :primary_color
      f.input :secondary_color
      f.input :educations, as: :array
    end
    inputs 'Menuer' do
      f.input :primary_menu, as: :select, collection: f.object.menus.pluck(:name, :id), include_blank: false
    end
    actions
  end

  index do
    selectable_column
    column :name
    column :domain if current_user.system_admin?
    column :default_page
    column :primary_menu
    column :educations
    column 'Colors' do |ed|
      raw([
        "primary_color: #{ed.primary_color || 'N/A'}",
        "secondary_color: #{ed.secondary_color || 'N/A'}"
      ].join('<br />'))
    end

    actions
  end

  controller do
    def scoped_collection
      if current_user.system_admin?
        end_of_association_chain
      else
        end_of_association_chain.where(id: [current_user.educational_domain_id])
      end
    end
  end
end
