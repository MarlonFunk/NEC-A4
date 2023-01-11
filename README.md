# Genetic Algorithm

## Prerequisites

- Install [Julia 1.8](https://julialang.org/downloads/). **It has to be available in the path.**

## Installation

Install the dependencies by doing:
```sh
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

## Usage

Run the algorithm by doing:
```sh
julia --project=. A4.jl <graph_path> <population_size> <number_of_generations> <amount_of_mutations> <selection_function> <crossover_function>
```
**Note**: The selection function implemented are the following: `roulette`, `tournament`. The crossover function implemented are the following: `one_point`, `uniform`.

Run the analysis by doing:
```sh
julia --project=. analysis.jl
```

**Note**: During development, when adding or removing a package to the Julia project, regenerate the manifest with `julia --project=. -e 'using Pkg; Pkg.resolve()'`

## Credits

Marlon Funk [ [GitHub](https://github.com/MarlonFunk) ] – Co-developer
<br>
Romain Monier [ [GitHub](https://github.com/rmonier) ] – Co-developer

## Contact

Project Link: https://github.com/MarlonFunk/NEC-A4