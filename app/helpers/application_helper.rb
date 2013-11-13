module ApplicationHelper

  def matching_followed_comics(full_title_name)
    title = strip_issue_info(full_title_name)
    Comic.all.select { |comic| comic.title_name == title }
  end

  def title_followed?(full_title_name)
    matching_followed_comics(full_title_name).count > 0
  end

  def last_followed_issue(full_title_name)
    matching_followed_comics(full_title_name).last
  end

  def strip_issue_info(full_title_name)
    full_title_name.gsub(/(\s#.*)/, '')
  end

  def previous_months
    List.find(:all, order: "id DESC", limit: 4)
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