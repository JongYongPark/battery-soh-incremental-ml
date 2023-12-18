

gen_header = false ;
%gen_header = true ;

%save_data = false ;
save_data = true ;

%load_data = false ;
load_data = true ;

%save_data_from_scratch = true ;
save_data_from_scratch = false ;

if load_data  == true
load ryan5_battery_dataset.mat
load ryan5_data.mat
%load ryan5_data_for_test.mat
end
%%

if save_data == true
ryan5_data_for_test_desc = "ryan5_data_for_test";

if save_data_from_scratch == true
save('ryan5_data_for_test.mat','ryan5_data_for_test_desc');
end

end

%%
line_1='--';
line_2='-.';
line_3=':';
nth_fit = 5;


%clear Ic Id Td Tc Vc Vd 
%%

idxAll
idxTest
idxTestSort
%%
cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;
nLines = length(idxAll);
idxTestCount = nLines;
%legend_str = cell(nLines,1);

figure
hold on 
for j = 1 : idxTestCount
    i = idxAll(j);
    plot(ryan5_battery_dataset(i).cycle,ryan5_battery_dataset(i).QDischarge)
    cycle_life_list(j,:) = [j i ryan5_battery_dataset(i).cycle_life];
    %legend_str{j} = num2str(j) + ", " +num2str(i) + ", " + num2str(ryan5_battery_dataset(i).cycle_life);
    %pause(1)
end
ylabel 'SOH (Ah)'
xlabel 'Cycle'
hold off
title 'SOH (Ah) of dataset before smoothing '
%legend(legend_str)
%%
for j = 1 : length(idxAll)
    
    if ryan5_battery_dataset(j).cycle_life < 316  && ryan5_battery_dataset(j).cycle_life > 300
    [j, ryan5_battery_dataset(j).cycle_life ]
    end

end
%%
idxTrainValid = [idxTrain idxValid];
cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;
nLines = length(idxTrainValid);
idxTestCount = nLines;
legend_str = cell(nLines,1);

figure
hold on 
for j = 1 : idxTestCount
    i = idxTrainValid(j);
    plot(ryan5_battery_dataset(i).cycle,ryan5_battery_dataset(i).QDischargeSmooth)
    cycle_life_list(j,:) = [j i ryan5_battery_dataset(i).cycle_life];
    %legend_str{j} = num2str(j) + ", " +num2str(i) + ", " + num2str(ryan5_battery_dataset(i).cycle_life);
    %pause(1)
end
hold off
ylabel 'SOH (Ah)'
xlabel 'Cycle'
title 'Train dataset'
%%
cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;
nLines = length(idxTest);
idxTestCount = nLines;
legend_str = cell(nLines,1);

figure
hold on 
for j = 1 : idxTestCount
    i = idxTest(j);
    plot(ryan5_battery_dataset(i).cycle,ryan5_battery_dataset(i).QDischargeSmooth)
    cycle_life_list(j,:) = [j i ryan5_battery_dataset(i).cycle_life];
    %legend_str{j} = num2str(j) + ", " +num2str(i) + ", " + num2str(ryan5_battery_dataset(i).cycle_life);
    %pause(1)
end
hold off
ylabel 'SOH (Ah)'
xlabel 'Cycle'
title 'Test dataset'
%legend(legend_str)
%%
cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;
nLines = length(idxTest);
idxTestCount = nLines;
legend_str = cell(nLines,1);

figure
hold on 
for j = 1 : idxTestCount
    i = idxTest(j);
    plot(ryan5_battery_dataset(i).cycle,ryan5_battery_dataset(i).QDischargeSmooth)
    cycle_life_list(j,:) = [j i ryan5_battery_dataset(i).cycle_life];
    legend_str{j} = num2str(j) + ", " +num2str(i) + ", " + num2str(ryan5_battery_dataset(i).cycle_life);
    %pause(1)
end
hold off
ylabel 'SOH (Ah)'
xlabel 'Cycle'
title 'Test Dataset (Index,Batter Number,RUL)'
legend(legend_str)
%%

cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;
nLines = length(idxTestSort);
idxTestCount = nLines;
legend_str = cell(nLines,1);

figure
hold on 
for j = 1 : idxTestCount
    i = idxTestSort(j);
    plot(ryan5_battery_dataset(i).cycle,ryan5_battery_dataset(i).QDischargeSmooth)
    cycle_life_list(j,:) = [j i ryan5_battery_dataset(i).cycle_life];
    legend_str{j} = num2str(j) + ", " +num2str(i) + ", " + num2str(ryan5_battery_dataset(i).cycle_life);
    %pause(1)
end
hold off
ylabel 'SOH (Ah)'
xlabel 'Cycle'
title 'Test dataset with idxTestSort (idx,batNum,RUL)'
legend(legend_str)
%% 테스트 데이타 3개의 배터리 번호 선정

testdata_base_batNum = idxTest(7)
testdata_shortRul_batNum  = idxTest(1)
testdata_longRul_batNum  = idxTest(10)

testdata1_batNum_str = num2str(testdata_base_batNum) ;
testdata2_batNum_str = num2str(testdata_base_batNum) + "->" + num2str(testdata_shortRul_batNum);
testdata3_batNum_str = num2str(testdata_base_batNum) + "->" + num2str(testdata_longRul_batNum);


%%
fprintf(">> test data set based on each measure point <<")

idxTestAll

fprintf(">> find out battery index of each point <<")
idxTestAll_batIndex
%%
fprintf(">> find out each point of battery index 16 <<")
testdata_idxTestAll_batIndex = (idxTestAll_batIndex == 16)

find(idxTestAll_batIndex == testdata_base_batNum)
find(idxTestAll_batIndex == testdata_base_batNum)
idxTestAll_idx_testdata1 = idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum))
testdata_base_batNum
testdata_base_batNum
%idxTestAll_idx_testdata1_1 = idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum))

RUL(idxTestAll_idx_testdata1);
%testdata_base_batNum = testdata_base_batNum
RUL_idx_testdata1 = RUL(idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)));
ynorm_RUL_idx_testdata1 = ynorm_RUL(idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)));
SOH_idx_testdata1 = Cap(idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)));
ynorm_SOH_idx_testdata1 = ynorm_SOH(idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)));

Ic_idx_testdata1 = Ic(idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)),:);
Vd_idx_testdata1 = Vd(idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)),:);
xnorm_Vd_idx_testdata1 = xnorm_Vd(idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)),:);
%%
% clear IcFull IdFull VcFull VdFull TcFull TdFull 
%% clear Ic Id Tc Td Vc Vd 
%% 점전적 모델은 5개씩 학습하므로 딱 떨어지지 않을 경우 나머지는 버린다.

ytrain = ynorm_RUL_idx_testdata1 ;
Xtrain = xnorm_Vd_idx_testdata1 ;
Ytrain = RUL_idx_testdata1 ;
Ytrain_soh = SOH_idx_testdata1 ;

len_1  =  length(RUL_idx_testdata1 ) - mod(length(RUL_idx_testdata1 ),5) ; 

len = length(ynorm_RUL_idx_testdata1) ;
Xtrain = Xtrain(1:len_1,:);
ytrain = ytrain(1:len_1,:);
Ytrain = Ytrain(1:len_1,:);
Ytrain_soh = Ytrain_soh(1:len_1,:);


% idxSearch_idx_testdata1 = 1; % 316
% %idxSearch_idx266 = 2; % 239
% 
% testdata_base_batNum
% 

idxFindAll = find(idxTestAll_batIndex == testdata_base_batNum);
Y_test_RUL_idx_testdata1 = Y_test_RUL(idxFindAll);
Y_test_SOH_idx_testdata1 = Y_test_SOH(idxFindAll);
%Yfit_test_RUL_test1 = Yfit_test_RUL(idxFindAll);
%% 테스트 데이타 생성 
%% testdata1_change_idx testdata2_change_idx testdata3_change_idx
%% ryan5_change_bb_Qd ryan5_change_bs_Qd ryan5_change_bl_Qd

Cap_change = (Cap_Rated + Cap_EOL ) / 2 ;

[testdata2_change_idx] = find(ryan5_battery_dataset(testdata_shortRul_batNum).QDischargeSmooth >= Cap_change,1,'last') 
[testdata1_change_idx] = find(ryan5_battery_dataset(testdata_base_batNum).QDischargeSmooth >= Cap_change,1,'last') 
[testdata3_change_idx] = find(ryan5_battery_dataset(testdata_longRul_batNum).QDischargeSmooth >= Cap_change,1,'last') 

ryan5_change_ss_Qd = ryan5_battery_dataset(testdata_shortRul_batNum).QDischargeSmooth;
ryan5_change_bb_Qd = ryan5_battery_dataset(testdata_base_batNum).QDischargeSmooth;
ryan5_change_ll_Qd = ryan5_battery_dataset(testdata_longRul_batNum).QDischargeSmooth;
ryan5_change_bs_Qd = [ ryan5_change_bb_Qd(1:testdata1_change_idx) ; ryan5_change_ss_Qd(testdata2_change_idx+1:end) ];
ryan5_change_bl_Qd = [ ryan5_change_bb_Qd(1:testdata1_change_idx) ; ryan5_change_ll_Qd(testdata3_change_idx+1:end) ];

ryan5_change_ss_VdFull = ryan5_battery_dataset(testdata_shortRul_batNum).Vd;
ryan5_change_bb_VdFull = ryan5_battery_dataset(testdata_base_batNum).Vd;
ryan5_change_ll_VdFull = ryan5_battery_dataset(testdata_longRul_batNum).Vd;
ryan5_change_bs_VdFull = vertcat( ryan5_change_bb_VdFull(1:testdata1_change_idx,:) , ryan5_change_ss_VdFull(testdata2_change_idx+1:end,:) );
ryan5_change_bl_VdFull = vertcat( ryan5_change_bb_VdFull(1:testdata1_change_idx,:) , ryan5_change_ll_VdFull(testdata3_change_idx+1:end,:) );

% https://kr.mathworks.com/matlabcentral/answers/80480-how-do-i-take-the-average-of-every-n-values-in-a-vector
blockSize = [1, 5] % 다섯개를 묶어서.
meanFilterFunction = @(theBlockStructure) mean2(theBlockStructure.data(:))

ryan5_change_ss_Vd = blockproc(ryan5_change_ss_VdFull, blockSize, meanFilterFunction);
ryan5_change_bb_Vd = blockproc(ryan5_change_bb_VdFull, blockSize, meanFilterFunction);
ryan5_change_ll_Vd = blockproc(ryan5_change_ll_VdFull, blockSize, meanFilterFunction);
ryan5_change_bs_Vd = blockproc(ryan5_change_bs_VdFull, blockSize, meanFilterFunction);
ryan5_change_bl_Vd = blockproc(ryan5_change_bl_VdFull, blockSize, meanFilterFunction);

ryan5_change_ss_rul_cnt = ryan5_battery_dataset(testdata_shortRul_batNum).cycle_life
ryan5_change_ss_rul_all   = linspace(ryan5_change_ss_rul_cnt,1,ryan5_change_ss_rul_cnt)';
ryan5_change_ss_rul_pre   = linspace(ryan5_change_ss_rul_cnt,ryan5_change_ss_rul_cnt-testdata2_change_idx+1,testdata2_change_idx)' ;
ryan5_change_ss_rul_post  = linspace(ryan5_change_ss_rul_cnt-testdata2_change_idx ,1,ryan5_change_ss_rul_cnt-testdata2_change_idx)';

length(ryan5_change_ss_rul_all)
length(ryan5_change_ss_rul_pre)
length(ryan5_change_ss_rul_post)

ryan5_change_ss_rul_pre(1)
ryan5_change_ss_rul_pre(end)
ryan5_change_ss_rul_post(1)
ryan5_change_ss_rul_post(end)


ryan5_change_bb_rul_cnt = ryan5_battery_dataset(testdata_base_batNum).cycle_life
ryan5_change_bb_rul_all   = linspace(ryan5_change_bb_rul_cnt,1,ryan5_change_bb_rul_cnt)'
ryan5_change_bb_rul_pre   = linspace(ryan5_change_bb_rul_cnt,ryan5_change_bb_rul_cnt-testdata1_change_idx+1,testdata1_change_idx)' 
ryan5_change_bb_rul_post  = linspace(ryan5_change_bb_rul_cnt-testdata1_change_idx ,1,ryan5_change_bb_rul_cnt-testdata1_change_idx)'

length(ryan5_change_bb_rul_all)
length(ryan5_change_bb_rul_pre)
length(ryan5_change_bb_rul_post)

ryan5_change_bb_rul_pre(1)
ryan5_change_bb_rul_pre(end)
ryan5_change_bb_rul_post(1)
ryan5_change_bb_rul_post(end)


ryan5_change_ll_rul_cnt = ryan5_battery_dataset(testdata_longRul_batNum).cycle_life
ryan5_change_ll_rul_all   = linspace(ryan5_change_ll_rul_cnt,1,ryan5_change_ll_rul_cnt)'
ryan5_change_ll_rul_pre   = linspace(ryan5_change_ll_rul_cnt,ryan5_change_ll_rul_cnt-testdata3_change_idx+1,testdata3_change_idx)' 
ryan5_change_ll_rul_post  = linspace(ryan5_change_ll_rul_cnt-testdata3_change_idx ,1,ryan5_change_ll_rul_cnt-testdata3_change_idx)'

length(ryan5_change_ll_rul_all)
length(ryan5_change_ll_rul_pre)
length(ryan5_change_ll_rul_post)

ryan5_change_ll_rul_pre(1)
ryan5_change_ll_rul_pre(end)
ryan5_change_ll_rul_post(1)
ryan5_change_ll_rul_post(end)

ryan5_change_bs_Rul = [ryan5_change_bb_rul_pre ; ryan5_change_ss_rul_post ];
ryan5_change_bl_Rul = [ryan5_change_bb_rul_pre ; ryan5_change_ll_rul_post ];

ryan5_change_ss_Rul = linspace(ryan5_battery_dataset(testdata_shortRul_batNum).cycle_life,1,ryan5_battery_dataset(testdata_shortRul_batNum).cycle_life)';
ryan5_change_bb_Rul = linspace(ryan5_battery_dataset(testdata_base_batNum).cycle_life,1,ryan5_battery_dataset(testdata_base_batNum).cycle_life)';
ryan5_change_ll_Rul = linspace(ryan5_battery_dataset(testdata_longRul_batNum).cycle_life,1,ryan5_battery_dataset(testdata_longRul_batNum).cycle_life)';


%%

