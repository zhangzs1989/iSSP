function spectpara = Invert_z(model,invert_method,xdata,ydata)
% xdata: frequence
% ydata: velocity spectrum
    model = model;invert = invert_method;xdata = xdata;vel = ydata;
    disl = vel./(2*pi*xdata).^1;acc = vel.*(2*pi*xdata).^1;tecc = vel.*(2*pi*xdata).^2.5;
    save('./temp/fv.mat','xdata');save('./temp/disl.mat','disl');
    fun_Brune = @(a,b,x) (a./(1+(x./b).^2));                 
    fun_Boore = @(a,b,c,d,x) a./((1.+(x./b).^2).*(1+(x./c).^d));
    fun_Brune2 = @(a,b,c,x) (a./(1+(x./b).^c));
    switch model
        case 1
            switch invert
                case 1
                    [omg0,fc0,~,~,~,~] = spectpara_rmse_HC(xdata,ydata);
                    [fitobj_1,gof] = fit(xdata,disl,(fun_Brune),'StartPoint',[omg0,fc0],...
                    'Lower',[min(ydata) min(xdata)],...
                    'Upper',[max(disl) 20  ],...
                    'Robust','on');
                    CI = confint(fitobj_1,0.95);		 % 95% confidence intervals
                    omega =fitobj_1.a;
                    fc    =fitobj_1.b;
                    omega_intervals =CI(:,1);
                    fc_intervals    =CI(:,2);
                    spectpara.fc = fc;
                    spectpara.omg = omega;
                    spectpara.fc_intervals = fc_intervals;
                    spectpara.omg_intervals = omega_intervals;
                    spectpara.gof = gof;
%                     figure(),loglog(xdata,disl),hold on,loglog(xdata,fun_Brune(omega,fc,xdata))
                case 2 % 最小残差
                    [omg,fc,outfc] = spectpara_rmse_Brune(xdata,ydata);
                    spectpara.omg = omg;
                    spectpara.fc = fc;
                    spectpara.fc_intervals = [fc,fc];
                    spectpara.omg_intervals = [omg,omg];
                    spectpara.outfc = outfc;
                case 3 % pso
%                     fitnessfcn = @(par,x) (par(1)./(1+(x./par(2)).^2));                     
                    uplimits= [0 10];
                    lolimits= [1000 1];
                    [omg0,fc0,~,~,~,~] = spectpara_rmse_HC(xdata,ydata);
                    x0 = [omg0,fc0];
                    problem.options.InitialPopulation = x0 ;
                    problem.Aineq = [] ; problem.bineq = [] ;
                    problem.Aeq = [] ;   problem.beq = [] ;
                    problem.LB = lolimits ;
                    problem.UB = uplimits ;
            % 		problem.LB = [] ;
            % 		problem.UB = [] ;
                    problem.fitnessfcn = @brune_ga;
                    problem.nvars = 2 ;
                    problem.nonlcon = [] ;
                    try
                    [coeff, misfit_min,exitflag,output,population,scores]=pso(problem);                    
                    spectpara.omg = coeff(1);
                    spectpara.fc = coeff(2);
                    spectpara.fc_intervals = [coeff(2),coeff(2)];
                    spectpara.omg_intervals = [coeff(1),coeff(1)];
                    catch
                        
                    end
            end
        case 2  % High-Cut模型      
            switch invert
                case 1  % matlab 自带拟合函数        
                    [omg,fc,fmax,p,~,~] = spectpara_rmse_HC(xdata,ydata);
                    [fitobj_1,~] = fit(xdata,disl,fun_Boore,'StartPoint',[omg,fc,fmax,p],...
                        'Lower',[0,1,5,0],...
                        'Upper',[Inf,10,20,5],...
                        'Robust','on');
                    CI = confint(fitobj_1,0.95);		 % 95% confidence intervals
                    omega =fitobj_1.a;
                    fc    =fitobj_1.b;
                    fmax  =fitobj_1.c;
                    p     =fitobj_1.d;
                    if fc>fmax
                    temp = fc;
                    fc = fmax;
                    fmax = temp;
                    omega_intervals =CI(:,1);
                    fc_intervals    =CI(:,4);
                    fmax_intervals  =CI(:,3);
                    p_intervals     =CI(:,2);
                    spectpara.fc = fc;
                    spectpara.omg = omega;
                    spectpara.fmax = fmax;
                    spectpara.p =p;
                    spectpara.fc_intervals = fc_intervals;
                    spectpara.omg_intervals = omega_intervals;
                    spectpara.fmax_intervals = fmax_intervals;
                    spectpara.p_intervals = p_intervals;
                    else
                    omega_intervals =CI(:,1);
                    fc_intervals    =CI(:,2);
                    fmax_intervals  =CI(:,3);
                    p_intervals     =CI(:,4);
                    spectpara.fc = fc;
                    spectpara.omg = omega;
                    spectpara.fmax = fmax;
                    spectpara.p =p;
                    spectpara.fc_intervals = fc_intervals;
                    spectpara.omg_intervals = omega_intervals;
                    spectpara.fmax_intervals = fmax_intervals;
                    spectpara.p_intervals = p_intervals;    
                    end
