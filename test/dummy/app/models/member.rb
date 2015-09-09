class Member < ActiveRecord::Base
  belongs_to :company
  
  enum status: [:enable, :disable]
  
end
