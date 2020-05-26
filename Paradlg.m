function para = paradlg(prompt0,dlg0 )
% ��Ŀ:��׼���Ի��򴴽�����
% ����:
%       prompt0    -- ��Ҫ��������ʾ���Լ�Ĭ�ϲ�����n*2
%       dlg0       -- ��ѡ�����Ի����ȣ�������Ϣ
%       dlg0.width -- �Ի�����
%       dlg0.title -- �Ի������
%       dlg0.auto  -- �Ƿ��Զ������ϴ����ݣ�dlg0.auto=1��dlg0.auto=0
% ���ܣ�
%       ������׼����������Ի���
%       ֧�� �������������ַ���
%       �����������
%       �����ϴ�����

%% prompt����
n = size(prompt0,1);
prompt = cell(n,1);                                                 % ��ʾ��
def0 = cell(n,1);                                                   % Ĭ�ϲ���
for iloop = 1:n
    prompt{iloop} = prompt0{iloop,1};                               % ��������
    def0{iloop} = num2str(prompt0{iloop,2});                        % Ĭ�ϲ�������Ϊ�ַ�����ʽ
end
try 
    load data_dlg                                                   % �����ϴ���������def
catch
    def =def0;
end

%% dlg����
try                                                                 % �������
    dlg.width = dlg0.width;
catch
    dlg.width = 60;    
end

try                                                                 % ��������
    dlg.title = dlg0.title;
catch
    dlg.title = '��������'; 
end

%% �Ի���

linewidth = ones(n,2);                                              % �������
linewidth(:,2) = linewidth(:,2)*dlg.width;                          % �����������
options.Interpreter='tex';
para_dlg = inputdlg(prompt,dlg.title,linewidth,def,options);        % �򿪶Ի��򣬻�ȡ�����ַ���

%% ����ת��

% ����ת�����ַ���ת��

para = cell(n,1);                                                   % �������

for iloop = 1:n
    temp = ['[',para_dlg{iloop},']'];                               % Ĭ�ϰ�����ת��
    para{iloop} = str2num(temp);
    
    if isempty(para{iloop})                                         % ���ת����Ϊ�գ���Ϊ�ַ���
        para{iloop} = para_dlg{iloop};
    end
    
end

%% ��������
def = para_dlg;                                                     % �������븳ֵ��def
save('data_dlg','def');                                             % ����Ի������ݣ������´ε���
try 
   if ~dlg0.auto
       delete data_dlg.mat
   end
catch
end

end