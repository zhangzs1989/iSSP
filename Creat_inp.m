function Creat_inp()
try
    
    inpfilename = ['.\pathinp\',datestr(now,'yyyymmddTHHMMSS'),'.inp'];
    fid = fopen(inpfilename,'wt');
    fprintf(fid,'%s\n%s\n%s\n%s\n','%%-- input filepath of seismic wave(.evt) and report(.txt)','%%-- 1st line is evtfile',...
        '%%-- 2nd line is reportfile','%%-----------------------------------------');
    folder_name_evt = uigetdir('.\','���벨���ļ���.evt�������ļ���');
    index = findstr(folder_name_evt,'\');
    folder_name_rpt = folder_name_evt(1:index(end));
    folder_name_rpt = uigetdir(folder_name_rpt,'����۲ⱨ�������ļ���');
    if folder_name_evt(end)~='\'
        folder_name_evt=[folder_name_evt,'\'];
    end
    if folder_name_rpt(end)~='\'
        folder_name_rpt=[folder_name_rpt,'\'];
    end
    DIRS_evt=dir([folder_name_evt,'*.evt']);  %��չ��
    DIRS_rpt=dir([folder_name_rpt,'*.txt']);  %��չ��
    n1=length(DIRS_evt);n2=length(DIRS_rpt);
    pp = 1;
    if n1 >= n2
        for i = 1:n2
            for j = 1:n1
                result=FindSameFilename(DIRS_evt(j).name,DIRS_rpt(i).name); 
                if result==1
                    evtrpt{pp,1} = [folder_name_evt,DIRS_evt(j).name];
                    evtrpt{pp,2} = [folder_name_rpt,DIRS_rpt(i).name];
                    pp=pp+1;
                end
            end
        end
    else
        for i = 1:n1
            for j = 1:n2
                result=FindSameFilename(DIRS_evt(i).name,DIRS_rpt(j).name); 
                if result==1
                    evtrpt{pp,1} = [folder_name_evt,DIRS_evt(i).name];
                    evtrpt{pp,2} = [folder_name_rpt,DIRS_rpt(j).name];
                    pp=pp+1;
                end
            end
        end
    end
    h = waitbar(0,'�������ɣ����Ժ�...','Positon',[1 1]);
    fid = fopen(inpfilename,'a+');
    for i=1:length(evtrpt)          
        fprintf(fid,'%s\n%s\n',strrep(evtrpt{i,1},'\','/'),strrep(evtrpt{i,2},'\','/'));
        waitbar(i / length(evtrpt));
    end
        close(h);
        msgbox(['Ŀ¼��ȡ���!','inp�ļ�·��Ϊ:',inpfilename],'�����ʾ');
        fclose('all'); 
catch        
end
end