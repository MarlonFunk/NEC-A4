using Graphs
using GraphIO
using Random

function initalize_population!(size_population, number_of_nodes)
    population = []
    for _ in range(size_population)
        c = rand((0,1), number_of_nodes)
        population.append!(c)
    return population
end

function get_modularity!()
    return modularity
end

function get_fitness!(population, g)
    # MF: In A4.pdf: "Modularity cannot be used directly as the fitness since it may take negative values, and
    # also the difference in modularity of good partitions may be very small.", but abs is okay?
    
    # Or just modularity squared? Not negative and difference bigger. Just guessing
    return fitness
end

function selection!(population, fitness)
    # Select two individuals c_alpha, c_beta from P
    # Here we can choose from p.39 - p.45 what is the easiest?
    return c_1, c_2
end

function uniform_crossover!()
    # Uniform crossover p.49 - Swap each gene with probability 0.5
    return
end

function mutate!(c_alpha_prime)
    # Mutate individuals p.50

    return c
end

function fittest_indivduals!(fitness, population_prime)
    # How many of the fittest to return?
    return fittest
end

"""
v = vertices(g) # Kind of iterator
number_of_nodes = nv(g) # Int
e = edges(g)    # Kind of iterator
a = adjacency_matrix(g)
"""

g = loadgraph("A4-networks/20x2+5x2.net", NETFormat())
number_of_nodes = nv(g)

# Define size of population and number of generations
size_population = 25
num_generations = 100

highest_modularity_partition = []
highest_modularity = 0

# According to U6-Slides.pdf, page 38

# Initalize population
# Population is random array of [[0,1,0,1,1,0...],[0,1,0,1,1,0...] ,[0,1,0,1,1,0...] ...]
population = initalize_population!(size_population, number_of_nodes)

# Evaluate fitness of inital population
fitness = get_fitness!(population, g)

for generation in range(num_generations)
    population_prime = []
    for _ in size_population/2
        # Select two individuals c_alpha, c_beta from P
        # Here we can choose from p.39 - p.45 what is the easiest?
        c_alpha, c_beta = selection!(population, fitness)

        # Crossover c_alpha_prime, c_beta_prime
        # Uniform crossover p.49 - Swap each gene with probability 0.5
            # Seems very easy to implement lets choose this
        c_alpha_prime, c_beta_prime = uniform_crossover!()

        # Mutate individuals c_alpha_prime, c_beta_prime p.50
        mutated_c_alpha_prime = mutate!(c_alpha_prime)
        mutated_c_beta_prime = mutate!(c_beta_prime)

        # Add mutated individuals to P'
        population_prime.append!(mutated_c_alpha_prime, mutated_c_beta_prime)
    end

    # Elitism add best fitted individuals of P to P'
    best_fitted = fittest_indivduals!(fitness, population_prime)

    # Should the population be growing?
    population.append!(best_fitted)

    # Evaluate fitness of all individuals in p
    fitness = get_fitness!(population, g)
    
    # Compare with highest_modularity_partition, highest_modularity and safe if higher
    # TODO
end