ynorm_ryan5_change_ss_Rul = minmax_norm_x_with_param(ryan5_change_ss_Rul  , ymin_RUL , yrate_RUL );
ynorm_ryan5_change_bb_Rul = minmax_norm_x_with_param(ryan5_change_bb_Rul  , ymin_RUL , yrate_RUL );
ynorm_ryan5_change_bs_Qd  = minmax_norm_x_with_param(ryan5_change_bs_Qd   , ymin_SOH , yrate_SOH );
ynorm_ryan5_change_bb_Qd  = minmax_norm_x_with_param(ryan5_change_bb_Qd   , ymin_SOH , yrate_SOH );
ynorm_ryan5_change_bl_Qd  = minmax_norm_x_with_param(ryan5_change_bl_Qd   , ymin_SOH , yrate_SOH );
xnorm_ryan5_change_bs_Vd  = minmax_norm_x_with_param(ryan5_change_bs_Vd   , xmin_Vd  , xrate_Vd  );
xnorm_ryan5_change_bb_Vd  = minmax_norm_x_with_param(ryan5_change_bb_Vd   , xmin_Vd  , xrate_Vd  );
xnorm_ryan5_change_bl_Vd  = minmax_norm_x_with_param(ryan5_change_bl_Vd   , xmin_Vd  , xrate_Vd  );

ynorm_ryan5_change_bs_Rul = minmax_norm_x_with_param(ryan5_change_bs_Rul  , ymin_RUL , yrate_RUL );
ynorm_ryan5_change_bl_Rul = minmax_norm_x_with_param(ryan5_change_bl_Rul  , ymin_RUL , yrate_RUL );

%%
% check SOH change
%ryan5_change_bb_Qd

figure, hold on
plot(ryan5_change_bb_Qd)
plot(ryan5_change_bs_Qd,'--')
plot(ryan5_change_bl_Qd,'-.')
hold off

title ("Test Data 1, 2, 3")
ylabel('SOH (Ah)')
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = 'Test Data 1';
legend_str{2} = 'Test Data 2';
legend_str{3} = 'Test Data 3';
legend(legend_str)
%% 테스트 데이타 3개의 그래프

%load robotarm
idxTest ;
count = length(idxTest) ;

for i=1:count 
   [i idxTest(i) ryan5_battery_dataset(idxTest(i)).cycle_life ] ;
end

% 1 76  140 
% 7 16  316
% 10 106 504
%% 11 84 638

figure, hold on
plot( ryan5_battery_dataset(testdata_base_batNum).QDischargeSmooth )
plot( ryan5_battery_dataset(testdata_shortRul_batNum).QDischargeSmooth, line_1 )
plot( ryan5_battery_dataset(testdata_longRul_batNum).QDischargeSmooth, line_2 )
hold off
ylabel('SOH (Ah)')
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = num2str(testdata_base_batNum) + " , "+ "Base RUL";
legend_str{2} = num2str(testdata_shortRul_batNum) + " , "+ "Short RUL";
legend_str{3} = num2str(testdata_longRul_batNum) + " , "+ "Long RUL";
legend(legend_str)
title 'Test Dataset for Incremetal Learning'
%%

%%

%% Find most similar dataset for Test Data 1 based on RUL => from cycle 1 to cycle end
%% Full cycle - manually  /  118이 RUL로 가장 근접

compareTo = Y_test_RUL_idx_testdata1(1)

idx = testdata_base_batNum %16
% find most similar data
idxTrainValid = [idxTrain idxValid]

count = length(idxTrain) + length(idxValid)
idxSel = 0;
diff_val = 1000;
for i=1:count 
    diff_new = abs( ryan5_battery_dataset(idxTrainValid(i)).cycle_life - compareTo );
    if diff_new < diff_val 
        idxSel = idxTrainValid(i);
        save_idx = i;
        diff_val = diff_new;
    end
end
save_idx
idxSel
idxTrainValid

matchedRUL = ryan5_battery_dataset(idxSel).cycle_life

idxTrainValidAll_batIndex = [idxTrainAll_batIndex idxValidAll_batIndex  ];
idxFindAllSel = find(idxTrainValidAll_batIndex == idxSel);
y_trainValid_RUL_testdata1 = y_trainValid_RUL(idxFindAllSel);
Y_trainValid_RUL_testdata1 = Y_trainValid_RUL(idxFindAllSel);
Y_trainValid_SOH_testdata1 = Y_trainValid_SOH(idxFindAllSel); 
ytrainSim_testdata1 = y_trainValid_RUL_testdata1;

figure, hold on
plot(ryan5_battery_dataset(idx).QDischargeSmooth)
plot(ryan5_battery_dataset(idxSel).QDischargeSmooth,line_1)
hold off
ylabel 'SOH (Ah)'
xlabel 'Cycle'
title 'Find most similar dataset for Test Data 1 based on RUL'
legend_str = cell(2,1);
legend_str{1} = num2str(idx) + " , "+ "Base RUL";
legend_str{2} = num2str(idxSel) + " , "+ "Best Fit";

legend(legend_str)
%% Find most similar dataset for Test Data 1 based on RUL  => from cycle 1 to cycle end
%% ryan5_util_find_similar_rul_bat_with_full_cycle  
%% 118이 RUL로 가장 근접하지만 46의 SOH변화량이 비슷하다.

testdata1_cycle_num = ryan5_battery_dataset(testdata_base_batNum).cycle_life
cycle_gap = 20

for j = 1 : length(idxAll)
    
    if ryan5_battery_dataset(j).cycle_life < (testdata1_cycle_num + cycle_gap)  & ryan5_battery_dataset(j).cycle_life > (testdata1_cycle_num - cycle_gap)
    [j, ryan5_battery_dataset(j).cycle_life, testdata1_cycle_num - ryan5_battery_dataset(j).cycle_life  ]
    end
end
testdata_base_batNum
ryan5_battery_dataset(testdata_base_batNum).cycle_life


ryan5_util_global

[testdata1_similar_batNum_1, testdata1_similar_Rul_1,testdata1_similar_batNum_2, testdata1_similar_Rul_2, bestMatchIdx ] = ...
    ryan5_util_find_similar_rul_bat_with_full_cycle(testdata_base_batNum)
bestMatchIdx

figure, hold on
plot(ryan5_battery_dataset(testdata_base_batNum).QDischargeSmooth)
plot(ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth,line_1)
plot(ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth,line_2)
hold off
ylabel 'SOH (Ah)'
xlabel 'Cycle'
title 'Find Most Similar Data for Test Data 1 based on RUL'
legend_str = cell(3,1);
legend_str{1} = num2str(testdata_base_batNum) + " , "+ "Base RUL";
legend_str{2} = num2str(testdata1_similar_batNum_1) + " , "+ "Best Fit";
legend_str{3} = num2str(testdata1_similar_batNum_2) + " , "+ "2nd Fit";
legend(legend_str)
%% Find best match for test data 1 based on SOH => 5 window from cycle 1
%% ryan5_util_find_similar_soh_bat_with_cycles

[bestFitBatNum, bestFitBatCycle,bestFitBatNumNth,bestFitBatCycleNth] = ...
    ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,5,nth_fit)
bestFitBatNum
bestFitBatCycle
bestFitBatNumNth
bestFitBatCycleNth


[bestFitFor50BatNum, bestFitFor50BatCycle,bestFitBatNumNth,bestFitBatCycleNth] = ...
    ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,50,50)
%[bestFitFor100BatNum, bestFitFor100BatCycle] = ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,100)

figure, hold on,
plot(ryan5_change_bb_Qd);
plot(ryan5_battery_dataset(bestFitBatNum).QDischargeSmooth, line_1);
plot(ryan5_battery_dataset(bestFitFor50BatNum).QDischargeSmooth, line_2);
plot(ryan5_battery_dataset(bestFitBatNumNth).QDischargeSmooth, line_3);
ylabel('SOH (Ah)')
%yyaxis right
%plot(ryan5_change_bl_Qd_diff_diff)
%ylabel('2nd diff')
hold off 

title("Find similar data for Test Data 1 for Full Cycle")
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 1";
legend_str{2} = num2str(bestFitBatNum) + ", Similar from 1 cycle for 5 window";
legend_str{3} = num2str(bestFitFor50BatNum) + ", Similar from 1 cycle for 50 window";
legend_str{4} = num2str(bestFitBatNumNth) + ", 50th Similar from 1 cycle for 50 window";
legend(legend_str)
%%

%%

%%

%% Find best match for test data 1 after change  - RUL based

compareTo = Y_test_RUL_idx_testdata1(testdata2_change_idx+1)
Y_test_SOH_idx_testdata1(testdata2_change_idx+1)

count = length(idxTrain) + length(idxValid)
idxSel = 0;
diff_val = 1000;
for i=1:count 
    [val,idxCross] = min(abs(ryan5_battery_dataset(idxTrainValid(i)).QDischarge -  Cap_change ));
    rul_remained =  ryan5_battery_dataset(idxTrainValid(i)).cycle_life - idxCross ;
    diff_new = abs( rul_remained - compareTo );
    if diff_new < diff_val 
        idxSel = idxTrainValid(i);
        diff_val = diff_new;
        idxCrossSel = idxCross;
    end
end
Cap_change
save_idx
idxSel
idxTrainValid

matchedRUL = ryan5_battery_dataset(idxSel).cycle_life

idxTrainValidAll_batIndex = [idxTrainAll_batIndex idxValidAll_batIndex  ];
idxFindAllSel = find(idxTrainValidAll_batIndex == idxSel);
y_trainValid_RUL_testdata1 = y_trainValid_RUL(idxFindAllSel);
Y_trainValid_RUL_testdata1 = Y_trainValid_RUL(idxFindAllSel);
Y_trainValid_SOH_testdata1 = Y_trainValid_SOH(idxFindAllSel); 
ytrainSim_testdata1 = y_trainValid_RUL_testdata1;

figure, hold on
plot(Y_test_SOH_idx_testdata1(testdata2_change_idx+1:end))
plot(ryan5_battery_dataset(idxSel).QDischargeSmooth(idxCrossSel:end),line_1)

ylabel('SOH (Ah)')
%yyaxis right
hold off 

title("Find similar data for Test Data 1 After Change Based on RUL - do not use it")
xlabel('Cycle after change')
legend_str = cell(2,1);
legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 1";
legend_str{2} = num2str(idxSel) + ", The Best Similar Data After change ";
legend(legend_str)
%% Find best match for test data 1 after change  - RUL based

ryan5_util_global
% Cap_change = (Cap_Rated + Cap_EOL ) / 2

[   testdata1_similar_batNum_1 , ... 
    testdata1_similar_Rul_1, ...
    testdata1_similar_idx_1, ...
    testdata1_similar_batNum_2, ...
    testdata1_similar_Rul_2,...
    testdata1_similar_idx_2 ] = ...
    ryan5_util_find_similar_bat_with_rul_after_change( ryan5_change_bb_Rul,testdata1_change_idx+1, Cap_change)
%[bestFitBatNum, bestFitBatCycle] = ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,5)

% testdata1_similar_batNum_1 = idxAll(testdata1_similar_batNum_1)
% testdata1_similar_batNum_2 = idxAll(testdata1_similar_batNum_2)

figure, hold on
plot(ryan5_change_bb_Qd(testdata1_change_idx+1:end))
plot(ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(testdata1_similar_idx_1:end),'--')
plot(ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(testdata1_similar_idx_2:end),':')
ylabel('SOH (Ah)')
xlabel('Cycle from Change Point')
hold off
title("Find similar data for Test Data 1 After Change Based on RUL")
legend_str = cell(3,1);
legend_str{1} = num2str(testdata1_batNum_str) + ", Test Data 2";
legend_str{2} = num2str(testdata1_similar_batNum_1) + ", Upper Matched";
legend_str{3} = num2str(testdata1_similar_batNum_2+1) + " , Lower Matched";
legend(legend_str)
%% Find best match for test data 1 After Change  - SOH based ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,testdata1_change_idx+1,5) 변화이후 5 / 50 사이클로 비슷한 곡선 찾기. 44가 가장 비슷

[bestFitBatNum, bestFitBatCycle] = ...
    ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,testdata1_change_idx+1,5,nth_fit)
bestFitBatNum
bestFitBatCycle

[bestFitFor50BatNum, bestFitFor50BatCycle] = ...
    ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,testdata1_change_idx+1,50,nth_fit)
%[bestFitFor100BatNum, bestFitFor100BatCycle] = ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,100)

figure, hold on,
plot(ryan5_change_bb_Qd(testdata1_change_idx+1:end));
plot(ryan5_battery_dataset(bestFitBatNum).QDischargeSmooth(bestFitBatCycle:end), line_1);
plot(ryan5_battery_dataset(bestFitFor50BatNum).QDischargeSmooth(bestFitFor50BatCycle:end), line_2);
%plot(ryan5_battery_dataset(bestFitFor100BatNum).QDischargeSmooth, line_1);
ylabel('SOH (Ah)')
%yyaxis right
%plot(ryan5_change_bl_Qd_diff_diff)
%ylabel('2nd diff')
hold off 

title("Find Similar Data for Test Data 1 After Change (SOH based)")
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 1";
legend_str{2} = num2str(bestFitBatNum) + ", The Best Similar Data After Change for 5 Window";
legend_str{3} = num2str(bestFitFor50BatNum) + ", The Best Similar Data After Change for 50 Window";
%legend_str{4} = num2str(bestFitFor100BatNum) + ", Similar from 1 cycle for 100 window";
legend(legend_str)

figure, hold on,
plot(ryan5_change_bb_Qd);
plot(ryan5_battery_dataset(bestFitBatNum).QDischargeSmooth, line_1);
plot(ryan5_battery_dataset(bestFitFor50BatNum).QDischargeSmooth, line_2);
%plot(ryan5_battery_dataset(bestFitFor100BatNum).QDischargeSmooth, line_1);
ylabel('SOH (Ah)')
%yyaxis right
%plot(ryan5_change_bl_Qd_diff_diff)
%ylabel('2nd diff')
hold off 

title("Find Similar Data for Test Data 1 After Change - Full cycle (SOH based)")
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 1";
legend_str{2} = num2str(bestFitBatNum) + ", The Best Similar Data After Change for 5 Window";
legend_str{3} = num2str(bestFitFor50BatNum) + ", The Best Similar Data After Change for 50 Window";
%legend_str{4} = num2str(bestFitFor100BatNum) + ", Similar from 1 cycle for 100 window";
legend(legend_str)
%% 

% similar 
% pre = 19
% post = 32

