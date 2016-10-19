module Administrable
  module Field
    class BasicField
      class << self
        def filters
          [Administrable::Field::Filter::BasicFilter]
        end
        
        def edit_fields(resource)
          filters.inject(resource.attributes.keys) {|acc, f| f.edit_field_filter(acc)}
        end
  
        def show_fields(resource)
          filters.inject(resource.attributes.keys) {|acc, f| f.show_field_filter(acc)}
        end
  
        def field_type(klass, attr)
          # TODO:
          if klass.reflect_on_belongs_to_class(attr).present?
            :belongs_to
          elsif klass.reflect_on_has_many_to_class(attr).present?
            :has_many
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
          association = klass.reflect_on_belongs_to_class(attr)
          return [] if association.nil?
          if association.respond_to?(:list_for_select)
            association.list_for_select
          elsif association.new.attributes.include?('name')
            association.pluck(:name, :id)
          else
            raise Administrable::Field::MissingPrimaryNameException
          end
        end
      end
    end
  end
end
