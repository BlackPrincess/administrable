module Administrable
  module CRUDFeature
    extend ActiveSupport::Concern

    included do |klass|
      def klass.local_prefixes
        super + ['administrable']
      end

      helper_method :administrable_index_url, :administrable_new_url, :administrable_edit_url
      helper_method :model_class
      before_action :set_resource, only: [:show, :edit, :update, :destroy]

      def index
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
        params[model_class.name.underscore.to_sym].permit!
      end
    end
  end
end