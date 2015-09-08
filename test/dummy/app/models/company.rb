class Company < ActiveRecord::Base
  paginates_per 3
  validates :name, :presence => true
end
