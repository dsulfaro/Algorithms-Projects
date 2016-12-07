class Vertex

  attr_accessor :value, :in_edges, :out_edges, :in_degree

  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
    @in_degree = 0
  end

end

class Edge

  attr_accessor :from_vertex, :to_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    @cost = 1
    @to_vertex.in_edges << self;
    @from_vertex.out_edges << self;
    @to_vertex.in_degree += 1
  end

  def destroy!
    @to_vertex.in_edges.delete(self)
    @from_vertex.out_edges.delete(self)
    @to_vertex.in_degree -= 1
    @from_vertex, @to_vertex = nil
  end

end
