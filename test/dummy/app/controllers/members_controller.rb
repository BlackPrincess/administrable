class MembersController < ApplicationController
  include Administrable::CRUDFeature
  
  def search_fields 
    [:name_cont, :age_lteq, :age_gteq]
  end
  
  def search_results_fields
    [:name, :company_id, :age, {:status => :status_i18n}, :updated_at]
  end
  
  def search_scoped_model
    model_class.eager_load(:company)
  end
end