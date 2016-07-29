class ImageValidator < ActiveModel::EachValidator

  unless value.chars.first == "h"
    record.errors[attribute] << (options[:message] || "is not a valid url")
  end

  def validate_each(record, attribute, value)
    return if value.blank?
    begin
      uri = URI.parse(value)
      resp = FastImage.type(uri)

#   rescue URI::InvalidURIError
#      resp = false
#    end

    unless resp == :gif || resp == :jpeg || resp == :png
      record.errors[attribute] << (options[:message] || "is not a valid url")
    end



  end





end
