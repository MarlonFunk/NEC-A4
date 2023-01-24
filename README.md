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
> **Note** The selection functions implemented are the following: `roulette`, `tournament` and `rank`.
> The crossover functions implemented are the following: `one_point`, `uniform`.


<details>
    <summary>Best parameters</summary>
    <p>
    <p>----------------------------------------<br />NET Graph: 20x2+5x2.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: uniform<br />Max Fitness: 17.21811301763276</p>
<p>----------------------------------------<br />NET Graph: 256_4_4_2_15_18_p.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 1000<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: one_point<br />Max Fitness: 18.255441637808982</p>
<p>----------------------------------------<br />NET Graph: 256_4_4_4_13_18_p.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: one_point<br />Max Fitness: 19.62977718333518</p>
<p>----------------------------------------<br />NET Graph: adjnoun.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 1000<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: uniform<br />Max Fitness: 6.790261706690035</p>
<p>----------------------------------------<br />NET Graph: cat_cortex_sim.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 100<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: one_point<br />Max Fitness: 3.0112973169045336</p>
<p>----------------------------------------<br />NET Graph: circle9.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 1000<br />Amount of Mutations: 1<br />Selection Function: roulette<br />Crossover Function: one_point<br />Max Fitness: 7.1720774272214705</p>
<p>----------------------------------------<br />NET Graph: clique_stars.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: roulette<br />Crossover Function: uniform<br />Max Fitness: 8.663144236491934</p>
<p>----------------------------------------<br />NET Graph: cliques_line.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: uniform<br />Max Fitness: 16.67755719188137</p>
<p>----------------------------------------<br />NET Graph: dolphins.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 1000<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: one_point<br />Max Fitness: 12.12955063774663</p>
<p>----------------------------------------<br />NET Graph: graph3+1+3.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 100<br />Amount of Mutations: 1<br />Selection Function: roulette<br />Crossover Function: one_point<br />Max Fitness: 4.55682373046875</p>
<p>----------------------------------------<br />NET Graph: graph3+2+3.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 1000<br />Amount of Mutations: 1<br />Selection Function: roulette<br />Crossover Function: uniform<br />Max Fitness: 4.693795735443437</p>
<p>----------------------------------------<br />NET Graph: grid-6x6.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: uniform<br />Max Fitness: 15.520651851852033</p>
<p>----------------------------------------<br />NET Graph: grid-p-6x6.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 1000<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: uniform<br />Max Fitness: 15.295469916933792</p>
<p>----------------------------------------<br />NET Graph: qns04_d.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: one_point<br />Max Fitness: 17.888588873481844</p>
<p>----------------------------------------<br />NET Graph: rb125.net<br />----------------------------------------<br />Population Size: 50<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: uniform<br />Max Fitness: 5.150291531166661</p>
<p>----------------------------------------<br />NET Graph: rb25.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: one_point<br />Max Fitness: 5.199185551250911</p>
<p>----------------------------------------<br />NET Graph: rhesus_simetrica.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 1000<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: one_point<br />Max Fitness: 1.110721515979026</p>
<p>----------------------------------------<br />NET Graph: wheel.net<br />----------------------------------------<br />Population Size: 25<br />Number of Generations: 500<br />Amount of Mutations: 1<br />Selection Function: tournament<br />Crossover Function: uniform<br />Max Fitness: 1.1744270324707031</p>
<p>----------------------------------------<br />NET Graph: zachary_unwh.net<br />----------------------------------------<br />Population Size: 100<br />Number of Generations: 100<br />Amount of Mutations: 1<br />Selection Function: roulette<br />Crossover Function: one_point<br />Max Fitness: 6.542126533592129</p>
    </p>
</details>

<br>

Run the analysis by doing:
```sh
julia --project=. analysis.jl
```

After the analysis, proceed to the evaluation to get the best parameters for each network by doing:
```sh
julia --project=. evaluation.jl
```

> **Note** During development, when adding or removing a package to the Julia project, regenerate the manifest with `julia --project=. -e 'using Pkg; Pkg.resolve()'`

## Credits

Marlon Funk [ [GitHub](https://github.com/MarlonFunk) ] – Co-developer
<br>
Romain Monier [ [GitHub](https://github.com/rmonier) ] – Co-developer

## Contact

Project Link: https://github.com/MarlonFunk/NEC-A4
