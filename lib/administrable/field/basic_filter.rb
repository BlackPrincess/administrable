module Administrable
  module Field
    module BasicFilter
      def self.edit_field_filter(attributes)
        ignore_fields = ['id' , 'created_at', 'updated_at']
        attributes.reject { |a| ignore_fields.include?(a) }
      end

      def self.show_field_filter(attributes)
        ignore_fields = ['id']
        attributes.reject { |a| ignore_fields.include?(a) }
      end
    end
  end
end