% testdata1_best2step_pre_batNum = 19;
% len = length(ryan5_battery_dataset(testdata1_best2step_pre_batNum).QDischargeSmooth)
% for i=1:len 
%     if ryan5_battery_dataset(testdata1_best2step_pre_batNum).QDischargeSmooth(i) < Cap_change  
%         break
%     end
% end
% testdata1_best2step_pre_idx = i+1
% testdata1_best2step_pre_soh = ryan5_battery_dataset(testdata1_best2step_pre_batNum).QDischargeSmooth(1:testdata1_best2step_pre_idx);
% testdata1_best2step_pre_rul = ryan5_battery_dataset(testdata1_best2step_pre_batNum).RUL(1:testdata1_best2step_pre_idx);
% 
% testdata1_best2step_post_batNum = 32;
% len = length(ryan5_battery_dataset(testdata1_best2step_post_batNum).QDischargeSmooth)
% for i=1:len 
%     if ryan5_battery_dataset(testdata1_best2step_post_batNum).QDischargeSmooth(i) < Cap_change  
%         break
%     end
% end
% testdata1_best2step_post_idx = i
% testdata1_best2step_post_soh = ryan5_battery_dataset(testdata1_best2step_post_batNum).QDischargeSmooth(testdata1_best2step_post_idx:end);
% testdata1_best2step_post_rul = ryan5_battery_dataset(testdata1_best2step_post_batNum).RUL(testdata1_best2step_post_idx:end);
% 
% 
% testdata1_best2step_soh = [testdata1_best2step_pre_soh ; testdata1_best2step_post_soh ];
% testdata1_best2step_rul = [testdata1_best2step_pre_rul ; testdata1_best2step_post_rul ];
% 
% figure, hold on,
% plot(ryan5_change_bb_Qd);
% plot(testdata1_best2step_soh, line_1);
% ylabel('SOH (Ah)')
% yyaxis right
% plot(ryan5_change_bb_Rul);
% plot(testdata1_best2step_rul, line_1);
% ylabel('RUL')
% hold off 
% 
% title("The Best Similar Data for Test Data 1 (2 step)")
% xlabel('Cycle')
% legend_str = cell(4,1);
% legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 1 (SOH)";
% legend_str{2} = num2str(testdata1_best2step_pre_batNum) + "->" + num2str(testdata1_best2step_pre_batNum) + ", The Best Similar Data (SOH)";
% legend_str{3} = num2str(testdata_base_batNum) + ", Test Data 1 (RUL)";
% legend_str{4} = num2str(testdata1_best2step_pre_batNum) + "->" + num2str(testdata1_best2step_pre_batNum) + ", The Best Similar Data (RUL)";
% 

%%
% similar = 19 - no change

testdata1_best_batNum = 19;
len = length(ryan5_battery_dataset(testdata1_best_batNum).QDischargeSmooth)
testdata1_best_soh = ryan5_battery_dataset(testdata1_best_batNum).QDischargeSmooth;
testdata1_best_rul = ryan5_battery_dataset(testdata1_best_batNum).RUL;
testdata1_best_VdFull = ryan5_battery_dataset(testdata1_best_batNum).Vd;
testdata1_best_Vd = blockproc(testdata1_best_VdFull, blockSize, meanFilterFunction);
testdata1_best_Vd_norm = minmax_norm_x_with_param(testdata1_best_Vd   , xmin_Vd  , xrate_Vd  );


figure, hold on,
plot(ryan5_change_bb_Qd);
plot(testdata1_best_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bb_Rul);
plot(testdata1_best_rul, line_1);
ylabel('RUL')
hold off 

title("The Best Similar Training Data for Test Data 1 (Battery Number : " + num2str(testdata1_best_batNum) +")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 1 (SOH)";
legend_str{2} = num2str(testdata1_best_batNum) + ", The Best Similar Data (SOH)";
legend_str{3} = num2str(testdata_base_batNum) + ", Test Data 1 (RUL)";
legend_str{4} = num2str(testdata1_best_batNum) +  ", The Best Similar Data (RUL)";
legend(legend_str)
%%
% 50th similar = 17 - no change

testdata1_poor_batNum = 17;
len = length(ryan5_battery_dataset(testdata1_poor_batNum).QDischargeSmooth)
testdata1_poor_soh = ryan5_battery_dataset(testdata1_poor_batNum).QDischargeSmooth;
testdata1_poor_rul = ryan5_battery_dataset(testdata1_poor_batNum).RUL;
testdata1_poor_VdFull = ryan5_battery_dataset(testdata1_poor_batNum).Vd;
testdata1_poor_Vd = blockproc(testdata1_poor_VdFull, blockSize, meanFilterFunction);
testdata1_poor_Vd_norm = minmax_norm_x_with_param(testdata1_poor_Vd   , xmin_Vd  , xrate_Vd  );

figure, hold on,
plot(ryan5_change_bb_Qd);
plot(testdata1_poor_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bb_Rul);
plot(testdata1_poor_rul, line_1);
ylabel('RUL')
hold off 

title("The Avarage Similar Training Data for Test Data 1 (Battery Number : " + num2str(testdata1_poor_batNum) +")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 1 (SOH)";
legend_str{2} = num2str(testdata1_poor_batNum) + ", The Average Similar Data (SOH)";
legend_str{3} = num2str(testdata_base_batNum) + ", Test Data 1 (RUL)";
legend_str{4} = num2str(testdata1_poor_batNum) +  ", The Average Similar Data (RUL)";
legend(legend_str)
%%

testdata1_worse_batNum = testdata_shortRul_batNum;
len = length(ryan5_battery_dataset(testdata1_worse_batNum).QDischargeSmooth);
testdata1_worse_soh = ryan5_battery_dataset(testdata1_worse_batNum).QDischargeSmooth;
testdata1_worse_rul = ryan5_battery_dataset(testdata1_worse_batNum).RUL;
testdata1_worse_VdFull = ryan5_battery_dataset(testdata1_worse_batNum).Vd;
testdata1_worse_Vd = blockproc(testdata1_worse_VdFull, blockSize, meanFilterFunction);
testdata1_worse_Vd_norm = minmax_norm_x_with_param(testdata1_worse_Vd   , xmin_Vd  , xrate_Vd  );

figure, hold on,
plot(ryan5_change_bb_Qd);
plot(testdata1_worse_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bb_Rul);
plot(testdata1_worse_rul, line_1);
ylabel('RUL')
hold off 

title("The Worse Similar Training Data for Test Data 1 (Battery Number : " + num2str(testdata1_worse_batNum) +")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 1 (SOH)";
legend_str{2} = num2str(testdata1_worse_batNum) + ", The Worse Similar Data (SOH)";
legend_str{3} = num2str(testdata_base_batNum) + ", Test Data 1 (RUL)";
legend_str{4} = num2str(testdata1_worse_batNum) +  ", The Worse Similar Data (RUL)";
legend(legend_str)
%%

%%

%% Find best match for Test Data 2 after change  - RUL based

compareTo = ryan5_change_bs_Rul(testdata1_change_idx+1)
ryan5_change_bs_Qd(testdata1_change_idx+1)

count = length(idxTrain) + length(idxValid)
idxSel = 0;
diff_val = 1000;
for i=1:count 
    [val,idxCross] = min(abs(ryan5_battery_dataset(idxTrainValid(i)).QDischarge -  Cap_change ));
    rul_remained =  ryan5_battery_dataset(idxTrainValid(i)).cycle_life - idxCross ;
    diff_new = abs( rul_remained - compareTo );
    if diff_new < diff_val 
        idxSel = idxTrainValid(i);
        diff_val = diff_new;
        idxCrossSel = idxCross;
    end
end
Cap_change
save_idx
idxSel
idxTrainValid

matchedRUL = ryan5_battery_dataset(idxSel).cycle_life

idxTrainValidAll_batIndex = [idxTrainAll_batIndex idxValidAll_batIndex  ];
idxFindAllSel = find(idxTrainValidAll_batIndex == idxSel);
% y_trainValid_RUL_testdata2 = ynorm_ryan5_change_bs_Rul(idxFindAllSel);
% Y_trainValid_RUL_testdata2 = ryan5_change_bs_Rul(idxFindAllSel);
% Y_trainValid_SOH_testdata2 = ryan5_change_bs_Qd(idxFindAllSel); 

idxTrainValidAll_batIndex = [idxTrainAll_batIndex idxValidAll_batIndex  ];
idxFindAllSel = find(idxTrainValidAll_batIndex == idxSel);
y_trainValid_RUL_testdata2 = y_trainValid_RUL(idxFindAllSel);
Y_trainValid_RUL_testdata2 = Y_trainValid_RUL(idxFindAllSel);
Y_trainValid_SOH_testdata2 = Y_trainValid_SOH(idxFindAllSel); 
ytrainSim_testdata2 = y_trainValid_RUL_testdata2;


figure, hold on
plot(ryan5_change_bs_Qd(testdata1_change_idx+1:end))
plot(ryan5_battery_dataset(idxSel).QDischargeSmooth(idxCrossSel:end),line_1)

ylabel('SOH (Ah)')
%yyaxis right
hold off 

title("Find similar data for Test Data 2 After Change Based on RUL - do not use it")
xlabel('Cycle after change')
legend_str = cell(2,1);

legend_str{1} = testdata2_batNum_str + ", Test Data 2";
legend_str{2} = num2str(idxSel) + ", The Best Similar Data After change ";
legend(legend_str)
%% Find best match for Test Data 2 after change  - RUL based

ryan5_util_global
% Cap_change = (Cap_Rated + Cap_EOL ) / 2

[   testdata1_similar_batNum_1 , ... 
    testdata1_similar_Rul_1, ...
    testdata1_similar_idx_1, ...
    testdata1_similar_batNum_2, ...
    testdata1_similar_Rul_2,...
    testdata1_similar_idx_2 ] = ...
    ryan5_util_find_similar_bat_with_rul_after_change( ryan5_change_bs_Rul,testdata1_change_idx+1, Cap_change)
%[bestFitBatNum, bestFitBatCycle] = ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,5)

% testdata1_similar_batNum_1 = idxAll(testdata1_similar_batNum_1)
% testdata1_similar_batNum_2 = idxAll(testdata1_similar_batNum_2)

figure, hold on
plot(ryan5_change_bs_Qd(testdata1_change_idx+1:end))
plot(ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(testdata1_similar_idx_1:end),'--')
plot(ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(testdata1_similar_idx_2:end),':')
ylabel('SOH (Ah)')
xlabel('Cycle from Change Point')
hold off
title("Find similar data for Test Data 2 After Change Based on RUL")
legend_str = cell(3,1);
legend_str{1} = testdata2_batNum_str + ", Test Data 2";
legend_str{2} = num2str(testdata1_similar_batNum_1) + ", Upper Matched";
legend_str{3} = num2str(testdata1_similar_batNum_2+1) + " , Lower Matched";
legend(legend_str)
%% Find best match for Test Data 2 After Change  - SOH based ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,testdata1_change_idx+1,5) 변화이후 5 / 40 사이클로 비슷한 곡선 찾기(50은 에러). 

[bestFitBatNum, bestFitBatCycle] = ...
    ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bs_Qd,testdata1_change_idx+1,5,nth_fit)
bestFitBatNum
bestFitBatCycle

[bestFitFor50BatNum, bestFitFor50BatCycle,bestFitBatNumNth,bestFitBatCycleNth] = ...
    ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bs_Qd,testdata1_change_idx+1,40,50)
%[bestFitFor100BatNum, bestFitFor100BatCycle] = ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,100)

figure, hold on,
plot(ryan5_change_bs_Qd(testdata1_change_idx+1:end));
plot(ryan5_battery_dataset(bestFitBatNum).QDischargeSmooth(bestFitBatCycle:end), line_1);
plot(ryan5_battery_dataset(bestFitFor50BatNum).QDischargeSmooth(bestFitFor50BatCycle:end), line_2);
plot(ryan5_battery_dataset(bestFitBatNumNth).QDischargeSmooth(bestFitBatCycleNth:end), line_2);
ylabel('SOH (Ah)')
%yyaxis right
%plot(ryan5_change_bl_Qd_diff_diff)
%ylabel('2nd diff')
hold off 

title("Find Similar Data for Test Data 2 After Change (SOH based)")
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = testdata2_batNum_str + ", Test Data 2";
legend_str{2} = num2str(bestFitBatNum) + ", The Best Similar Data After Change for 5 Window";
legend_str{3} = num2str(bestFitFor50BatNum) + ", The Best Similar Data After Change for 40 Window";
legend_str{4} = num2str(bestFitBatNumNth) + ", 50th Similar Data After Change for 40 window";
legend(legend_str)

figure, hold on,
plot(ryan5_change_bs_Qd);
plot(ryan5_battery_dataset(bestFitBatNum).QDischargeSmooth, line_1);
plot(ryan5_battery_dataset(bestFitFor50BatNum).QDischargeSmooth, line_2);
%plot(ryan5_battery_dataset(bestFitFor100BatNum).QDischargeSmooth, line_1);
ylabel('SOH (Ah)')
%yyaxis right
%plot(ryan5_change_bl_Qd_diff_diff)
%ylabel('2nd diff')
hold off 

title("Find Similar Data for Test Data 2 After Change - Full cycle (SOH based)")
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = testdata2_batNum_str + ", Test Data 2";
legend_str{2} = num2str(bestFitBatNum) + ", The Best Similar Data After Change for 5 Window";
legend_str{3} = num2str(bestFitFor50BatNum) + ", The Best Similar Data After Change for 50 Window";
%legend_str{4} = num2str(bestFitFor100BatNum) + ", Similar from 1 cycle for 100 window";
legend(legend_str)
%% 

% similar 
% pre = 19
% post = 67

testdata2_best_pre_batNum = 19;
len = length(ryan5_battery_dataset(testdata2_best_pre_batNum).QDischargeSmooth)
for i=1:len 
    if ryan5_battery_dataset(testdata2_best_pre_batNum).QDischargeSmooth(i) < Cap_change  
        break
    end
end
testdata2_best_pre_idx = i+1
testdata2_best_pre_soh = ryan5_battery_dataset(testdata2_best_pre_batNum).QDischargeSmooth(1:testdata2_best_pre_idx);
testdata2_best_pre_rul = ryan5_battery_dataset(testdata2_best_pre_batNum).RUL(1:testdata2_best_pre_idx);
testdata2_best_pre_VdFull = ryan5_battery_dataset(testdata2_best_pre_batNum).Vd(1:testdata2_best_pre_idx,:);
testdata2_best_pre_Vd = blockproc(testdata2_best_pre_VdFull, blockSize, meanFilterFunction);
testdata2_best_pre_Vd_norm = minmax_norm_x_with_param(testdata2_best_pre_Vd   , xmin_Vd  , xrate_Vd  );

