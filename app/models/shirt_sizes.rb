class ShirtSizes
  include ActiveModel::Model

  def self.load json
    attrs = JSON.load(json || "{}")
    if attrs.keys.include?("small")
      new_with_old_sizes(attrs)
    else
      new(attrs)
    end
  end

  def self.new_with_old_sizes(attrs)
    new.tap do |shirt_sizes|
      shirt_sizes.instance_variable_set :"@sizes", {
        small: "S",
        medium: "M",
        large: "L",
        x_large: "XL",
        xx_large: "XXL",
        xxx_large: "XXXL",
      }
      shirt_sizes.attributes = attrs
    end
  end

  def self.dump obj
    obj.attributes.to_json
  end

  def initialize attrs={}
    self.attributes = attrs
  end

  def sizes
    @sizes ||= {
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
  end

  def method_missing meth, *args, **kwargs, &block
    attr_name = meth.to_s.sub(/=$/, '').to_sym
    if sizes.keys.include?(attr_name)
      if meth.to_s =~ /=$/
        instance_variable_set :"@#{attr_name}", args.first.to_i
      else
        instance_variable_get :"@#{attr_name}"
      end
    else
      super
    end
  end

  def attributes
    sizes.inject({}) do |attrs, (key, _)|
      attrs.merge key => send(key)
    end
  end

  def attributes= attrs
    attrs.each do |key, value|
      send :"#{key}=", value
    end
  end

  def summary
    sizes.flat_map do |key, value|
      [value] * send(key).to_i
    end.join(", ")
  end

  def total
    sizes.flat_map do |key, value|
      send(key).to_i
    end.sum
  end

  attr_accessor :errors
end

