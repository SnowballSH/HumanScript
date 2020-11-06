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

VarAccessNode = Struct.new(:name) do
  def eval(ctx)
    res = ctx.locals[name]
    res || $constants['nil']
  end
end

VarAssignNode = Struct.new(:name, :value) do
  def eval(ctx)
    ctx.locals[name] = value.eval(ctx)
  end
end
