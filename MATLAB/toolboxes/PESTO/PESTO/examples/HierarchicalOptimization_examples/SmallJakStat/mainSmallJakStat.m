% Main file of the JakStat signaling model I  example.
%
% Demonstrates the use of:
% * logLikelhoodHierarchical()
%
% Performs parameter estimation for the standard and hierarchical approach
% and Gaussian and Laplace noise.

clear
close all
clc

addpath(genpath('/Users/lisa.bast/Documents/MATLAB_WD/class_0/Tools'))
addpath(genpath('/Users/lisa.bast/Documents/MATLAB_WD/class_0/Tools/PESTO/examples/HierarchicalOptimization_examples/SmallJakStat'))
compilation_JakStat
%%
runEstimation_JakStat('hierarchical','normal')
% runEstimation_JakStat('hierarchical','laplace')
% 
% runEstimation_JakStat('standard','normal')
% runEstimation_JakStat('standard','laplace')
% %%
% runEstimation_JakStat('hierarchical','normal','pswarm')
% runEstimation_JakStat('hierarchical','laplace','pswarm')
% 
% runEstimation_JakStat('standard','normal','pswarm')
% runEstimation_JakStat('standard','laplace','pswarm')
