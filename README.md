# Multiscale structural gradient differentiation correlates with cortical morphology maturation and functional specialization from childhood to adolescence


## Code


The source code for our analysis is provided in the code folder. We used the following open-source packages:


1.Geodesic distance was calculated by the imGeodesics toolbox (https://github.com/mattools/matImage/wiki/imGeodesics).

2.Multiscale structural connectome was generated using the package provided at https://github.com/MICA-MNI/micaopen/tree/master/structural_manifold (1).	

3.Gradient analysis was performed using the BrainSpace toolbox (https://github.com/MICA-MNI/brainspace) (2).	

4.The variogram matching approach was used to estimate the spatial correlation significance by generating surrogate maps (3) (https://github.com/murraylab/brainsmash).	

5.Partial least square correlation was performed with the myPLS toolbox (https://github.com/danizoeller/myPLS).	

6.The AHBA dataset was preprocessed with the abagen toolbox (https://github.com/netneurolab/abagen).


## Data


All data are available in Releases (https://zenodo.org/records/14440214), , which includes individual structural connectivity features (MPC, TS, and GD), multiscale structural gradients, cortical morphology principal component 1 (PC1), structural-functional connectivity (SC-FC) coupling, global gradient measures, and their corresponding age-effect results from generalized additive models (GAMs). AHBA gene expression data, processed using the abagen toolbox, was also provided. Neuroimaging data of all participants were obtained from the Children School Functions and Brain Development project (CBD, Beijing Cohort). All data were based on the Schaefer 1000 atlas.


## References

(1)Paquola C, Seidlitz J, Benkarim O, Royer J, Klimes P, Bethlehem RAI, et al. A multi-scale cortical wiring space links cellular architecture and functional dynamics in the human brain. PLoS Biology. 2020;18(11).

(2)Vos de Wael R, Benkarim O, Paquola C, Lariviere S, Royer J, Tavakol S, et al. BrainSpace: a toolbox for the analysis of macroscale gradients in neuroimaging and connectomics datasets. Communications Biology. 2020;3(1):103.

(3)Burt JB, Helmer M, Shinn M, Anticevic A, Murray JD. Generative modeling of brain maps with spatial autocorrelation. NeuroImage. 2020;220:117038.