%                     figure(),loglog(xdata,disl),hold on,loglog(xdata,fun_Boore(omega,fc,fmax,p,xdata))
                case 2 % 最小残差
                    [omg,fc,fmax,p,outfc,outfmax] = spectpara_rmse_HC(xdata,ydata);
                    spectpara.omg = omg;
                    spectpara.fc = fc;
                    spectpara.fmax = fmax;
                    spectpara.p = p;
                    spectpara.fc_intervals = [fc,fc];
                    spectpara.omg_intervals = [omg,omg];
                    spectpara.fmax_intervals = [fmax,fmax];
                    spectpara.p_intervals = [p,p];
                    spectpara.outfc = outfc;
                    spectpara.outfmax = outfmax;
                case 3 % ga
                    [omg0,fc0,fmax0,p0,outfc0,outfmax0] = spectpara_rmse_HC(xdata,ydata);
                    uplimits= [];
                    lolimits= [];
                    problem.options.InitialPopulation = [omg0 fc0 fmax0 p0];
                    problem.Aineq = [] ; problem.bineq = [] ;
                    problem.Aeq = [] ;   problem.beq = [] ;
                    problem.LB = lolimits ;
                    problem.UB = uplimits ;
            % 		problem.LB = [] ;
            % 		problem.UB = [] ;
                    problem.fitnessfcn = @highcut_ga;
                    problem.nvars = 4 ;
                    problem.nonlcon = [] ;
%                     [coeff, misfit_min,exitflag,output,population,scores]=pso(problem);                    
                    [coeff, misfit_min,exitflag,output,population,scores]=pso(problem);
%                     omg=mean(acc)/(2*pi*coeff(2)).^2;
                    try
                    spectpara.fc = coeff(2);
                    spectpara.omg = coeff(1);
                    spectpara.fmax = coeff(3);
                    spectpara.p = coeff(4);
                    spectpara.fc_intervals = [coeff(2),coeff(2)];
                    spectpara.omg_intervals = [coeff(1),coeff(1)];
                    spectpara.fmax_intervals = [coeff(3),coeff(3)];
                    spectpara.p_intervals = [coeff(4),coeff(4)];
                    catch ErrorInfo
                        throw(ErrorInfo);
                    end
%                     spectpara.fc = coeff(2);
%                     spectpara.omg = coeff(1);
%                     spectpara.fmax = coeff(3);
%                     spectpara.p = coeff(4);
%                     spectpara.fc_intervals = [coeff(2),coeff(2)];
%                     spectpara.omg_intervals = [coeff(1),coeff(1)];
%                     spectpara.fmax_intervals = [coeff(3),coeff(3)];
%                     spectpara.p_intervals = [coeff(4),coeff(4)];
            end
        case 3 %Brune2 model
            switch invert
                case 1 %fit
                    [omg0,fc0,~,p0,~,~] = spectpara_rmse_HC(xdata,ydata);
                    [fitobj_1,~] = fit(xdata,disl,(fun_Brune2),'StartPoint',[omg0,fc0,p0],...
                    'Lower',[0,1,1],...
                    'Upper',[max(disl) 10 5],...
                    'Robust','on');
                    CI = confint(fitobj_1,0.95);		 % 95% confidence intervals
                    omega =fitobj_1.a;
                    fc    =fitobj_1.b;
                    gamma =fitobj_1.c;
                    omega_intervals =CI(:,1);
                    fc_intervals    =CI(:,2);
                    gamma_intervals =CI(:,3);
                    spectpara.fc = fc;
                    spectpara.omg = omega;
                    spectpara.gamma = gamma;
                    spectpara.fc_intervals = fc_intervals;
                    spectpara.omg_intervals = omega_intervals;
                    spectpara.gamma_intervals = gamma_intervals;
                case 2 %rms
                    [omg,fc,gamma,outfc,outgamma] = spectpara_rmse_Brune2(xdata,ydata);
                    spectpara.omg = omg;
                    spectpara.fc = fc;
                    spectpara.gamma=gamma;
                    spectpara.gamma_intervals=[gamma,gamma];
                    spectpara.fc_intervals = [fc,fc];
                    spectpara.omg_intervals = [omg,omg];
%                     spectpara.fmax_intervals = [fmax,fmax];
%                     spectpara.p_intervals = [p,p];
                    spectpara.outfc = outfc;
                    spectpara.outgamma = outgamma;
                case 3 %pso
% %                     LB=[0 1 1]; % lower boundary
% %                     UB=[10000 10 5]; % upper boundary
% % %                     fitnessfcn = str2func('brune');
% %                     ObjectiveFunction = @brune2_ga; 
% %                     nvars = 3; % number of varibles
% %                     ConstraintFunction = []; % constraints
% % %                     rng default; % for reproducibality ?
% %                     [coeff,~]=ga(ObjectiveFunction,nvars);
                    uplimits= [0 1 1];
                    lolimits= [50 10 5];
                    problem.options.InitialPopulation = [5,mean(acc)/(2*pi*5).^2,2] ;
                    problem.Aineq = [] ; problem.bineq = [] ;
                    problem.Aeq = [] ;   problem.beq = [] ;
                    problem.LB = lolimits ;
                    problem.UB = uplimits ;
            % 		problem.LB = [] ;
            % 		problem.UB = [] ;
                    problem.fitnessfcn = @brune2_ga ;
                    problem.nvars = 3 ;
                    problem.nonlcon = [] ;
                    try
                    [coeff, misfit_min,exitflag,output,population,scores]=pso(problem);
                    omg=mean(acc)/(2*pi*coeff(2)).^2;
                    spectpara.fc = coeff(2);
                    spectpara.omg = omg;
                    spectpara.gamma = coeff(3);
                    spectpara.fc_intervals = [coeff(2),coeff(2)];
                    spectpara.omg_intervals = [coeff(1),coeff(1)];
                    spectpara.gamma_intervals = [coeff(3),coeff(3)];
                    catch ErrorInfo
                        throw(ErrorInfo);
                    end
            end
    end
end