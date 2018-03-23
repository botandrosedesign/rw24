class ShirtSizes
  include ActiveModel::Model

  def self.load json
    new(JSON.load(json || "{}"))
  end

  def self.dump obj
    obj.to_json
  end

  SIZES = {
    small: "S",
    medium: "M",
    large: "L",
    x_large: "XL",
    xxx_large: "XXXL",
  }

  SIZES.each do |key, _|
    attr_reader key

    define_method :"#{key}=" do |value|
      instance_variable_set :"@#{key}", value.to_i
    end
  end

  def attributes
    SIZES.inject({}) do |attrs, (key, _)|
      attrs.merge key => send(key)
    end
  end

  def summary
    SIZES.flat_map do |key, value|
      [value] * send(key).to_i
    end.join(", ") 
  end

  attr_accessor :errors
end

