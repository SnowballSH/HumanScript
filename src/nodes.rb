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
    value = receiver ? receiver.eval(ctx) : ctx.current_self
    if value.runtime_class.runtime_vars[name] && value.runtime_class.runtime_vars[name].callable
      value.call(name, [])
    else
      res = value.runtime_class.runtime_vars[name]
      res ||= ctx.locals[name]
      res ||= $constants[name]
      raise "undefined local or method '#{name}'" unless res

      res
    end
  end
end

StrictVarAccessNode = Struct.new(:receiver, :name) do
  def eval(ctx)
    value = receiver ? receiver.eval(ctx) : ctx.current_self
    res = value.runtime_class.runtime_vars[name]
    res ||= ctx.locals[name]
    res ||= $constants[name]
    raise "undefined local '#{name}'" unless res

    res
  end
end

VarAssignNode = Struct.new(:name, :value) do
  def eval(ctx)
    ctx.current_class.assign(name, value.eval(ctx)) unless name == '_'
  end
end

ConstantAssignNode = Struct.new(:name, :value) do
  def eval(ctx)
    $constants[name] = value.eval(ctx)
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

ClassNode = Struct.new(:name, :body) do
  def eval(context)
    cls = context.current_class.runtime_vars[name]
    cls ||= context.locals[name]
    cls ||= $constants[name]

    unless cls
      cls = HClass.new(context.current_class, 'Class')
      context.current_class.assign(name, cls)
    end
    class_context = Context.new(cls, cls)
    body.eval(class_context)

    cls
  end
end

IfNode = Struct.new(:cond, :body) do
  def eval(ctx)
    if cond.eval(ctx).value
      body.eval(ctx)
    else
      $constants['nil']
    end
  end
end

IfElseNode = Struct.new(:cond, :body, :else_body) do
  def eval(ctx)
    if cond.eval(ctx).value
      body.eval(ctx)
    else
      else_body.eval(ctx)
    end
  end
end
