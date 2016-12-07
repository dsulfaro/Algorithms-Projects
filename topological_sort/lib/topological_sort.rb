require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn
def topological_sort(vertices)

  degrees = {}
  sorted = []
  top_level = []

  vertices.each do |vert|
    degrees[vert] = vert.in_edges.size
    top_level << vert if vert.in_edges.empty?
  end

  until top_level.empty?
    current = top_level.pop
    sorted << current
    current.out_edges.each do |edge|
      degrees[edge.to_vertex] -= 1
      top_level << edge.to_vertex if degrees[edge.to_vertex] == 0
    end
  end
  sorted
end

# Tarjan
def topological_sort(vertices)
  result = []
  seen = []
  vertices.each { |vert| depth_first_search(vert, result, seen) unless seen.include?(vert) }
  result
end

def depth_first_search(vertex, result, seen)
  seen << vertex
  vertex.out_edges.each do |edge|
    vert = edge.to_vertex
    depth_first_search(vert, result, seen) unless seen.include?(vert)
  end
  result.unshift(vertex)
end
