class Member < ActiveRecord::Base
  belongs_to :company
  validates :name, presence: true
  enum status: {:enable => 'enable', :disable => 'disable'}
  
end
