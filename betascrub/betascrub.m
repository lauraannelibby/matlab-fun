function bad=betascrub(betas,gmmask,varargin)
%BETASCRUB    Identifies funky single trial beta images.
%   bad = BETASCRUB(BETAS,GMMASK) returns a vector of trials with mean 
%   absolute Z scores (across time) that are higher than a set threshold 
%   (see below). BETAS is a 4D matrix of single-trial beta images. GMMASK 
%   is a 3D matrix of grey matter voxels in the same space (alignment and 
%   dimensions) as the beta images. All non-zero voxels will be used as a 
%   mask. Ideally, this function will be run iteratively for each subject 
%   to identify an optimal mean absolute Z threshold.
%
%   bad = BETASCRUB(BETAS,GMMASK,'PropertyName',PropertyValue,...) sets
%   multiple property values. The available properties are:
%   
%       'threshold' : a numeric mean absolute Z threshold (default=1.5)
%       'showhist'  : 0 to hide histogram of mean abs Z scores (default=1)
%   
%   Example:
%       % First iteration, run with defaults.
%       bad = betascrub(allbetas,gm)
%
%       % After checking histogram for all subjects and determining custom 
%       % threshold, run again.
%       bad = betascrub(allbetas,gm,'threshold',2)
%
%       % Once you have a set threshold and don't need to inspect
%       % histograms, turn them off.
%       bad = betascrub(allbetas,gm,'threshold',2,'showhist',0)
%
%   Notes/tips: 
%       Technically, any mask (in the same space as betas) can be used.
%       A grey matter mask is simply advised.
%
%       Run this script separately for every subject, but use the same 
%       threshold for everybody.
%
%   Relevant publications:
%       Libby LA, Hannula DE, Ranganath C (2014). Medial temporal lobe coding
%           of item and spatial information during relational binding in 
%           working memory. The Journal of Neuroscience, 34, 14233-14242.
%
%       Libby LA, Ragland JD, Ranganath C (Under review and in preprint).
%           The hippocampus generalizes across memories that share item and
%           context information.
%
%   By Laura A Libby, lauraannelibby.github.io, 05/05/2016 (R2015a)

% Set defaults
defaultThreshold = 1.5;
defaultShowhist = 1;

% Parse and validate input
p = inputParser;
addRequired(p,'betas',@isnumeric);
addRequired(p,'gmmask',@isnumeric);
addOptional(p,'threshold',defaultThreshold,@(x) isnumeric(x) & x>0); % threshold must be > 0
addOptional(p,'showhist',defaultShowhist,@(x) ismember(x,[0,1]));
parse(p,betas,gmmask,varargin{:});
threshold=p.Results.threshold;
showhist=p.Results.showhist;

% Calculate absolute zscore of all voxels across time
abszbetas=abs(zscore(betas,1,4));

% Calculate mean absolute zscore of gm voxels for each trial
zmeans=zeros(size(abszbetas,4),1);
for b=1:length(zmeans)
    trial=abszbetas(:,:,:,b);
    zmeans(b)=mean(trial(gmmask>0));
end

% Find suprathreshold trials
bad=find(zmeans>threshold);
nbad=length(bad);

% Plot zmean histogram, unless turned off
if showhist
    figure;
    hist(zmeans,50);
    g=get(gca);
    title(sprintf('Threshold = %2.2f, Bad trials = %u',threshold,nbad));
    xlabel('mean absolute Z (across time)')
    ylabel('# trials')
    line([threshold threshold],g.YLim);
end



