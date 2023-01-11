graphs = ["20x2+5x2.net", "256_4_4_2_15_18_p.net", "256_4_4_4_13_18_p.net", "adjnoun.net", "cat_cortex_sim.net", "circle9.net", "clique_stars.net", "cliques_line.net", "dolphins.net", "graph3+1+3.net", "graph3+2+3.net", "grid-6x6.net", "grid-p-6x6.net", "qns04_d.net", "rb25.net", "rb125.net", "rhesus_simetrica.net", "star.net", "wheel.net", "zachary_unwh.net"]
population_sizes = [10, 100, 1000]
number_of_generations = [10, 100, 1000]

for graph in graphs
    for population_size in population_sizes
        for number_of_generation in number_of_generations
            outfile = "results/$graph-$population_size-$number_of_generation.txt"
            cmd = `julia --project=. A4.jl "A4-networks/$graph" $population_size $number_of_generation "$outfile"`
            run(cmd)
        end
    end
end

