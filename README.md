# Dewey2018

Mouse cochlear vibration data from:

"Mammalian Auditory Hair Cell Bundle Stiffness Affects Frequency Tuning by Increasing Coupling along the Length of the Cochlea."
Dewey JB, Xia A, Müller U, Belyantseva IA, Applegate BE, Oghalai JS. (2018). Cell Rep. 2018 Jun 5;23(10):2915-2927. doi: 10.1016/j.celrep.2018.05.024. 
https://www.ncbi.nlm.nih.gov/pubmed/29874579

Data for each mouse strain ('C57BL6J' (wild type), 'salsa', 'Triobp', 'CBACaJ' (wild type), 'Tecta') are stored in the 'data' structure in  the appropriately named MATLAB .mat file. Substructures are measurement condition ('live' or 'dead') and sub-substructures are the measurement location ('BM','RL', or 'TM'; for basilar membrane, reticular lamina, and tectorial membrane measurements).  For example, the following lines will yield basilar membrane vibration data from live salsa mice (when executed within the data folder):

>> load salsa
>> data.live.BM

The variables stored under each measurement location are:
         freq: [1×25 double]               = stimulus frequency (Hz)
          amp: [10 20 30 40 50 60 70 80]   = stimulus amplitude (dB SPL)
     gain_all: [25×8×10 double]            = vibration magnitude normalized to middle ear displacements (i.e., gain) for all mice
     gain_ave: [25×8 double]               = gain average
      gain_sd: [25×8 double]               = gain standard deviation
       gain_n: [25×8 double]               = # of mice w/ data > 3 SDs above the noise floor for each stimulus frequency/amplitude
      gain_se: [25×8 double]               = gain standard error
      phi_all: [25×8×10 double]            =  vibration phase (radians) for all mice
      phi_ave: [25×8 double]               = phase average
       phi_sd: [25×8 double]               = phase standard deviation
        phi_n: [25×8 double]               = # of mice w/ data > 3 SDs above the noise floor for each stimulus frequency/amplitude
       phi_se: [25×8 double]               = phase standard error

The function ave_plot.m can be called with each mouse strain as an argument to recreate the majority of the plot panels from Figs. 3-6 of the manuscript. The following line will reproduce panels from Fig. 4 (when executed within the data folder).

>> ave_plot('salsa')
