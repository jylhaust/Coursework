%% -------------------------------------
clc;clear;
load allData.mat;
% keyPoint = load('data1.txt');
commuSta = load('data2.txt');
% getPos = ceil(keyPoint*1000/38.2);
 for cnt = 1:72
    t1(cnt) = ceil(commuSta(cnt,1)*1000/38.2);
    t2(cnt) = ceil(commuSta(cnt,2)*1000/38.2);
    if t2(cnt) >ceil(110*1000/38.2);
        t2(cnt) =ceil(110*1000/38.2);
    end
    commuAlti(cnt) = allData(t1(cnt),t2(cnt)); %获得地面站的高度
 end
%  plot(commuSta(:,1),commuSta(:,2),'*');hold on; %% 移动通信地点
%  axis([20,110,0,110]);
 
 %-----------基地位置--------------
hig = allData(ceil(106*1000/38.2),1);
H = [110,0,hig];
plot3(H(1),H(2),H(3),'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.5,0.5,0.5])
hold on;
 %--------------传输计算------------------
 rol = 4.314*10^-10;
 dataVolu = 500*10^6;
 powToa = 5;
 linkNum = 10;
 powPer = powToa /linkNum;
 eucDis = 3000;
 brandWh = commuSta(:,3);
 volTrans = brandWh*log2(1+powPer/(rol*eucDis^2));
%  timeTrans
 %--------------plot绘图-------------------
 x = commuSta(:,1);
 y = commuSta(:,2);
 z = commuAlti';
%  scatter(x,y,20,z,'r');
%  axis([20,110,0,110]);
%  hold on;
% plot(x,y,'*')

corr = [x y z];
[idx,centr]=kmeans(corr,3); 

%最后显示聚类后的数据
% figure;

for i=1:size(corr,1) 
    tmp = corr(i,:);
    if idx(i)==1   
         plot3(tmp(:,1),tmp(:,2),tmp(:,3),'ro'); 
    elseif idx(i)==2
         plot3(tmp(:,1),tmp(:,2),tmp(:,3),'g+'); 
    else 
         plot3(tmp(:,1),tmp(:,2),tmp(:,3),'b*'); 
    end
    hold on;
end
% legend('基地','一类','二类','三类');
% [X,Y,Z] = griddata(x,y,z,linspace(20,110)',linspace(0,120),'v4' );    
% hold on;
% pcolor(X,Y,Z); shading interp;
% contourf(X,Y,Z);
% figure(4),surf(X,Y,Z);
 