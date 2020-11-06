Nodes = Struct.new(:nodes) do
  def eval
    nodes.each do |n|
      n.eval
    end
  end

  def <<(node)
    nodes << node
    self
  end
end

IntegerNode = Struct.new(:value) do
  def eval
    value
  end
end

VarAccessNode = Struct.new(:name) do
  def eval
    name
  end
end
