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
    ctx.locals[name]
  end
end
