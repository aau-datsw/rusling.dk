require 'icalendar'

class Public::EventsController < PublicApplicationController
  def index
    @events = @domain.events

    respond_to do |format|
      format.html
      format.json { render json: @events.to_json }
      format.any(:ics, :vcs, &method(:render_ics))
    end
  end

  def show
    @event = @domain.events.find(params[:id])
  end

private

  def render_ics
    cal = Icalendar::Calendar.new

    tzid = 'Europe/Copenhagen'

    filename = "#{@domain.domain}-events"
    if params[:format] == 'vcs'
      cal.prodid = '-//Microsoft Corporation//Outlook MIMEDIR//EN'
      cal.version = '1.0'
      filename += '.vcs'
    else # ical
      cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
      cal.version = '2.0'
      filename += '.ics'
    end

    @events.each do |event|
      cal.event do |e|
        e.dtstart = Icalendar::Values::DateTime.new(event.begin_at, tzid: tzid)
        e.dtend = Icalendar::Values::DateTime.new(event.end_at, tzid: tzid)
        e.summary = event.title
        e.description = event.description
        e.url = event_url(host: @domain.domain, id: event)
        e.location = event.location
      end
    end

    send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
  end
end
