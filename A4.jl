using Graphs
using GraphIO
using Random

function initalize_population!(size_population, number_of_nodes)
    population = []
    for _ in range(size_population)
        c = rand((0,1), number_of_nodes)
        population.append!(c)
    end
    return population
end

function get_modularity!(chromosome, g)
    # TODO TWOL??
    TWOL = ne(g)*2
    a = adjacency_matrix(g)
    number_of_nodes = nv(g)
    modularity = 0
    for i in 1:number_of_nodes
        push!(edges, sum(a[i,:]))
    end
    for i in 1:number_of_nodes # Every chromose has number_of_nodes elements
        tmp = 0
        for j in 1:number_of_nodes
            paranthesis = a[i,j] - (edges[i]*edges[j]/TWOL)
            delta = chromosome[i]*chromosome[j] + (1-chromosome[i])*(1-chromosome[j])
            modularity += paranthesis * delta
        end

    end
    modularity = modularity/TWOL
    return modularity
end

function get_fitness!(population, g)
    # MF: In A4.pdf: "Modularity cannot be used directly as the fitness since it may take negative values, and
    # also the difference in modularity of good partitions may be very small.", but abs is okay?
    
    # Or just modularity squared? Not negative and difference bigger. Just guessing
    fitness = []
    for chromosome in population
        push!(fitness,abs(get_modularity!(chromosome, g)))
    end
    return fitness
end

function tournament_selection!(population, fitness, size_population)
    # Select two individuals c_alpha, c_beta from P
    # Here we can choose from p.39 - p.45 what is the easiest?
    # tournament_selection?
    selection = []
    for i in 1:2
        K = 3
        index = []
        for i in 1:size_population
            push!(index, mod(rand(Int), K) + 1) #TODO Same element can appear twice
        end
        first_selection = []
        for j in 1:size_population
            if j in index
                push!(first_selection, (population[j], fitness[j]))
            end
        end
        tmp_fitness = 0
        index = 0
        
        for x in eachindex(first_selection)
            if tmp_fitness < first_selection[x][2]
                tmp_fitness = first_selection[x][2]
                index = x
            end
        end
        push!(selection, first_selection[index][1])
    end
    return selection
end

function uniform_crossover!()
    # Uniform crossover p.49 - Swap each gene with probability 0.5
    return
end

function mutate!(c_alpha_prime)
    # Mutate individuals p.50
    index = mod(rand(Int), length(c_alpha_prime)) + 1
    if c_alpha_prime[index]==1
        c_alpha_prime[index]=0
    else
        c_alpha_prime[index]=1
    end
    return mutated
    index = mod(rand(Int), length(c_alpha_prime)) + 1
    if c_alpha_prime[index]==1
        c_alpha_prime[index]=0
    else
        c_alpha_prime[index]=1
    end
    return mutated
end

function fittest_indivduals!(fitness, population_prime)
    # How many of the fittest to return?
    return fittest
end

"""
v = vertices(g) # Kind of iterator
number_of_nodes = nv(g) # Int
e = edges(g)    # Kind of iterator

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
        c_alpha, c_beta = tournament_selection!(population, fitness, size_population)

        # Crossover c_alpha_prime, c_beta_prime
        # Uniform crossover p.49 - Swap each gene with probability 0.5
            # Seems very easy to implement lets choose this
        c_alpha_prime, c_beta_prime = uniform_crossover!()

        # Mutate individuals c_alpha_prime, c_beta_prime p.50
        mutated_c_alpha_prime = mutate!(c_alpha_prime)
        mutated_c_beta_prime = mutate!(c_beta_prime)

        # Add mutated individuals to P'
        push!(population_prime, mutated_c_alpha_prime, mutated_c_beta_prime)
        push!(population_prime, mutated_c_alpha_prime, mutated_c_beta_prime)
    end

    # Elitism add best fitted individuals of P to P'
    best_fitted = fittest_indivduals!(fitness, population_prime)

    # TODO: Should the population be growing?
    push!(population, best_fitted)
    # TODO: Should the population be growing?
    push!(population, best_fitted)

    # Evaluate fitness of all individuals in p
    fitness = get_fitness!(population, g)
    
    # Compare with highest_modularity_partition, highest_modularity and safe if higher
    # TODO
end
