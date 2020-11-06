class HObject
  attr_accessor :runtime_class, :value

  def initialize(runtime_class, value = self)
    @runtime_class = runtime_class
    @value = value
  end

  def call(method, arguments = [])
    @runtime_class.lookup(method).call(self, arguments)
  end

  def callable?
    false
  end
end

class HClass < HObject
  attr_reader :runtime_vars

  def initialize
    @runtime_vars = {}
    @runtime_class = $constants['Class']
  end

  def lookup(method_name)
    method = @runtime_vars[method_name]
    raise "Method not found: #{method_name}" if method.nil?
    raise "#{method_name} is not callable" unless method.callable?

    method
  end

  def def(name, &block)
    @runtime_vars[name.to_s] = block
  end

  def assign(name, val)
    @runtime_vars[name.to_s] = val
  end

  def new
    HObject.new(self)
  end

  def new_with_value(value)
    HObject.new(self, value)
  end
end

class Context
  attr_reader :locals, :current_self, :current_class

  def initialize(current_self, current_class = current_self.runtime_class)
    @locals = {}
    @current_self = current_self
    @current_class = current_class
  end
end
