function Loadwave(varargin)
% LOADWAVE Summary of this function goes here
% loadwave:���벨������·�����ļ���  
% �������С��1����Ĭ�ϲ��θ�ʽ.evt��Ŀǰ��֧��evt��ʽ
% ���������1-evt��2-seed��3-SAC��4-ASCII�ı��ļ�����ʽ��ͳһ��������ʹ�ã�
try
    if nargin > 1
        msgbox('���������ʽ���࣡', '��ʾ');
    else
        if nargin == 0
            wavetype = 1;
            [filename,filepath] = uigetfile('.evt','Select an evt file');
        end
        if nargin == 1
            wavetype = varargin{1};
           switch wavetype
                case 1
                    type =  '.evt';
                case 2
                    type =  '.seed';
                case 3
                    type =  '.SAC';
                case 4
                    type =  '.ASCII';
           end
            [filename,filepath] = uigetfile(type,['Select an',type,'file']);
        end
        if ~isequal(filename,0) && ~isequal(filepath,0)
                msgbox('��ȡ�����ļ�·���ɹ���','������ʾ')
                file_path_name = [filepath,filename];
            else
                warndlg('��ȡ�����ļ�ʧ��','������ʾ')
        end
    end
    evt_path_name = file_path_name;
    save('./temp/evt_path_name.mat','evt_path_name');
catch 
end
end


