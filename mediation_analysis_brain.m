% cd /fmri2/projects/RDoC/PPIproject/Analysis/mediation/

% get X, Y, and M variables needed for analysis
cd /fmri2/projects/RDoC/PPIproject/Analysis/mediation/SE_PCA/CI-II/gray_matter_PCA_brain_Vine
dinf = what('gray_matter_PCA_brain_Vine');
imgs = fullfile(dinf.path, 'CI_vs_II_contrast_images.nii.gz');

behav_dat = importdata(fullfile(dinf.path,'X_Y_measures.txt'));

x=behav_dat(:,3);
y=behav_dat(:,4);
names = {'X:PCA1' 'Y:Vineland_Socialization' 'M:gray_matter_mask'};

% get mask
mask = which('gray_matter_mask.nii');
canlab_results_fmridisplay(mask, 'compact2');

% This is what you would run:
% results = mediation_brain(x,y,imgs,'names',names,'mask', mask);

% We run this instead to suppress output for report publishing
str = 'results = mediation_brain(x,y,imgs,''names'',names,''mask'', mask);';
disp(['Running with output suppressed (for report-generation): ' str]);
evalc(str);
mediation_brain_results_all_script;