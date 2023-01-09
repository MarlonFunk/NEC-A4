using Graphs
using GraphIO
using Random
using StatsBase

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

    # Optional Task: Divide chromose by two and call get_modularity again. Compare output
    return modularity
end

# function get_modularity_optional!(chromosome, g, recursive_call, last_stage_modularity, all_modularitys)
#     if recursive_call == 3
#         return
#     else
#         modularity = abs(get_modularity!(chromosome, g)) # TODO abs
#         if modularity > last_stage_modularity
#             #Continue to split if modularity is growing
#             step = recursive_call + 1
#             get_modularity_optional!(chromosome[1:trunc(Int, lastindex(chromosome)/2)], g, step, modularity, all_modularitys)
#             get_modularity_optional!(chromosome[trunc(Int, lastindex(chromosome)/2):lastindex(chromosome)], g, step, modularity, all_modularitys)
#         else
#             # Modularity not growing, so push last stage
#             push!(all_modularitys, last_stage_modularity)
#         end
#     end
   
#     return all_modularitys
# end

function get_fitness!(population, g)
    # MF: In A4.pdf: "Modularity cannot be used directly as the fitness since it may take negative values, and
    # also the difference in modularity of good partitions may be very small.", but abs is okay?
    
    # TODO: Or just modularity squared? Not negative and difference bigger. Just guessing
    fitness = []
    all_modularitys = []
    for chromosome in population
        push!(fitness,(get_modularity!(chromosome, g)).^2)
        # push!(fitness,abs(get_modularity!(chromosome, g)))

        # TODO for optional task: How to get new adjacency_matrix of splitted chromosome? Or is it just with delta?
        # push!(fitness, get_modularity_optional!(chromosome, g, 0, 0, all_modularitys))
    end
    return fitness
end

function tournament_selection!(population, fitness, size_population)
    # Select two individuals c_alpha, c_beta from P
    # tournament_selection
    selection = []
    for i in 1:2 # rand gives random index of 
        K = 3
        index = []
        for i in 1:K # Get three random indices
            push!(index, mod(rand(Int), size_population) + 1) #TODO Same element can appear twice
        end
        first_selection = []
        for j in 1:size_population  # Push element with random indices into first_selection
            if j in index
                push!(first_selection, (population[j], fitness[j]))
            end
        end
        tmp_fitness = 0
        index = 0
        
        for x in eachindex(first_selection) # Get element with highest fitness of three randomly selected
            if tmp_fitness < first_selection[x][2]
                tmp_fitness = first_selection[x][2]
                index = x
            end
        end
        push!(selection, first_selection[index][1])
    end
    return selection
end

function roulette_selection!(population, fitness, size_population)
    # Select two individuals c_alpha, c_beta from P
    # Rank selection
    sum_fitness = sum(fitness)
    # chromosome probability = fitness of chromosome / sum of all fitnesses
    propabilities = []
    for c in eachindex(population)
        tmp_propability = fitness[c]/sum_fitness
        push!(propabilities, tmp_propability)
    end
    
    selection = sample(population, Weights(Float64.(propabilities)),2, replace=false)

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

function one_point_crossover!(first_chromosome, second_chromosome)
    index = mod(rand(Int), length(first_chromosome)) + 1
    first_offspring = []
    second_offspring = []

    for i in eachindex(first_chromosome)
        if i > index
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

function mutate!(chromosome, amount_of_mutations)
    # Mutate individuals p.50
    index = []
    for i in 1:amount_of_mutations
        push!(index, mod(rand(Int), length(chromosome)) + 1) # Index contains one or more indices
    end
    for i in eachindex(chromosome)      # Go over whole chromosome
        if i in index                   # Swap if in random indices
            if chromosome[i]==1
                chromosome[i]=0
            else
                chromosome[i]=1
            end
        end
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

g = loadgraph("A4-networks/20x2+5x2.net", NETFormat())
# g = loadgraph("A4-networks/256_4_4_2_15_18_p.net", NETFormat())
# g = loadgraph("A4-networks/dolphins.net", NETFormat())
number_of_nodes = nv(g)

# Define size of population and number of generations
"""
# TODO for wrapper
size_population, num_generations, amount_of_mutations, 
tournament_selection or roulette_selection
uniform_crossover or one_point_crossover
"""
size_population = 100
num_generations = 1000
amount_of_mutations = 3



# According to U6-Slides.pdf, page 38

# Initalize population
# Population is random array of [[0,1,0,1,1,0...],[0,1,0,1,1,0...] ,[0,1,0,1,1,0...] ...]
let Population = initalize_population!(size_population, number_of_nodes)

    # Evaluate fitness of inital population
    let Fitness = get_fitness!(Population, g)
        max_fitness = 0
        max_fitness_population = []


        for generation in 1:num_generations
            population_prime = []
            for a in 1:size_population/2
                sum_fitness = sum(Fitness)
                # Check for optimum in the beginning, random initialization could be the optimal one
                if sum_fitness > max_fitness
                    max_fitness = sum_fitness
                    max_fitness_population = Population
                end

                println("------------------------------")
                println("Generation: $generation")
                println("Current fitness: $sum_fitness")
                println("Optimal fitness: $max_fitness")
                println("------------------------------")

                # Select two individuals c_alpha, c_beta from P
                # Here we can choose from p.39 - p.45 what is the easiest?
                
                #c_alpha, c_beta = tournament_selection!(Population, Fitness, size_population)
                c_alpha, c_beta = roulette_selection!(Population, Fitness, size_population)
                
                # # Crossover c_alpha_prime, c_beta_prime
                # Uniform crossover p.49 - Swap each gene with probability 0.5
                c_alpha_prime, c_beta_prime = uniform_crossover!(c_alpha, c_beta)
                #c_alpha_prime, c_beta_prime = one_point_crossover!(c_alpha, c_beta)

                # Mutate individuals c_alpha_prime, c_beta_prime p.50
                mutated_c_alpha_prime = mutate!(c_alpha_prime, amount_of_mutations)
                mutated_c_beta_prime = mutate!(c_beta_prime, amount_of_mutations)

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

