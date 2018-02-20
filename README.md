# binCodedNSGA2
*A constrained binary coded NSGA-II (Deb, 2002) for research purposes*

The motivation for the development of this code was the necessity to handle nonconvex nonlinear mixed integer multiobjective optimisation
problems, which can't be solved by commercial solvers in an acceptable period of time.

How to use:

1. Set up your multiobjective optimisation problem modifying Problem.m object, setF1.m, setF2.m and setConstraints.m contained in @Problem
folder.

2. Modify test.m file: 
  ->Set NSGA-II parameters: number of generations, population size, number of bits, crossover and mutation probabilities
