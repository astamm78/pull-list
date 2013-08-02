module ApplicationHelper

  def next_date
    doc = Nokogiri::HTML(open('http://www.grahamcrackers.com/newcomics.htm'))
    doc.search('td.header div').last.inner_text.gsub(/\n?/, "").gsub(/\t?/, "")
  end

  def comic_list
    @_array = []
    doc = Nokogiri::HTML(open('http://www.grahamcrackers.com/newcomics.htm'))
    doc.search('.newr a').each do |title|
      @_array << title.inner_text
    end
    @_array.uniq
  end

  def comics_to_purchase
    List.last.comics.where(purchase: true).order('id ASC')
  end

  def comics_to_download
    List.last.comics.where(download: true).order('id ASC')
  end

  def time_to_send_reminder?
    if List.last
      Time.now > Time.parse(List.last.date)
    else
      false
    end
  end

  def send_reminder
    ReminderMailer.reminder_email.deliver
  end

end