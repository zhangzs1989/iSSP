function EVENT=zjc_readc01(reportfile)
% % function EVENT=zjc_readc01(reportfile)
%   read report file into memory, and return usefull value.
% Input:
%   reportfile - ȫ����Ŀϵͳ�����Ŀ챨�۲ⱨ�棬���Ե����¼� 
% Output:
%   EVENT      - �ṹ��, �������
% Zheng JC, Aug. 1st, 2015 @ Jinan.
% ========================================================================

file = textread(reportfile, '%s', 'delimiter', '\n', ...
				'whitespace', '');
	line = numel(file);
	sti  = 0;
%	flaw = 0;         % ����Pg�����Sg��̨վ��������������: ȱ��; ȱ��; 覴�
	Pg   = [];
	Sg   = [];
	for i=1:line
		strline=char(file{i});
		if isempty(strline)
			break
		end
		if strcmp(strline(1:3),'DBO')
			ind=strline<=57&strline>=46;            % �����������ֺ�С����
			ind=~ind;                               % 46='.', 57='9'
			strline(ind)=' ';
			TempA =sscanf(strline,'%f');
			EVENT.origintime=TempA(1:6)';
			EVENT.epicenter =TempA(7:8)';
			EVENT.depth     =TempA(9);
			EVENT.mag       =TempA(10);
			EVENT.loc_stn   =TempA(14);
			EVENT.STA(EVENT.loc_stn).staname='';
			EVENT.STA(EVENT.loc_stn).Pg=[];
			EVENT.STA(EVENT.loc_stn).Sg=[];
		end
		if strcmp(strline(1:3),'DPB') && ~isempty(strfind(strline,' Pg '))
			Pgsta=strtrim(strline(8:12));
			ind=strline<=57&strline>=46;            % �����������ֺ�С����
			ind=~ind;
			strline(ind)=' ';
			TempA =sscanf(strline,'%f');
			Pg=TempA(2:7);
		end
		if strcmp(strline(1:3),'DPB') && ~isempty(strfind(strline,' Sg '))
			Sgsta=strtrim(strline(8:12));
			ind=strline<=57&strline>=46;            % �����������ֺ�С����
			ind=~ind;
			strline(ind)=' ';
			TempA =sscanf(strline,'%f');
			Sg=TempA(2:7); 
		end
		if ~isempty(Pg) && ~isempty(Sg)
			if strcmp(Pgsta,Sgsta)
				sti=sti+1;
				EVENT.STA(sti).staname=Pgsta;
				EVENT.STA(sti).Pg=Pg';
				EVENT.STA(sti).Sg=Sg';
				Pg=[];
				Sg=[];
			end
		end
	end
	EVENT.loc_stn = sti;
%end of file.