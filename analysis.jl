graphs = ["dolphins.net", "20x2+5x2.net", "256_4_4_2_15_18_p.net", "256_4_4_4_13_18_p.net", "adjnoun.net", "cat_cortex_sim.net", "circle9.net", "clique_stars.net", "cliques_line.net", "graph3+1+3.net", "graph3+2+3.net", "grid-6x6.net", "grid-p-6x6.net", "qns04_d.net", "rb25.net", "rb125.net", "rhesus_simetrica.net", "star.net", "wheel.net", "zachary_unwh.net"]
population_sizes = [25, 50, 100]
# In the beginning everything is total random, at a random point the fitness increases fast until it reaches the maximum.
# The beginning can be < 50 or > 500. So a high fitness can appear befor 50 generations or after 500.
number_of_generations = [100, 500, 1000]
# Playing around with mutations resulted in the knowledge, that a number > 3 has a bad impact on the result
#   which makes sense, because the amount of randomness is increased and the impact of the fittest individuals is decreased
amount_of_mutations = [1, 2, 3] 
selection_function = ["tournament", "roulette"]
crossover_function = ["one_point", "uniform"]

for graph in graphs
    for population_size in population_sizes
        for number_of_generation in number_of_generations
            for amount_of_mutation in amount_of_mutations
                for selection in selection_function
                    for crossover in crossover_function
                        outfile = "results/$graph-$population_size-$number_of_generation-$amount_of_mutation-$selection-$crossover.csv"
                        cmd = `julia --project=. A4.jl "A4-networks/$graph" $population_size $number_of_generation $amount_of_mutation "$selection" "$crossover" "$outfile"`
                        run(cmd)
                    end
                end
            end
        end
    end
end

