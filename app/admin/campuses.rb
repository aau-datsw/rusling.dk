ActiveAdmin.register Campus do
  permit_params do
    permitted = current_user.system_admin? ? %i[university name logo] : []
    permitted
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :university, as: :select, collection: [
        "Aalborg Universitet",
        "Københavns Universitet",
        "Roskilde Universitet",
        "Syddansk Universitet",
        "Danmarks Tekniske Universitet (DTU)",
        "IT Universitetet i København"
      ]
      f.input :logo, as: :file
    end
    actions
  end

  index do
    selectable_column
    column :name
    column :university
    actions
  end
end
