

function main
%変数の初期値
x10 = 0;
x20 = 0;
x1m0 = 0;
x2m0 = 0;
x1t0 = 0;
x2t0 = 0;
sekibun = 0;
for i = 1:4
    r1 = 0.5*i;
%delta = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X0=[x10,x20,x1m0,x2m0,r1,x1t0,x2t0,sekibun];
[t,xf] = ode45(@sub,0:0.01:100,X0);%微分方程式を解く
%[t,xf2] = ode45(@sub2,0:0.01:100,X0);%微分方程式を解く

figure(1)
plot(t,xf(:,1),'linewidth',1,'Color','k');
xlabel('time','FontSize',16);
ylabel('y','FontSize',16);
hold on
axis([0 20 -0.2 1.4])

figure(1)
plot(t,xf(:,3),'linewidth',1,'linestyle','-.','Color','k');
xlabel('time','FontSize',16);
ylabel('y','FontSize',16);
hold on
%plot(t,xf(:,4),'linewidth',1,'linestyle','-.','Color','k');
%hold on
axis([0 20 -0.2 1.4])

figure(2)
plot(t,xf(:,3),'linewidth',1,'linestyle','-.','Color','k');
xlabel('time','FontSize',16);
ylabel('y','FontSize',16);
hold on
%plot(t,xf(:,4),'linewidth',1,'linestyle','-.','Color','k');
%hold on
axis([0 20 -0.2 1.4])

figure(3)
plot(t,xf(:,3),'linewidth',1,'linestyle','-.','Color','k');
xlabel('time','FontSize',16);
ylabel('y','FontSize',16);
hold on
%plot(t,xf(:,4),'linewidth',1,'linestyle','-.','Color','k');
%hold on
axis([0 20 -0.2 1.4])

figure(3)
plot(t,xf(:,6),'linewidth',1,'Color','k');
xlabel('time','FontSize',16);
ylabel('y','FontSize',16);
hold on
axis([0 20 -0.2 1.4])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end    

%%%%%%%%%%%%%%%%%%%%%%%%%% 関数 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dxf = sub(t,xf)
x1 = xf(1);
x2 = xf(2);
x1m = xf(3);
x2m = xf(4);
r1 = xf(5);
x1t = xf(6);
x2t = xf(7);
sekibun = xf(8);

%Delta1 = 0.1+0.1*sin(t);Delta2 = 0;Delta3 = 0; % case 1　実線
%Delta1 = 0; Delta2 = 0.2*sin(0.5*t);Delta3 = 0; % case 2　破線
%Delta1 = 0;Delta2 = 0;Delta3 = 0.1*sin(2*t); % case 3 点線
%Delta1 = 0.2+0.2*sin(t); Delta2 = 0.5*sin(0.5*t);
%Delta1 = 0.2+0.2*sin(t); Delta2 = 0.2*sin(0.5*t);Delta3 = 0.1*sin(2*t); % case 4 全部
eps = 0.1;
if t > 7
    d = 0.1;
else
    d = 0;
end

F1 = -2;
F2 = -3;

K1 = -100;
K2 = -10;

r = F1*x1m+F2*2*sin(0.5*x2m)+r1;%6;
%r = sin(t);
u1 = (x1m^3+2*x2m)/cos(x1m)+r/cos(0.5*x2m)/cos(x1m);
%u2 = 0;
u2 = K1*(x1-x1m)+K2*sekibun;
%u1 = r1;

rt=F1*x1t+F2*2*sin(0.5*x2t)+r1;

u1t=(x1t^3+2*x2t)/cos(x1t)+rt/cos(0.5*x2t)/cos(x1t);

dxf = zeros(7,1);

dxf(1) = 2*sin(0.5*x2)+d;
%dxf(2) = Delta1-x1^3-n*x2+(1+Delta2)*cos(x1)*(u1+u2);
dxf(2) = -x1^3-2*x2+eps*x1+(1)*cos(x1)*(u1+u2);
dxf(3) = 2*sin(0.5*x2m);
dxf(4) = -x1m^3-2*x2m+cos(x1m)*(u1);
dxf(5) = 0;
dxf(6) = 2*sin(0.5*x2t)+d;
%dxf(7) = Delta1-x1t^3-n*x2t+(1+Delta2)*cos(x1t)*(u1t);
dxf(7) = -x1t^3-2*x2t+eps*x1t+(1)*cos(x1t)*(u1t);
dxf(8) = x1-x1m;