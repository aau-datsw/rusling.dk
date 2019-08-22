ActiveAdmin.register Page do
  includes :educational_domain
  permit_params do
    params = [:slug, :title, :view_file, :content, accordion_items_attributes: [:title, :content, :_destroy, :id]]
    params += [:educational_domain_id] if current_user.system_admin?
    params
  end

  index do
    selectable_column
    column :slug
    column :title
    column 'content' do |p|
      if p.view_file == 'accordion'
        "Accordion: #{p.accordion_items.count} stk"
      else
        truncate(p.content, omision: '...', length: 100)
      end
    end

    column :educational_domain if current_user.system_admin?
    actions
  end

  form title: 'Page' do |f|
    inputs 'Siden' do
      f.input :educational_domain, as: :select, collection: EducationalDomain.all, include_blank: false if current_user.system_admin?
      f.input :slug
      f.input :title
      f.input :view_file, as: :select, collection: [:index, :accordion, :contacts, :frontpage, :show], include_blank: false
    end
    inputs 'Indhold' do
      f.input :content, as: :quill_editor

      if f.object.view_file == 'accordion'
        f.has_many :accordion_items, allow_destroy: true do |g|
          g.input :title
          g.input :content
        end
      end
    end
    actions
  end

  scope_to(if: -> { current_user.domain_admin? }) do
    current_user.educational_domain
  end
end
