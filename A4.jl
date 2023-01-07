using Graphs
using GraphIO
using Random

function initalize_population!(size_population, number_of_nodes)
    population = []
    for _ in 1:size_population
        c = rand((0,1), number_of_nodes)
        push!(population, c)
    end
    return population
end

function get_modularity!(chromosome, g)
    # TODO TWOL??
    TWOL = ne(g)*2
    a = adjacency_matrix(g)
    number_of_nodes = nv(g)
    Edges = [] # variable edges already taken in library
    for i in 1:number_of_nodes
        push!(Edges, sum(a[i,:]))
    end
    modularity = 0
    for i in 1:number_of_nodes # Every chromose has number_of_nodes elements
        tmp = 0
        for j in 1:number_of_nodes
            paranthesis = a[i,j] - (Edges[i]*Edges[j]/TWOL)
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

function uniform_crossover!(first_chromosome, second_chromosome)
    # Uniform crossover p.49 - Swap each gene with probability 0.5
    
    index = rand((0,1), length(first_chromosome)) # TODO: is that probability 0.5?
    first_offspring = []
    second_offspring = []

    for i in eachindex(first_chromosome)
        if index[i] == 1
            # Swap values
            push!(first_offspring, second_chromosome[i])
            push!(second_offspring, first_chromosome[i])
        else
            # Dont swap values
            push!(first_offspring, first_chromosome[i])
            push!(second_offspring, second_chromosome[i])
        end
    end
    return first_offspring, second_offspring
end

function mutate!(chromosome)
    # Mutate individuals p.50
    index = mod(rand(Int), length(chromosome)) + 1
    if chromosome[index]==1
        chromosome[index]=0
    else
        chromosome[index]=1
    end
    return chromosome
end

function fittest_indivdual!(fitness)
    # Return index of fittest individual

    return argmax(fitness)
end

"""
v = vertices(g) # Kind of iterator
number_of_nodes = nv(g) # Int
e = edges(g)    # Kind of iterator

"""

# g = loadgraph("A4-networks/20x2+5x2.net", NETFormat())
# g = loadgraph("A4-networks/256_4_4_2_15_18_p.net", NETFormat())
g = loadgraph("A4-networks/dolphins.net", NETFormat())
number_of_nodes = nv(g)

# Define size of population and number of generations
size_population = 100
num_generations = 1000

# According to U6-Slides.pdf, page 38

# Initalize population
# Population is random array of [[0,1,0,1,1,0...],[0,1,0,1,1,0...] ,[0,1,0,1,1,0...] ...]
let Population = initalize_population!(size_population, number_of_nodes)

    # Evaluate fitness of inital population
    let Fitness = get_fitness!(Population, g)
        max_fitness = 0
        max_fitness_population = []
        sum_fitness = sum(Fitness)
        # Check for optimum in the beginning, random initialization could be the optimal one
        if sum_fitness > max_fitness
            max_fitness = sum_fitness
            max_fitness_population = Population
        end

        for generation in 1:num_generations
            population_prime = []
            for _ in size_population/2
                println("------------------------------")
                println("Generation: $generation")
                println("Current fitness: $sum_fitness")
                println("Optimal fitness: $max_fitness")
                println("------------------------------")

                # Select two individuals c_alpha, c_beta from P
                # Here we can choose from p.39 - p.45 what is the easiest?
                c_alpha, c_beta = tournament_selection!(Population, Fitness, size_population)

                # Crossover c_alpha_prime, c_beta_prime
                # Uniform crossover p.49 - Swap each gene with probability 0.5
                    # Seems very easy to implement lets choose this
                c_alpha_prime, c_beta_prime = uniform_crossover!(c_alpha, c_beta)

                # Mutate individuals c_alpha_prime, c_beta_prime p.50
                mutated_c_alpha_prime = mutate!(c_alpha_prime)
                mutated_c_beta_prime = mutate!(c_beta_prime)

                # Add mutated individuals to P'
                push!(population_prime, mutated_c_alpha_prime, mutated_c_beta_prime)
            end

            # Elitism add best fitted individuals of P to P'
            index_best_fitted = fittest_indivdual!(Fitness)
            push!(population_prime, Population[index_best_fitted]) # TODO: Should the Population be growing?
            Population = population_prime

            # Evaluate fitness of all individuals in p
            Fitness = get_fitness!(Population, g)
            
        end # end for

        println("------------------------------")
        println("Computation complete!")
        println("Optimal fitness: $max_fitness")
        # println("Optimal population: $max_fitness_population")
        println("------------------------------")


        # How to safe the graph?
        # savegraph("optimal.lgz", max_fitness_population)
        # t = plot(max_fitness_population)
        # save(SVG("plot.svg"), t)
    end #end let
end #end let

