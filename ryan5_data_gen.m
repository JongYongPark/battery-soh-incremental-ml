load_data = true 
% save_data_from_scratch = true 
save_data_from_scratch = false
if load_data
    load ryan5_battery_dataset.mat
end
%%
length(ryan5_battery_dataset)
size(ryan5_battery_dataset)
[ryan5_battery_dataset.key]
{[ryan5_battery_dataset.key]}
contains([ryan5_battery_dataset.key],'b1','IgnoreCase',true)
contains([ryan5_battery_dataset.key],'b2','IgnoreCase',true)
contains([ryan5_battery_dataset.key],'b3','IgnoreCase',true)
idx1 = find(contains([ryan5_battery_dataset.key],'b1','IgnoreCase',true))
idx2 = find(contains([ryan5_battery_dataset.key],'b2','IgnoreCase',true))
idx3 = find(contains([ryan5_battery_dataset.key],'b3','IgnoreCase',true))
idx12 = [idx1 idx2]
idx13 = [idx1 idx3]
idx23 = [idx2 idx3]
idxAll = (1:length(ryan5_battery_dataset))
idx123 = [idx1 idx2 idx3]

key1 = [ryan5_battery_dataset(idx1).key]';
key2 = [ryan5_battery_dataset(idx2).key]';
key3 = [ryan5_battery_dataset(idx3).key]';
cycle_life = [ryan5_battery_dataset(idxAll).cycle_life]';
bat_index = [1:length(idxAll)]';
index_cyclelife = [ bat_index, cycle_life];
% https://kr.mathworks.com/help/matlab/ref/double.sortrows.html#bt8bz9j-3
index_cyclelife_table = table(bat_index,cycle_life)
[index_cyclelife_table_sort,index] = sortrows(index_cyclelife_table,{'cycle_life'},{'ascend'})

%%%%%%%%%%%%%%%%
total_index = length(idxAll)
	
index_cyclelife_table_sort.Variables
index_cyclelife_table_sort.Properties
[~, maxrow] = max(index_cyclelife_table_sort.bat_index)
%maxrowname = index_cyclelife_table_sort.Properties.RowNames(1:maxrow-1)
%index_cyclelife_table_sort.Properties.RowNames

index_vec = [1:total_index]
idxVal_ = index_vec(5:10:end)
idxTest_ = index_vec(6:10:end)
idxTrain_ = setdiff(index_vec,idxVal_);
idxTrain_ = setdiff(idxTrain_,idxTest_)
idxTestTable = index_cyclelife_table_sort(idxTest_,{'bat_index'})
idxTrainTable = index_cyclelife_table_sort(idxTrain_,{'bat_index'})
idxValTable = index_cyclelife_table_sort(idxVal_,{'bat_index'})
idxTest = idxTestTable.Variables'
idxValid = idxValTable.Variables'
idxTrain = idxTrainTable.Variables'
idxAll
idxTrainSort = sort(idxTrain)
idxValidSort = sort(idxValid)
idxTestSort = sort(idxTest)

%https://kr.mathworks.com/matlabcentral/answers/101996-how-can-i-sort-a-vector-in-a-random-manner-in-matlab

idxTestRand =  idxTest(randperm(length(idxTest)))
idxTrainRand =  idxTrain(randperm(length(idxTrain)))
idxValidRand =  idxValid(randperm(length(idxValid)))

%sortrows(idxValTable,{'cycle_life'},{'ascend'})
input_size = 100;
%%
ryan5_gen_data_desc = 'ryan5_data_feature';
if save_data_from_scratch
save('ryan5_data.mat','ryan5_gen_data_desc');
end 

% ryan5_battery_dataset_raw 는 지워도 된다.
%save('ryan5_data.mat','ryan5_battery_dataset_raw' ,'-append')
%save('ryan5_data.mat','data_conversion_param' ,'-append')
save('ryan5_data.mat','idx1' ,'-append')
save('ryan5_data.mat','idx2' ,'-append')
save('ryan5_data.mat','idx3' ,'-append')
save('ryan5_data.mat','idx12' ,'-append')
save('ryan5_data.mat','idx23' ,'-append')
save('ryan5_data.mat','idx13' ,'-append')
save('ryan5_data.mat','idxAll' ,'-append')
save('ryan5_data.mat','idx123' ,'-append')
save('ryan5_data.mat','key1' ,'-append')
save('ryan5_data.mat','key2' ,'-append')
save('ryan5_data.mat','key3' ,'-append')
save('ryan5_data.mat','input_size' ,'-append')

save('ryan5_data.mat','idxTrain' ,'-append')
save('ryan5_data.mat','idxValid' ,'-append')
save('ryan5_data.mat','idxTest' ,'-append')
save('ryan5_data.mat','idxTrainRand' ,'-append')
save('ryan5_data.mat','idxValidRand' ,'-append')
save('ryan5_data.mat','idxTestRand' ,'-append')
save('ryan5_data.mat','idxTrainSort' ,'-append')
save('ryan5_data.mat','idxValidSort' ,'-append')
save('ryan5_data.mat','idxTestSort' ,'-append')
%%
cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;
%%
a = ryan5_battery_dataset(idxTest(1)).QDischargeSmooth;
b = ryan5_battery_dataset(idxTest(end)).QDischargeSmooth;
a1 = ryan5_battery_dataset(idxTest(2)).QDischargeSmooth;
b1 = ryan5_battery_dataset(idxTest(end-1)).QDischargeSmooth;

%https://kr.mathworks.com/matlabcentral/answers/146685-find-index-where-value-exceeds-threshold
[idxFirst] = find(a >= 1,1,'last')
[idxLast] = find(b >= 1,1,'last' )
idxLast = idxLast + 1
a(idxFirst-1)
a(idxFirst)
a(idxFirst+1)

b(idxLast-1)
b(idxLast)
b(idxLast+1)
[idxFirst] = find(a1 >= 1,1,'last')
[idxLast] = find(b1 >= 1,1,'last' )
idxLast = idxLast + 1
a1(idxFirst-1)
a1(idxFirst)
a1(idxFirst+1)

b1(idxLast-1)
b1(idxLast)
b1(idxLast+1)



%%
idxTestCount = length(idxTest)

nLines = length(idxTest);
legend_str = cell(nLines,1);

figure
hold on 
for j = 1 : idxTestCount
    i = idxTest(j);
    plot(ryan5_battery_dataset(i).cycle,ryan5_battery_dataset(i).QDischargeSmooth)
    cycle_life_list(j,:) = [j i ryan5_battery_dataset(i).cycle_life];
    legend_str{j} = num2str(i);
end
hold off
title 'Test Y dataset'
legend(legend_str)
cycle_life_list
%%
battery_testset_org = zeros();
battery_testset_org = ryan5_battery_dataset(idxTest(1));
idxTestCount = length(idxTest)
idxTestStopCount = idxTestCount / 2 
idxTestReverse = idxTestCount
k = 1;
kk = idxTestCount;
for j = 1 : idxTestStopCount
    pre = idxTest(j);
    post = idxTest(idxTestReverse);
    idxTestReverse = idxTestReverse - 1;
    battery_testset_org(k,:) = ryan5_battery_dataset(pre);
    k=k+1;
    battery_testset_org(k,:) = ryan5_battery_dataset(post);
    k=k+1;
end

cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;

nLines = size(battery_testset_org,1);
legend_str = cell(nLines,1);
figure
hold on 
for i = 1 : nLines
    %plot(battery_testset(i).cycle,battery_testset(i).QDischargeSmooth)
    plot(battery_testset_org(i).QDischargeSmooth)
    cycle_life_list(i,:) = [i i battery_testset_org(i).cycle_life];
    legend_str{i} = num2str(i);
