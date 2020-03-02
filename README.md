# HematopoiesisModelComparison
## Comparison of different lineage hierarchy models describing hematopoiesis

contains code and data accompanying

<strong>Dynamic Modeling of Stem and Progenitor Cell Kinetics Identifies Plausible Hematopoietic Lineage Hierarchies</strong> (in preparation)

Lisa Bast<sup>1,2,3,\*</sup>, Michèle C. Buck<sup>4,\*</sup>, Lynette Henkel<sup>5</sup>, Judith S. Hecker<sup>4</sup>, Florian Bassermann<sup>4,6</sup>, Robert A.J. Oostendorp<sup>4</sup>, Katharina S. Götze<sup>4,6,+</sup> and Carsten Marr<sup>1,2,+</sup>

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
- MATLAB (R2017a), usage of Toolboxes:
  - PESTO (https://github.com/ICB-DCM/PESTO/)
  - AMICI (https://github.com/ICB-DCM/AMICI) 
  - STRIKEGOLDD (https://github.com/afvillaverde/strike-goldd_2.1)
 
  which are already included in folder 'tools' but need to get unzipped. Note that AMICI uses '.mex' files and requires MinGW as C/C++ compiler.   If you have not used mex with MATLAB before you might need to set it up first (by following these instructions: https://de.mathworks.com/help/matlab/matlab_external/install-mingw-support-package.html).


download the required data and code from folder <strong>MATLAB</strong> 

<h3>Model selection</h3>
First go to folder <strong>./Model_Selection</strong> and specify the directories in <strong>setPaths()</strong>. To perform model selection  

  1a) open <strong>getAppSettings_hierarchy.m</strong> and specify opt.realdata=false; to perform model selection on in silico data.
    
  1b) open <strong>getAppSettings_hierarchy.m</strong> and specify opt.realdata=true; to perform model selection on experimental data. 
    
  2) run <strong>RUN_H_hierarchy()</strong>.

<h3>Structural identifiability analysis for multi-compartmental models</h3>
To perform structural identifiability analysis go to <strong>./Structural_Identifiability_Analysis</strong>.

  1. specify the directories in <strong>setPaths()</strong>.
    
  2. run <strong>Create_Structural_Identifiability_Files.m</strong>.
    
<h3>Results visualization</h2> 
Go to ...
    

