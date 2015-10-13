module Administrable::Field::Filter
  class RecordWithOperatorFilter
    def self.edit_field_filter(attributes)
      ignore_fields = ['created_by', 'updated_by']
      attributes.reject { |a| ignore_fields.include?(a) }
    end

    def self.show_field_filter(attributes)
      attributes
    end
  end
end