testdata2_best_post_batNum = 67;
len = length(ryan5_battery_dataset(testdata2_best_post_batNum).QDischargeSmooth)
for i=1:len 
    if ryan5_battery_dataset(testdata2_best_post_batNum).QDischargeSmooth(i) < Cap_change  
        break
    end
end
testdata2_best_post_idx = i
testdata2_best_post_soh = ryan5_battery_dataset(testdata2_best_post_batNum).QDischargeSmooth(testdata2_best_post_idx:end);
testdata2_best_post_rul = ryan5_battery_dataset(testdata2_best_post_batNum).RUL(testdata2_best_post_idx:end);
testdata2_best_post_VdFull = ryan5_battery_dataset(testdata2_best_post_batNum).Vd(testdata2_best_post_idx:end,:);
testdata2_best_post_Vd = blockproc(testdata2_best_post_VdFull, blockSize, meanFilterFunction);
testdata2_best_post_Vd_norm = minmax_norm_x_with_param(testdata2_best_post_Vd   , xmin_Vd  , xrate_Vd  );

testdata2_best_soh = [testdata2_best_pre_soh ; testdata2_best_post_soh ];
testdata2_best_rul = [testdata2_best_pre_rul ; testdata2_best_post_rul ];
testdata2_best_Vd_norm = [testdata2_best_pre_Vd_norm ; testdata2_best_post_Vd_norm ]
%%

figure, hold on,
plot(ryan5_change_bs_Qd);
plot(testdata2_best_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bs_Rul);
plot(testdata2_best_rul, line_1);
ylabel('RUL')
hold off 

title("The Best Similar Training Data for Test Data 2 ("+ num2str(testdata2_best_pre_batNum) + "->" + num2str(testdata2_best_post_batNum)+")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = testdata2_batNum_str + ", Test Data 2 (SOH)";
legend_str{2} = num2str(testdata2_best_pre_batNum) + "->" + num2str(testdata2_best_post_batNum) + ", The Best Similar Data (SOH)";
legend_str{3} = testdata2_batNum_str + ", Test Data 2 (RUL)";
legend_str{4} = num2str(testdata2_best_pre_batNum) + "->" + num2str(testdata2_best_post_batNum) + ", The Best Similar Data (RUL)";
legend(legend_str)
%%

% 50th similar = 17 -> 34

testdata2_poor_pre_batNum = 17;
len = length(ryan5_battery_dataset(testdata2_poor_pre_batNum).QDischargeSmooth)
for i=1:len 
    if ryan5_battery_dataset(testdata2_poor_pre_batNum).QDischargeSmooth(i) < Cap_change  
        break
    end
end
testdata2_poor_pre_idx = i+1
testdata2_poor_pre_soh = ryan5_battery_dataset(testdata2_poor_pre_batNum).QDischargeSmooth(1:testdata2_poor_pre_idx);
testdata2_poor_pre_rul = ryan5_battery_dataset(testdata2_poor_pre_batNum).RUL(1:testdata2_poor_pre_idx);
testdata2_poor_pre_VdFull = ryan5_battery_dataset(testdata2_poor_pre_batNum).Vd(1:testdata2_poor_pre_idx,:);
testdata2_poor_pre_Vd = blockproc(testdata2_poor_pre_VdFull, blockSize, meanFilterFunction);
testdata2_poor_pre_Vd_norm = minmax_norm_x_with_param(testdata2_poor_pre_Vd   , xmin_Vd  , xrate_Vd  );


testdata2_poor_post_batNum = 34;
len = length(ryan5_battery_dataset(testdata2_poor_post_batNum).QDischargeSmooth)
for i=1:len 
    if ryan5_battery_dataset(testdata2_poor_post_batNum).QDischargeSmooth(i) < Cap_change  
        break
    end
end
testdata2_poor_post_idx = i
testdata2_poor_post_soh = ryan5_battery_dataset(testdata2_poor_post_batNum).QDischargeSmooth(testdata2_poor_post_idx:end);
testdata2_poor_post_rul = ryan5_battery_dataset(testdata2_poor_post_batNum).RUL(testdata2_poor_post_idx:end);
testdata2_poor_post_VdFull = ryan5_battery_dataset(testdata2_poor_post_batNum).Vd(testdata2_poor_post_idx:end,:);
testdata2_poor_post_Vd = blockproc(testdata2_poor_post_VdFull, blockSize, meanFilterFunction);
testdata2_poor_post_Vd_norm = minmax_norm_x_with_param(testdata2_poor_post_Vd   , xmin_Vd  , xrate_Vd  );
testdata2_poor_Vd_norm = [testdata2_poor_pre_Vd_norm ; testdata2_poor_post_Vd_norm ]

testdata2_poor_soh = [testdata2_poor_pre_soh ; testdata2_poor_post_soh ];
testdata2_poor_rul = [testdata2_poor_pre_rul ; testdata2_poor_post_rul ];
%%

figure, hold on,
plot(ryan5_change_bs_Qd);
plot(testdata2_poor_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bs_Rul);
plot(testdata2_poor_rul, line_1);
ylabel('RUL')
hold off 

title("The Average Similar Training Data for Test Data 2 (Battery Number : " +num2str(testdata2_poor_pre_batNum) + "-> " + num2str(testdata2_poor_post_batNum) +")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = testdata2_batNum_str + ", Test Data 2 (SOH)";
legend_str{2} = num2str(testdata2_poor_pre_batNum) + "-> " + num2str(testdata2_poor_post_batNum) +" , The Average Similar Data (SOH)";
legend_str{3} = testdata2_batNum_str + ", Test Data 2 (RUL)";
legend_str{4} = num2str(testdata2_poor_pre_batNum) + "-> " + num2str(testdata2_poor_post_batNum) +", The Average Similar Data (RUL)";
legend(legend_str)
%%

testdata2_worse_batNum = testdata_shortRul_batNum;
len = length(ryan5_battery_dataset(testdata2_worse_batNum).QDischargeSmooth);
testdata2_worse_soh = ryan5_battery_dataset(testdata2_worse_batNum).QDischargeSmooth;
testdata2_worse_rul = ryan5_battery_dataset(testdata2_worse_batNum).RUL;
testdata2_worse_VdFull = ryan5_battery_dataset(testdata2_worse_batNum).Vd;
testdata2_worse_Vd = blockproc(testdata2_worse_VdFull, blockSize, meanFilterFunction);
testdata2_worse_Vd_norm = minmax_norm_x_with_param(testdata2_worse_Vd   , xmin_Vd  , xrate_Vd  );

figure, hold on,
plot(ryan5_change_bs_Qd);
plot(testdata2_worse_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bs_Rul);
plot(testdata2_worse_rul, line_1);
ylabel('RUL')
hold off 

title("The Worse Similar Training Data for Test Data 2 (Battery Number : " + num2str(testdata2_worse_batNum) +")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = num2str(testdata_base_batNum) + ", Test Data 2 (SOH)";
legend_str{2} = num2str(testdata2_worse_batNum) + ", The Worse Similar Data (SOH)";
legend_str{3} = num2str(testdata_base_batNum) + ", Test Data 2 (RUL)";
legend_str{4} = num2str(testdata2_worse_batNum) +  ", The Worse Similar Data (RUL)";
legend(legend_str)
%%

%%

%% Find best match for Test Data 3 after change  - RUL based

compareTo = ryan5_change_bl_Rul(testdata1_change_idx+1)
ryan5_change_bl_Qd(testdata1_change_idx+1)

count = length(idxTrain) + length(idxValid)
idxSel = 0;
diff_val = 1000;
for i=1:count 
    [val,idxCross] = min(abs(ryan5_battery_dataset(idxTrainValid(i)).QDischarge -  Cap_change ));
    rul_remained =  ryan5_battery_dataset(idxTrainValid(i)).cycle_life - idxCross ;
    diff_new = abs( rul_remained - compareTo );
    if diff_new < diff_val 
        idxSel = idxTrainValid(i);
        diff_val = diff_new;
        idxCrossSel = idxCross;
    end
end
Cap_change
save_idx
idxSel
idxTrainValid

matchedRUL = ryan5_battery_dataset(idxSel).cycle_life

idxTrainValidAll_batIndex = [idxTrainAll_batIndex idxValidAll_batIndex  ];
idxFindAllSel = find(idxTrainValidAll_batIndex == idxSel);
% y_trainValid_RUL_testdata2 = ynorm_ryan5_change_bl_Rul(idxFindAllSel);
% Y_trainValid_RUL_testdata2 = ryan5_change_bl_Rul(idxFindAllSel);
% Y_trainValid_SOH_testdata2 = ryan5_change_bl_Qd(idxFindAllSel); 

idxTrainValidAll_batIndex = [idxTrainAll_batIndex idxValidAll_batIndex  ];
idxFindAllSel = find(idxTrainValidAll_batIndex == idxSel);
y_trainValid_RUL_testdata2 = y_trainValid_RUL(idxFindAllSel);
Y_trainValid_RUL_testdata2 = Y_trainValid_RUL(idxFindAllSel);
Y_trainValid_SOH_testdata2 = Y_trainValid_SOH(idxFindAllSel); 
ytrainSim_testdata2 = y_trainValid_RUL_testdata2;


figure, hold on
plot(ryan5_change_bl_Qd(testdata1_change_idx+1:end))
plot(ryan5_battery_dataset(idxSel).QDischargeSmooth(idxCrossSel:end),line_1)

ylabel('SOH (Ah)')
%yyaxis right
hold off 

title("Find similar data for Test Data 3 After Change Based on RUL - do not use it")
xlabel('Cycle after change')
legend_str = cell(2,1);
legend_str{1} = testdata3_batNum_str + ", Test Data 3";
legend_str{2} = num2str(idxSel) + ", The Best Similar Data After change ";
legend(legend_str)
%% Find best match for Test Data 3 after change  - RUL based

ryan5_util_global
% Cap_change = (Cap_Rated + Cap_EOL ) / 2

[   testdata1_similar_batNum_1 , ... 
    testdata1_similar_Rul_1, ...
    testdata1_similar_idx_1, ...
    testdata1_similar_batNum_2, ...
    testdata1_similar_Rul_2,...
    testdata1_similar_idx_2 ] = ...
    ryan5_util_find_similar_bat_with_rul_after_change( ryan5_change_bl_Rul,testdata1_change_idx+1, Cap_change)
%[bestFitBatNum, bestFitBatCycle] = ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,5)

% testdata1_similar_batNum_1 = idxAll(testdata1_similar_batNum_1)
% testdata1_similar_batNum_2 = idxAll(testdata1_similar_batNum_2)

figure, hold on
plot(ryan5_change_bl_Qd(testdata1_change_idx+1:end))
plot(ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(testdata1_similar_idx_1:end),'--')
plot(ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(testdata1_similar_idx_2:end),':')
ylabel('SOH (Ah)')
xlabel('Cycle from Change Point')
hold off
title("Find similar data for Test Data 3 After Change Based on RUL")
legend_str = cell(3,1);
legend_str{1} = testdata3_batNum_str +", Test Data 3";
legend_str{2} = num2str(testdata1_similar_batNum_1) + ", Upper Matched";
legend_str{3} = num2str(testdata1_similar_batNum_2+1) + " , Lower Matched";
legend(legend_str)
%% Find best match for Test Data 3 After Change  - SOH based ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,testdata1_change_idx+1,5) 변화이후 5 / 50 사이클로 비슷한 곡선 찾기 

[bestFitBatNum, bestFitBatCycle] = ...
    ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bl_Qd,testdata1_change_idx+1,5,nth_fit)
bestFitBatNum
bestFitBatCycle

[bestFitFor50BatNum, bestFitFor50BatCycle,bestFitBatNumNth,bestFitBatCycleNth] = ...
    ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bl_Qd,testdata1_change_idx+1,50,50)
%[bestFitFor100BatNum, bestFitFor100BatCycle] = ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,100)

figure, hold on,
plot(ryan5_change_bl_Qd(testdata1_change_idx+1:end));
plot(ryan5_battery_dataset(bestFitBatNum).QDischargeSmooth(bestFitBatCycle:end), line_1);
plot(ryan5_battery_dataset(bestFitFor50BatNum).QDischargeSmooth(bestFitFor50BatCycle:end), line_2);
plot(ryan5_battery_dataset(bestFitBatNumNth).QDischargeSmooth(bestFitBatCycleNth:end), line_3);
ylabel('SOH (Ah)')
%yyaxis right
%plot(ryan5_change_bl_Qd_diff_diff)
%ylabel('2nd diff')
hold off 

title("Find Similar Data for Test Data 3 After Change (SOH based)")
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = testdata3_batNum_str + ", Test Data 3";
legend_str{2} = num2str(bestFitBatNum) + ", The Best Similar Data After Change for 5 Window";
legend_str{3} = num2str(bestFitFor50BatNum) + ", The Best Similar Data After Change for 50 Window";
legend_str{4} = num2str(bestFitBatNumNth) + ", 50th Similar from 1 cycle for 50 window";
legend(legend_str)

figure, hold on,
plot(ryan5_change_bl_Qd);
plot(ryan5_battery_dataset(bestFitBatNum).QDischargeSmooth, line_1);
plot(ryan5_battery_dataset(bestFitFor50BatNum).QDischargeSmooth, line_2);
%plot(ryan5_battery_dataset(bestFitFor100BatNum).QDischargeSmooth, line_1);
ylabel('SOH (Ah)')
%yyaxis right
%plot(ryan5_change_bl_Qd_diff_diff)
%ylabel('2nd diff')
hold off 

title("Find Similar Data for Test Data 3 After Change - Full cycle (SOH based)")
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = testdata3_batNum_str + ", Test Data 3";
legend_str{2} = num2str(bestFitBatNum) + ", The Best Similar Data After Change for 5 Window";
legend_str{3} = num2str(bestFitFor50BatNum) + ", The Best Similar Data After Change for 50 Window";
%legend_str{4} = num2str(bestFitFor100BatNum) + ", Similar from 1 cycle for 100 window";
legend(legend_str)
%% 

% similar 
% pre = 19
% post = 95

testdata3_best_pre_batNum = 19;
len = length(ryan5_battery_dataset(testdata3_best_pre_batNum).QDischargeSmooth)
for i=1:len 
    if ryan5_battery_dataset(testdata3_best_pre_batNum).QDischargeSmooth(i) < Cap_change  
        break
    end