end

hold off
title 'Test Y dataset'
legend(legend_str)
cycle_life_list_org = cycle_life_list
%%
battery_testset = zeros();
battery_testset = ryan5_battery_dataset(idxTest(1));

battery_testset_before = [ ... 
    1, ...
    ryan5_battery_dataset(1).cycle_life , ...
    ryan5_battery_dataset(1).policy , ...
    ryan5_battery_dataset(1).policy_readable , ...
    ryan5_battery_dataset(1).key  ...
    ];

battery_testset_after = [ ... 
    1, ...
    ryan5_battery_dataset(1).cycle_life , ...
    ryan5_battery_dataset(1).policy , ...
    ryan5_battery_dataset(1).policy_readable , ...
    ryan5_battery_dataset(1).key  ...
    ];


%bat_pre = ryan5_battery_dataset(idxTest(1))
%bat_post = ryan5_battery_dataset(idxTest(12))
%battery_testset = bat_pre

idxTestCount = length(idxTest)
idxTestStopCount = idxTestCount / 2 
idxTestReverse = idxTestCount
k = 1;
kk = idxTestCount;
for j = 1 : idxTestStopCount
    pre = idxTest(j);
    post = idxTest(idxTestReverse);
    idxTestReverse = idxTestReverse - 1;
    
    %ryan5_battery_dataset(pre).QDischargeSmooth
    %cycle_life_list(j,:) = [j pre ryan5_battery_dataset(pre).cycle_life];
    %legend_str{j} = num2str(pre);
    
    [idxPre] = find(ryan5_battery_dataset(pre).QDischargeSmooth >= 1,1,'last');
    [idxPost] = find(ryan5_battery_dataset(post).QDischargeSmooth >= 1,1,'last' );
    idxPost = idxPost + 1;
    idxPreAfter = idxPre + 1;
    idxPreBefore = idxPre ;
    idxPostBefore = idxPost -1;
    idxPostAfter = idxPost ;
    
    battery_testset_before(k,:) = [ ... 
    pre, ...
    ryan5_battery_dataset(pre).cycle_life , ...
    ryan5_battery_dataset(pre).policy , ...
    ryan5_battery_dataset(pre).policy_readable , ...
    ryan5_battery_dataset(pre).key  ...
    ];

    battery_testset_after(k,:) = [ ... 
    post, ...
    ryan5_battery_dataset(post).cycle_life , ...
    ryan5_battery_dataset(post).policy , ...
    ryan5_battery_dataset(post).policy_readable , ...
    ryan5_battery_dataset(post).key  ...
    ];

    battery_testset_before(k+1,:) = [ ... 
    post, ...
    ryan5_battery_dataset(post).cycle_life , ...
    ryan5_battery_dataset(post).policy , ...
    ryan5_battery_dataset(post).policy_readable , ...
    ryan5_battery_dataset(post).key  ...
    ];

    battery_testset_after(k+1,:) = [ ... 
    pre, ...
    ryan5_battery_dataset(pre).cycle_life , ...
    ryan5_battery_dataset(pre).policy , ...
    ryan5_battery_dataset(pre).policy_readable , ...
    ryan5_battery_dataset(pre).key  ...
    ];


    battery_testset(k,:) = ryan5_battery_dataset(pre);
    
    battery_testset(k).IR([idxPreAfter:end],:) = [] ;
    battery_testset(k).QCharge([idxPreAfter:end],:) = [] ;
    battery_testset(k).QDischarge([idxPreAfter:end],:) = [] ;
    battery_testset(k).SOH_c([idxPreAfter:end],:) = [] ;
    battery_testset(k).SOH_d([idxPreAfter:end],:) = [] ;
    battery_testset(k).RUL([idxPreAfter:end],:) = [] ;
    battery_testset(k).Time_c([idxPreAfter:end],:) = [] ;
    battery_testset(k).Time_d([idxPreAfter:end],:) = [] ;
    battery_testset(k).Time_d1([idxPreAfter:end],:) = [] ;    
    battery_testset(k).Tavg([idxPreAfter:end],:) = [] ;
    battery_testset(k).Tmin([idxPreAfter:end],:) = [] ;
    battery_testset(k).Tmax([idxPreAfter:end],:) = [] ;

    battery_testset(k).Vc([idxPreAfter:end],:) = [] ;
    battery_testset(k).Vd([idxPreAfter:end],:) = [] ;
    battery_testset(k).Tc([idxPreAfter:end],:) = [] ;
    battery_testset(k).Td([idxPreAfter:end],:) = [] ;
    battery_testset(k).Ic([idxPreAfter:end],:) = [] ;
    battery_testset(k).Id([idxPreAfter:end],:) = [] ;
    
    battery_testset(k).discharge_dQdV([idxPreAfter:end],:) = [] ;
    battery_testset(k).Qdlin([idxPreAfter:end],:) = [] ;
    battery_testset(k).Tdlin([idxPreAfter:end],:) = [] ;
    
    battery_testset(k).chargetime([idxPreAfter:end],:) = [] ;
    battery_testset(k).QDischargeSmooth([idxPreAfter:end],:) = [] ;
    
    battery_testset(k).IR = vertcat(battery_testset(k).IR,ryan5_battery_dataset(post).IR([idxPost:end],:)) ;
    battery_testset(k).QCharge = vertcat(battery_testset(k).QCharge,ryan5_battery_dataset(post).QCharge([idxPost:end],:)) ;
    battery_testset(k).QDischarge = vertcat(battery_testset(k).QDischarge,ryan5_battery_dataset(post).QDischarge([idxPost:end],:)) ;
    battery_testset(k).SOH_c = vertcat(battery_testset(k).SOH_c,ryan5_battery_dataset(post).SOH_c([idxPost:end],:)) ;
    battery_testset(k).SOH_d = vertcat(battery_testset(k).SOH_d,ryan5_battery_dataset(post).SOH_d([idxPost:end],:)) ;
    battery_testset(k).RUL = vertcat(battery_testset(k).RUL,ryan5_battery_dataset(post).RUL([idxPost:end],:)) ;
    battery_testset(k).Time_c = vertcat(battery_testset(k).Time_c,ryan5_battery_dataset(post).Time_c([idxPost:end],:)) ;
    battery_testset(k).Time_d = vertcat(battery_testset(k).Time_d,ryan5_battery_dataset(post).Time_d([idxPost:end],:)) ;
    battery_testset(k).Time_d1 = vertcat(battery_testset(k).Time_d1,ryan5_battery_dataset(post).Time_d1([idxPost:end],:)) ;
    battery_testset(k).Tavg = vertcat(battery_testset(k).Tavg,ryan5_battery_dataset(post).Tavg([idxPost:end],:)) ;
    battery_testset(k).Tmin = vertcat(battery_testset(k).Tmin,ryan5_battery_dataset(post).Tmin([idxPost:end],:)) ;
    battery_testset(k).Tmax = vertcat(battery_testset(k).Tmax,ryan5_battery_dataset(post).Tmax([idxPost:end],:)) ;
    battery_testset(k).Vc = vertcat(battery_testset(k).Vc,ryan5_battery_dataset(post).Vc([idxPost:end],:)) ;
    battery_testset(k).Vd = vertcat(battery_testset(k).Vd,ryan5_battery_dataset(post).Vd([idxPost:end],:)) ;
    battery_testset(k).Tc = vertcat(battery_testset(k).Tc,ryan5_battery_dataset(post).Tc([idxPost:end],:)) ;
    battery_testset(k).Td = vertcat(battery_testset(k).Td,ryan5_battery_dataset(post).Td([idxPost:end],:)) ;
    battery_testset(k).Ic = vertcat(battery_testset(k).Ic,ryan5_battery_dataset(post).Ic([idxPost:end],:)) ;
    battery_testset(k).Id = vertcat(battery_testset(k).Id,ryan5_battery_dataset(post).Id([idxPost:end],:)) ;
    
    battery_testset(k).discharge_dQdV = vertcat(battery_testset(k).discharge_dQdV,ryan5_battery_dataset(post).discharge_dQdV([idxPost:end],:)) ;
    battery_testset(k).Qdlin = vertcat(battery_testset(k).Qdlin,ryan5_battery_dataset(post).Qdlin([idxPost:end],:)) ;
    battery_testset(k).Tdlin = vertcat(battery_testset(k).Tdlin,ryan5_battery_dataset(post).Tdlin([idxPost:end],:)) ;
    
    battery_testset(k).chargetime = vertcat(battery_testset(k).chargetime,ryan5_battery_dataset(post).chargetime([idxPost:end],:)) ;
    battery_testset(k).QDischargeSmooth = vertcat(battery_testset(k).QDischargeSmooth,ryan5_battery_dataset(post).QDischargeSmooth([idxPost:end],:)) ;
    
    battery_testset(k).cycle_life = idxPre +  (ryan5_battery_dataset(post).cycle_life - idxPost  ) + 1 ;
    battery_testset(k).cycle = [];
    battery_testset(k).cycle = linspace(1,battery_testset(k).cycle_life,battery_testset(k).cycle_life) ;

    battery_testset(k).QDischargePolyMdl = [];
