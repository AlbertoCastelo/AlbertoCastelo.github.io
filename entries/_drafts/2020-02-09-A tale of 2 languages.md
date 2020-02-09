---
layout: post
title: Numba vs. Julia, a subjective comparison
tags: [software, julia, numba, python]
---

I have been reading for some time about how Numba was great to accelerate Python code. Finally, I had enough time and an excuse to try it out. This led me on a path to dislike Numba (and, for what is worth, any other attempt to speed up Python) and falling in love with Julia.


The excuse was that I was playing around with some Neuroevolution code and I found a huge bottleneck due to the slow nature of Python. Neuroevolution basically consists on evolving Neural Networks architectures and sometimes even learning the right weights. If you want to read more about Neuroevolution you can check out [Wikipedia](https://en.wikipedia.org/wiki/Neuroevolution). Anyway, a huge part of Neuroevolution consist on search carried out by an Evolutionary AI. In Evolutionary AI, a population of individuals is evolved across generations making sure these individuals get better at the task they are being considered. You can read more about [here](https://en.wikipedia.org/wiki/Evolutionary_algorithm)

Anyway, the problem I was facing was that the program needed to iterate over a very large set and mutate some values. As pure Python is very slow, this required a new approach. Here was when I though of Numba. It was the perfect use-case for it. Therefore, I did a small spike to evaluate the improvements of adding Numba to the project. The following is a Pure Python implementation that suffers from the issues discussed:

### Pure Python Implementation

[Github Code](https://github.com/AlbertoCastelo/blog-the-2-language-problem/blob/master/notebooks/pure-python.ipynb)


```
class Node:
    def __init__(self, key, mutate_rate, possible_bias_values):
        self.key = key
        self.mutate_rate = mutate_rate
        self.possible_bias_values = possible_bias_values
        self._bias = 0.0

    def get_bias(self):
        return self._bias

    def mutate_bias(self):
        r = np.random.random()
        if r < self.mutate_rate:
            self._bias = np.random.choice(self.possible_bias_values, 
            size=1)[0]


def initialize_nodes(n_nodes, mutate_rate, possible_bias_values):
    nodes = {}
    for i in range(n_nodes):
        node = Node(i, 
                    mutate_rate, 
                    possible_bias_values)
        node.mutate_bias()
        nodes[i] = node
    return nodes
```

After fighting with Numba compiler and lose a few hairs debugging the solution, I arrived at the following Numba-Accelerated Python implementation:

### Numba-Accelerated Python Implementation

[Github Code](https://github.com/AlbertoCastelo/blog-the-2-language-problem/blob/master/notebooks/numba-accelated-python.ipynb)

```
spec_node = [('key', types.int32),
             ('mutate_rate', types.float32),
             ('possible_bias_values', types.int64[:]),
             ('bias', types.float64)
            ]

@numba.jitclass(spec_node)
class NodeNB:
    
    def __init__(self, key, mutate_rate, possible_bias_values):
        self.key = key
        self.mutate_rate = mutate_rate
        self.possible_bias_values = possible_bias_values
        self.bias = 0.0
        
    def get_bias(self):
        return self.bias
    
    def get_key(self):
        return self.key
    
    def mutate_bias(self):
        r = np.random.random()
        if r < self.mutate_rate:
            self.bias = np.random.choice(self.possible_bias_values, 
            size=1)[0]

            
@numba.njit()
def get_numba_array(list_):
    return np.array(list_)


@numba.njit(debug=True)
def initialize_nodes_numba(n_nodes, mutate_rate, possible_bias_values):
    nodes = {}
    for i in range(n_nodes):
        node = NodeNB(i, 
                      mutate_rate, 
                      possible_bias_values)
        node.mutate_bias()
        nodes[i] = node
    return nodes
```

Indeed, as we will see below, Numba accelerates **A LOT** the original code. However, after the pain of debugging, finding parts of code that Numba didn't support, I had another excuse to try out Julia. Julia is relatively new programming language developed at MIT that aims at being both fast and useful for prototyping. That is, solving the [Two Language Problem](https://www.nature.com/articles/d41586-019-02310-3).

### Julia Implementation

[Github Code](https://github.com/AlbertoCastelo/blog-the-2-language-problem/blob/master/notebooks/pure-julia.ipynb)


```
mutable struct NodeJu
  key::Int64
  mutate_rate::Float64
  possible_bias_values::Array{Int64,1}
  bias::Float64
  function NodeJu(key::Int, 
                  mutate_rate::Float64, 
                  possible_bias_values::Array{Int64,1})
    node = new(key, mutate_rate, possible_bias_values, 0.0)
    node
  end
end


function mutate_bias!(node::NodeJu)
  if rand() < mutate_rate
    node.bias = StatsBase.sample(node.possible_bias_values);
  end
  node 
end


function initialize_nodes_julia(n_nodes::Int, mutate_rate::Float64, 
                                possible_bias_values::Array{Int64,1})
    nodes = Dict()
    for i = 1 : n_nodes
        node = NodeJu(i, 
                      mutate_rate, 
                      possible_bias_values)
        mutate_bias!(node)
        nodes[i] = node
    end
    nodes
end
```

While writing Numba code felt hard, Julia was the opposite. Intuitive, despite being Object-Oriented, and easy to debug, thanks to the REPL and Jupyter-Lab.

## Benchmarking Results

I benchmarked the 3 implementions against a increasingly number of n_nodes. Basically, this is the parameter that determines the amount of iterations to carry out. Each  experiment was repeated 10 times and the first execution (that includes JIT compiling step) was discarded. 

```
n_nodes_values = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000]
```

The 

