class ShirtSizes
  include ActiveModel::Model

  def self.load json
    new(JSON.load(json || "{}"))
  end

  def self.dump obj
    obj.to_json
  end

  SIZES = {
    mens_small: "MS",
    mens_medium: "MM",
    mens_large: "ML",
    mens_x_large: "MXL",
    mens_xx_large: "MXXL",
    mens_xxx_large: "MXXXL",

    womens_small: "WS",
    womens_medium: "WM",
    womens_large: "WL",
    womens_x_large: "WXL",
    womens_xx_large: "WXXL",
    womens_xxx_large: "WXXXL",
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

  def total
    SIZES.flat_map do |key, value|
      send(key).to_i
    end.sum
  end

  attr_accessor :errors
end

