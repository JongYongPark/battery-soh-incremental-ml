function [alert,aleart_bad_cnt, aleart_good_cnt, rul_predicted_diff,rul_predicted_2nd_diff] = ryan5_util_plot_change_detect( rul_predicted, titleStr)
    
    limit_val =5;
    rul_predicted = smooth(rul_predicted);
    rul_predicted_diff = [ 0  ; diff(rul_predicted)];
    rul_predicted_2nd_diff = [ 0 ;  diff(rul_predicted_diff)];

%     rul_predicted_diff = smooth(rul_predicted_diff);
%     rul_predicted_2nd_diff = smooth(rul_predicted_2nd_diff);
    %alert = rul_predicted;
    aleart_bad_cnt =0;
    aleart_good_cnt =0;
    len = length(rul_predicted_diff);
    alert = zeros (1,len);
    alert( rul_predicted_diff > 5 ) = 1 ;
    alert( rul_predicted_diff < -5 ) = -1 ;
    for i=1:len-1
        if alert(i) == 1 & alert(i+1) == -1
            alert(i+1) = 0;
        elseif alert(i) == -1 & alert(i+1) == 1
            alert(i+1) = 0;
        end
    end
    alert(len) = 0;

  for i=1:len
        if alert(i) == 1 
            aleart_good_cnt = aleart_good_cnt + 1;
        elseif alert(i) == -1 
            aleart_bad_cnt = aleart_bad_cnt + 1;
        end
  end

    alert;
    figure, hold on 
    plot(rul_predicted_diff)
    %ylim([-20,20])
    xlabel 'Cycle'
    ylabel 'RUL Diff'
    
    yyaxis right
    plot(rul_predicted_2nd_diff,'--')
    %ylim([-20,20])
    ylabel 'RUL 2nd Diff '
    hold off
    title(titleStr,'Diff of Yhat (RUL)')
    
    
    figure
    subplot(2,1,1)
    plot(rul_predicted_diff)
    ylim([-limit_val-0.5,limit_val+0.5])
    xlabel 'Cycle'
    ylabel 'RUL Diff'
    title 'Diff of Yhat (RUL)'
    
    subplot(2,1,2)
    plot(alert) %,'o')
    %stem(alert)
    ylim([-1-0.5,1+0.5])
    xlabel 'Cycle'
    ylabel 'Bad / Good Alram '
    title("Pattern Change Alarm: Bad("+num2str(aleart_bad_cnt)+") Good(" + num2str(aleart_good_cnt) + ")" )
    %title(titleStr,"Pattern Change Alarm: Bad("+num2str(aleart_bad_cnt)+") Good(" + num2str(aleart_good_cnt) + ")" )
    %figtitle(titleStr,"Pattern Change Alarm: Bad("+num2str(aleart_bad_cnt)+") Good(" + num2str(aleart_good_cnt) + ")" )

end