module Administrable
  module Field
    class << self
      def edit_fields(resource)
        resource.attributes.except('id', 'created_at', 'updated_at').keys
      end
      
      alias :show_fields :edit_fields
      
      def field_type(klass, attr)
        # TODO:
        association = klass.reflect_on_all_associations.find { |_| _.foreign_key == attr }
        if association.present?
          :select # TODO: it should 'type' != 'html input type'
        else
          klass.columns_hash[attr].type
        end
      end
      
      def data_for_select(klass, attr)
        # TODO:
        association = klass.reflect_on_all_associations.find { |_| _.foreign_key == attr }
        return [] if association.nil?
        association.klass.pluck(:name, :id)
      end
    end
  end
end