end
testdata3_best_pre_idx = i+1
testdata3_best_pre_soh = ryan5_battery_dataset(testdata3_best_pre_batNum).QDischargeSmooth(1:testdata3_best_pre_idx);
testdata3_best_pre_rul = ryan5_battery_dataset(testdata3_best_pre_batNum).RUL(3:testdata3_best_pre_idx);
testdata3_best_pre_VdFull = ryan5_battery_dataset(testdata3_best_pre_batNum).Vd(3:testdata3_best_pre_idx,:);
testdata3_best_pre_Vd = blockproc(testdata3_best_pre_VdFull, blockSize, meanFilterFunction);
testdata3_best_pre_Vd_norm = minmax_norm_x_with_param(testdata3_best_pre_Vd   , xmin_Vd  , xrate_Vd  );

testdata3_best_post_batNum = 95;
len = length(ryan5_battery_dataset(testdata3_best_post_batNum).QDischargeSmooth)
for i=1:len 
    if ryan5_battery_dataset(testdata3_best_post_batNum).QDischargeSmooth(i) < Cap_change  
        break
    end
end
testdata3_best_post_idx = i
testdata3_best_post_soh = ryan5_battery_dataset(testdata3_best_post_batNum).QDischargeSmooth(testdata3_best_post_idx:end);
testdata3_best_post_rul = ryan5_battery_dataset(testdata3_best_post_batNum).RUL(testdata3_best_post_idx:end);
testdata3_best_post_VdFull = ryan5_battery_dataset(testdata3_best_post_batNum).Vd(testdata3_best_post_idx:end,:);
testdata3_best_post_Vd = blockproc(testdata3_best_post_VdFull, blockSize, meanFilterFunction);
testdata3_best_post_Vd_norm = minmax_norm_x_with_param(testdata3_best_post_Vd   , xmin_Vd  , xrate_Vd  );

testdata3_best_soh = [testdata3_best_pre_soh ; testdata3_best_post_soh ];
testdata3_best_rul = [testdata3_best_pre_rul ; testdata3_best_post_rul ];
testdata3_best_Vd_norm = [testdata3_best_pre_Vd_norm ; testdata3_best_post_Vd_norm ]
%%

figure, hold on,
plot(ryan5_change_bl_Qd);
plot(testdata3_best_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bl_Rul);
plot(testdata3_best_rul, line_1);
ylabel('RUL')
hold off 

title("The Best Similar Training Data for Test Data 3 ("+ num2str(testdata3_best_pre_batNum) + "->" + num2str(testdata3_best_post_batNum)+")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = testdata3_batNum_str + ", Test Data 3 (SOH)";
legend_str{2} = num2str(testdata3_best_pre_batNum) + "->" + num2str(testdata3_best_post_batNum) + ", The Best Similar Data (SOH)";
legend_str{3} = testdata3_batNum_str + ", Test Data 3 (RUL)";
legend_str{4} = num2str(testdata3_best_pre_batNum) + "->" + num2str(testdata3_best_post_batNum) + ", The Best Similar Data (RUL)";
legend(legend_str)
%%

%%
% 50th similar = 17 -> 103

testdata3_poor_pre_batNum = 17;
len = length(ryan5_battery_dataset(testdata3_poor_pre_batNum).QDischargeSmooth)
for i=1:len 
    if ryan5_battery_dataset(testdata3_poor_pre_batNum).QDischargeSmooth(i) < Cap_change  
        break
    end
end
testdata3_poor_pre_idx = i+1
testdata3_poor_pre_soh = ryan5_battery_dataset(testdata3_poor_pre_batNum).QDischargeSmooth(1:testdata3_poor_pre_idx);
testdata3_poor_pre_rul = ryan5_battery_dataset(testdata3_poor_pre_batNum).RUL(1:testdata3_poor_pre_idx);
testdata3_poor_pre_VdFull = ryan5_battery_dataset(testdata3_poor_pre_batNum).Vd(1:testdata3_poor_pre_idx,:);
testdata3_poor_pre_Vd = blockproc(testdata3_poor_pre_VdFull, blockSize, meanFilterFunction);
testdata3_poor_pre_Vd_norm = minmax_norm_x_with_param(testdata3_poor_pre_Vd   , xmin_Vd  , xrate_Vd  );

testdata3_poor_post_batNum = 103;
len = length(ryan5_battery_dataset(testdata3_poor_post_batNum).QDischargeSmooth)
for i=1:len 
    if ryan5_battery_dataset(testdata3_poor_post_batNum).QDischargeSmooth(i) < Cap_change  
        break
    end
end
testdata3_poor_post_idx = i
testdata3_poor_post_soh = ryan5_battery_dataset(testdata3_poor_post_batNum).QDischargeSmooth(testdata3_poor_post_idx:end);
testdata3_poor_post_rul = ryan5_battery_dataset(testdata3_poor_post_batNum).RUL(testdata3_poor_post_idx:end);
testdata3_poor_post_VdFull = ryan5_battery_dataset(testdata3_poor_post_batNum).Vd(testdata3_poor_post_idx:end,:);
testdata3_poor_post_Vd = blockproc(testdata3_poor_post_VdFull, blockSize, meanFilterFunction);
testdata3_poor_post_Vd_norm = minmax_norm_x_with_param(testdata3_poor_post_Vd   , xmin_Vd  , xrate_Vd  );
testdata3_poor_Vd_norm = [testdata3_poor_pre_Vd_norm ; testdata3_poor_post_Vd_norm ]

testdata3_poor_soh = [testdata3_poor_pre_soh ; testdata3_poor_post_soh ];
testdata3_poor_rul = [testdata3_poor_pre_rul ; testdata3_poor_post_rul ];
%%

figure, hold on,
plot(ryan5_change_bl_Qd);
plot(testdata3_poor_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bl_Rul);
plot(testdata3_poor_rul, line_1);
ylabel('RUL')
hold off 

title("The Average Similar Training Data for Test Data 3 ("+ num2str(testdata3_poor_pre_batNum) + "->" + num2str(testdata3_poor_post_batNum)+")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = testdata3_batNum_str + ", Test Data 3 (SOH)";
legend_str{2} = num2str(testdata3_poor_pre_batNum) + "->" + num2str(testdata3_poor_post_batNum) + ", The Average Similar Data (SOH)";
legend_str{3} = testdata3_batNum_str + ", Test Data 3 (RUL)";
legend_str{4} = num2str(testdata3_poor_pre_batNum) + "->" + num2str(testdata3_poor_post_batNum) + ", The Average Similar Data (RUL)";
legend(legend_str)
%%
testdata3_worse_batNum = testdata_shortRul_batNum;
len = length(ryan5_battery_dataset(testdata3_worse_batNum).QDischargeSmooth);
testdata3_worse_soh = ryan5_battery_dataset(testdata3_worse_batNum).QDischargeSmooth;
testdata3_worse_rul = ryan5_battery_dataset(testdata3_worse_batNum).RUL;
testdata3_worse_VdFull = ryan5_battery_dataset(testdata3_worse_batNum).Vd;
testdata3_worse_Vd = blockproc(testdata3_worse_VdFull, blockSize, meanFilterFunction);
testdata3_worse_Vd_norm = minmax_norm_x_with_param(testdata3_worse_Vd   , xmin_Vd  , xrate_Vd  );

figure, hold on,
plot(ryan5_change_bl_Qd);
plot(testdata3_worse_soh, line_1);
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bl_Rul);
plot(testdata3_worse_rul, line_1);
ylabel('RUL')
hold off 

title("The Worse Similar Training Data for Test Data 3 (Battery Number : " + num2str(testdata2_worse_batNum) +")" )
xlabel('Cycle')
legend_str = cell(4,1);
legend_str{1} = testdata3_batNum_str + ", Test Data 3 (SOH)";
legend_str{2} = num2str(testdata2_worse_batNum) + ", The Worse Similar Data (SOH)";
legend_str{3} = testdata3_batNum_str + ", Test Data 3 (RUL)";
legend_str{4} = num2str(testdata2_worse_batNum) +  ", The Worse Similar Data (RUL)";
legend(legend_str)
%%

%%

%%
ryan5_change_bb_Qd_diff = [ 0 ; diff(ryan5_change_bb_Qd)];
ryan5_change_bb_Qd_diff_diff = [ 0 ; diff(ryan5_change_bb_Qd_diff)];
figure
histogram(ryan5_change_bb_Qd_diff_diff);
%%%%%%%%%%%%%%%%%%%%%%%%%%%5
ryan5_change_bs_Qd_diff = [ 0 ; diff(ryan5_change_bs_Qd)];
ryan5_change_bs_Qd_diff_diff = [ 0 ; diff(ryan5_change_bs_Qd_diff)];
figure
histogram(ryan5_change_bs_Qd_diff_diff);

find(ryan5_change_bs_Qd_diff_diff > 0);
find(ryan5_change_bs_Qd_diff_diff < -0.001 );
%%%%%%%%%%%%%%%%%%%%%%%%%%%5

ryan5_change_bl_Qd_diff = [ 0 ; diff(ryan5_change_bl_Qd)];
ryan5_change_bl_Qd_diff_diff = [ 0 ; diff(ryan5_change_bl_Qd_diff)];
figure
histogram(ryan5_change_bl_Qd_diff_diff);
find(ryan5_change_bl_Qd_diff_diff > 0);
find(ryan5_change_bl_Qd_diff_diff < -0.001 );

% check SOH change
%ryan5_change_bb_Qd

figure, hold on
plot(ryan5_change_bb_Qd_diff)
plot(ryan5_change_bs_Qd_diff,'--')
plot(ryan5_change_bl_Qd_diff,'-.')
hold off

title("1st Diff of Test Data 1,2,3")
ylabel('1st Diff')
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = 'Test Data 1';
legend_str{2} = 'Test Data 2';
legend_str{3} = 'Test Data 3';
legend(legend_str)



%%

figure, hold on
plot(ryan5_change_bb_Qd_diff_diff)
%pause(1)
plot(ryan5_change_bs_Qd_diff_diff,'--')
%pause(1)
plot(ryan5_change_bl_Qd_diff_diff,'-.')
hold off

title("2nd Diff of Test Data 1,2,3")
ylabel('2nd Diff')
xlabel('Cycle')
legend_str = cell(3,1);
legend_str{1} = 'Test Data 1';
legend_str{2} = 'Test Data 2';
legend_str{3} = 'Test Data 3';
legend(legend_str)
peak_bs_ = max(abs(ryan5_change_bs_Qd_diff_diff))
peak_bl_ = max(abs(ryan5_change_bl_Qd_diff_diff))
peak_change_point = min(peak_bs_, peak_bl_) * 0.8 

%%
ryan5_change_bs_Qd_change_idx = find(abs(ryan5_change_bs_Qd_diff_diff) > peak_change_point)
ryan5_change_bs_Qd_change_idx = ryan5_change_bs_Qd_change_idx(end)

ryan5_change_bl_Qd_change_idx = find(abs(ryan5_change_bl_Qd_diff_diff) > peak_change_point)

ryan5_change_bl_Qd_change_idx = ryan5_change_bl_Qd_change_idx(end)

figure, hold on,
plot(ryan5_change_bb_Qd)
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bb_Qd_diff_diff)
ylabel('2nd diff')
hold off 
title("Change Point of Test Data 1")
xlabel('Cycle')
legend_str = cell(1,1);
legend_str{1} = 'Test Data 1';
legend(legend_str)


figure, hold on,
plot(ryan5_change_bs_Qd)
plot(ryan5_change_bs_Qd_change_idx,ryan5_change_bs_Qd(ryan5_change_bs_Qd_change_idx),'r*')
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bs_Qd_diff_diff)
ylabel('2nd diff')
hold off 

title("Change Point of Test Data 2")
xlabel('Cycle')
legend_str = cell(2,1);
legend_str{1} = 'Test Data 2';
legend_str{2} = 'Change Point';
legend(legend_str)

figure, hold on,
plot(ryan5_change_bl_Qd)
plot(ryan5_change_bl_Qd_change_idx,ryan5_change_bl_Qd(ryan5_change_bl_Qd_change_idx),'r*')
ylabel('SOH (Ah)')
yyaxis right
plot(ryan5_change_bl_Qd_diff_diff)
ylabel('2nd diff')
hold off 

title("Change Point of Test Data 3")

xlabel('Cycle')


legend_str = cell(2,1);
legend_str{1} = 'Test Data 3';
legend_str{2} = 'Change Point';
legend(legend_str)
%% 
%% 
%% Find best match for test data 2 after change  - RUL based

% ryan5_util_global
% % Cap_change = (Cap_Rated + Cap_EOL ) / 2
% 
% [   testdata1_similar_batNum_1 , ... 
%     testdata1_similar_Rul_1, ...
%     testdata1_similar_idx_1, ...
%     testdata1_similar_batNum_2, ...
%     testdata1_similar_Rul_2,...
%     testdata1_similar_idx_2 ] = ...
%     ryan5_util_find_similar_bat_with_rul_after_change( ryan5_change_bs_Rul,testdata1_change_idx+1, Cap_change)
% %[bestFitBatNum, bestFitBatCycle] = ryan5_util_find_similar_soh_bat_with_cycles(ryan5_change_bb_Qd,1,5)
% 
% % testdata1_similar_batNum_1 = idxAll(testdata1_similar_batNum_1)
% % testdata1_similar_batNum_2 = idxAll(testdata1_similar_batNum_2)
% 
% figure, hold on
% plot(ryan5_change_bs_Qd(testdata1_change_idx+1:end))
% plot(ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(testdata1_similar_idx_1:end),'--')
% plot(ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(testdata1_similar_idx_2:end),':')
% ylabel('SOH (Ah)')
% xlabel('Cycle from Change Point')
% hold off
% legend_str = cell(3,1);
% legend_str{1} = '16->76, Test Data 2';
% legend_str{2} = num2str(testdata1_similar_batNum_1) + ", Upper Matched";
% legend_str{3} = num2str(testdata1_similar_batNum_2+1) + " , Lower Matched";
% legend(legend_str)
%% Find best match for test data 2 after change  - RUL based - manual

