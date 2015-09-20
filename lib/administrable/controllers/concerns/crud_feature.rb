module Administrable
  module CRUDFeature
    extend ActiveSupport::Concern

    included do |klass|
      def klass.local_prefixes
        super + ["#{controller_path}/parts", 'administrable', 'administrable/parts']
      end

      helper_method :administrable_index_url, :administrable_new_url, :administrable_edit_url
      helper_method :model_class
      before_action :set_resource, only: [:show, :edit, :update, :destroy]
      before_action :set_form_fields, only: [:new, :edit, :create, :update, :destroy]
      before_action :set_show_fields, only: [:show]

      def index
        @search_fields ||= search_fields
        @search_results_header_fields ||= search_results_header_fields
        @search_results_row_fields ||= search_results_row_fields
        params[:q] ||= {}
        @q = model_class.search(params[:q])
        @resources = @q.result.page(params[:page])
        render :index
      end

      def new
        @resource = model_class.new
        render :new
      end

      def show
        render :show
      end

      def edit
        render :edit
      end

      def create
        @resource = model_class.new(permitted_params)

        if @resource.save
          redirect_to @resource
        else
          render :new
        end
      end

      def update
        if @resource.update(permitted_params)
          redirect_to @resource
        else
          render :edit
        end
      end

      def destroy
        @resource.destroy
        redirect_to action: :index
      end

      protected

      def model_class
        "#{controller_name.classify}".constantize
      end

      def set_resource
        @resource = model_class.find(params[:id])
      end
      
      def search_fields
        []
      end
      
      def search_results_fields
        []
      end
      
      def search_results_header_fields
        search_results_fields.map { |a| case a
          when Hash
            a.keys.first
          else
            a
          end
        }
      end

      def search_results_row_fields
        search_results_fields.map { |a| case a
          when Hash
            a.values.first
          else
            a
        end
        }
      end
      
      def form_fields
        Administrable::Field.edit_fields(@resource)
      end
      
      def show_fields
        Administrable::Field.show_fields(@resource)
      end
      
      def set_form_fields
        @form_fields ||= form_fields
      end
      
      def set_show_fields
        @show_fields ||= show_fields
      end

      def administrable_index_url
        polymorphic_url(model_class)
      end

      def administrable_new_url
        new_polymorphic_url(model_class)
      end
      
      def administrable_edit_url(resource = @resource)
        edit_polymorphic_url(resource)
      end
      
      def permitted_params
        params.require(model_class.name.underscore.to_sym).permit!
      end
    end
  end
end