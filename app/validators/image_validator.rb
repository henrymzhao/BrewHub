class ImageValidator < ActiveModel::EachValidator


  def validates_format_of_url(*attr_names)
    require 'uri/http'

    configuration = { :on => :save, :schemes => %w(http https) }
    configuration.update(attr_names.extract_options!)

    allowed_schemes = [*configuration[:schemes]].map(&:to_s)

    validates_each(attr_names, configuration) do |record, attr_name, value|
      begin
        uri = URI.parse(value)

        if !allowed_schemes.include?(uri.scheme)
          raise(URI::InvalidURIError)
        end

        if [:scheme, :host].any? { |i| uri.send(i).blank? }
          raise(URI::InvalidURIError)
        end

      rescue URI::InvalidURIError => e
        record.errors.add(attr_name, :invalid, :default => configuration[:message], :value => value)
        next
      end
    end



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






  end















end