%    battery_testset(k).QDischargePolyMdl = polyfit(battery_testset(k).cycle, battery_testset(k).QDischargeSmooth,4);
    battery_testset(k).QDischargePolyfit = [];
%    battery_testset(k).QDischargePolyfit = polyval(battery_testset.QDischargePolyMdl,battery_testset.cycle')';

%%%%%%%%%%%%%%%
    k = k+1;
    battery_testset(k,:) = ryan5_battery_dataset(post);
    
    battery_testset(k).IR([idxPostAfter:end],:) = [] ;
    battery_testset(k).QCharge([idxPostAfter:end],:) = [] ;
    battery_testset(k).QDischarge([idxPostAfter:end],:) = [] ;
    battery_testset(k).SOH_c([idxPostAfter:end],:) = [] ;
    battery_testset(k).SOH_d([idxPostAfter:end],:) = [] ;
    battery_testset(k).RUL([idxPostAfter:end],:) = [] ;
    battery_testset(k).Time_c([idxPostAfter:end],:) = [] ;
    battery_testset(k).Time_d([idxPostAfter:end],:) = [] ;
    battery_testset(k).Time_d1([idxPostAfter:end],:) = [] ;
    battery_testset(k).Tavg([idxPostAfter:end],:) = [] ;
    battery_testset(k).Tavg([idxPostAfter:end],:) = [] ;
    battery_testset(k).Tmin([idxPostAfter:end],:) = [] ;
    battery_testset(k).Tmax([idxPostAfter:end],:) = [] ;
    battery_testset(k).Vc([idxPostAfter:end],:) = [] ;
    battery_testset(k).Vd([idxPostAfter:end],:) = [] ;
    battery_testset(k).Tc([idxPostAfter:end],:) = [] ;
    battery_testset(k).Td([idxPostAfter:end],:) = [] ;
    battery_testset(k).Ic([idxPostAfter:end],:) = [] ;
    battery_testset(k).Id([idxPostAfter:end],:) = [] ;
    
    battery_testset(k).discharge_dQdV([idxPostAfter:end],:) = [] ;
    battery_testset(k).Qdlin([idxPostAfter:end],:) = [] ;
    battery_testset(k).Tdlin([idxPostAfter:end],:) = [] ;
    
    battery_testset(k).chargetime([idxPostAfter:end],:) = [] ;
    battery_testset(k).QDischargeSmooth([idxPostAfter:end],:) = [] ;
    
    battery_testset(k).IR = vertcat(battery_testset(k).IR,ryan5_battery_dataset(pre).IR([idxPreAfter:end],:)) ;
    battery_testset(k).QCharge = vertcat(battery_testset(k).QCharge,ryan5_battery_dataset(pre).QCharge([idxPreAfter:end],:)) ;
    battery_testset(k).QDischarge = vertcat(battery_testset(k).QDischarge,ryan5_battery_dataset(pre).QDischarge([idxPreAfter:end],:)) ;
    battery_testset(k).SOH_c = vertcat(battery_testset(k).SOH_c,ryan5_battery_dataset(pre).SOH_c([idxPreAfter:end],:)) ;
    battery_testset(k).SOH_d = vertcat(battery_testset(k).SOH_d,ryan5_battery_dataset(pre).SOH_d([idxPreAfter:end],:)) ;
    battery_testset(k).RUL = vertcat(battery_testset(k).RUL,ryan5_battery_dataset(pre).RUL([idxPreAfter:end],:)) ;
    battery_testset(k).Time_c = vertcat(battery_testset(k).Time_c,ryan5_battery_dataset(pre).Time_c([idxPreAfter:end],:)) ;
    battery_testset(k).Time_d = vertcat(battery_testset(k).Time_d,ryan5_battery_dataset(pre).Time_d([idxPreAfter:end],:)) ;
    battery_testset(k).Time_d1 = vertcat(battery_testset(k).Time_d1,ryan5_battery_dataset(pre).Time_d1([idxPreAfter:end],:)) ;
    battery_testset(k).Tavg = vertcat(battery_testset(k).Tavg,ryan5_battery_dataset(pre).Tavg([idxPreAfter:end],:)) ;
    battery_testset(k).Tmin = vertcat(battery_testset(k).Tmin,ryan5_battery_dataset(pre).Tmin([idxPreAfter:end],:)) ;
    battery_testset(k).Tmax = vertcat(battery_testset(k).Tmax,ryan5_battery_dataset(pre).Tmax([idxPreAfter:end],:)) ;
    battery_testset(k).Vc = vertcat(battery_testset(k).Vc,ryan5_battery_dataset(pre).Vc([idxPreAfter:end],:)) ;
    battery_testset(k).Vd = vertcat(battery_testset(k).Vd,ryan5_battery_dataset(pre).Vd([idxPreAfter:end],:)) ;
    battery_testset(k).Tc = vertcat(battery_testset(k).Tc,ryan5_battery_dataset(pre).Tc([idxPreAfter:end],:)) ;
    battery_testset(k).Td = vertcat(battery_testset(k).Td,ryan5_battery_dataset(pre).Td([idxPreAfter:end],:)) ;
    battery_testset(k).Ic = vertcat(battery_testset(k).Ic,ryan5_battery_dataset(pre).Ic([idxPreAfter:end],:)) ;
    battery_testset(k).Id = vertcat(battery_testset(k).Id,ryan5_battery_dataset(pre).Id([idxPreAfter:end],:)) ;
    
    battery_testset(k).discharge_dQdV = vertcat(battery_testset(k).discharge_dQdV,ryan5_battery_dataset(pre).discharge_dQdV([idxPreAfter:end],:)) ;
    battery_testset(k).Qdlin = vertcat(battery_testset(k).Qdlin,ryan5_battery_dataset(pre).Qdlin([idxPreAfter:end],:)) ;
    battery_testset(k).Tdlin = vertcat(battery_testset(k).Tdlin,ryan5_battery_dataset(pre).Tdlin([idxPreAfter:end],:)) ;   
     
    battery_testset(k).chargetime = vertcat(battery_testset(k).chargetime,ryan5_battery_dataset(pre).chargetime([idxPreAfter:end],:)) ;
    battery_testset(k).QDischargeSmooth = vertcat(battery_testset(k).QDischargeSmooth,ryan5_battery_dataset(pre).QDischargeSmooth([idxPreAfter:end],:)) ;
    
    battery_testset(k).cycle_life = idxPost +  (ryan5_battery_dataset(pre).cycle_life - idxPre  ) + 1 ;
    battery_testset(k).cycle = [];
    battery_testset(k).cycle = linspace(1,battery_testset(k).cycle_life,battery_testset(k).cycle_life) ;

    battery_testset(k).QDischargePolyMdl = [];
%    battery_testset(k).QDischargePolyMdl = polyfit(battery_testset(k).cycle, battery_testset(k).QDischargeSmooth,4);
    battery_testset(k).QDischargePolyfit = [];
%    battery_testset(k).QDischargePolyfit = polyval(battery_testset.QDischargePolyMdl,battery_testset.cycle')';
    k = k +1;
end
%battery_testset


%%

cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;

nLines = size(battery_testset,1);
legend_str = cell(nLines,1);
figure
hold on 
for i = 1 : nLines
    %plot(battery_testset(i).cycle,battery_testset(i).QDischargeSmooth)
    plot(battery_testset(i).QDischargeSmooth)
    cycle_life_list(i,:) = [i i battery_testset(i).cycle_life];
    legend_str{i} = num2str(i) + " : " + num2str(battery_testset_before(i,1))  + " -> " +  num2str(battery_testset_after(i,1)) ;
end

hold off
title 'Test Y dataset'
legend(legend_str)
cycle_life_list_change = cycle_life_list

%%
%{
cycle_life_list = zeros();
cycle_life_list =  [ 1 1 1 ] ;

nLines = length(idxTestSort);
legend_str = cell(nLines,1);
figure
hold on 
for j = 1 : length(idxTestSort)
    i = idxTestSort(j);
    plot(ryan5_battery_dataset(i).cycle,ryan5_battery_dataset(i).QDischargeSmooth)
    cycle_life_list(j,:) = [j i ryan5_battery_dataset(i).cycle_life];
    legend_str{j} = num2str(i);
end

hold off
title 'Test Y dataset'
legend(legend_str)
cycle_life_list
%}
%%
save('ryan5_battery_dataset.mat','battery_testset_before' ,'-append')
save('ryan5_battery_dataset.mat','battery_testset_after' ,'-append')
save('ryan5_battery_dataset.mat','battery_testset' ,'-append')
save('ryan5_battery_dataset.mat','battery_testset_org' ,'-append')
%%
%% load ryan5_gen_data.mat

%{
load('ryan5_battery_dataset.mat','ryan5_battery_dataset' )
load('ryan5_data.mat','idxAll' )

%}
%% 
% 첫번째 cycle의 충전전류를 얻는다.

idx = 1; % idxAll; 

ryan5_battery_dataset(idx).Ic
ryan5_battery_dataset(idx).Ic(1,:)
% 열벡터로 바꾼다.
Ic1 = ryan5_battery_dataset(idx).Ic(1,:)'
%%
% 전체 데이타에 대해서 
IcFirstFull = zeros()
IcFirstFull = ryan5_battery_dataset(1).Ic(1,:)

VdFirstFull = zeros()
VdFirstFull = ryan5_battery_dataset(1).Vd(1,:)

%IcFirstFull = ryan5_battery_dataset(2).Ic(1,:)
for i=1:length(ryan5_battery_dataset)
    IcFirstFull(i,:) = ryan5_battery_dataset(i).Ic(1,:);
    VdFirstFull(i,:) = ryan5_battery_dataset(i).Vd(1,:);
end
IcFirstFull
VdFirstFull
%IcFirstFull = IcFirstFull'
RulFirst = [ryan5_battery_dataset(idxAll).cycle_life ]'
blockSize = [1, 5] % 다섯개를 묶어서.
meanFilterFunction = @(theBlockStructure) mean2(theBlockStructure.data(:))
IcFirst = blockproc(IcFirstFull, blockSize, meanFilterFunction)
VdFirst = blockproc(VdFirstFull, blockSize, meanFilterFunction)
%RulFirst = cycleLife;
%clear cycleLife
%%
%{
load("ryan5_data.mat",'RulFirst')
load("ryan5_data.mat",'IcFirstFull')
load("ryan5_data.mat",'IcFirst')
load("ryan5_data.mat",'VdFirstFull')
load("ryan5_data.mat",'VdFirst')

load("ryan5_data.mat",'idxA;;')
load("ryan5_data.mat",'idxTrain')
load("ryan5_data.mat",'idxValid')
load("ryan5_data.mat",'idxTest')

%}

[ynorm_IcFirst_RUL,ymax_IcFirst_RUL,ymin_IcFirst_RUL,yrate_IcFirst_RUL,xnorm_IcFirstFull_RUL,xmax_IcFirst_RUL,xmin_IcFirst_RUL,xrate_IcFirst_RUL] = ...
minmax_norm_new(RulFirst,IcFirstFull);
[ynorm_IcFirst_RUL1,xnorm_IcFirst_RUL] = minmax_norm_new_with_param(RulFirst,IcFirst,ymin_IcFirst_RUL,yrate_IcFirst_RUL,xmin_IcFirst_RUL,xrate_IcFirst_RUL);
% https://stackoverflow.com/questions/40053450/compare-if-two-vectors-are-the-same
all(ynorm_IcFirst_RUL == ynorm_IcFirst_RUL1)
%%
[ynorm_VdFirst_RUL,ymax_VdFirst_RUL,ymin_VdFirst_RUL,yrate_VdFirst_RUL,xnorm_VdFirstFull_RUL,xmax_VdFirst_RUL,xmin_VdFirst_RUL,xrate_VdFirst_RUL] = ...
minmax_norm_new(RulFirst,VdFirstFull);
[ynorm_VdFirst_RUL1,xnorm_VdFirst_RUL] = minmax_norm_new_with_param(RulFirst,VdFirst,ymin_VdFirst_RUL,yrate_VdFirst_RUL,xmin_VdFirst_RUL,xrate_VdFirst_RUL);
% https://stackoverflow.com/questions/40053450/compare-if-two-vectors-are-the-same
all(ynorm_VdFirst_RUL == ynorm_VdFirst_RUL1)
%%

all(ynorm_IcFirst_RUL == ynorm_VdFirst_RUL)
all(ymax_IcFirst_RUL == ymax_VdFirst_RUL)
all(ymin_IcFirst_RUL == ymin_VdFirst_RUL)
all(yrate_IcFirst_RUL == yrate_VdFirst_RUL)

ynorm_First_RUL = ynorm_IcFirst_RUL
ymax_First_RUL = ymax_IcFirst_RUL
ymin_First_RUL = ymin_IcFirst_RUL
yrate_First_RUL = yrate_IcFirst_RUL
%%
x_trainValid_IcFirstFull_RUL = xnorm_IcFirstFull_RUL([idxTrain idxValid],:);
x_test_IcFirstFull_RUL = xnorm_IcFirstFull_RUL([idxTest],:);
x_trainValid_IcFirst_RUL = xnorm_IcFirst_RUL([idxTrain idxValid],:);
x_test_IcFirst_RUL = xnorm_IcFirst_RUL([idxTest],:);

y_trainValid_IcFirst_RUL = ynorm_IcFirst_RUL([idxTrain idxValid]);
y_test_IcFirst_RUL = ynorm_IcFirst_RUL([idxTest]);
Y_trainValid_IcFirst_RUL = RulFirst([idxTrain idxValid]);
Y_test_IcFirst_RUL = RulFirst([idxTest]);


x_trainValid_VdFirstFull_RUL = xnorm_VdFirstFull_RUL([idxTrain idxValid],:);
x_test_VdFirstFull_RUL = xnorm_VdFirstFull_RUL([idxTest],:);
x_trainValid_VdFirst_RUL = xnorm_VdFirst_RUL([idxTrain idxValid],:);
x_test_VdFirst_RUL = xnorm_VdFirst_RUL([idxTest],:);

y_trainValid_VdFirst_RUL = ynorm_VdFirst_RUL([idxTrain idxValid]);
y_test_VdFirst_RUL = ynorm_VdFirst_RUL([idxTest]);
Y_trainValid_VdFirst_RUL = RulFirst([idxTrain idxValid]);
Y_test_VdFirst_RUL = RulFirst([idxTest]);

all(y_trainValid_IcFirst_RUL == y_trainValid_VdFirst_RUL)
all(y_test_IcFirst_RUL == y_test_VdFirst_RUL)
all(Y_trainValid_IcFirst_RUL == Y_trainValid_VdFirst_RUL)
all(Y_test_IcFirst_RUL == Y_test_VdFirst_RUL)

y_trainValid_First_RUL = y_trainValid_IcFirst_RUL ;
y_test_First_RUL = y_test_IcFirst_RUL ;
Y_trainValid_First_RUL = Y_trainValid_IcFirst_RUL ;
Y_test_First_RUL = Y_test_IcFirst_RUL ;

%% 변수 추출

Cap = zeros();
Cap_c = zeros();
%SOH = zeros();
% = zeeros();
IcFull = zeros();
IdFull = zeros();
VcFull = zeros();
VdFull = zeros();
TcFull = zeros();
TdFull = zeros();

%VdFull = [1:100];
ryan5_battery_dataset(1).QDischargeSmooth
ryan5_battery_dataset(1).Vd
size(ryan5_battery_dataset(1).QDischargeSmooth)
length(ryan5_battery_dataset(1).QDischargeSmooth)

idxAll = (1:length(ryan5_battery_dataset));
idxTrainValid = [ idxTrain idxValid ];
idxTrainAll = []; %zeros();
idxValidAll = []; %zeros();
idxTestAll = []; %zeros();
idxAllAll = []; %zeros();
idxTrainAll_batIndex = []; %zeros();
idxValidAll_batIndex = []; %zeros();
idxTestAll_batIndex = []; %zeros();
idxAllAll_batIndex = []; %zeros();
%batIndex_temp = [];
j =1;
startIndx = j ;
GenerateFrameList = @(A,S,N) A+S*(0:N-1);

for i = 1: length(idxAll)
        
    cap_temp = ryan5_battery_dataset(i).QDischargeSmooth;
    cap_c_temp = ryan5_battery_dataset(i).QDischargeSmooth;

    %SOH_temp = max(cap_temp);
    RUL_temp = linspace(ryan5_battery_dataset(i).cycle_life,1,ryan5_battery_dataset(i).cycle_life)';
    leng = length(cap_temp);
    
    %startIndx = j ;
    % https://kr.mathworks.com/matlabcentral/answers/478553-how-can-i-have-a-starting-number-a-step-size-then-the-number-of-numbers-i-need-in-a-1d-array
    append_index = GenerateFrameList(startIndx,1,leng);
    
    Vd_temp = ryan5_battery_dataset(i).Vd ;
    Vc_temp = ryan5_battery_dataset(i).Vc ;
    Td_temp = ryan5_battery_dataset(i).Td ;
    Tc_temp = ryan5_battery_dataset(i).Tc ;
    Id_temp = ryan5_battery_dataset(i).Id ;
    Ic_temp = ryan5_battery_dataset(i).Ic ;
    batIndex_temp = [];
    batIndex_temp(1:leng, 1) = i;
    %VdFull = [VdFull ; Vd_temp];
    if  i == 1

        Cap = cap_temp; 
        Cap_c = cap_c_temp;
        RUL = RUL_temp;

        VdFull = Vd_temp ;
        VcFull = Vc_temp ;
        TdFull = Td_temp ;
        TcFull = Tc_temp ;
        IdFull = Id_temp ;
        IcFull = Ic_temp ;


    else
        Cap = vertcat(Cap,cap_temp);
        Cap_c = vertcat(Cap_c,cap_c_temp);
        RUL = vertcat(RUL,RUL_temp);

        VdFull = vertcat(VdFull , Vd_temp );
        VcFull = vertcat(VcFull , Vc_temp );
        TdFull = vertcat(TdFull , Td_temp );
        TcFull = vertcat(TcFull , Tc_temp );
        IdFull = vertcat(IdFull , Id_temp );
        IcFull = vertcat(IcFull , Ic_temp );
    end
       
    idxAllAll =  [idxAllAll append_index ] ;
    idxAllAll_batIndex = [idxAllAll_batIndex batIndex_temp'];

    if any(idxTrain(:) == i) 
       % https://kr.mathworks.com/matlabcentral/answers/283821-add-single-element-to-array-or-vector
       idxTrainAll =  [idxTrainAll append_index ] ;
       idxTrainAll_batIndex = [idxTrainAll_batIndex batIndex_temp'];
    end
    if any(idxValid(:) == i) 
       idxValidAll =  [idxValidAll append_index ] ;
       idxValidAll_batIndex = [idxValidAll_batIndex batIndex_temp'];
    end
    if any(idxTest(:) == i) 
       idxTestAll =  [idxTestAll append_index ] ;
       idxTestAll_batIndex = [idxTestAll_batIndex batIndex_temp'];
    end
    %VdFull(i) = Vd_temp;
    
    startIndx = startIndx + leng;
end
%%

idxTrainAll
idxTrainAll_batIndex
idxValidAll
idxValidAll_batIndex
idxTestAll
idxTestAll_batIndex

Cap
VdFull
IcFull
% https://kr.mathworks.com/matlabcentral/answers/80480-how-do-i-take-the-average-of-every-n-values-in-a-vector
blockSize = [1, 5] % 다섯개를 묶어서.
meanFilterFunction = @(theBlockStructure) mean2(theBlockStructure.data(:))

Ic = blockproc(IcFull, blockSize, meanFilterFunction)
%clear IcFull  

Vd = blockproc(VdFull, blockSize, meanFilterFunction)
%clear VdFull  
Vc = blockproc(VcFull, blockSize, meanFilterFunction);
Td = blockproc(TdFull, blockSize, meanFilterFunction);
Tc = blockproc(TcFull, blockSize, meanFilterFunction);
Id = blockproc(IdFull, blockSize, meanFilterFunction);

%%


%%

%ryan5_gen_data_raw_desc = "ryan5_gen_data_raw_desc";
%save('ryan5_data_raw.mat','ryan5_gen_data_raw_desc');
%save('ryan5_data_raw.mat','ryan5_battery_dataset','-append');

%%

% https://stackoverflow.com/questions/39149677/how-to-delete-a-variable-from-mat-file-in-matlab
%rmmatvar('ryan5_gen_data.mat', 'ryan5_battery_dataset');
%%
%clear ryan5_battery_dataset

%%
[ynorm_Ic_RUL,ymax_Ic_RUL,ymin_Ic_RUL,yrate_Ic_RUL,xnorm_Ic_RUL,xmax_Ic_RUL,xmin_Ic_RUL,xrate_Ic_RUL] = minmax_norm_new(RUL,Ic);
[ynorm_Vd_RUL,ymax_Vd_RUL,ymin_Vd_RUL,yrate_Vd_RUL,xnorm_Vd_RUL,xmax_Vd_RUL,xmin_Vd_RUL,xrate_Vd_RUL] = minmax_norm_new(RUL,Vd);

Y_trainValid_Ic_RUL = RUL([idxTrainAll idxValidAll],:);
Y_test_Ic_RUL = RUL([idxTestAll],:);
x_trainValid_Ic_RUL = xnorm_Ic_RUL([idxTrainAll idxValidAll],:)
x_test_Ic_RUL = xnorm_Ic_RUL([idxTestAll],:)
y_trainValid_Ic_RUL = ynorm_Ic_RUL([idxTrainAll idxValidAll])
y_test_Ic_RUL = ynorm_Ic_RUL([idxTestAll])
Y_trainValid_Vd_RUL = RUL([idxTrainAll idxValidAll],:);
Y_test_Vd_RUL = RUL([idxTestAll],:);
x_trainValid_Vd_RUL = xnorm_Vd_RUL([idxTrainAll idxValidAll],:)
x_test_Vd_RUL = xnorm_Vd_RUL([idxTestAll],:)
y_trainValid_Vd_RUL = ynorm_Vd_RUL([idxTrainAll idxValidAll])
y_test_Vd_RUL = ynorm_Vd_RUL([idxTestAll])


all(Y_trainValid_Ic_RUL == Y_trainValid_Vd_RUL)
all(Y_test_Ic_RUL == Y_test_Vd_RUL)
all(y_trainValid_Ic_RUL == y_trainValid_Vd_RUL)
all(y_test_Ic_RUL == y_test_Vd_RUL)

all(ynorm_Ic_RUL == ynorm_Vd_RUL)
ynorm_RUL = ynorm_Ic_RUL ;
ymax_RUL = ymax_Ic_RUL ;
ymin_RUL = ymin_Ic_RUL ;
yrate_RUL = yrate_Ic_RUL ;


Y_trainValid_RUL = Y_trainValid_Vd_RUL ;
Y_test_RUL = Y_test_Vd_RUL ;
y_trainValid_RUL = y_trainValid_Vd_RUL ;
y_test_RUL = y_test_Vd_RUL ;
%%
[ynorm_SOH,ymax_SOH,ymin_SOH,yrate_SOH,xnorm_Ic_SOH,xmax_Ic_SOH,xmin_Ic_SOH,xrate_Ic_SOH] = minmax_norm_new(Cap,Ic);
[ynorm_SOH,ymax_SOH,ymin_SOH,yrate_SOH,xnorm_Vd_SOH,xmax_Vd_SOH,xmin_Vd_SOH,xrate_Vd_SOH] = minmax_norm_new(Cap,Vd);
%%

Y_trainValid_SOH = Cap([idxTrainAll idxValidAll],:);
Y_test_SOH = Cap([idxTestAll],:);
y_trainValid_SOH = ynorm_SOH([idxTrainAll idxValidAll]);
y_test_SOH = ynorm_SOH([idxTestAll]);

x_trainValid_Ic_SOH = xnorm_Ic_SOH([idxTrainAll idxValidAll],:);
x_test_Ic_SOH = xnorm_Ic_SOH([idxTestAll],:);
x_trainValid_Vd_SOH = xnorm_Vd_SOH([idxTrainAll idxValidAll],:);
x_test_Vd_SOH = xnorm_Vd_SOH([idxTestAll],:);


%%
[xnorm_Tc,xmax_Tc,xmin_Tc,xrate_Tc] = minmax_norm_x(Tc);
x_trainValid_Tc = xnorm_Tc([idxTrainAll idxValidAll],:);
x_test_Tc = xnorm_Tc([idxTestAll],:);

[xnorm_Td,xmax_Td,xmin_Td,xrate_Td] = minmax_norm_x(Td);
x_trainValid_Td = xnorm_Td([idxTrainAll idxValidAll],:);
x_test_Td = xnorm_Td([idxTestAll],:);

[xnorm_Vc,xmax_Vc,xmin_Vc,xrate_Vc] = minmax_norm_x(Vc);
x_trainValid_Vc = xnorm_Vc([idxTrainAll idxValidAll],:);
x_test_Vc = xnorm_Vc([idxTestAll],:);

[xnorm_Id,xmax_Id,xmin_Id,xrate_Id] = minmax_norm_x(Id);
x_trainValid_Id = xnorm_Id([idxTrainAll idxValidAll],:);
x_test_Id = xnorm_Id([idxTestAll],:);

[ynorm_SOHc,ymax_SOHc,ymin_SOHc,yrate_SOHc] = minmax_norm_x(Cap_c);

Y_trainValid_SOHc = Cap_c([idxTrainAll idxValidAll],:);
Y_test_SOHc = Cap_c([idxTestAll],:);
y_trainValid_SOHc = ynorm_SOHc([idxTrainAll idxValidAll]);
y_test_SOHc = ynorm_SOHc([idxTestAll]);
%%
cap_min = zeros();
for i = 1: length(idxAll)
    cap_min = [cap_min min(ryan5_battery_dataset(i).QDischargeSmooth)];
end
cap_min = cap_min(2:end)
min(cap_min)
max(cap_min)
Cap_EOL = mean(cap_min)
plot(cap_min)
cap_max = zeros();
for i = 1: length(idxAll)
    cap_max = [cap_max max(ryan5_battery_dataset(i).QDischargeSmooth)];
end
cap_max = cap_max(2:end)
min(cap_max)
max(cap_max)
Cap_Rated = mean(cap_max)
plot(cap_max)
%%
CapDiff = diff(Cap).*(-1);
% plot(CapDiff); % 다음 베티러 셋으로 갈때 Cap 이 값자기 증가하고 이전에 마이너스를 했기 때문에 마이너스 값을 갖는다.
% histogram(CapDiff)
newBatIndex = find(CapDiff < -0.02);
newBatIndex_next = newBatIndex + 1;
CapDiff(newBatIndex) = CapDiff(newBatIndex_next);
CapDiff = [ CapDiff(1) ; CapDiff];
% plot(CapDiff)
% A =  [ 1 2 3 ]
% A([1 2]) = A([ 2 3])
RulDiff = diff(RUL).*(-1)
% plot(RulDiff); % 다음 베티러 셋으로 갈때 RUL 이 값자기 증가하고 이전에 마이너스를 했기 때문에 마이너스 값을 갖는다.
histogram(RulDiff);
newBatIndex = find(RulDiff < -10);
newBatIndex_next = newBatIndex + 1;
RulDiff(newBatIndex) = RulDiff(newBatIndex_next);
RulDiff = [ RulDiff(1) ; RulDiff];
% plot(RulDiff);
%%
[ynorm_DeltaSOH,ymax_DeltaSOH,ymin_DeltaSOH,yrate_DeltaSOH] = minmax_norm_x(CapDiff);

Y_trainValid_DeltaSOH = CapDiff([idxTrainAll idxValidAll],:);
Y_test_DeltaSOH = CapDiff([idxTestAll],:);
y_trainValid_DeltaSOH = ynorm_DeltaSOH([idxTrainAll idxValidAll]);
y_test_DeltaSOH = ynorm_DeltaSOH([idxTestAll]);

[ynorm_DeltaRUL,ymax_DeltaRUL,ymin_DeltaRUL,yrate_DeltaRUL] = minmax_norm_x(RulDiff);

Y_trainValid_DeltaRUL = RulDiff([idxTrainAll idxValidAll],:);
Y_test_DeltaRUL = RulDiff([idxTestAll],:);
y_trainValid_DeltaRUL = ynorm_DeltaRUL([idxTrainAll idxValidAll]);
y_test_DeltaRUL = ynorm_DeltaRUL([idxTestAll]);
%%
Y_trainValid_SOH_DeltaSOH = [ Y_trainValid_SOH Y_trainValid_DeltaSOH ];
Y_test_SOH_DeltaSOH = [ Y_test_SOH Y_test_DeltaSOH ];
y_trainValid_SOH_DeltaSOH = [ y_trainValid_SOH y_trainValid_DeltaSOH ]; 
y_test_SOH_DeltaSOH = [ y_test_SOH y_test_DeltaSOH ];
ynorm_SOH_DeltaSOH = [ ynorm_SOH ynorm_DeltaSOH ];
% y_trainValid_RUL
%% 실제 실험에 사용될 데이타


save('ryan5_data.mat','Ic','-append');
save('ryan5_data.mat','Vd','-append');
save('ryan5_data.mat','Cap','-append');
save('ryan5_data.mat','IcFull','-append');
save('ryan5_data.mat','Ic','-append');
save('ryan5_data.mat','VdFull','-append');
save('ryan5_data.mat','Vd','-append');

save('ryan5_data.mat','VcFull','-append');
save('ryan5_data.mat','TdFull','-append');
save('ryan5_data.mat','TcFull','-append');
save('ryan5_data.mat','IdFull','-append');
save('ryan5_data.mat','Vc','-append');
save('ryan5_data.mat','Td','-append');
save('ryan5_data.mat','Tc','-append');
save('ryan5_data.mat','Id','-append');
save('ryan5_data.mat','Cap_c','-append');

save('ryan5_data.mat','idxTrainAll','-append');
save('ryan5_data.mat','idxValidAll','-append');
save('ryan5_data.mat','idxTestAll','-append');
save('ryan5_data.mat','idxAllAll','-append');

save('ryan5_data.mat','idxTrainAll_batIndex','-append');
save('ryan5_data.mat','idxValidAll_batIndex','-append');
save('ryan5_data.mat','idxTestAll_batIndex','-append');
save('ryan5_data.mat','idxAllAll_batIndex','-append');

save('ryan5_data.mat','RUL','-append');

%%%%%%%%%  First - common
save('ryan5_data.mat','RulFirst','-append');
save('ryan5_data.mat','IcFirstFull','-append');
save('ryan5_data.mat','IcFirst','-append');
save('ryan5_data.mat','VdFirstFull','-append');
save('ryan5_data.mat','VdFirst','-append');
save('ryan5_data.mat','ynorm_First_RUL','-append');
save('ryan5_data.mat','ymax_First_RUL','-append');
save('ryan5_data.mat','ymin_First_RUL','-append');
save('ryan5_data.mat','yrate_First_RUL','-append');
save('ryan5_data.mat','y_trainValid_First_RUL','-append');
save('ryan5_data.mat','y_test_First_RUL','-append');
save('ryan5_data.mat','Y_trainValid_First_RUL','-append');
save('ryan5_data.mat','Y_test_First_RUL','-append');

%%%%%%%%%%  IcFirst / RUL 
save('ryan5_data.mat','ynorm_IcFirst_RUL','-append');
save('ryan5_data.mat','ymax_IcFirst_RUL','-append');
save('ryan5_data.mat','ymin_IcFirst_RUL','-append');
save('ryan5_data.mat','yrate_IcFirst_RUL','-append');
save('ryan5_data.mat','xnorm_IcFirstFull_RUL','-append');
save('ryan5_data.mat','xmax_IcFirst_RUL','-append');
save('ryan5_data.mat','xmin_IcFirst_RUL','-append');
save('ryan5_data.mat','xrate_IcFirst_RUL','-append');
save('ryan5_data.mat','xnorm_IcFirst_RUL','-append');


save('ryan5_data.mat','x_trainValid_IcFirstFull_RUL','-append');
save('ryan5_data.mat','x_test_IcFirstFull_RUL','-append');
save('ryan5_data.mat','x_trainValid_IcFirst_RUL','-append');
save('ryan5_data.mat','x_test_IcFirst_RUL','-append');
save('ryan5_data.mat','y_trainValid_IcFirst_RUL','-append');
save('ryan5_data.mat','y_test_IcFirst_RUL','-append');
save('ryan5_data.mat','Y_trainValid_IcFirst_RUL','-append');
save('ryan5_data.mat','Y_test_IcFirst_RUL','-append');

%%%%%%% VdFirst / RUL 
save('ryan5_data.mat','ynorm_VdFirst_RUL','-append');
save('ryan5_data.mat','ymax_VdFirst_RUL','-append');
save('ryan5_data.mat','ymin_VdFirst_RUL','-append');
save('ryan5_data.mat','yrate_VdFirst_RUL','-append');
save('ryan5_data.mat','xnorm_VdFirstFull_RUL','-append');
save('ryan5_data.mat','xmax_VdFirst_RUL','-append');
save('ryan5_data.mat','xmin_VdFirst_RUL','-append');
save('ryan5_data.mat','xrate_VdFirst_RUL','-append');
save('ryan5_data.mat','xnorm_VdFirst_RUL','-append');


%save('ryan5_data.mat','x_trainValid_IcFirstFull_RUL','-append');
%save('ryan5_data.mat','x_test_IcFirstFull_RUL','-append');
save('ryan5_data.mat','x_trainValid_VdFirstFull_RUL','-append');
save('ryan5_data.mat','x_trainValid_VdFirst_RUL','-append');
save('ryan5_data.mat','x_test_VdFirst_RUL','-append');
save('ryan5_data.mat','y_trainValid_VdFirst_RUL','-append');
save('ryan5_data.mat','y_test_VdFirst_RUL','-append');
save('ryan5_data.mat','Y_trainValid_VdFirst_RUL','-append');
save('ryan5_data.mat','Y_test_VdFirst_RUL','-append');
%%

%%%%%%% Ic Vd RUL common
save('ryan5_data.mat','ynorm_RUL','-append');
save('ryan5_data.mat','ymax_RUL','-append');
save('ryan5_data.mat','ymin_RUL','-append');
save('ryan5_data.mat','yrate_RUL','-append');
save('ryan5_data.mat','y_trainValid_RUL','-append');
save('ryan5_data.mat','y_test_RUL','-append');
save('ryan5_data.mat','Y_trainValid_RUL','-append');
save('ryan5_data.mat','Y_test_RUL','-append');



%%%%%%%%  Ic / RUL
save('ryan5_data.mat','ynorm_Ic_RUL','-append');
save('ryan5_data.mat','ymax_Ic_RUL','-append');
save('ryan5_data.mat','ymin_Ic_RUL','-append');
save('ryan5_data.mat','yrate_Ic_RUL','-append');
save('ryan5_data.mat','xnorm_Ic_RUL','-append');
save('ryan5_data.mat','xmax_Ic_RUL','-append');
save('ryan5_data.mat','xmin_Ic_RUL','-append');
save('ryan5_data.mat','xrate_Ic_RUL','-append');

save('ryan5_data.mat','x_trainValid_Ic_RUL','-append');
save('ryan5_data.mat','x_test_Ic_RUL','-append');
save('ryan5_data.mat','y_trainValid_Ic_RUL','-append');
save('ryan5_data.mat','y_test_Ic_RUL','-append');
save('ryan5_data.mat','Y_trainValid_Ic_RUL','-append');
save('ryan5_data.mat','Y_test_Ic_RUL','-append');

%%%%%%% Vd / RUL 
save('ryan5_data.mat','ynorm_Vd_RUL','-append');
save('ryan5_data.mat','ymax_Vd_RUL','-append');
save('ryan5_data.mat','ymin_Vd_RUL','-append');
save('ryan5_data.mat','yrate_Vd_RUL','-append');
save('ryan5_data.mat','xnorm_Vd_RUL','-append');
save('ryan5_data.mat','xmax_Vd_RUL','-append');
save('ryan5_data.mat','xmin_Vd_RUL','-append');
save('ryan5_data.mat','xrate_Vd_RUL','-append');

save('ryan5_data.mat','x_trainValid_Vd_RUL','-append');
save('ryan5_data.mat','x_test_Vd_RUL','-append');
save('ryan5_data.mat','y_trainValid_Vd_RUL','-append');
save('ryan5_data.mat','y_test_Vd_RUL','-append');
save('ryan5_data.mat','Y_trainValid_Vd_RUL','-append');
save('ryan5_data.mat','Y_test_Vd_RUL','-append');

%%

%%%%%%% SOH
save('ryan5_data.mat','ynorm_SOH','-append');
save('ryan5_data.mat','ymax_SOH','-append');
save('ryan5_data.mat','ymin_SOH','-append');
save('ryan5_data.mat','yrate_SOH','-append');
save('ryan5_data.mat','y_trainValid_SOH','-append');
save('ryan5_data.mat','y_test_SOH','-append');
save('ryan5_data.mat','Y_trainValid_SOH','-append');
save('ryan5_data.mat','Y_test_SOH','-append');


%%%%%%% Ic / SOH
save('ryan5_data.mat','xnorm_Ic_SOH','-append');
save('ryan5_data.mat','xmax_Ic_SOH','-append');
save('ryan5_data.mat','xmin_Ic_SOH','-append');
save('ryan5_data.mat','xrate_Ic_SOH','-append');
save('ryan5_data.mat','x_trainValid_Ic_SOH','-append');
save('ryan5_data.mat','x_test_Ic_SOH','-append');
%%%%%%% Vd / SOH
save('ryan5_data.mat','xnorm_Vd_SOH','-append');
save('ryan5_data.mat','xmax_Vd_SOH','-append');
save('ryan5_data.mat','xmin_Vd_SOH','-append');
save('ryan5_data.mat','xrate_Vd_SOH','-append');
save('ryan5_data.mat','x_trainValid_Vd_SOH','-append');
save('ryan5_data.mat','x_test_Vd_SOH','-append');
%%
%%%%% SOH == RUL   for x value 
x_trainValid_Ic = x_trainValid_Ic_SOH;
x_trainValid_Vd = x_trainValid_Vd_SOH;
x_test_Ic = x_test_Ic_SOH;
x_test_Vd = x_test_Vd_SOH;

xnorm_Ic = xnorm_Ic_SOH;
%xmax_Ic = xmax_Ic_SOH;
xmin_Ic = xmin_Ic_SOH;
xrate_Ic = xrate_Ic_SOH;

xnorm_Vd = xnorm_Vd_SOH;
%xmax_Vd = xmax_Vd_SOH;
xmin_Vd = xmin_Vd_SOH;
xrate_Vd = xrate_Vd_SOH;

%%%%%%%%% common 
save('ryan5_data.mat','x_trainValid_Ic','-append');
save('ryan5_data.mat','x_trainValid_Vd','-append');
save('ryan5_data.mat','x_test_Ic','-append');
save('ryan5_data.mat','x_test_Vd','-append');

save('ryan5_data.mat','xnorm_Ic','-append');
%save('ryan5_data.mat','xmax_Ic','-append');
save('ryan5_data.mat','xmin_Ic','-append');
save('ryan5_data.mat','xrate_Ic','-append');

save('ryan5_data.mat','xnorm_Vd','-append');
%save('ryan5_data.mat','xmax_Vd','-append');
save('ryan5_data.mat','xmin_Vd','-append');
save('ryan5_data.mat','xrate_Vd','-append');

%%
save('ryan5_data.mat','x_trainValid_Id','-append');
save('ryan5_data.mat','x_test_Id','-append');
save('ryan5_data.mat','xnorm_Id','-append');
%save('ryan5_data.mat','xmax_Id','-append');
save('ryan5_data.mat','xmin_Id','-append');
save('ryan5_data.mat','xrate_Id','-append');


save('ryan5_data.mat','x_trainValid_Vc','-append');
save('ryan5_data.mat','x_test_Vc','-append');
save('ryan5_data.mat','xnorm_Vc','-append');
%save('ryan5_data.mat','xmax_Vc','-append');
save('ryan5_data.mat','xmin_Vc','-append');
save('ryan5_data.mat','xrate_Vc','-append');

save('ryan5_data.mat','x_trainValid_Tc','-append');
save('ryan5_data.mat','x_test_Tc','-append');
save('ryan5_data.mat','xnorm_Tc','-append');
%save('ryan5_data.mat','xmax_Tc','-append');
save('ryan5_data.mat','xmin_Tc','-append');
save('ryan5_data.mat','xrate_Tc','-append');


save('ryan5_data.mat','x_trainValid_Td','-append');
save('ryan5_data.mat','x_test_Td','-append');
save('ryan5_data.mat','xnorm_Td','-append');
%save('ryan5_data.mat','xmax_Td','-append');
save('ryan5_data.mat','xmin_Td','-append');
save('ryan5_data.mat','xrate_Td','-append');

save('ryan5_data.mat','CapDiff','-append');
save('ryan5_data.mat','RulDiff','-append');
%%
save('ryan5_data.mat','ynorm_SOHc','-append');
save('ryan5_data.mat','ymax_SOHc','-append');
save('ryan5_data.mat','ymin_SOHc','-append');
save('ryan5_data.mat','yrate_SOHc','-append');
save('ryan5_data.mat','y_trainValid_SOHc','-append');
save('ryan5_data.mat','y_test_SOHc','-append');
save('ryan5_data.mat','Y_trainValid_SOHc','-append');
save('ryan5_data.mat','Y_test_SOHc','-append');
%%

save('ryan5_data.mat','ynorm_DeltaSOH','-append');
save('ryan5_data.mat','ymax_DeltaSOH','-append');
save('ryan5_data.mat','ymin_DeltaSOH','-append');
save('ryan5_data.mat','yrate_DeltaSOH','-append');
save('ryan5_data.mat','y_trainValid_DeltaSOH','-append');
save('ryan5_data.mat','y_test_DeltaSOH','-append');
save('ryan5_data.mat','Y_trainValid_DeltaSOH','-append');
save('ryan5_data.mat','Y_test_DeltaSOH','-append');

save('ryan5_data.mat','ynorm_DeltaRUL','-append');
save('ryan5_data.mat','ymax_DeltaRUL','-append');
save('ryan5_data.mat','ymin_DeltaRUL','-append');
save('ryan5_data.mat','yrate_DeltaRUL','-append');
save('ryan5_data.mat','y_trainValid_DeltaRUL','-append');
save('ryan5_data.mat','y_test_DeltaRUL','-append');
save('ryan5_data.mat','Y_trainValid_DeltaRUL','-append');
save('ryan5_data.mat','Y_test_DeltaRUL','-append');
%%
save('ryan5_data.mat','Cap_Rated','-append');
save('ryan5_data.mat','Cap_EOL','-append');

save('ryan5_data.mat','Y_trainValid_SOH_DeltaSOH','-append');
save('ryan5_data.mat','Y_test_SOH_DeltaSOH','-append');
save('ryan5_data.mat','y_trainValid_SOH_DeltaSOH','-append');
save('ryan5_data.mat','y_test_SOH_DeltaSOH','-append');
save('ryan5_data.mat','ynorm_SOH_DeltaSOH','-append');

Cap_change = (Cap_Rated + Cap_EOL )/2
save('ryan5_data.mat','Cap_change','-append')