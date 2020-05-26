function plt_spectrum(type)
%- �ӵ�����result������ͼ�����ƴ�ֱ���ٶ���,λ���׺ͼ��ٶ���
%- �����֣�1������zipѹ���ļ�����ȡcsv���ݣ�2ֱ�Ӽ���csv����
type = type;
try 
    [filename, pathname]  = uigetfile({'*.zip;*.csv'},'ѡ������zip or csv');
catch ErrorInfo 
    msgbox(ErrorInfo.message);
end
try
if strcmp(filename(end-3:end),'.zip') % �ļ���׺Ϊ.zip�����´���
    Files = unzip([pathname,filename],cd);
    for ii = 1:length(Files)
       if ~isempty(strfind(Files{ii},'.csv'))
           data = importdata(Files{ii});
           fdata = data.data;
           dhead = data.colheaders;
           [~,index] = find(strcmp(dhead,'Frequency'));
%            [sel,ok]=listdlg('ListString',{'�ٶ���','λ����','���ٶ���'},...
%             'Name','ѡ��������','OKString','ȷ��','CancelString','ȡ��','SelectionMode','single','ListSize',[180 80]);
%            type = sel;
%             if ok == 1
            figure()
            switch type
               case 1
                    xdata = fdata(:,1);ydata = fdata(:,index(1)+1:index(2)-2);
                    plot_stationspectrum(xdata,ydata,type,filename(1:end-4));
%                     savefigure(type);
               case 2
                   xdata = fdata(:,1);ydata = fdata(:,index(2)+1:index(3)-2);
                    plot_stationspectrum(xdata,ydata,type,filename(1:end-4));
%                     savefigure(type);
                case 3
                    xdata = fdata(:,1);ydata = fdata(:,index(3)+1:end-1);
                    plot_stationspectrum(xdata,ydata,type,filename(1:end-4));
%                     savefigure(type);
           end
           break;
%            else
            % δѡ��
%            end
       end
    end
else if strcmp(filename(end-3:end),'.csv')
       data = importdata([pathname,filename]);
       fdata = data.data;
       dhead = data.colheaders;
       [~,index] = find(strcmp(dhead,'Frequency'));
%        [sel, ok]=listdlg('ListString',{'�ٶ���','���ٶ���','λ����'},...
%             'Name','ѡ��������','OKString','ȷ��','CancelString','ȡ��','SelectionMode','single','ListSize',[180 80]);
%            type = sel;
%             if ok == 1
            figure()
            switch type
               case 1
                    xdata = fdata(:,1);ydata = fdata(:,index(1)+1:index(2)-2);
                    plot_stationspectrum(xdata,ydata,type,filename(1:end-4));
%                     savefigure(type);
               case 2
                   xdata = fdata(:,1);ydata = fdata(:,index(2)+1:index(3)-2);
                    plot_stationspectrum(xdata,ydata,type,filename(1:end-4));
%                     savefigure(type);
                case 3
                    xdata = fdata(:,1);ydata = fdata(:,index(3)+1:end-1);
                    plot_stationspectrum(xdata,ydata,type,filename(1:end-4));
%                     savefigure(type);
           end
%            return;
%            else
            % δѡ��
%            end
    else
        msgbox('��ѡ�����.csv���ݵ�.zip�ļ�����ֱ��ѡ��.csv�����ļ�!')        
    end
end
catch
    
end
end