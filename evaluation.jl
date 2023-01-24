import DataFrames
import CSV
import Glob

df = DataFrames.DataFrame()

if !isfile("results/0_all_results.csv")
    print("Reading data...")
    for result_file in Glob.glob("*.csv", "results")
        push!(df, CSV.read(result_file, DataFrames.DataFrame)[end, :], promote=true)
    end
    println("done.")
    CSV.write("results/0_all_results.csv", df)
else
    print("Reading data...")
    df = CSV.read("results/0_all_results.csv", DataFrames.DataFrame)
    println("done.")
end

# get the maximum of Max Fitness for each NET Graph and display the parameters for it
# these are the best parameters for each NET Graph
for graph in unique(df[!, "NET Graph"])
    println("----------------------------------------")
    println("NET Graph: $graph")
    println("----------------------------------------")
    entry = df[df[!, "NET Graph"] .== graph, :]
    entry = entry[entry[!, "Max Fitness"] .== maximum(entry[!, "Max Fitness"]), :]
    println("Population Size: $(entry[!, "Population Size"][1])")
    println("Number of Generations: $(entry[!, "Number of Generations"][1])")
    println("Amount of Mutations: $(entry[!, "Amount of Mutations"][1])")
    println("Selection Function: $(entry[!, "Selection Function"][1])")
    println("Crossover Function: $(entry[!, "Crossover Function"][1])")
    println("Max Fitness: $(entry[!, "Max Fitness"][1])")
    println("Max Modularity: $(entry[!, "Max modularity"][1])")
    println()
end