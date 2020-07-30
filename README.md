# HematopoiesisModelComparison
## Comparison of different lineage hierarchy models describing hematopoiesis

contains code and data accompanying

____Computational modeling of stem and progenitor cell kinetics to identify plausible hematopoietic lineage hierarchies____

Lisa Bast<sup>1,2,3,\*</sup>, Michèle C. Buck<sup>4,\*</sup>, Judith S. Hecker<sup>4</sup>, Robert A.J. Oostendorp<sup>4</sup>, Katharina S. Götze<sup>4,6,+</sup> and Carsten Marr<sup>1,2,+</sup>

<sub><sup>
<sup>1</sup>Institute of Computational Biology, Helmholtz Zentrum München–German Research Center for Environmental Health, Neuherberg, Germany. <br>
<sup>2</sup>Department of Mathematics, Chair of Mathematical Modeling of Biological Systems, Technische Universität München, Garching, Germany. <br>
<sup>3</sup>Laboratory of Molecular Neurobiology, Department of Medical Biochemistry and Biophysics, Karolinska Institutet, Stockholm, Sweden.<br>
<sup>4</sup>Department of Medicine III, Technical University of Munich, Klinikum rechts der Isar, Munich, Germany. <br>
<sup>5</sup>Institute of Microbiology, Technische Universität München, Munich, Germany. <br>
<sup>6</sup>German Cancer Consortium (DKTK), Heidelberg, Partner Site Munich.<br>
<sup>\*</sup> Equal contribution  <br>
<sup>+</sup> Joint corresponding authors  <br>
</sup></sub>

required software: 
- MATLAB R2017a
- Python 3.7.6

MATLAB toolboxes:
- [PESTO] 1.1.0 (https://github.com/ICB-DCM/PESTO/) 
- [AMICI] 0.10.7 (https://github.com/ICB-DCM/AMICI) 
- [STRIKEGOLDD] 2.1 (https://github.com/afvillaverde/strike-goldd_2.1) 
 
which are already included in folder <strong>./MATLAB/toolboxes</strong>. Note that AMICI uses `.mex` files and requires `MinGW` as `C/C++` compiler. If you have not used `mex` with MATLAB before you might need to set it up first (by following these [instructions](https://de.mathworks.com/help/matlab/matlab_external/install-mingw-support-package.html).

Python tools:
- pandas 
- numpy 
- seaborn
- matplotlib
- scipy
- os
- fnmatch

### Model comparison analysis
#### Intermediate states Analysis

 1) Go to folder <strong>./MATLAB/model_comparison_analysis</strong> and run <strong>intermediate_states_main()</strong>. Settings can be adapted in <strong>getIntermediateStatesSettings.m</strong>.
 
 2) For Results visualization run jupyter notebook results_visualization_intermediate_states.ipynb.
    
#### Lineage Hierarchy comparison

 1) Go to folder <strong>./MATLAB/model_comparison_analysis</strong> and run <strong>lineage_hierarchies_main()</strong>. Settings can be adapted in <strong>getLineageHierarchySettings.m</strong>.
 
 2) For Results visualization run jupyter notebook results_visualization_lineage_hierarchies.ipynb.

### Structural identifiability analysis for multi-compartmental models
To perform structural identifiability analysis go to <strong>.MATLAB/structural_identifiability_analysis</strong> and run <strong>structural_identifiability_main()</strong>. Settings and paths can be updated iun <strong>getSISettings.m</strong> if necessary. 
  
### In silico analysis
 1) To perform in silico model selection go to folder <strong>./MATLAB/in_silico_analysis</strong>, specify settings in <strong>getInSilicoSettings.m</strong> and run <strong>in_silico_main()</strong>.
 
 2) For Results visualization go to folder <strong>./Python</strong> and run jupyter notebook <strong>results_visualization_in_silico_analysis.ipynb</strong>
 
In general, to change settings regarding optimization such as number of multistarts or number of workers (to run code in parallel) go to folder <strong>./MATLAB/utils</strong> and make changes in <strong>getOptimizationSettings.m</strong>

    
    

