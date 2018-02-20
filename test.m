%VALIDATED!
clear
clc
fprintf('\n=== Starting NSGA2 test ===\n')

%define your optimisation problem
nVars = 2;
problem = Problem([-1 -1], nVars);
%set NSGA-II parameters
nGenerations = 500;
nIndividuals = 40;
nBits = 26; %number of genes
pC = 0.9; %crossover probability
pM = 1/(nBits*nVars); %mutation probability
probs = [pC pM];
%get NSGA-II object
mobjga = Nsga2BinCoded(nIndividuals, nBits, probs, problem);
%start loop
tic = cputime;
for gen = 1:nGenerations+1 %plus one because we apply the elite operator in the last gen's solution, for example...if you want 500 generations you need to apply elitism of gen501 in the last solution(gen500), using
    fprintf('\ngeneration %d', gen);
    %non-dominated sorting
    [mobjga.F ,mobjga.Rt] = mobjga.nonDominatedSorting(); 
    %initialize P(t+1) and set the total number of fronts needed to create P(t+1)
    [newPopIdxs, lastFrontIdx] = mobjga.setNewPopulation();
    %get full P(t+1) 
    [mobjga.mpCandidates, mobjga.Pt, ~] = mobjga.getCrowdingDistances(lastFrontIdx, newPopIdxs); 
    %get mating pool
    mobjga.Mpool = mobjga.crowdedTSO(lastFrontIdx); 
    %get Q(t+1)
    mobjga.Qt = mobjga.getOffspring(); 
end
%get generation i solution
mobjga.finalFront = mobjga.getFinalFront();
toc = cputime - tic;
fprintf('\n-> elapsed CPU time: %.2fs', toc);
%plot final front
%plot(mobjga.finalFront(:,1), mobjga.finalFront(:,2), '*')
%get optimal pareto front
paretoFront = getOptimalFront(mobjga);  
%plot(paretoFront(:,1), paretoFront(:,2))
f1 = mobjga.finalFront(:,1);
f2 = mobjga.finalFront(:,2);
f1opt = paretoFront(:,1);
f2opt = paretoFront(:,2);
plot(f1opt, f2opt ,'b');
hold on
plot(f1, f2, 'k*');
title('NSGA-II Test');
stringLegend = nGenerations + " generations," + " popsize = " + ...
    nIndividuals + ", pX = " + pC + ", pM = " + pM;
legend('pareto front', stringLegend);
xlabel('F1')
ylabel('F2')
hold off
fprintf('\nDone!\n');