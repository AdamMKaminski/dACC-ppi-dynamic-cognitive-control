% CONN output; get images
% Adapted from CANlab Core Toolbox 
% https://canlab.github.io/_pages/tutorials/html/mediation_brain_multilevel_walkthrough1.html

cd '/fmri2/projects/RDoC/PPIproject/Fall_rotation_2019/conn_files/conn_project01_fmriprep_ALL_schaefer_mask/results/secondlevel/SocStroop_SBC_04/con_adapt_motion'

dinf = what('cont_conflict');
imgs = fullfile(dinf(1).path,'CON_Subjects_all_compA001_001.nii.gz');

cd 'cont_conflict/FPN_mediation/'
mask = which("conn_bool_resam_Yeo7NetworkMaps_fromSchaefer4007AFNI_Cont.nii_onatlas.nii");

p_factor = [0.6385
1.5064
12.4388
5.1303
19.4295
5.2668
14.3235
-9.2609
-5.0857
-3.365
-4.5354
-10.462
-22.402
10.2999
41.9567
4.2423
-15.4054
-6.8109
-8.6894
-30.0507
-10.6946
13.3102
-24.9671
24.799
33.2218
0.2087
-27.9051
-16.3093
15.2272
-21.3476
-7.188
5.9533
0.247
12.2683
18.6161
0.2024
-0.1977
-16.8663
-8.3807
29.7801
-8.5959
-21.865
-23.9045
-28.0839
-7.049
14.4286
1.8865
-18.2418
4.5915
9.641
16.2108
4.4526
-26.6968
-20.5459
8.6622
32.7228
-2.5526
-6.5642
-24.0435
3.2512
-20.7381
28.8991
-26.9693
33.2678
-23.3482
41.5268
9.4359
21.1078
8.4883
-16.0022
-16.1905
15.0343
52.1821
-22.8072
5.6733
19.4835
9.5103
-22.9762
-24.3206
-2.2779
-21.538
-5.7986
-1.614
-2.3579
-2.75
-6.398
8.7351
48.1132
-12.2181];

vabs_abc = [93
78
66
94
85
76
87
104
84
81
88
91
93
87
89
101
91
87
94
88
94
75
105
79
74
101
84
101
75
93
89
87
76
93
108
83
93
84
94
103
123
110
83
90
71
84
88
87
88
74
80
71
109
94
72
82
116
97
95
83
88
75
90
69
102
74
87
67
76
108
85
83
51
112
98
71
75
94
98
78
95
85
80
99
88
88
81
64
94];

cd 'output3'

names = {'X:p-factor' 'Y:AdaptiveBehavior' 'M:BrainMediator'};
results = mediation_brain(p_factor,vabs_abc,imgs,'names',names,'mask',mask,'noverbose');
%results = mediation_brain(p_factor,vabs_abc,imgs,'names',names,'mask', mask,'boot','pvals',5, 'bootsamples', 10000, 'noverbose');

%publish_mediation_report;

% imgs = {};
% for i = 1:89
%     
%     id = '';
%         if i < 10
%             id = strcat('00',int2str(i));
%         elseif i < 100
%             id = strcat('0',int2str(i));
%         else
%             id = int2str(i);
%         end
%     
%         %imgs(i) = fullfile(dinf(1).path,['CON_Subject' id '_compA001_001.nii']);
%         
%         
%     imgs(i) = {['/Users/adamkaminski/Desktop/PhD/Research_and_grants/Paper_1/SUBMISSION/RESUBMISSION/New_data/mediation_wager/CONN_output/cont_conflict/CON_Subject' id '_compA001_001.nii']};
% end
% images_t = imgs';
% cd '..'
% mask = which("resam_2mm_Schaefer_7N_400_addSubCortical_01mask.nii");
% 
% 
% cd mediation_results
% 
% SETUP.mask = mask;
% SETUP.preprocX = 0;
% SETUP.preprocY = 0;
% SETUP.preprocM = 0;
% 
% % mediation_brain_multilevel(X, Y, M, [other inputs])
% mediation_brain_multilevel(p_factor,vabs_abc, imgs, SETUP)
