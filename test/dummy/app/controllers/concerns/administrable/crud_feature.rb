module Administrable
  module CRUDFeature
    extend ActiveSupport::Concern

    included do |klass|
      def klass.local_prefixes
        super + ['administrable']
      end

      def index
        params[:q] ||= {}
        @q = model_class.search(params[:q])
        @resources = @q.result.page(params[:page])
        render :index
      end

      protected

      def model_class
        "#{controller_name.classify}".constantize
      end

      def set_resource
        @resource = model_class.find(params[:id])
      end
    end
  end
end