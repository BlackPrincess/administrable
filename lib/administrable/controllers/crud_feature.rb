module Administrable
  module CRUDFeature
    extend ActiveSupport::Concern

    included do |klass|
      klass.include Administrable::FlashMessage
      def klass.local_prefixes
        dirs = ["parts", 'form_fields', 'show_fields']
        super + dirs.map{|dir| "#{controller_path}/#{dir}"} + ['administrable'] + dirs.map{|dir| "administrable/#{dir}"}
      end
      
      helper_method :title
      helper_method :title=
      helper_method :administrable_index_url, :administrable_new_url, :administrable_edit_url
      helper_method :model_class, :field_strategy
      
      before_action :set_resource, only: [:show, :edit, :update, :destroy]
      before_action :set_form_fields, only: [:new, :edit, :create, :update, :destroy]
      before_action :set_show_fields, only: [:show]

      attr_writer :title

      def index
        @search_fields ||= search_fields
        @search_results_header_fields ||= search_results_header_fields
        @search_results_row_fields ||= search_results_row_fields

        @q = search_scoped_model.search(search_params)
        @resources = @q.result.page(params[:page])
        render :index
      end

      def new
        @resource = new_resource
        render :new
      end

      def show
        render :show
      end

      def edit
        render :edit
      end

      def create
        @resource = new_resource(permitted_params)

        if @resource.save
          redirect_to administrable_show_url(@resource), flash: {success: I18n.t('administrable.messages.created', resource: model_class.model_name.human)}
        else
          render :new
        end
      end

      def update
        if @resource.update(permitted_params)
          redirect_to administrable_show_url(@resource), flash: {success: I18n.t('administrable.messages.updated', resource: model_class.model_name.human)}
        else
          render :edit
        end
      end

      def destroy
        @resource.destroy!
        redirect_to administrable_index_url, flash: {success: I18n.t('administrable.messages.destroyed', resource: model_class.model_name.human)}
      end

      protected

      def namespace
        self.class.name.deconstantize
      end

      def model_class
        if namespace.present?
          "#{namespace}::#{controller_name.classify}".constantize
        else
          "#{controller_name.classify}".constantize
        end
      end
      
      def title
        @title || ''  
      end
      
      def search_params
        params[:q] ||= {}
        params[:q]
      end

      def search_scoped_model
        model_class
      end

      def new_resource(*args)
        model_class.new(*args)
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
        @resource ||= new_resource # TODO:
        field_strategy.edit_fields(@resource)
      end
      
      def show_fields
        @resource ||= new_resource # TODO:
        field_strategy.show_fields(@resource)
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

      def administrable_show_url(resource = @resource)
        polymorphic_url(resource)
      end

      def administrable_new_url
        new_polymorphic_url(model_class)
      end
      
      def administrable_edit_url(resource = @resource)
        edit_polymorphic_url(resource)
      end
      
      def permitted_params
        params.require(model_class.name.underscore.split('/').join("_").to_sym).permit!
      end
      
      def field_strategy
        Administrable::Field::BasicField
      end
    end
  end
end