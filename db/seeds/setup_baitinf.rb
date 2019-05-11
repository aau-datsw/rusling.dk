puts "creating baitixdinf domain"
baitixdinfdomain = EducationalDomain.find_or_initialize_by(domain: domain)
baitixdinfdomain.name = 'Informationsteknologi, Interaktionsdesign og Informatik'
baitixdinfdomain.educations = ["Informationsteknologi", "Interaktionsdesign", "Informatik"]
baitixdinfdomain.colors = {"primary-color" => "#eb7115", "secondary-color" => "#f19c5c"}
baitixdinfdomain.locale = "da"
baitixdinfdomain.save

baitixdinfmenu = baitixdinfdomain.menus.find_or_initialize_by(name: "BaitIxdInf Menu")
baitixdinfmenu.items = [
  {
    "name" => "Information",
    "description" => "Studiestartsdagen og andet",
    "link" => "/information",
    "image_url" => 'menu/vigtigviden.png'
  },
  {
    "name" => "Arrangementer",
    "description" => "Begivenheder i studiestartsperioden",
    "link" => "/events",
    "image_url" => ''
  },
  {
    "name" => "Kontakt",
    "description" => "Hvem kan du kontakte?",
    "link" => "/kontakter",
    "image_url" => 'menu/arrangementer.png'
  },
  {
    "name" => "Guides",
    "description" => "Print, WiFi og andet",
    "link" => "/guides",
    "image_url" => ''
  },
  ]
baitixdinfmenu.educational_domain = baitixdinfdomain
baitixdinfmenu.save

#Contacts
contact1 = Contact.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "Anders Høgh")
contact1.email = "ahha15@student.aau.dk"
contact1.number = "31 31 78 28"
contact1.description = "Anders er jeres overinstruktør. Det er ham som har det overordnede ansvar for jeres studiestartsperiode. Er du i tvivl om noget så kontakt ham gerne!"
contact1.image = "contacts/andershogh.jpg"
contact1.save

contact2 = Contact.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "Studiesekretær")
contact2.description = "Kontaktinformationer kommer"
contact2.image = "contacts/placeholder.jpg"
contact2.save

contact3 = Contact.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "Anders Brams")
contact3.email = "studievejl@cs.aau.dk"
contact3.description = "Anders er tutor og studievejleder, og ham og hans kolleger kan hjælpe med dispensationer, eksamensregler, studiemiljø, og andre emner i den boldgade."
contact3.image = "contacts/andersbrams.jpg"
contact3.save

contact4 = Contact.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "Pernille Aagaard Madsen")
contact4.email = "pama16@student.aau.dk"
contact4.description = "Pernille er én af de 4 tutorinstruktører tilknytte din studiestart. Pernille læser Informatik på 5. semester, og kan svare på diverse spørgsmål ang. uddannelserne BaIT/ INF. "
contact4.image = "contacts/placeholder.jpg"
contact4.save


#Sponsors
sponsor1 = Sponsor.find_or_initialize_by(educational_domain: baitixdinfdomain, name: "prosa")
sponsor1.image = "sponsors/prosa.png"
sponsor1.save


pa_baitixdinf = Page.find_or_initialize_by(educational_domain: baitixdinfdomain, title: 'Informationsteknologi, Interaktionsdesign og Informatik')
pa_baitixdinf.content_header = 'Velkommen til Rusling.dk'
pa_baitixdinf.content = 'Vi gør alt hvad vi kan for at I kan få en fantastisk start på jeres studie! Her på siden har vi forsøgt at samle alle de informationer I kunne få brug for!<br><em>&ndash; Tutorerne</em>'
pa_baitixdinf.view_file = "index"
pa_baitixdinf.save

faq_page = Page.find_or_initialize_by(slug: "information", educational_domain: baitixdinfdomain)
faq_page.title = 'Information'
faq_page.content_header = 'Alt (..næsten) der er værd at vide om studiestarten!'
faq_page.content = 'Mangler der noget du vil vide? Skriv til ahha15@student.aau.dk med spørgsmålet'
faq_page.view_file = "accordion"
faq_page.accordion = [
  {
    "title" => "Studiestartsdagen",
    "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/information/studiestartsdagen.md"), "markdown")
  },
  {
    "title" => "Ruskorpset",
    "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/information/ruskorpset.md"), "markdown")
  },
  {
    "title" => "Samarbejdspartnere",
    "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/information/samarbejdspartnere.md"), "markdown")
  },
  {
    "title" => "Rusturen",
    "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/information/rusturen.md"), "markdown")
  }
]
faq_page.save

howto_page = Page.find_or_initialize_by(slug: "guides", educational_domain: baitixdinfdomain)
howto_page.title = 'Guides'
howto_page.content_header = 'Guides til alt!'
howto_page.view_file = "accordion"
howto_page.accordion = [
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
  },
  {
    "title" => "InDesign",
    "content" => html_parse(File.read(__dir__ + "/seeds/baitixdinf/guides/indesign.md"), "markdown")
  }
]
howto_page.save

contacts_page = Page.find_or_initialize_by(slug: "kontakter", educational_domain: baitixdinfdomain)
contacts_page.title = 'Kontakt'
contacts_page.content_header = 'Hvem skal du have fat i for at få svar på dit spørgsmål?'
contacts_page.content = 'Hold musen over billedet for at se kontaktoplysninger på personen!'
contacts_page.view_file = "contacts"
contacts_page.save

ev1baitixdinf = Event.find_or_initialize_by(title: "Studiestartsdag", educational_domain: baitixdinfdomain)
ev1baitixdinf.description = "<p>Den store dag! Du starter på dit studie. Husk at vi mødes på Honnørkajen. Se kortet hvis du er i tvivl om hvor det er.</p>"
ev1baitixdinf.location = "Honnørkajen"
ev1baitixdinf.lat = 57.0502987
ev1baitixdinf.lng = 9.9229435
ev1baitixdinf.begin_at = "2018-09-03 08:30:00"
ev1baitixdinf.save

baitixdinfdomain.update(primary_menu: baitixdinfmenu, default_page: pa_baitixdinf)
