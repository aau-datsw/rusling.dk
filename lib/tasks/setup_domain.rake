namespace :rusling do
  def setup_domain(domain, ed_name, color)
    html_parse = lambda do |input, parser|
      if parser == 'textile'
        RedCloth.new(input).to_html
      elsif parser == 'markdown'
        options = {
          filter_html: true,
          hard_wrap: true,
          link_attributes: { rel: 'nofollow', target: '_blank' },
          space_after_headers: true,
          fenced_code_blocks: true
        }

        extensions = {
          autolink: true,
          superscript: true,
          disable_indented_code_blocks: true
        }

        renderer = Redcarpet::Render::HTML.new(options)
        markdown = Redcarpet::Markdown.new(renderer, extensions)
        markdown.render(input)
      else
        raise 'Parser not supported, please try again (markdown/textile)'
      end
    end

    cf_key  = ENV['CLOUDFLARE_KEY']
    cf_mail = ENV['CLOUDFLARE_EMAIL']

    puts "Creating domain: '#{domain}'"
    ed_dom = EducationalDomain.find_or_initialize_by(domain: domain)
    ed_dom.name = ed_name
    ed_dom.educations = ed_name.split('/')
    ed_dom.colors = { 'primary_color' => color, 'secondary_color' => color }
    ed_dom.locale = 'da'
    ed_dom.save!

    puts 'Creating Menu'
    menu = ed_dom.menus.find_or_initialize_by(name: "#{ed_name} Menu")
    menu.menu_items_attributes = [
      {
        'name' => 'Information',
        'description' => 'Studiestartsdagen og andet',
        'link' => '/information',
        'image_url' => 'menu/vigtigviden.png'
      },
      {
        'name' => 'Arrangementer',
        'description' => 'Begivenheder i studiestartsperioden',
        'link' => '/events',
        'image_url' => ''
      },
      {
        'name' => 'Kontakt',
        'description' => 'Hvem kan du kontakte?',
        'link' => '/kontakter',
        'image_url' => 'menu/arrangementer.png'
      },
      {
        'name' => 'Guides',
        'description' => 'Print, WiFi og andet',
        'link' => '/guides',
        'image_url' => ''
      }
    ]
    menu.educational_domain = ed_dom
    menu.save

    # Contacts
    puts 'Creating Contacts'
    contact2 = Contact.find_or_initialize_by(educational_domain: ed_dom, name: 'Studiesekretær')
    contact2.description = 'Kontaktinformationer kommer'
    contact2.image = 'contacts/placeholder.jpg'
    contact2.save

    # Sponsors
    puts 'Creating Sponsors'
    sponsor1 = Sponsor.find_or_initialize_by(educational_domain: ed_dom, name: 'progras')
    sponsor1.image = 'sponsors/progras.png'
    sponsor1.save

    puts 'Creating Home'
    home_page = Page.find_or_initialize_by(educational_domain: ed_dom, title: 'Generisk')
    home_page.content_header = 'Velkommen til Rusling.dk'
    home_page.content = 'Vi gør alt hvad vi kan for at I kan få en fantastisk start på jeres studie! Her på siden har vi forsøgt at samle alle de informationer I kunne få brug for!<br><em>&ndash; Tutorerne</em>'
    home_page.view_file = 'index'
    home_page.save

    puts 'Creating FAQ'
    faq_page = Page.find_or_initialize_by(slug: 'information', educational_domain: ed_dom)
    faq_page.title = 'Information'
    faq_page.content_header = 'Alt (..næsten) der er værd at vide om studiestarten!'
    faq_page.content = 'Mangler der noget du vil vide? Skriv til someone@student.aau.dk med spørgsmålet'
    faq_page.view_file = 'accordion'
    faq_page.accordion = [
      {
        'title' => 'Studiestartsdagen',
        'content' => html_parse.call(File.read(Rails.root.join('db', 'seeds', 'baitixdinf', 'information', 'studiestartsdagen.md')), 'markdown')
      },
      {
        'title' => 'Ruskorpset',
        'content' => html_parse.call(File.read(Rails.root.join('db', 'seeds', 'baitixdinf', 'information', 'ruskorpset.md')), 'markdown')
      },
      {
        'title' => 'Rusturen',
        'content' => html_parse.call(File.read(Rails.root.join('db', 'seeds', 'baitixdinf', 'information', 'rusturen.md')), 'markdown')
      }
    ]
    faq_page.save

    puts 'Creating HowTo'
    howto_page = Page.find_or_initialize_by(slug: 'guides', educational_domain: ed_dom)
    howto_page.title = 'Guides'
    howto_page.content_header = 'Guides til alt!'
    howto_page.view_file = 'accordion'
    howto_page.accordion = [
      {
        'title' => 'LaTeX',
        'content' => File.read(Rails.root.join('db', 'seeds', 'howto', 'latex.html'))
      },
      {
        'title' => 'WiFi',
        'content' => File.read(Rails.root.join('db', 'seeds', 'howto', 'wifi.html'))
      },
      {
        'title' => 'Studiekort',
        'content' => File.read(Rails.root.join('db', 'seeds', 'howto', 'studiekort.html'))
      },
      {
        'title' => 'Print',
        'content' => File.read(Rails.root.join('db', 'seeds', 'howto', 'print.html'))
      },
      {
        'title' => 'Skema',
        'content' => File.read(Rails.root.join('db', 'seeds', 'howto', 'skema.html'))
      },
      {
        'title' => 'Studiemail på telefon',
        'content' => File.read(Rails.root.join('db', 'seeds', 'howto', 'studiemail.html'))
      },
      {
        'title' => 'Moodle',
        'content' => File.read(Rails.root.join('db', 'seeds', 'howto', 'moodle.html'))
      }
    ]
    howto_page.save

    puts 'Creating contact-pages'
    contacts_page = Page.find_or_initialize_by(slug: 'kontakter', educational_domain: ed_dom)
    contacts_page.title = 'Kontakt'
    contacts_page.content_header = 'Hvem skal du have fat i for at få svar på dit spørgsmål?'
    contacts_page.content = 'Hold musen over billedet for at se kontaktoplysninger på personen!'
    contacts_page.view_file = 'contacts'
    contacts_page.save

    puts 'Creating Event'
    event = Event.find_or_initialize_by(title: 'Studiestartsdag', educational_domain: ed_dom)
    event.description = '<p>Den store dag! Du starter på dit studie. Husk at vi mødes på Honnørkajen. Se kortet hvis du er i tvivl om hvor det er.</p>'
    event.location = 'Honnørkajen'
    event.lat = 57.0502987
    event.lng = 9.9229435
    event.begin_at = '2019-09-02 08:30:00'
    event.save

    ed_dom.update(primary_menu: menu, default_page: home_page)
    if cf_key.present? && cf_mail.present?
      Cloudflare.connect(key: cf_key, email: cf_mail) do |connection|
        zone = connection.zones.find_by_name('rusling.dk')
        begin
          zone.dns_records.create('CNAME', domain.gsub('rusling.dk', ''), 'rusling.dk', proxied: true)
        rescue StandardError
          puts "Failed to create DNS for #{domain}"
        end
      end
    end
  end

  task get_educations: :environment do
    CSV.foreach(Rails.root.join('lib', 'tasks', 'uddannelser.csv'), col_sep: ';', headers: true) do |c|
      setup_domain(c['domain'].downcase, c['studier'], c['colorhex'])
    end
  end

end
