class MembersController < ApplicationController
  include Administrable::CRUDFeature
  
  def search_fields 
    [:name_cont]
  end
  
  def search_results_fields
    [:name, :company_id, :age, {:status => :status_i18n}, :updated_at]
  end
end