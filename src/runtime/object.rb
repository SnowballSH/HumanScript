class HObject
  attr_accessor :runtime_class, :value, :callable

  def initialize(runtime_class, value = self, type = nil)
    @runtime_class = runtime_class
    @value = if type.nil?
               value
             else
               value.nil? ? Prim[type.to_sym] : value
             end
    @callable = false
  end

  def call(method, arguments = [])
    @runtime_class.lookup(method).call(self, arguments)
  end
end

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

class Context
  attr_reader :locals, :current_self, :current_class

  def initialize(current_self, current_class = current_self.runtime_class)
    @locals = {}
    @current_self = current_self
    @current_class = current_class
  end
end

class HMethod
  attr_accessor :params, :callable

  def initialize(params, body)
    @params = params
    @body = body
    @callable = true
  end

  def call(receiver, arguments)
    context = Context.new(receiver)

    if @params.size != arguments.size
      raise "Mismatched amount of arguments: Expected #{@params.size}, got #{arguments.size}"
    end

    @params.each_with_index do |param, index|
      context.locals[param] = arguments[index]
    end

    @body.eval(context)
  end
end

class HNativeMethod
  attr_accessor :param_amount, :callable

  def initialize(param_amount, body)
    @param_amount = param_amount
    @body = body
    @callable = true
  end

  def call(receiver, arguments)
    if @param_amount > arguments.size && @param_amount != -1
      raise "Mismatched amount of arguments: Expected #{@param_amount}, got #{arguments.size}"
    end

    @body.call(receiver, arguments)
  end
end

require_relative './prim.rb'
