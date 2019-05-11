dom = EducationalDomain.find_or_initialize_by(domain: domain)
dom.colors = {"primary-color" => "#211A52"}
dom.name = 'Rusling.dk'
dom.locale = 'da'
dom.save!

fppage = Page.find_or_create_by(educational_domain: dom, slug: "")
fppage.title = 'rusling.dk'
fppage.content_header = 'Velkommen til rusling.dk'
fppage.content = 'Find din uddannelse i oversigten nedenunder!'
fppage.view_file = "frontpage"

dom.update!(default_page: fppage)
