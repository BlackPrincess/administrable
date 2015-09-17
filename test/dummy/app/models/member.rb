class Member < ActiveRecord::Base
  belongs_to :company
  
  enum status: {:enable => 's', :disable => 'disable'}
  
end
