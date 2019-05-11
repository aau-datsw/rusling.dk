puts "creating datsw"
datswdomain = EducationalDomain.find_or_initialize_by(domain: domain)
datswdomain.name = 'Datalogi og Software'
datswdomain.educations = ["Datalogi", "Software"]
datswdomain.colors = {"primary-color" => "#eb7115", "secondary-color" => "#f19c5c"}
datswdomain.locale = "da"
datswdomain.save

datswmenu = datswdomain.menus.find_or_initialize_by(name: "DatSW Menu")
datswmenu.items = [
  {
    "name" => "Vigtig viden",
    "description" => "Ligegyldig info",
    "link" => "/faq",
    "image_url" => 'menu/vigtigviden.png'
  },
  {
    "name" => "Information",
    "description" => "Alt om studiestartsdagen osv.",
    "link" => "/info",
    "image_url" => ''
  },
  {
    "name" => "Arrangementer",
    "description" => "Se kalenderen over de kommende arrangementer",
    "link" => "/events",
    "image_url" => 'menu/arrangementer.png'
  },
  {
    "name" => "Kontakt",
    "description" => "Få overblik over hvem du kan kontakte",
    "link" => "/kontakter",
    "image_url" => ''
  },
  {
    "name" => "Guides",
    "description" => "Hjælp til print, Wifi osv.",
    "link" => "/howto",
    "image_url" => 'menu/guides.png'
  },
  {
    "name" => "Gode råd",
    "description" => "Kloge ord fra andre studerende",
    "link" => "/advice",
    "image_url" => 'menu/goderaad.png'
  }
  ]
datswmenu.educational_domain = datswdomain
datswmenu.save

puts "creating datsw contacts"
#Contacts
tobias = Contact.find_or_initialize_by(educational_domain: datswdomain, name: "Tobias Palludan")
tobias.email = "tpallu16@student.aau.dk"
tobias.number = "20 58 21 14"
tobias.description = "Tobias er ansvarlig for studiestartsperioden. Er du i tvivl om noget, kan du starte med at skrive til Tobias - så finder han den rette person til dig."
tobias.image = "contacts/tobiaspalludan.jpg"
tobias.save

diana = Contact.find_or_initialize_by(educational_domain: datswdomain, name: "Diana Wolff Bie")
diana.email = "dwb@staff.aau.dk"
diana.description = "Diana er studiesekretæren, og står for mange af de praktiske ting på jeres uddannelse. I vil høre mere om, hvordan hun kan hjælpe, til studiestarten."
diana.image = "contacts/dianawolffbie.jpg"
diana.save

brams = Contact.find_or_initialize_by(educational_domain: datswdomain, name: "Anders Brams")
brams.email = "studievejl@cs.aau.dk"
brams.description = "Anders er tutor og studievejleder, og ham og hans kolleger kan hjælpe med dispensationer, eksamensregler, studiemiljø, og andre emner i den boldgade."
brams.image = "contacts/andersbrams.jpg"
brams.save

kurt = Contact.find_or_initialize_by(educational_domain: datswdomain, name: "Kurt Nørmark")
kurt.email = "normark@cs.aau.dk"
kurt.description = "Du kan skrive til Kurt hvis du har spørgsmål vedr. alt der har med studiet, grupper og projekter at gøre."
kurt.image = "contacts/kurt.jpg"
kurt.save

#anders = Contact.create(educational_domain: datswdomain, name: "Anders Madsen", email: "amads15@student.aau.dk", number: "31 61 79 58", description: "Anders er toxic af!", image: "http://placekitten.com/1200/500")

puts "creating datsw sponsors"
#Sponsors
sponsor_progras = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "progras")
sponsor_progras.image = "sponsors/progras.png"
sponsor_progras.save

sponsor_prosa = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "prosa")
sponsor_prosa.image = "sponsors/prosa.png"
sponsor_prosa.save

sponsor_cego = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "cego")
sponsor_cego.image = "sponsors/cego.png"
sponsor_cego.save

sponsor_bankdata = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "bankdata")
sponsor_bankdata.image = "sponsors/bankdata.png"
sponsor_bankdata.save

sponsor_accenture = Sponsor.find_or_initialize_by(educational_domain: datswdomain, name: "accenture")
sponsor_accenture.image = "sponsors/accenture.png"
sponsor_accenture.save

pa = Page.find_or_initialize_by(educational_domain: datswdomain, title: 'Datalogi og Software')
pa.content_header = 'Velkommen til Rusling.dk'
pa.content = 'Vi gør alt hvad vi kan for at I kan få en fantastisk start på jeres studie! Her på siden har vi forsøgt at samle alle de informationer I kunne få brug for!<br><em>&ndash; Tutorerne</em>'
pa.view_file =  "index"
pa.save

