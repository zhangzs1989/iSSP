function x_opt = PSO_ExpFit2(t, Et)
%{
�������ܣ�ѹ����������Ⱥ�㷨ʵ��ָ����ϣ�y = a1*exp(-x/b1) + a2*exp(-x/b2) + c
���룺
  t���Ա�����
  Et���������
�����
  x_opt�����Ž⣻
���ø�ʽ��
clear;clc;
t = 0.2*(1:3000)';
data = 400*exp(-t/5) + 600*exp(-t/200) + 10*rand(size(t));
tic;
p = PSO_ExpFit2(t, data)
toc;
fit = p(1)*exp(-t/p(2)) + p(3)*exp(-t/p(4)) + p(5);
plot(t, data, t, fit, 'LineWidth', 2)
legend('model', 'PSO');
%} 
% ��ʼֵ
D = 5;                      % ����ά�ȣ�δ֪��������
IterMax = 500;      % ������������
Vmin = -1;               % �ٶ���Сֵ��
Vmax = 1;               % �ٶ����ֵ��
c1 = 2.05;               % ѧϰ����1����֪���֣�
c2 = 2.05;               % ѧϰ����2����Ჿ�֣�
N = 100;               % ��Ⱥ������
Xmin = [0, -2, 0, -2, 0];    % ����
max_sig = max(Et);
Xmax = [1.5*max_sig, 4, 1.5*max_sig, 4, 0.5*max_sig];  % ���ޣ�
% ����
phy = c1 + c2;
lamda = 2 / abs(2 - phy - sqrt(phy^2 - 4*phy));   % ѹ������
% ��ʼ����Ⱥ���壨�޶�λ�ú��ٶȣ� 
x = rand(N, D).*repmat(Xmax - Xmin, N, 1) + repmat(Xmin, N, 1);
v = rand(N, D)*(Vmax - Vmin) + Vmin;
% ��ʼ����������λ�ú�����ֵ 
p = x;
pbest = ones(1, N);
for i = 1 : N
   pbest(i) = Obj_Fit(x(i, :), t ,Et);
end
% ��ʼ��ȫ������λ�ú�����ֵ 
g = ones(1, D);
gbest = inf;
for i = 1 : N
   if pbest(i) < gbest
      g = p(i, :);
      gbest = pbest(i);
   end
end
% ����ֱ�����㾫�Ȼ��ߵ������� 
fx = zeros(1, N);
for i = 1 : IterMax
   for j = 1 : N
      % ���¸�������λ�ú�����ֵ 
      fx(j) = Obj_Fit(x(j, :), t ,Et);
      if fx(j) < pbest(j)
         p(j, :) = x(j, :);
         pbest(j) = fx(j);
      end
      % ����ȫ������λ�ú�����ֵ 
      if pbest(j) < gbest
         g = p(j, :);
         gbest = pbest(j);
      end
      % ����λ�ú��ٶ�ֵ  
      v(j, :) = lamda*v(j, :) + c1*rand*(p(j, :) - x(j, :)) + c2*rand*(g - x(j, :));
      x(j, :) = x(j, :) + v(j, :);
      % �߽��������� 
      for ii = 1 : D
         if (v(j, ii) > Vmax) || (v(j, ii) < Vmin)
            v(j, ii) = rand*(Vmax - Vmin) + Vmin;
         end
         if (x(j, ii) > Xmax(ii)) || (x(j, ii) < Xmin(ii))
            x(j, ii) = rand*(Xmax(ii) - Xmin(ii)) + Xmin(ii);
         end
      end
   end
end
x_opt = g;
x_opt(2) = 10^(x_opt(2));
x_opt(4) = 10^(x_opt(4));
end
 
% Ŀ�꺯��
function fitError = Obj_Fit(p0, t ,Et)
A1 = p0(1);
B1 = p0(2);
A2 = p0(3);
B2 = p0(4);
A0 = p0(5);
f = A1*exp(-t/10^B1) + A2*exp(-t/10^B2) + A0;  
fitError = norm(Et - f);
end