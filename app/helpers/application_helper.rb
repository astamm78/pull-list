module ApplicationHelper

  def previous_months
    List.find(:all, order: "id DESC", limit: 8)
  end

  def previous_months_comics
    results = []
    previous_months.each do |list|
      results << list.comics
    end
    results.flatten
  end

  def previous_months_comics_sorted
    previous_months_comics.sort { |a, b| a.title <=> b.title }
  end

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

  def leftovers
    Comic.where(obtained: false) - List.last.comics
  end

  def leftovers_to_purchase
    _results = []
    leftovers.each { |comic| _results << comic if comic.purchase == true }
    _results
  end

  def leftovers_to_download
    _results = []
    leftovers.each { |comic| _results << comic if comic.download == true }
    _results
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