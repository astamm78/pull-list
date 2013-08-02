class List < ActiveRecord::Base

  attr_accessible :date, :sent, :created_at, :updated_at

  has_many :comics, :dependent => :destroy

end