function [ result ] = FindSameFilename(evtname,rptname)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   �ʺ���xx.yyyymmddhhmm.evt
%   �ʺ���xx.yyyymmddhhmm.txt
    evtsplit = regexp(evtname,'\.', 'split');
    rptsplit = regexp(rptname,'\.', 'split');
    [~,evtsplit,~] = fileparts(evtname);
    [~,rptsplit,~] = fileparts(rptname);
    if strcmp(evtsplit,rptsplit)
        result = 1;
    else
        result = 0;
    end
end