% for i=1:length(ryan5_battery_dataset(testdata_base_batNum).cycle)
%  if ryan5_battery_dataset(testdata_base_batNum).QDischargeSmooth(i) < Cap_change 
%     break
%  end
% end 
% batNum_base_pre_idx = i;
% 
% for i=1:length(ryan5_battery_dataset(testdata1_similar_batNum_1).cycle)
%  if ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(i) < Cap_change 
%     break
%  end
% end 
% batNum_ref_pre_idx = i;
% 
% for i=1:length(ryan5_battery_dataset(testdata1_similar_batNum_2).cycle)
%  if ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(i) < Cap_change 
%     break
%  end
% end 
% batNum_ref_2nd_pre_idx = i;
% 
% %testdata2_bast_match_SOH_pre = [ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(testdata1_similar_idx_1:end)];
% %testdata2_2nd_match_SOH_pre = [ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(testdata1_similar_idx_2:end)];
% 
% testdata2_base_SOH_pre = [ryan5_battery_dataset(testdata_base_batNum).QDischargeSmooth(1:batNum_base_pre_idx)];
% testdata2_base_SOH_post = [ryan5_battery_dataset(testdata_base_batNum).QDischargeSmooth(batNum_base_pre_idx+1:end)];
% 
% testdata2_bestMatch_SOH_pre = [ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(1:batNum_ref_pre_idx)];
% testdata2_2ndMatch_SOH_pre = [ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(1:batNum_ref_2nd_pre_idx)];
% 
% testdata2_bestMatch_RUL_pre = linspace(ryan5_battery_dataset(testdata1_similar_batNum_1).cycle_life, ...
%     ryan5_battery_dataset(testdata1_similar_batNum_1).cycle_life - length(testdata2_bestMatch_SOH_pre) + 1 , ... 
%     length(testdata2_bestMatch_SOH_pre ) )
% testdata2_2ndMatch_RUL_pre = linspace(ryan5_battery_dataset(testdata1_similar_batNum_2).cycle_life, ...
%     ryan5_battery_dataset(testdata1_similar_batNum_2).cycle_life - length(testdata2_2ndMatch_SOH_pre) + 1 , ... 
%     length(testdata2_2ndMatch_SOH_pre ) )
% %%%%%%%%%%%%%%%%%
% %testdata2_bast_match_SOH_post = [ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(testdata1_similar_idx_1:end)];
% %testdata2_2nd_match_SOH_post = [ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(testdata1_similar_idx_2:end)];
% 
% testdata2_bestMatch_SOH_post= ryan5_battery_dataset(testdata1_similar_batNum_1).QDischargeSmooth(testdata1_similar_idx_1:end);
% testdata2_2ndMatch_SOH_post  = ryan5_battery_dataset(testdata1_similar_batNum_2).QDischargeSmooth(testdata1_similar_idx_2:end);
% 
% testdata2_bestMatch_SOH = [ testdata2_bestMatch_SOH_pre ; testdata2_bestMatch_SOH_post];
% testdata2_2ndMatch_SOH = [ testdata2_2ndMatch_SOH_pre ; testdata2_2ndMatch_SOH_post];
% 
% % testdata2_base_SOH = [ testdata2_base_SOH_pre ; testdata2_base_SOH_post ];
% % testdata2_base_RUL = linspace(ryan5_battery_dataset(testdata_base_batNum).cycle_life, ...
% %     1 , ... 
% %     length(testdata2_base_SOH ) )
% 
% testdata2_base_SOH = ryan5_change_bs_Qd;
% testdata2_base_RUL = ryan5_change_bs_Rul;
% 
% testdata2_bestMatch_RUL_post = linspace(length(testdata2_bestMatch_SOH_post), ...
%      1 , length(testdata2_bestMatch_SOH_post))
% 
% testdata2_2ndMatch_RUL_post = linspace(length(testdata2_2ndMatch_SOH_post), ...
%      1 , length(testdata2_2ndMatch_SOH_post))
% 
% testdata2_bestMatch_RUL = [ testdata2_bestMatch_RUL_pre  testdata2_bestMatch_RUL_post ]';
% testdata2_2ndMatch_RUL = [ testdata2_2ndMatch_RUL_pre  testdata2_2ndMatch_RUL_post]';
% 
% 
% %%%%%%%%%%%%%%%%
% 
% 
% figure, hold on
% plot(testdata2_base_SOH_pre)
% plot(testdata2_bestMatch_SOH_pre,line_1)
% plot(testdata2_2ndMatch_SOH_pre,line_2)
% hold off
% ylabel 'SOH (Ah)'
% xlabel 'Cycle - After change '
% title 'Find Most Mimilar Data for Test Data 2 - Show difference in Pre'
% 
% 
% figure, hold on
% plot(ryan5_change_bs_Qd)
% plot(testdata2_bestMatch_SOH,line_1)
% plot(testdata2_2ndMatch_SOH,line_2)
% hold off
% ylabel 'SOH (Ah)'
% xlabel 'Cycle - After change '
% title 'Find Most Similar Data for Test Data 2 '
%%
% 
% figure, hold on
% plot(testdata2_base_SOH)
% plot(testdata2_bestMatch_SOH,'--')
% plot(testdata2_2ndMatch_SOH,':')
% hold off
% legend_str = cell(3,1);
% legend_str{1} = 'Refernce';
% legend_str{2} = 'Upper Matched';
% legend_str{3} = 'Lower Matched';
% legend(legend_str)
% 
% figure, hold on
% plot(testdata2_base_RUL)
% plot(testdata2_bestMatch_RUL,'--')
% plot(testdata2_2ndMatch_RUL,':')
% hold off
% legend_str = cell(3,1);
% legend_str{1} = 'Refernce';
% legend_str{2} = 'Upper Matched';
% legend_str{3} = 'Lower Matched';
% legend(legend_str)
%%

%%
ynorm_ryan5_change_bb_Rul = minmax_norm_x_with_param(ryan5_change_bb_Rul  , ymin_RUL , yrate_RUL );
ynorm_ryan5_change_bs_Qd  = minmax_norm_x_with_param(ryan5_change_bs_Qd   , ymin_SOH , yrate_SOH );
ynorm_ryan5_change_bb_Qd  = minmax_norm_x_with_param(ryan5_change_bb_Qd   , ymin_SOH , yrate_SOH );
ynorm_ryan5_change_bl_Qd  = minmax_norm_x_with_param(ryan5_change_bl_Qd   , ymin_SOH , yrate_SOH );
xnorm_ryan5_change_bs_Vd  = minmax_norm_x_with_param(ryan5_change_bs_Vd   , xmin_Vd  , xrate_Vd  );
xnorm_ryan5_change_bb_Vd  = minmax_norm_x_with_param(ryan5_change_bb_Vd   , xmin_Vd  , xrate_Vd  );
xnorm_ryan5_change_bl_Vd  = minmax_norm_x_with_param(ryan5_change_bl_Vd   , xmin_Vd  , xrate_Vd  );

ynorm_ryan5_change_bs_Rul = minmax_norm_x_with_param(ryan5_change_bs_Rul  , ymin_RUL , yrate_RUL );
ynorm_ryan5_change_bl_Rul = minmax_norm_x_with_param(ryan5_change_bl_Rul  , ymin_RUL , yrate_RUL )



xnorm_ref   = xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)) , : );
xnorm_small = xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == testdata_shortRul_batNum)) , : );
xnorm_big = xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == testdata_longRul_batNum)) , : );

ynorm_ref   = ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)) , : );
ynorm_small = ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == testdata_shortRul_batNum)) , : );
ynorm_big = ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == testdata_longRul_batNum)) , : );

ynorm_soh_ref   = ynorm_SOH( idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)) , : );
ynorm_soh_small = ynorm_SOH( idxTestAll(find(idxTestAll_batIndex == testdata_shortRul_batNum)) , : );
ynorm_soh_big = ynorm_SOH( idxTestAll(find(idxTestAll_batIndex == testdata_longRul_batNum)) , : );

Y_ref   = RUL( idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)) , : );
Y_small = RUL( idxTestAll(find(idxTestAll_batIndex == testdata_shortRul_batNum)) , : );
Y_big = RUL( idxTestAll(find(idxTestAll_batIndex == testdata_longRul_batNum)) , : );

xnorm_ref_to_small   = xnorm_ryan5_change_bs_Vd;
xnorm_ref_to_big     = xnorm_ryan5_change_bl_Vd;


size(ynorm_ryan5_change_bl_Rul)
%size(ynorm_ref_to_big)

ynorm_ref_to_small   = ynorm_ryan5_change_bs_Rul;
ynorm_ref_to_big     = ynorm_ryan5_change_bl_Rul;


Y_ref_to_small   = ryan5_change_bs_Rul;
Y_ref_to_big     = ryan5_change_bl_Rul;

%%
Y_soh_ref   = Cap( idxTestAll(find(idxTestAll_batIndex == testdata_base_batNum)) , : );
Y_soh_small = Cap( idxTestAll(find(idxTestAll_batIndex == testdata_shortRul_batNum)) , : );
Y_soh_big   = Cap( idxTestAll(find(idxTestAll_batIndex == testdata_longRul_batNum)) , : );

ynorm_soh_ref = ynorm_ryan5_change_bb_Qd;
ynorm_soh_ref_to_small   = ynorm_ryan5_change_bs_Qd;
ynorm_soh_ref_to_big     = ynorm_ryan5_change_bl_Qd;
Y_soh_ref_to_small   = ryan5_change_bs_Qd;
Y_soh_ref_to_big     = ryan5_change_bl_Qd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

testdata1_base_rul = ryan5_change_bb_Rul;
testdata2_base_rul = ryan5_change_bs_Rul;
testdata3_base_rul = ryan5_change_bs_Rul;

len_testdata1_base_rul = length(  testdata1_base_rul  ) - mod(length(  testdata1_base_rul  ),5);
len_testdata1_best_rul = length(  testdata1_best_rul  ) - mod(length(  testdata1_best_rul  ),5);
len_testdata1_poor_rul = length(  testdata1_poor_rul  ) - mod(length(  testdata1_poor_rul  ),5);
len_testdata2_base_rul = length(  testdata2_base_rul  ) - mod(length(  testdata2_base_rul  ),5);
len_testdata2_best_rul = length(  testdata2_best_rul  ) - mod(length(  testdata2_best_rul  ),5);
len_testdata2_poor_rul = length(  testdata2_poor_rul  ) - mod(length(  testdata2_poor_rul  ),5);
len_testdata3_base_rul = length(  testdata3_base_rul  ) - mod(length(  testdata3_base_rul  ),5);
len_testdata3_best_rul = length(  testdata3_best_rul  ) - mod(length(  testdata3_best_rul  ),5);
len_testdata3_poor_rul = length(  testdata3_poor_rul  ) - mod(length(  testdata3_poor_rul  ),5);

testdata1_base_rul = testdata1_base_rul(1:len_testdata1_base_rul , : ); 
testdata1_best_rul = testdata1_best_rul(1:len_testdata1_best_rul , : ); 
testdata1_poor_rul = testdata1_poor_rul(1:len_testdata1_poor_rul , : ); 
testdata2_base_rul = testdata2_base_rul(1:len_testdata2_base_rul , : ); 
testdata2_best_rul = testdata2_best_rul(1:len_testdata2_best_rul , : ); 
testdata2_poor_rul = testdata2_poor_rul(1:len_testdata2_poor_rul , : ); 
testdata3_base_rul = testdata3_base_rul(1:len_testdata3_base_rul , : ); 
testdata3_best_rul = testdata3_best_rul(1:len_testdata3_best_rul , : ); 
testdata3_poor_rul = testdata3_poor_rul(1:len_testdata3_poor_rul , : ); 


testdata1_base_soh = ryan5_change_bb_Qd;
testdata2_base_soh = ryan5_change_bs_Qd;
testdata3_base_soh = ryan5_change_bs_Qd;

len_testdata1_base_soh = length(  testdata1_base_soh  ) - mod(length(  testdata1_base_soh  ),5);
len_testdata1_best_soh = length(  testdata1_best_soh  ) - mod(length(  testdata1_best_soh  ),5);
len_testdata1_poor_soh = length(  testdata1_poor_soh  ) - mod(length(  testdata1_poor_soh  ),5);
len_testdata2_base_soh = length(  testdata2_base_soh  ) - mod(length(  testdata2_base_soh  ),5);
len_testdata2_best_soh = length(  testdata2_best_soh  ) - mod(length(  testdata2_best_soh  ),5);
len_testdata2_poor_soh = length(  testdata2_poor_soh  ) - mod(length(  testdata2_poor_soh  ),5);
len_testdata3_base_soh = length(  testdata3_base_soh  ) - mod(length(  testdata3_base_soh  ),5);
len_testdata3_best_soh = length(  testdata3_best_soh  ) - mod(length(  testdata3_best_soh  ),5);
len_testdata3_poor_soh = length(  testdata3_poor_soh  ) - mod(length(  testdata3_poor_soh  ),5);

testdata1_base_soh = testdata1_base_soh(1:len_testdata1_base_soh , : ); 
testdata1_best_soh = testdata1_best_soh(1:len_testdata1_best_soh , : ); 
testdata1_poor_soh = testdata1_poor_soh(1:len_testdata1_poor_soh , : ); 
testdata2_base_soh = testdata2_base_soh(1:len_testdata2_base_soh , : ); 
testdata2_best_soh = testdata2_best_soh(1:len_testdata2_best_soh , : ); 
testdata2_poor_soh = testdata2_poor_soh(1:len_testdata2_poor_soh , : ); 
testdata3_base_soh = testdata3_base_soh(1:len_testdata3_base_soh , : ); 
testdata3_best_soh = testdata3_best_soh(1:len_testdata3_best_soh , : ); 
testdata3_poor_soh = testdata3_poor_soh(1:len_testdata3_poor_soh , : ); 


testdata1_base_rul_norm = ynorm_ref;
testdata1_best_rul_norm = minmax_norm_x_with_param(testdata1_best_rul  , ymin_RUL , yrate_RUL );
testdata1_poor_rul_norm = minmax_norm_x_with_param(testdata1_poor_rul  , ymin_RUL , yrate_RUL );
testdata2_base_rul_norm = ynorm_ref_to_small;
testdata2_best_rul_norm = minmax_norm_x_with_param(testdata2_best_rul  , ymin_RUL , yrate_RUL );
testdata2_poor_rul_norm = minmax_norm_x_with_param(testdata2_poor_rul  , ymin_RUL , yrate_RUL );
testdata3_base_rul_norm = ynorm_ref_to_big;
testdata3_best_rul_norm = minmax_norm_x_with_param(testdata3_best_rul  , ymin_RUL , yrate_RUL );
testdata3_poor_rul_norm = minmax_norm_x_with_param(testdata3_poor_rul  , ymin_RUL , yrate_RUL );


