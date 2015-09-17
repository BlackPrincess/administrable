module Administrable
  module Field
    class << self
      def edit_fields(resource)
        resource.attributes.except('id', 'created_at', 'updated_at').keys
      end
      
      alias :show_fields :edit_fields
      
      def field_type(klass, attr)
        # TODO:
        if get_association_belongs_to(klass, attr).present?
          :belongs_to
        elsif klass.defined_enums[attr].present?
          :enum
        else
          klass.columns_hash[attr].type
        end
      end
      
      def data_for_select(klass, attr)
        # TODO:
        association = get_association_class(klass, attr)
        return [] if association.nil?
        if association.respond_to?(:list_for_select)
          association.list_for_select
        else
          association.pluck(:name, :id)  
        end
      end
      
      def get_association_class(klass, attr)
        # TODO:
        get_association_belongs_to(klass, attr).try(:klass)
      end
      
      def get_association_belongs_to(klass, attr)
        # TODO:
        klass.reflect_on_all_associations(:belongs_to).find { |_| _.foreign_key == attr }
      end
    end
  end
end