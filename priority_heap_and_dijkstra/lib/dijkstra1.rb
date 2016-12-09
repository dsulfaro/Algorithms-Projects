require_relative 'graph'
require 'byebug'

# Credit: App Academy
def find_min_cost(possible_paths)
  vertex, data = possible_paths.min_by do |(vertex, data)|
    data[:cost]
  end
  vertex
end

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = { source: { cost: 0, previous_edge: nil }}

  until possible_paths.empty?

  end

  shortest_paths
end

paths = {
  "a" => { cost: 3,  previous_edge: nil },
  "b" => { cost: 1, previous_edge: nil },
  "c" => { cost: 2, previous_edge: nil }
}

p find_min_cost(paths)