faq_page = Page.find_or_initialize_by(slug: "faq", educational_domain: datswdomain)
faq_page.title = 'Vigtig viden (FAQ)'
faq_page.content_header = 'Her er svarene på alle jeres spørgmål!'
faq_page.view_file = "accordion"
faq_page.accordion = [
  {
    "title" => "De første par dage",
    "content" => File.read(__dir__ + "/faq/studiestartsdagen.html")
  },
  {
    "title" => "Rusperioden",
    "content" => File.read(__dir__ + "/faq/rusperioden.html")
  },
  {
    "title" => "Studiet",
    "content" => File.read(__dir__ + "/faq/studiet.html")
  },
  {
    "title" => "Eksamen",
    "content" => File.read(__dir__ + "/faq/eksamen.html")
  }
]
faq_page.save

info_page = Page.find_or_initialize_by(slug: "info", educational_domain: datswdomain)
info_page.title = 'Information'
info_page.content_header = 'Vi har samlet så mange informationer som mulig!'
info_page.content = 'Hvis I synes der mangler noget, må I gerne sige til!'
info_page.view_file = "accordion"
info_page.accordion = [
  {
    "title" => "Studiestartsdagen",
    "content" => html_parse(File.read(__dir__ + "/info/studiestartsdagen.md"), "markdown")
  },
  {
    "title" => "Studieordninger",
    "content" => File.read(__dir__ + "/info/studieordninger.html")
  },
  {
    "title" => "Studenterpolitik",
    "content" => html_parse(File.read(__dir__ + "/info/studenterpolitik.md"), "markdown")
  },
  {
    "title" => "Ruskorpset",
    "content" => html_parse(File.read(__dir__ + "/info/ruskorpset.md"), "markdown")
  },
  {
    "title" => "Samarbejdspartnere",
    "content" => html_parse(File.read(__dir__ + "/info/samarbejdspartnere.md"), "markdown")
  }
]
info_page.save

howto_page = Page.find_or_initialize_by(slug: "howto", educational_domain: datswdomain)
howto_page.title = 'Guides'
howto_page.content_header = 'Guides til alt!'
howto_page.view_file = "accordion"
howto_page.accordion = [
  {
    "title" => "LaTeX",
    "content" => File.read(__dir__ + "/howto/latex.html")
  },
  {
    "title" => "WiFi",
    "content" => File.read(__dir__ + "/howto/wifi.html")
  },
  {
    "title" => "Studiekort",
    "content" => File.read(__dir__ + "/howto/studiekort.html")
  },
  {
    "title" => "Print",
    "content" => File.read(__dir__ + "/howto/print.html")
  },
  {
    "title" => "Skema",
    "content" => File.read(__dir__ + "/howto/skema.html")
  },
  {
    "title" => "Studiemail på telefon",
    "content" => File.read(__dir__ + "/howto/studiemail.html")
  },
  {
    "title" => "Moodle",
    "content" => File.read(__dir__ + "/howto/moodle.html")
  }
]
howto_page.save

contacts_page = Page.find_or_initialize_by(slug: "kontakter", educational_domain: datswdomain)
contacts_page.title = 'Kontakt'
contacts_page.content_header = 'Her er alle de mennesker der er vigtige!'
contacts_page.content = 'mouseover(tap) for kontakt information.'
contacts_page.view_file = "contacts"
contacts_page.save

advice_page = Page.find_or_initialize_by(slug: "advice", educational_domain: datswdomain)
advice_page.title = 'Gode råd'
advice_page.content = File.read(__dir__ + "/advice.html")
advice_page.content_header = "Herunder har vi samlet er par gode råd fra ældre studerende på datalogi og software"
advice_page.view_file = "show"
advice_page.save

puts "creating datsw events"

studiestartsdag = Event.find_or_initialize_by(title: "Studiestartsdagen", educational_domain: datswdomain)
studiestartsdag.description = "<h5>Klar, parat, studiestart!</h5><p>Vi glæder os utrolig meget til at tage imod jer!<br />Mere info om dagen kan I finde <a href=\"/info/\">her</a> under overskriften \"Studiestartsdagen\"</p>"
studiestartsdag.location = "Honnørkajen"
studiestartsdag.lat = 57.0502987
studiestartsdag.lng = 9.9229435
studiestartsdag.begin_at = "2018-09-03 08:30:00"
studiestartsdag.end_at = "2018-09-03 14:00:00"
studiestartsdag.save

