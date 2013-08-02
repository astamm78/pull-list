class Comic < ActiveRecord::Base

  attr_accessible :title, :list_id, :purchase, :download, :obtained, :created_at, :updated_at

  belongs_to :list

end