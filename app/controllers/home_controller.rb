class HomeController < ApplicationController

  http_basic_authenticate_with :name => ENV['LOGIN'], :password => ENV['PASSWORD']

  def index
    @list = List.new
  end

  def create
    list = List.create(date: params[:date])

    params.select{|key, value| value == "download" }.each do |comic|
      Comic.create( list_id:    list.id,
                    title:      comic[0],
                    purchase:   false,
                    download:   true )
    end

    params.select{|key, value| value == "purchase" }.each do |comic|
      Comic.create( list_id:    list.id,
                    title:      comic[0],
                    purchase:   true,
                    download:   false )
    end
    redirect_to root_path
  end

  def mark
    Comic.find(params[:id]).update_attributes(obtained: true)
    redirect_to root_path
  end

  def unmark
    Comic.find(params[:id]).update_attributes(obtained: false)
    redirect_to root_path
  end

  def reset
    List.find(params[:id]).destroy
    redirect_to root_path
  end

end