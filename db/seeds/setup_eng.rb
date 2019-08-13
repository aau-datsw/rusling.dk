engdomain = EducationalDomain.find_or_initialize_by(domain: domain)
engdomain.name = 'Engineering'
engdomain.educations = ["Matematik", "Fysik", "Matematik-Økonomi", "Noget andet"]
engdomain.colors = {"primary_color" => "#4d9e45", "secondary_color" => "#83bb7d"}
engdomain.locale = "da"
engdomain.save

meneng = engdomain.menus.find_or_initialize_by(name: "Eng Menu")
meneng.items = [
    {
      "name" => "FAQ",
      "description" => "",
      "link" => "/faq",
      "image_url" => 'http://placekitten.com/200/200'
    },
    {
      "name" => "How To",
      "description" => "",
      "link" => "/howto",
      "image_url" => 'http://placekitten.com/300/300'
    },
    {
      "name" => "Arrangementer",
      "description" => "",
      "link" => "/events",
      "image_url" => 'http://placekitten.com/1920/1080'
    },
    {
      "name" => "Information",
      "description" => "",
      "link" => "/info",
      "image_url" => 'http://placekitten.com/500/500'
    },
    {
      "name" => "Vigtige Kontakter",
      "description" => "",
      "link" => "/kontakter",
      "image_url" => 'http://placekitten.com/600/600'
    },
    {
      "name" => "Gode Råd",
      "description" => "",
      "link" => "/advice",
      "image_url" => 'http://placekitten.com/700/200'
    }
  ]
meneng.educational_domain = engdomain
meneng.save

# paeng = Page.create(educational_domain: engdomain, title: 'Forside', content: 'Test', view_file: "index")

faqeng_page = Page.find_or_initialize_by(slug: "faq", educational_domain: engdomain)
faneng_page.assign_attributes(title: 'FAQ', content: 'Her er svarene på alle jeres spørgmål!', view_file:"accordion")
faqeng_page.accordion = [
  {
    "title" => "De første par dage",
    "content" => File.read(__dir__ + "/seeds/faq/studiestartsdagen.html")
  },
  {
    "title" => "Rusperioden",
    "content" => File.read(__dir__ + "/seeds/faq/rusperioden.html")
  },
  {
    "title" => "Studiet",
    "content" => File.read(__dir__ + "/seeds/faq/studiet.html")
  },
  {
    "title" => "Eksamen",
    "content" => File.read(__dir__ + "/seeds/faq/eksamen.html")
  }
]
faqeng_page.save

infoeng_page = Page.find_or_initialize_by(slug: "info", educational_domain: engdomain)
infoeng_page.assign_attributes(title: 'info', content: 'En masse informationer!', view_file:"accordion")
infoeng_page.accordion = [
  {
    "title" => "Studiestartsdagen",
    "content" => html_parse(File.read(__dir__ + "/seeds/info/studiestartsdagen.md"), "markdown")
  },
  {
    "title" => "Studenterpolitik",
    "content" => html_parse(File.read(__dir__ + "/seeds/info/studenterpolitik.md"), "markdown")
  }
]
infoeng_page.save

howtoeng_page = Page.find_or_initialize_by(slug: "howto", educational_domain: engdomain)
howtoeng_page.assign_attributes(title: 'info', content: 'En masse informationer!', view_file:"accordion")
howtoeng_page.accordion = [
  {
    "title" => "LaTeX",
    "content" => File.read(__dir__ + "/seeds/howto/latex.html")
  },
  {
    "title" => "WiFi",
    "content" => File.read(__dir__ + "/seeds/howto/wifi.html")
  },
  {
    "title" => "Studiekort",
    "content" => File.read(__dir__ + "/seeds/howto/studiekort.html")
  },
  {
    "title" => "Print",
    "content" => File.read(__dir__ + "/seeds/howto/print.html")
  },
  {
    "title" => "Skema",
    "content" => File.read(__dir__ + "/seeds/howto/skema.html")
  },
  {
    "title" => "Studiemail på telefon",
    "content" => File.read(__dir__ + "/seeds/howto/studiemail.html")
  },
  {
    "title" => "Moodle",
    "content" => File.read(__dir__ + "/seeds/howto/moodle.html")
  }
]
howtoeng_page.save

contactseng_page = Page.find_or_initialize_by(slug: "kontakter", educational_domain: engdomain)
contactseng_page.title = 'Vigtige Kontakter'
contactseng_page.content = 'Her er alle de mennesker der er vigtige!'
contactseng_page.view_file = "contacts"
contactseng_page.accordion = [
  {
    "name" => "Fornavn Efternavn",
    "email" => "sample@email.com",
    "nr" => "12345678",
    "image_url" => 'http://placekitten.com/1920/1080'
  }
]
contactseng_page.save

Page.find_or_initialize_by(slug: "advice", educational_domain: engdomain)
    .update(title: 'Gode råd fra ældre studerende!', content: File.read(__dir__ + "/seeds/advice.html"), view_file: "show")

engdomain.update(primary_menu: meneng, default_page: paeng)