len_testdata1_base_rul_norm = length(  testdata1_base_rul_norm  ) - mod(length(  testdata1_base_rul_norm  ),5);
len_testdata1_best_rul_norm = length(  testdata1_best_rul_norm  ) - mod(length(  testdata1_best_rul_norm  ),5);
len_testdata1_poor_rul_norm = length(  testdata1_poor_rul_norm  ) - mod(length(  testdata1_poor_rul_norm  ),5);
len_testdata2_base_rul_norm = length(  testdata2_base_rul_norm  ) - mod(length(  testdata2_base_rul_norm  ),5);
len_testdata2_best_rul_norm = length(  testdata2_best_rul_norm  ) - mod(length(  testdata2_best_rul_norm  ),5);
len_testdata2_poor_rul_norm = length(  testdata2_poor_rul_norm  ) - mod(length(  testdata2_poor_rul_norm  ),5);
len_testdata3_base_rul_norm = length(  testdata3_base_rul_norm  ) - mod(length(  testdata3_base_rul_norm  ),5);
len_testdata3_best_rul_norm = length(  testdata3_best_rul_norm  ) - mod(length(  testdata3_best_rul_norm  ),5);
len_testdata3_poor_rul_norm = length(  testdata3_poor_rul_norm  ) - mod(length(  testdata3_poor_rul_norm  ),5);

testdata1_base_rul_norm = testdata1_base_rul_norm(1:len_testdata1_base_rul_norm , : ); 
testdata1_best_rul_norm = testdata1_best_rul_norm(1:len_testdata1_best_rul_norm , : ); 
testdata1_poor_rul_norm = testdata1_poor_rul_norm(1:len_testdata1_poor_rul_norm , : ); 
testdata2_base_rul_norm = testdata2_base_rul_norm(1:len_testdata2_base_rul_norm , : ); 
testdata2_best_rul_norm = testdata2_best_rul_norm(1:len_testdata2_best_rul_norm , : ); 
testdata2_poor_rul_norm = testdata2_poor_rul_norm(1:len_testdata2_poor_rul_norm , : ); 
testdata3_base_rul_norm = testdata3_base_rul_norm(1:len_testdata3_base_rul_norm , : ); 
testdata3_best_rul_norm = testdata3_best_rul_norm(1:len_testdata3_best_rul_norm , : ); 
testdata3_poor_rul_norm = testdata3_poor_rul_norm(1:len_testdata3_poor_rul_norm , : ); 

%%%%%%%% Vd norm
testdata1_base_Vd_norm = xnorm_ryan5_change_bb_Vd;
testdata2_base_Vd_norm = xnorm_ryan5_change_bs_Vd;
testdata3_base_Vd_norm = xnorm_ryan5_change_bl_Vd;

len_testdata1_base_Vd_norm = length(  testdata1_base_Vd_norm  ) - mod(length(  testdata1_base_Vd_norm  ),5);
len_testdata1_best_Vd_norm = length(  testdata1_best_Vd_norm  ) - mod(length(  testdata1_best_Vd_norm  ),5);
len_testdata1_poor_Vd_norm = length(  testdata1_poor_Vd_norm  ) - mod(length(  testdata1_poor_Vd_norm  ),5);
len_testdata2_base_Vd_norm = length(  testdata2_base_Vd_norm  ) - mod(length(  testdata2_base_Vd_norm  ),5);
len_testdata2_best_Vd_norm = length(  testdata2_best_Vd_norm  ) - mod(length(  testdata2_best_Vd_norm  ),5);
len_testdata2_poor_Vd_norm = length(  testdata2_poor_Vd_norm  ) - mod(length(  testdata2_poor_Vd_norm  ),5);
len_testdata3_base_Vd_norm = length(  testdata3_base_Vd_norm  ) - mod(length(  testdata3_base_Vd_norm  ),5);
len_testdata3_best_Vd_norm = length(  testdata3_best_Vd_norm  ) - mod(length(  testdata3_best_Vd_norm  ),5);
len_testdata3_poor_Vd_norm = length(  testdata3_poor_Vd_norm  ) - mod(length(  testdata3_poor_Vd_norm  ),5);



testdata1_base_Vd_norm = testdata1_base_Vd_norm(1:len_testdata1_base_Vd_norm , : ); 
testdata1_best_Vd_norm = testdata1_best_Vd_norm(1:len_testdata1_best_Vd_norm , : ); 
testdata1_poor_Vd_norm = testdata1_poor_Vd_norm(1:len_testdata1_poor_Vd_norm , : ); 
testdata2_base_Vd_norm = testdata2_base_Vd_norm(1:len_testdata2_base_Vd_norm , : ); 
testdata2_best_Vd_norm = testdata2_best_Vd_norm(1:len_testdata2_best_Vd_norm , : ); 
testdata2_poor_Vd_norm = testdata2_poor_Vd_norm(1:len_testdata2_poor_Vd_norm , : ); 
testdata3_base_Vd_norm = testdata3_base_Vd_norm(1:len_testdata3_base_Vd_norm , : ); 
testdata3_best_Vd_norm = testdata3_best_Vd_norm(1:len_testdata3_best_Vd_norm , : ); 
testdata3_poor_Vd_norm = testdata3_poor_Vd_norm(1:len_testdata3_poor_Vd_norm , : ); 

%%%%%%%%%%%% SOH norm 

testdata1_base_soh_norm = ynorm_soh_ref;
testdata1_best_soh_norm = minmax_norm_x_with_param(testdata1_best_soh  , ymin_SOH , yrate_SOH );
testdata1_poor_soh_norm = minmax_norm_x_with_param(testdata1_poor_soh  , ymin_SOH , yrate_SOH );
testdata2_base_soh_norm = ynorm_soh_ref_to_small;
testdata2_best_soh_norm = minmax_norm_x_with_param(testdata2_best_soh  , ymin_SOH , yrate_SOH );
testdata2_poor_soh_norm = minmax_norm_x_with_param(testdata2_poor_soh  , ymin_SOH , yrate_SOH );
testdata3_base_soh_norm = ynorm_soh_ref_to_big;
testdata3_best_soh_norm = minmax_norm_x_with_param(testdata3_best_soh  , ymin_SOH , yrate_SOH );
testdata3_poor_soh_norm = minmax_norm_x_with_param(testdata3_poor_soh  , ymin_SOH , yrate_SOH );


len_testdata1_base_soh_norm = length(  testdata1_base_soh_norm  ) - mod(length(  testdata1_base_soh_norm  ),5);
len_testdata1_best_soh_norm = length(  testdata1_best_soh_norm  ) - mod(length(  testdata1_best_soh_norm  ),5);
len_testdata1_poor_soh_norm = length(  testdata1_poor_soh_norm  ) - mod(length(  testdata1_poor_soh_norm  ),5);
len_testdata2_base_soh_norm = length(  testdata2_base_soh_norm  ) - mod(length(  testdata2_base_soh_norm  ),5);
len_testdata2_best_soh_norm = length(  testdata2_best_soh_norm  ) - mod(length(  testdata2_best_soh_norm  ),5);
len_testdata2_poor_soh_norm = length(  testdata2_poor_soh_norm  ) - mod(length(  testdata2_poor_soh_norm  ),5);
len_testdata3_base_soh_norm = length(  testdata3_base_soh_norm  ) - mod(length(  testdata3_base_soh_norm  ),5);
len_testdata3_best_soh_norm = length(  testdata3_best_soh_norm  ) - mod(length(  testdata3_best_soh_norm  ),5);
len_testdata3_poor_soh_norm = length(  testdata3_poor_soh_norm  ) - mod(length(  testdata3_poor_soh_norm  ),5);

testdata1_base_soh_norm = testdata1_base_soh_norm(1:len_testdata1_base_soh_norm , : ); 
testdata1_best_soh_norm = testdata1_best_soh_norm(1:len_testdata1_best_soh_norm , : ); 
testdata1_poor_soh_norm = testdata1_poor_soh_norm(1:len_testdata1_poor_soh_norm , : ); 
testdata2_base_soh_norm = testdata2_base_soh_norm(1:len_testdata2_base_soh_norm , : ); 
testdata2_best_soh_norm = testdata2_best_soh_norm(1:len_testdata2_best_soh_norm , : ); 
testdata2_poor_soh_norm = testdata2_poor_soh_norm(1:len_testdata2_poor_soh_norm , : ); 
testdata3_base_soh_norm = testdata3_base_soh_norm(1:len_testdata3_base_soh_norm , : ); 
testdata3_best_soh_norm = testdata3_best_soh_norm(1:len_testdata3_best_soh_norm , : ); 
testdata3_poor_soh_norm = testdata3_poor_soh_norm(1:len_testdata3_poor_soh_norm , : ); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%%
len_ref            =  length(xnorm_ref            ) - mod(length(xnorm_ref          ),5) ; 
len_small          =  length(xnorm_small           ) - mod(length(xnorm_small       ),5) ; 
len_big            =  length(xnorm_big             ) - mod(length(xnorm_big          ),5) ; 
len_ref_to_small   =  length(xnorm_ref_to_small    ) - mod(length(xnorm_ref_to_small ),5) ; 
len_ref_to_big     =  length(xnorm_ref_to_big      ) - mod(length(xnorm_ref_to_big   ),5) ; 

xnorm_ref            =  xnorm_ref           (1:len_ref                 ,:     ) ; 
xnorm_small          =  xnorm_small         (1:len_small               ,:     ) ; 
xnorm_big            =  xnorm_big           (1:len_big                 ,:     ) ; 
xnorm_ref_to_small   =  xnorm_ref_to_small  (1:len_ref_to_small        ,:     ) ; 
xnorm_ref_to_big     =  xnorm_ref_to_big    (1:len_ref_to_big          ,:     ) ; 



size(ynorm_ref_to_big)
ynorm_ref            =  ynorm_ref           (1:len_ref                      ) ; 
ynorm_small          =  ynorm_small         (1:len_small                    ) ; 
ynorm_big            =  ynorm_big           (1:len_big                      ) ; 
ynorm_ref_to_small   =  ynorm_ref_to_small  (1:len_ref_to_small             ) ; 
ynorm_ref_to_big     =  ynorm_ref_to_big    (1:len_ref_to_big               ) ; 
ynorm_soh_ref_to_small   =  ynorm_soh_ref_to_small  (1:len_ref_to_small            ) ; 
ynorm_soh_ref_to_big     =  ynorm_soh_ref_to_big    (1:len_ref_to_big               ) ; 

Y_ref            =  Y_ref           (1:len_ref                      ) ; 
Y_small          =  Y_small         (1:len_small                    ) ; 
Y_big            =  Y_big           (1:len_big                      ) ; 
Y_ref_to_small   =  Y_ref_to_small  (1:len_ref_to_small             ) ; 
Y_ref_to_big     =  Y_ref_to_big    (1:len_ref_to_big               ) ; 


%%
Y_soh_ref            =  Y_soh_ref           (1:len_ref                      ) ; 
Y_soh_small          =  Y_soh_small         (1:len_small                    ) ; 
Y_soh_big            =  Y_soh_big           (1:len_big                      ) ; 
Y_soh_ref_to_small   =  Y_soh_ref_to_small  (1:len_ref_to_small             ) ; 
Y_soh_ref_to_big     =  Y_soh_ref_to_big    (1:len_ref_to_big               ) ; 


%%
xnorm_1  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(1 ))) , : );
xnorm_2  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(2 ))) , : );
xnorm_3  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(3 ))) , : );
xnorm_4  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(4 ))) , : );
xnorm_5  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(5 ))) , : );
xnorm_6  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(6 ))) , : );
xnorm_7  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(7 ))) , : );
xnorm_8  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(8 ))) , : );
xnorm_9  =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(9 ))) , : );
xnorm_10 =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(10))) , : );
xnorm_11 =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(11))) , : );
xnorm_12 =  xnorm_Vd( idxTestAll(find(idxTestAll_batIndex == idxTestSort(12))) , : );

ynorm_1  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(1 ))) );
ynorm_2  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(2 ))) );
ynorm_3  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(3 ))) );
ynorm_4  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(4 ))) );
ynorm_5  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(5 ))) );
ynorm_6  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(6 ))) );
ynorm_7  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(7 ))) );
ynorm_8  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(8 ))) );
ynorm_9  =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(9 ))) );
ynorm_10 =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(10))) );
ynorm_11 =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(11))) );
ynorm_12 =  ynorm_RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(12))) );

Y_1  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(1 ))) );
Y_2  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(2 ))) );
Y_3  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(3 ))) );
Y_4  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(4 ))) );
Y_5  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(5 ))) );
Y_6  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(6 ))) );
Y_7  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(7 ))) );
Y_8  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(8 ))) );
Y_9  =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(9 ))) );
Y_10 =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(10))) );
Y_11 =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(11))) );
Y_12 =  RUL( idxTestAll(find(idxTestAll_batIndex == idxTestSort(12))) );
	

len_1  =  length(xnorm_1 ) - mod(length(xnorm_1 ),5) ; 
len_2  =  length(xnorm_2 ) - mod(length(xnorm_2 ),5) ; 
len_3  =  length(xnorm_3 ) - mod(length(xnorm_3 ),5) ; 
len_4  =  length(xnorm_4 ) - mod(length(xnorm_4 ),5) ; 
len_5  =  length(xnorm_5 ) - mod(length(xnorm_5 ),5) ; 
len_6  =  length(xnorm_6 ) - mod(length(xnorm_6 ),5) ; 
len_7  =  length(xnorm_7 ) - mod(length(xnorm_7 ),5) ; 
len_8  =  length(xnorm_8 ) - mod(length(xnorm_8 ),5) ; 
len_9  =  length(xnorm_9 ) - mod(length(xnorm_9 ),5) ; 
len_10 =  length(xnorm_10) - mod(length(xnorm_10),5) ; 
len_11 =  length(xnorm_11) - mod(length(xnorm_11),5) ; 
len_12 =  length(xnorm_12) - mod(length(xnorm_12),5) ; 


xnorm_1  =  xnorm_1 (1:len_1  ,:);
xnorm_2  =  xnorm_2 (1:len_2  ,:);
xnorm_3  =  xnorm_3 (1:len_3  ,:);
xnorm_4  =  xnorm_4 (1:len_4  ,:);
xnorm_5  =  xnorm_5 (1:len_5  ,:);
xnorm_6  =  xnorm_6 (1:len_6  ,:);
xnorm_7  =  xnorm_7 (1:len_7  ,:);
xnorm_8  =  xnorm_8 (1:len_8  ,:);
xnorm_9  =  xnorm_9 (1:len_9  ,:);
xnorm_10 =  xnorm_10(1:len_10 ,:);
xnorm_11 =  xnorm_11(1:len_11 ,:);
xnorm_12 =  xnorm_12(1:len_12 ,:);

