class Admin::Master::CompaniesController < ApplicationController
  include Administrable::CRUDFeature

  def model_in_same_namespace?
    false
  end

  def search_fields
    [:name_cont, :address]
  end

  def search_results_fields
    [:name, :address, :created_at, :updated_at]
  end
  
  def show_fields
    [:name, :address]
  end
end
