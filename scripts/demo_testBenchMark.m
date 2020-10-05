%% 
% This scripts used to demo our algorithm on the bechmark PS database in
% the following paper
% A Benchmark Dataset and Evaluation for
% Non-Lambertian and Uncalibrated Photometric Stereo
% 
% We test the coarse-to-fine search strategy


function demo_testBenchMark(obj_name)

%% configs
base_dir = '/mnt/workspace2019/enomoto/dataset/DiLiGenT/pmsData/';
lights_path = [base_dir, sprintf('%s/light_directions.txt', obj_name)];
merl_dir = 'data/brdfs/';
brdf_dir = sprintf('/mnt/workspace2019/enomoto/iccp_dl_ps/data/Bmatrices/%s/', obj_name);
out_dir = sprintf('/mnt/workspace2019/enomoto/iccp_dl_ps.fork/results/diligent_tol_3/%s/', obj_name);
mkdir(out_dir);

%% 1.  load the lighting directions
fid = fopen(lights_path,'rb');
temp = textscan(fid, '%f %f %f');
lightMatrix = [temp{1} temp{2} temp{3}];
light = lightMatrix';

%% 2. generate B matrix in different scale
%files  = 'e:/psmImages/matlabCode/BRDF_data/'; %path to raw BRDF files
% 
%save_path = 'F:/newCode/B_matrix/benchMark/bear/';
load('data/candidate normals/canNormal.mat');
deg = {'10', '5', '3', '1', '0_5'};
%for kk = 1:length(canNormal)
%    normlas = canNormal{kk};
%    [B_totalR, B_totalG, B_totalB] = genBmatrix(normals, light, merl_dir, 1);
%    save([brdf_dir sprintf('Bn%d_%s.mat', kk, deg{kk})], 'normals', 'B_totalR', 'B_totalG', 'B_totalB');
%end
%% 3. load B matrix and candidate normals
[Bn, canNormal, mapSet] = initialize(brdf_dir);
normals = canNormal{5};
%% 4. load data from PS testbench mark database
%base_dir = 'F:/PS_benchmark/pmsData/'; % path to the input data;
[tSampleR, tSampleG, tSampleB, mask, lM, Normal_Gt]= processPsData(1, base_dir, obj_name);

%% 5. run our algorithm
opt.lid = 1:96; % lighting distributions
opt.start = 2; % start scale for multi-sclae;
opt.mapSet = mapSet; 
%
opt.thres = 3/255; % the threshold to reject shadows
                % we use 1/255 or 3/255 for testBenchmark database
                % you may need to change the value for optimal performance
% candiate normal ids
[idMat, ~] = ms_normalEst(Bn, tSampleR, tSampleG, tSampleB, opt);

% genertate est surface normals
if size(mask, 3) > 1
    mask = rgb2gray(mask);
end
mask = mask > 0;

Normal_Est = zeros([size(mask), 3]);
Normal_Est = reshape(Normal_Est, [], 3);
Normal_Est(mask > 0, :) = normals(:, idMat(5, :))';
Normal_Est = reshape(Normal_Est, [size(mask) 3]);

save(sprintf('%s/idMat.mat', out_dir), 'idMat');
save(sprintf('%s/normals.mat', out_dir), 'normals');
save(sprintf('%s/Normal_Est.mat', out_dir), 'Normal_Est');

ang_e = calAngE(Normal_Gt, Normal_Est, find(mask > 0));
disp(mean(ang_e(mask > 0)));
filename = sprintf('%s/mange.txt', out_dir);
fileID = fopen(filename, 'w');
fprintf(fileID, 'Mean Angular Error: %s', num2str(mean(ang_e(mask > 0))));
fclose(fileID);

save(sprintf('%s/ang_e.mat', out_dir), 'ang_e');
