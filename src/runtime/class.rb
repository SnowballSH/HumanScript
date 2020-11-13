class HClass < HObject
  attr_reader :runtime_vars, :type, :runtime_superclass, :value

  def initialize(superclass = nil, type = nil)
    @runtime_vars = {}
    @runtime_class = $constants['Class']
    @runtime_superclass = superclass
    @type = type
    @value = "Type '#{type}'"
  end

  def lookup(method_name)
    method = @runtime_vars[method_name]
    method = method.value if method

    method = @runtime_superclass.lookup(method_name) if method.nil? && @runtime_superclass
    raise "Method not found: #{method_name}" if method.nil?
    raise "#{method_name} is not callable" unless method.callable

    method
  end

  def try_lookup(method_name)
    method = @runtime_vars[method_name]

    method = @runtime_superclass.try_lookup(method_name) if method.nil? && @runtime_superclass
    return nil if method.nil?
    return nil unless method.callable

    method
  end

  def def(name, arg_amount, &block)
    x = $constants['Function'].new_with_value(HNativeMethod.new(arg_amount, block))
    x.callable = true
    @runtime_vars[name.to_s] = x
  end

  def assign(name, val)
    @runtime_vars[name.to_s] = val
  end

  def new
    HObject.new(self, nil, @type)
  end

  def new_with_value(value)
    HObject.new(self, value, @type)
  end
end
