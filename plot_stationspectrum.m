function plot_stationspectrum(xdata,ydata,type,str)
    % ���ƹ۲���Դ��
    % type:1-�ٶ��ף�2-λ���ף�3-���ٶ���
    % ftitle:ͼ��title
    fv = xdata;S_sta = ydata;
    type = type;str_tmp = 'ƽ����Դ��';
    ydatamean = median(S_sta,2);
    str = str(1:end-4);
    switch type
        case 1
            loglog(fv,S_sta); hold on,h = loglog(fv,ydatamean,'k','LineWidth',1.2);
%             str_tmp=strrep(str_tmp(12:end),',',''',''');
%             str_tmp=strcat(char(39),str_tmp,char(39));
%             str_tmp=strcat('hleg=legend(',str_tmp,');');
%             eval(str_tmp);
%             set(hleg,'FontName','Verdana','FontSize',7.0,'TextColor',[.3,.2,.1],...
%                      'Location','SouthWest');
            legend([h],str_tmp,'Location','southwest')
            xlabel('Frequency (Hz)'); ylabel('velocity Spectrum');title(str);
        case 2
            loglog(fv,S_sta); hold on,h = loglog(fv,ydatamean,'k','LineWidth',1.2);
%             str_tmp=strrep(str_tmp(12:end),',',''',''');
%             str_tmp=strcat(char(39),str_tmp,char(39));
%             str_tmp=strcat('hleg=legend(',str_tmp,');');
%             eval(str_tmp);
%             set(hleg,'FontName','Verdana','FontSize',7.0,'TextColor',[.3,.2,.1],...
%                      'Location','SouthWest');
            legend([h],str_tmp,'Location','southwest')
            xlabel('Frequency (Hz)'); ylabel('Displacement Spectrum');title(str);
        case 3
            loglog(fv,S_sta); hold on,h = loglog(fv,ydatamean,'k','LineWidth',1.2);
%             str_tmp=strrep(str_tmp(12:end),',',''',''');
%             str_tmp=strcat(char(39),str_tmp,char(39));
%             str_tmp=strcat('hleg=legend(',str_tmp,');');
%             eval(str_tmp);
%             set(hleg,'FontName','Verdana','FontSize',7.0,'TextColor',[.3,.2,.1],...
%                      'Location','SouthWest');
            legend([h],str_tmp,'Location','southwest')
            xlabel('Frequency (Hz)'); ylabel('Acceleration Spectrum');title(str)
    end
    
end