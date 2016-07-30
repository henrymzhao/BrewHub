class ImageValidator < ActiveModel::EachValidator



  String.class_eval do
      def is_valid_url?
          uri = URI.parse self
          uri.kind_of? URI::HTTP



          def validate_each(record, attribute, value)
            return if value.blank?
            begin
              uri = URI.parse(value)
              resp = FastImage.type(uri)

        #   rescue URI::InvalidURIError
        #      resp = false
            end

            unless resp == :gif || resp == :jpeg || resp == :png
              record.errors[attribute] << (options[:message] || "is not a valid url")
            end

          end







      rescue URI::InvalidURIError
          false
      end
  end








end
