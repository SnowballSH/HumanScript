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

require_relative 'class.rb'

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
