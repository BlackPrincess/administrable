module Administrable
  module Field
    class << self
      def edit_fields(resource)
        resource.attributes.except('id', 'created_at', 'updated_at').keys
      end
      
      def show_fields(resource)
        fields = edit_fields(resource)
        fields << 'created_at' if resource.respond_to?('created_at')
        fields << 'updated_at' if resource.respond_to?('updated_at')
        fields
      end
      
      def field_type(klass, attr)
        # TODO:
        if get_association_belongs_to(klass, attr).present?
          :belongs_to
        elsif klass.defined_enums[attr].present?
          :enum
        elsif klass.columns_hash[attr].present?
          klass.columns_hash[attr].type
        else
          # Default type is string
          :string
        end
      end
      
      def data_for_select(klass, attr)
        # TODO:
        association = get_association_class(klass, attr)
        return [] if association.nil?
        if association.respond_to?(:list_for_select)
          association.list_for_select
        elsif association.new.attributes.include?('name')
          association.pluck(:name, :id)  
        else
          raise MissingPrimaryNameException
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
      
      def accociation_attribute(klass, attr)
        # TODO:
        get_association_belongs_to(klass, attr).name
      end


      class MissingPrimaryNameException < StandardError
      end
    end
  end
end