pubcrawl = Event.find_or_initialize_by(title: "Pubcrawl", educational_domain: datswdomain)
pubcrawl.description = "Pubcrawl er en sjov og hyggelig aften, hvor I kommer rundt på de forskellige barer i Aalborg. I vil i starten af aftenen blive delt ind i hold, og dyste imod andre hold I møder. Dommerne på stedet vil tildele og fratage points fra de forskellige hold, og aftenens vinder vil modtage en velfortjent præmie, når I alle sammen samles til sidst i byen.
Bemærk, at der ikke er nogen af legene, hvor der er nødvendigt at drikke for at deltage."
pubcrawl.location = "Gammeltorv"
pubcrawl.lat = 57.048134
pubcrawl.lng = 9.919349
pubcrawl.begin_at = "2018-09-12 18:00:00"
pubcrawl.end_at = "2018-09-12 22:00:00"
pubcrawl.save

boardgame = Event.find_or_initialize_by(title: "Brætspilsaften", educational_domain: datswdomain)
boardgame.description = "Prosa inviterer jer til brætspilsaften, hvor I har mulighed for at hygge jer med nogle af jeres tutorer og medstuderende. Prosa har booket cafeen til os, og giver derudover den første omgang. Så tag dine gruppemedlemmer under armen, og kom til en hyggelig aften!"
boardgame.location = "Aalborg Brætspilscafé"
boardgame.lat = 57.0461006
boardgame.lng = 9.91350499
boardgame.begin_at = "2018-09-17 16:30:00"
boardgame.end_at = "2018-09-17 21:00:00"
boardgame.save

knoldbold = Event.find_or_initialize_by(title: "Knoldbold", educational_domain: datswdomain)
knoldbold.description = "Knoldbold er den ædle og oldgamle disciplin i organiseret kaos. Med 4 hold på banen, som kæmper to forskellige kampe, og korrupte, unfair dommere, er det helt garanteret, at der ikke er nogen der forstår hvad der foregår. Det skal nok blive sjovt!
Der er mindst 4 på banen fra hvert hold, og I skal derfor lave en gruppe med udklædningstema og bold. Der vil være præmier til vinderen af Knoldbold, og præmier til den bedste udklædning."
knoldbold.location = "Fjordmarken"
knoldbold.lat = 57.055934
knoldbold.lng = 9.906076
knoldbold.begin_at = "2018-09-20 14:30:00"
knoldbold.end_at = "2018-09-20 18:30:00"
knoldbold.save

ruskursus = Event.find_or_initialize_by(title: "Ruskursus", educational_domain: datswdomain)
ruskursus.description = "Ruskursus er studiestartsperiodens absolutte højdepunkt. Vi tager tidligt afsted onsdag morgen, og vil i løbet af onsdagen og torsdagen gennemgå en blanding af hyggelige, sociale aktiviteter, og spændende faglige arrangementer. Torsdag aften afsluttes med en kæmpe fest, hvor vi blandt andet spiser fantastisk mad, laver sketches i vores grupper, og har en fed aften, hvor vi lærer hinanden at kende, inden vi fredag morgen tager hjem til Aalborg igen."
ruskursus.location = "Kvickly Vestbyen"
ruskursus.lat = 57.054528
ruskursus.lng = 9.906408
ruskursus.begin_at = "2018-10-03 08:30:00"
ruskursus.end_at = "2018-10-05 15:00:00"
ruskursus.save

latex = Event.find_or_initialize_by(title: "LaTeX kursus", educational_domain: datswdomain)
latex.description = "PROSA inviterer på gratis LaTeX kursus! Kun for jer! Fordi I er nice!"
latex.location = "AUD 7"
latex.lat = 57.053007
latex.lng = 9.912546
latex.begin_at = "2018-10-11 16:30:00"
latex.end_at = "2018-10-11 19:00:00"
latex.save

ruslan = Event.find_or_initialize_by(title: "Ruslan", educational_domain: datswdomain)
ruslan.description = "RusLAN er et alkoholfrit arrangement, hvor der bliver dystet i diverse anerkendte e-sportsgrene. I løbet af en hel weekend vil der blive råbt \"n00b\" og \"360n0sc0pe\" i stride strømme, når der bliver afholdt turneringer i CSGO, Rocket League, LoL/DoTa, og 2 andre turneringer - selvfølgelig alt sammen med mega fede præmier!
Fik vi nævnt, at vi giver pizza både fredag og lørdag?"
ruslan.location = "Cassiopeia"
ruslan.lat = 57.0123062
ruslan.lng = 9.9889782
ruslan.begin_at = "2018-10-19 17:30:00"
ruslan.end_at = "2018-10-21 13:00:00"
ruslan.save

datswdomain.update(primary_menu: datswmenu, default_page: pa)
