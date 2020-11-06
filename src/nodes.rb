require_relative 'runtime'

Nodes = Struct.new(:nodes) do
  def eval(ctx)
    r = $constants['nil']
    nodes.each do |n|
      r = n.eval(ctx)
    end
    r
  end

  def <<(node)
    nodes << node
    self
  end
end

IntegerNode = Struct.new(:value) do
  def eval(_ctx)
    $constants['Number'].new_with_value(value)
  end
end

VarAccessNode = Struct.new(:receiver, :name) do
  def eval(ctx)
    value = if receiver
              receiver.eval(ctx)
            else
              ctx.current_self
            end
    res = value.runtime_class.runtime_vars[name]
    res ||= ctx.locals[name]
    res ||= $constants[name]
    res || $constants['nil']
  end
end

VarAssignNode = Struct.new(:name, :value) do
  def eval(ctx)
    ctx.locals[name] = value.eval(ctx)
  end
end

CallNode = Struct.new(:receiver, :name, :args) do
  def eval(ctx)
    value = if receiver
              receiver.eval(ctx)
            else
              ctx.current_self
            end

    evaluated_arguments = args.map { |arg| arg.eval(ctx) }
    value.call(name, evaluated_arguments)
  end
end

DefNode = Struct.new(:name, :params, :body) do
  def eval(context)
    method = $constants['Function'].new_with_value(HMethod.new(params, body))
    method.callable = true
    context.current_class.runtime_vars[name] = method
  end
end
