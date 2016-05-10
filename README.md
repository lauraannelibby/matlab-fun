# matlab-fun
MATLAB code from various projects and dalliances

## [betascrub]()
A handy little function to identify wonky single-trial beta images on the basis of unusual signal intensities in grey matter voxels. Applicable to single-trial estimates used in fMRI multivariate pattern analysis (classification, pattern similarity) and beta series correlation analysis, among others.
* Expects a 4D file of whole-brain single-trial images (where time is the 4th dimension, as it should be) and a 3D mask image in the same space. Mask does not have to be binary, but function uses all voxels > 0 as the mask.
* Outputs a vector containing bad trial numbers and plots histogram of mean GM absolute z scores (across trials). 
* Options include customizing the mean absolute z threshold (default = 1.5) and turning off histogram plotting (default = on).
* Best practice: Run betascrub iteratively to identify the optimal threshold for your dataset, applying the same threshold uniformly across participants.

## [cogneurojobs](https://github.com/lauraannelibby/matlab-fun/tree/master/cogneurojobs)
History of changes from the [Psychology Job Wiki](http://psychjobsearch.wikidot.com/) [2014-2015](http://psychjobsearch.wikidot.com/2014) faculty job market, parsed and plotted to find surges in new postings for cognitive neuroscience positions.
* Here's the [code](https://github.com/lauraannelibby/matlab-fun/blob/master/cogneurojobs/jobs.m)
* Here's the [output](https://github.com/lauraannelibby/matlab-fun/blob/master/cogneurojobs/jobs_2014-2015.pdf)

