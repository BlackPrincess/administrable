module Administrable
  module FlashMessage
    extend ActiveSupport::Concern
    
    module Helper
      def flash_messages
        output_buffer = ActionView::OutputBuffer.new
        flash.each do |type, message|
          # HACK:
          output_buffer << ActionController::Base.new.render_to_string(partial: 'administrable/templates/flash_messages', locals: {css_class: flash_message_style(type), message: message})
        end
        output_buffer.to_s
      end
        
      def flash_message_style(message_type)
        case message_type.to_sym
          when :success
            'alert-success'
          when :notice, :info
            'alert-info'
          when :alert, :warning
            'alert-warning'
          when :error, :danger
            'alert-danger'
          else
            'alert-info'
        end
      end
    end

    included do |klass|
      klass.extend(Helper)
      klass.helper(Helper)
    end
  end
end