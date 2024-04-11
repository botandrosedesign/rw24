class ShirtSizes
  include ActiveModel::Model

  def self.load json
    new(JSON.load(json))
  end

  def self.dump obj
    obj.attributes.to_json
  end

  def initialize attributes
    self.attributes = attributes
  end

  attr_accessor :attributes, :errors

  def method_missing meth, *args, **kwargs, &block
    attr_name = meth.to_s.sub(/=$/, '')
    if options.include?(attr_name)
      if meth.to_s =~ /=$/
        attributes[attr_name] = args.first.to_i
      else
        attributes.fetch(attr_name)
      end
    else
      super
    end
  end

  def options
    attributes.keys
  end

  def summary
    attributes.flat_map do |key, value|
      [key] * value
    end.join(", ")
  end

  def total
    attributes.values.sum
  end
end
