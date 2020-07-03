# HematopoiesisModelComparison
## Comparison of different lineage hierarchy models describing hematopoiesis

contains code and data accompanying

____Computational Modeling of Stem and Progenitor Cell Kinetics Identifies Plausible Hematopoietic Lineage Hierarchies____

Lisa Bast<sup>1,2,3,\*</sup>, Michèle C. Buck<sup>4,\*</sup>, Judith S. Hecker<sup>4</sup>, Florian Bassermann<sup>4,6</sup>, Robert A.J. Oostendorp<sup>4</sup>, Katharina S. Götze<sup>4,6,+</sup> and Carsten Marr<sup>1,2,+</sup>

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
- MATLAB (R2017a)
- [PESTO](https://github.com/ICB-DCM/PESTO/) @note: can you please add the version
- [AMICI](https://github.com/ICB-DCM/AMICI) @note: can you please add version 
- [STRIKEGOLDD](https://github.com/afvillaverde/strike-goldd_2.1) @note: can you please add version
 
which are already included in folder `tools` but need to get unzipped. Note that AMICI uses `.mex` files and requires `MinGW` as `C/C++` compiler. If you have not used `mex` with MATLAB before you might need to set it up first (by following these [instructions](https://de.mathworks.com/help/matlab/matlab_external/install-mingw-support-package.html).


### Structural identifiability analysis for multi-compartmental models
To perform structural identifiability analysis go to <strong>./Structural_Identifiability_Analysis</strong>.

  1. specify the directories in <strong>setPaths()</strong>.
    
  2. run <strong>Create_Structural_Identifiability_Files.m</strong>.
  
### In silico model selection 

@TODO: in which folder?

 1) specify opt.realdata = false; and set noise related settings in <strong>getAppSettings_hierarchy.m</strong> and run <strong>RUN_H_hierarchy()</strong>.
 
 2) for Results visualization run Hematopoiesis_Graphics_Results_hierarchyComparisonRun_in_silico.ipynb @TODO: which file? I could not find the file
 
### Real data model selection

First go to folder <strong>./Model_Selection</strong> and specify the directories in <strong>setPaths()</strong>. To perform model selection  

  1) open
  
    a) <strong>getAppSettings_hierarchy.m</strong> and specify opt.realdata=false; to perform model selection on in silico data.
  
    b) <strong>getAppSettings_hierarchy.m</strong> and specify opt.realdata=true; to perform model selection on experimental data. 
    
  2) run <strong>RUN_H_hierarchy()</strong> and specify in <strong>getAppSettings_hierarchy.m</strong> which models to compare and which data to use for the fit.
  
  3) run BuildScoresMatrix() for selection of models that should be compared.
  
  4) for Results visualization run jupyter notebook
  
    a) Hematopoiesis_Graphics_Results_hierarchyComparisonRun.ipynb for a fixed number of intermediate states but varying hierarchies (model_A, model_B, etc.)
  
    b) Hematopoiesis_Graphics_Results_hierarchyComparisonRun_IntermediateStates_redData.ipynb if different numbers of intermediate states should be compared
 


    
    

