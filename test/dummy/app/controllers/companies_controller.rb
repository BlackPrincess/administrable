class CompaniesController < ApplicationController
  include Administrable::CRUDFeature

  def search_fields
    [:name_cont]
  end

  def search_results_fields
    [:name, :created_at, :updated_at]
  end
  
  def show_fields
    [:name]
  end
end