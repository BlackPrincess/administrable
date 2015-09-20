class MembersController < ApplicationController
  include Administrable::CRUDFeature
  
  def search_fields 
    [:name_cont]
  end
  
  def search_results_fields
    [:name, :age, :updated_at]
  end
end