ynorm_1  =  ynorm_1 (1:len_1  ,:);
ynorm_2  =  ynorm_2 (1:len_2  ,:);
ynorm_3  =  ynorm_3 (1:len_3  ,:);
ynorm_4  =  ynorm_4 (1:len_4  ,:);
ynorm_5  =  ynorm_5 (1:len_5  ,:);
ynorm_6  =  ynorm_6 (1:len_6  ,:);
ynorm_7  =  ynorm_7 (1:len_7  ,:);
ynorm_8  =  ynorm_8 (1:len_8  ,:);
ynorm_9  =  ynorm_9 (1:len_9  ,:);
ynorm_10 =  ynorm_10(1:len_10 ,:);
ynorm_11 =  ynorm_11(1:len_11 ,:);
ynorm_12 =  ynorm_12(1:len_12 ,:);

Y_1  =  Y_1 (1:len_1  ,:);
Y_2  =  Y_2 (1:len_2  ,:);
Y_3  =  Y_3 (1:len_3  ,:);
Y_4  =  Y_4 (1:len_4  ,:);
Y_5  =  Y_5 (1:len_5  ,:);
Y_6  =  Y_6 (1:len_6  ,:);
Y_7  =  Y_7 (1:len_7  ,:);
Y_8  =  Y_8 (1:len_8  ,:);
Y_9  =  Y_9 (1:len_9  ,:);
Y_10 =  Y_10(1:len_10 ,:);
Y_11 =  Y_11(1:len_11 ,:);
Y_12 =  Y_12(1:len_12 ,:);
%%


figure
hold on 
plot(Y_soh_ref)
plot(Y_soh_ref_to_small,'--')
plot(Y_soh_ref_to_big,':')
hold off
title 'Refernce, Patten Change - decrease RUL, Patten Change - increase RUL'
ylabel('SOH (Ah)')
xlabel('cycle')
legend_str = cell(3,1);
legend_str{1} = 'Refernce';
legend_str{2} = 'Patten Change - decrease RUL';
legend_str{3} = 'Patten Change - increase RUL';
legend(legend_str)
%%
figure
hold on 
plot(Y_soh_ref)
ylabel('SOH (Ah)')
yyaxis right
ylabel('RUL')
plot(Y_ref)
hold off
xlabel('Cycle')
title('Refernce - No Pattern Change')
legend_str = cell(2,1);
legend_str{1} = 'Capacity';
legend_str{2} = 'RUL';
legend(legend_str)
%%
figure
hold on 
plot(Y_soh_ref_to_small)
ylabel('SOH (Ah)')
yyaxis right
ylabel('RUL')
plot(Y_ref_to_small)
hold off
xlabel('Cycle')
title('Patten Change - decrease RUL')
legend_str = cell(2,1);
legend_str{1} = 'Capacity';
legend_str{2} = 'RUL';
legend(legend_str)


%%
figure
hold on 
plot(Y_soh_ref_to_big)
ylabel('SOH (Ah)')
yyaxis right
ylabel('RUL')
plot(Y_ref_to_big)
hold off
xlabel('Cycle')
title('Patten Change - increase RUL')
legend_str = cell(2,1);
legend_str{1} = 'Capacity';
legend_str{2} = 'RUL';
legend(legend_str)
%%

scenario3_mdl = fitrlinear(x_trainValid_Vd,y_trainValid_RUL,"learner","leastsquares")
%%
%gen_header = false
if gen_header == true

ryan5_util_gen_header(xnorm_ref            ,ynorm_ref           ,Y_ref                     ,22 ) ; 
ryan5_util_gen_header(xnorm_small          ,ynorm_small         ,Y_small                   ,11 ) ; 
ryan5_util_gen_header(xnorm_big            ,ynorm_big           ,Y_big                     ,33 ) ; 
ryan5_util_gen_header(xnorm_ref_to_small   ,ynorm_ref_to_small  ,Y_ref_to_small            ,21 ) ; 
ryan5_util_gen_header(xnorm_ref_to_big     ,ynorm_ref_to_big    ,Y_ref_to_big              ,23 ) ; 
% ryan5_util_gen_header(xnorm_ref_to_small2   ,ynorm_ref_to_small2  ,Y_ref_to_small2         ,211 ) ; 
% ryan5_util_gen_header(xnorm_ref_to_big2     ,ynorm_ref_to_big2    ,Y_ref_to_big2           ,233 ) ; 


ryan5_util_gen_header(xnorm_1   ,ynorm_1   ,Y_1  ,1  )
ryan5_util_gen_header(xnorm_2   ,ynorm_2   ,Y_2  ,2  )
ryan5_util_gen_header(xnorm_3   ,ynorm_3   ,Y_3  ,3  )
ryan5_util_gen_header(xnorm_4   ,ynorm_4   ,Y_4  ,4  )
ryan5_util_gen_header(xnorm_5   ,ynorm_5   ,Y_5  ,5  )
ryan5_util_gen_header(xnorm_6   ,ynorm_6   ,Y_6  ,6  )
ryan5_util_gen_header(xnorm_7   ,ynorm_7   ,Y_7  ,7  )
ryan5_util_gen_header(xnorm_8   ,ynorm_8   ,Y_8  ,8  )
ryan5_util_gen_header(xnorm_9   ,ynorm_9   ,Y_9  ,9  )
ryan5_util_gen_header(xnorm_10  ,ynorm_10  ,Y_10 ,10 )
ryan5_util_gen_header(xnorm_11  ,ynorm_11  ,Y_11 ,11 )
ryan5_util_gen_header(xnorm_12  ,ynorm_12  ,Y_12 ,12 )

end
%%
if save_data == true
save('ryan5_data_for_test.mat','scenario3_mdl',  '-append');

save('ryan5_data_for_test.mat','testdata_base_batNum','-append');
save('ryan5_data_for_test.mat','testdata_shortRul_batNum','-append');
save('ryan5_data_for_test.mat','testdata_longRul_batNum','-append');
save('ryan5_data_for_test.mat','testdata1_batNum_str','-append');
save('ryan5_data_for_test.mat','testdata2_batNum_str','-append');
save('ryan5_data_for_test.mat','testdata3_batNum_str','-append');

save('ryan5_data_for_test.mat','line_1', '-append' );
save('ryan5_data_for_test.mat','line_2', '-append' );
save('ryan5_data_for_test.mat','line_3', '-append' );
save('ryan5_data_for_test.mat','nth_fit', '-append' );


save('ryan5_data_for_test.mat','ryan5_change_bs_Rul',  '-append');
save('ryan5_data_for_test.mat','ryan5_change_bl_Rul',  '-append');
save('ryan5_data_for_test.mat','ryan5_change_ss_Rul',  '-append');
save('ryan5_data_for_test.mat','ryan5_change_bb_Rul',  '-append');
save('ryan5_data_for_test.mat','ryan5_change_ll_Rul',  '-append');


save('ryan5_data_for_test.mat','testdata2_change_idx',  '-append');
save('ryan5_data_for_test.mat','testdata1_change_idx',  '-append');
save('ryan5_data_for_test.mat','testdata3_change_idx',  '-append');

%save('ryan5_data_for_test.mat','testdata2_base_SOH',  '-append');
%save('ryan5_data_for_test.mat','testdata2_bestMatch_SOH',  '-append');
%save('ryan5_data_for_test.mat','testdata2_2ndMatch_SOH',  '-append');

%save('ryan5_data_for_test.mat','testdata2_base_RUL',  '-append');
%save('ryan5_data_for_test.mat','testdata2_bestMatch_RUL',  '-append');
%save('ryan5_data_for_test.mat','testdata2_2ndMatch_RUL',  '-append');


save('ryan5_data_for_test.mat','ynorm_1',  '-append');
save('ryan5_data_for_test.mat','ynorm_2',  '-append');
save('ryan5_data_for_test.mat','ynorm_3',  '-append');
save('ryan5_data_for_test.mat','ynorm_4',  '-append');
save('ryan5_data_for_test.mat','ynorm_5',  '-append');
save('ryan5_data_for_test.mat','ynorm_6',  '-append');
save('ryan5_data_for_test.mat','ynorm_7',  '-append');
save('ryan5_data_for_test.mat','ynorm_8',  '-append');
save('ryan5_data_for_test.mat','ynorm_9',  '-append');
save('ryan5_data_for_test.mat','ynorm_10',  '-append');
save('ryan5_data_for_test.mat','ynorm_11',  '-append');
save('ryan5_data_for_test.mat','ynorm_12',  '-append');

save('ryan5_data_for_test.mat','xnorm_1',  '-append');
save('ryan5_data_for_test.mat','xnorm_2',  '-append');
save('ryan5_data_for_test.mat','xnorm_3',  '-append');
save('ryan5_data_for_test.mat','xnorm_4',  '-append');
save('ryan5_data_for_test.mat','xnorm_5',  '-append');
save('ryan5_data_for_test.mat','xnorm_6',  '-append');
save('ryan5_data_for_test.mat','xnorm_7',  '-append');
save('ryan5_data_for_test.mat','xnorm_8',  '-append');
save('ryan5_data_for_test.mat','xnorm_9',  '-append');
save('ryan5_data_for_test.mat','xnorm_10', '-append');
save('ryan5_data_for_test.mat','xnorm_11', '-append');
save('ryan5_data_for_test.mat','xnorm_12', '-append');

save('ryan5_data_for_test.mat','Y_1',  '-append');
save('ryan5_data_for_test.mat','Y_2',  '-append');
save('ryan5_data_for_test.mat','Y_3',  '-append');
save('ryan5_data_for_test.mat','Y_4',  '-append');
save('ryan5_data_for_test.mat','Y_5',  '-append');
save('ryan5_data_for_test.mat','Y_6',  '-append');
save('ryan5_data_for_test.mat','Y_7',  '-append');
save('ryan5_data_for_test.mat','Y_8',  '-append');
save('ryan5_data_for_test.mat','Y_9',  '-append');
save('ryan5_data_for_test.mat','Y_10', '-append');
save('ryan5_data_for_test.mat','Y_11', '-append');
save('ryan5_data_for_test.mat','Y_12', '-append');

save('ryan5_data_for_test.mat','xnorm_ref','-append');
save('ryan5_data_for_test.mat','xnorm_small','-append');
save('ryan5_data_for_test.mat','xnorm_big','-append');
save('ryan5_data_for_test.mat','xnorm_ref_to_small','-append');
save('ryan5_data_for_test.mat','xnorm_ref_to_big','-append');

save('ryan5_data_for_test.mat','ynorm_ref','-append');
save('ryan5_data_for_test.mat','ynorm_small','-append');
save('ryan5_data_for_test.mat','ynorm_big','-append');
save('ryan5_data_for_test.mat','ynorm_ref_to_small','-append');
save('ryan5_data_for_test.mat','ynorm_ref_to_big','-append');

save('ryan5_data_for_test.mat','Y_ref','-append');
save('ryan5_data_for_test.mat','Y_small','-append');
save('ryan5_data_for_test.mat','Y_big','-append');
save('ryan5_data_for_test.mat','Y_ref_to_small','-append');
save('ryan5_data_for_test.mat','Y_ref_to_big','-append');

save('ryan5_data_for_test.mat','Y_soh_ref','-append');
save('ryan5_data_for_test.mat','Y_soh_small','-append');
save('ryan5_data_for_test.mat','Y_soh_big','-append');

save('ryan5_data_for_test.mat','ynorm_soh_ref_to_small','-append');
save('ryan5_data_for_test.mat','ynorm_soh_ref_to_big','-append');
save('ryan5_data_for_test.mat','Y_soh_ref_to_small','-append');
save('ryan5_data_for_test.mat','Y_soh_ref_to_big','-append');

save('ryan5_data_for_test.mat','testdata1_base_rul_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata1_best_rul_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata1_poor_rul_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_base_rul_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_best_rul_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_poor_rul_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_base_rul_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_best_rul_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_poor_rul_norm',  '-append'); 

save('ryan5_data_for_test.mat','testdata1_base_Vd_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata1_best_Vd_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata1_poor_Vd_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_base_Vd_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_best_Vd_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_poor_Vd_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_base_Vd_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_best_Vd_norm',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_poor_Vd_norm',  '-append'); 

save('ryan5_data_for_test.mat','testdata1_base_soh',  '-append'); 
save('ryan5_data_for_test.mat','testdata1_best_soh',  '-append'); 
save('ryan5_data_for_test.mat','testdata1_poor_soh',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_base_soh',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_best_soh',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_poor_soh',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_base_soh',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_best_soh',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_poor_soh',  '-append'); 

save('ryan5_data_for_test.mat','testdata1_base_rul',  '-append'); 
save('ryan5_data_for_test.mat','testdata1_best_rul',  '-append'); 
save('ryan5_data_for_test.mat','testdata1_poor_rul',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_base_rul',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_best_rul',  '-append'); 
save('ryan5_data_for_test.mat','testdata2_poor_rul',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_base_rul',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_best_rul',  '-append'); 
save('ryan5_data_for_test.mat','testdata3_poor_rul',  '-append'); 

save('ryan5_data_for_test.mat','testdata1_best_rul', '-append' );
save('ryan5_data_for_test.mat','testdata1_poor_rul', '-append' );
save('ryan5_data_for_test.mat','testdata2_best_rul', '-append' );
save('ryan5_data_for_test.mat','testdata2_poor_rul', '-append' );
save('ryan5_data_for_test.mat','testdata3_best_rul', '-append' );
save('ryan5_data_for_test.mat','testdata3_poor_rul', '-append' );
save('ryan5_data_for_test.mat','testdata1_best_soh', '-append' );
save('ryan5_data_for_test.mat','testdata1_poor_soh', '-append' );
save('ryan5_data_for_test.mat','testdata2_best_soh', '-append' );
save('ryan5_data_for_test.mat','testdata2_poor_soh', '-append' );
save('ryan5_data_for_test.mat','testdata3_best_soh', '-append' );
save('ryan5_data_for_test.mat','testdata3_poor_soh', '-append' );

save('ryan5_data_for_test.mat','testdata1_worse_soh', '-append' );
save('ryan5_data_for_test.mat','testdata2_worse_soh', '-append' );
save('ryan5_data_for_test.mat','testdata3_worse_soh', '-append' );

save('ryan5_data_for_test.mat','testdata1_worse_rul', '-append' );
save('ryan5_data_for_test.mat','testdata2_worse_rul', '-append' );
save('ryan5_data_for_test.mat','testdata3_worse_rul', '-append' );

end
%%

%%