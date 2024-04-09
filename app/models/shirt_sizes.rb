class ShirtSizes
  include ActiveModel::Model

  def self.load json
    attrs = JSON.load(json || "{}")
    new(attrs)
  end

  def self.options
    new.sizes.values
  end

  def self.dump obj
    obj.attributes.to_json
  end

  def initialize attrs={}
    self.attributes = attrs
  end

  def sizes
    @sizes ||= {
      x_small: "XS",
      small: "S",
      medium: "M",
      large: "L",
      x_large: "XL",
      xx_large: "XXL",
      xxx_large: "XXXL",
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
