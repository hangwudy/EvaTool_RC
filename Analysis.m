function [Halsdicke_links,Halsdicke_rechts,Hinterschnitt_links,Hinterschnitt_rechts] = Analysis(x_oo,y_oo,x_ou,y_ou,x_uo,y_uo)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%
% Arrange for analysis
%

% Neck thickness for left and right sides
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_interp =(1:0.01:2.2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Under cut right side
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_interp_ou_right = (0.6:0.01:1.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Under cut left side

y_interp_ou_left = (0.6:0.01:1.3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%
% plot neck thickness
%

f101 = figure(101);
set(f101, 'Name', 'Neck thickness','NumberTitle','off');

Grenze_x = round(length(x_oo)/2);
Grenze_x_ou = round(length(x_ou)/2);
Grenze_x_uo = round(length(x_uo)/2);

%
% Right
%


x_oo_right = x_oo(Grenze_x:length(x_oo));
y_oo_right = y_oo(Grenze_x:length(x_oo));
x_ou_right = x_ou(Grenze_x_ou:length(x_ou));
y_ou_right = y_ou(Grenze_x_ou:length(x_ou));


x_interp_oo_right = interp1(y_oo_right, x_oo_right, y_interp); % y-x-plot
plot(x_oo_right,y_oo_right,'k-',x_interp_oo_right,y_interp,'r-')
hold on
x_interp_ou_right = interp1(y_ou_right, x_ou_right, y_interp);
plot(x_ou_right,y_ou_right,'k-',x_interp_ou_right,y_interp,'g-')


%%%%%%%%%
[Halsdicke_rechts,n] = min((x_interp_ou_right-x_interp_oo_right)); % get the number of the node
hold on
plot(x_interp_oo_right(n),y_interp(n),'o','Color','c','MarkerFaceColor', 'c','MarkerSize', 10)
hold on
plot(x_interp_ou_right(n),y_interp(n),'o','Color','m','MarkerFaceColor', 'm','MarkerSize', 10)


%
% Left
%


x_oo_left = x_oo(1:Grenze_x);
y_oo_left = y_oo(1:Grenze_x);
x_ou_left = x_ou(1:Grenze_x_ou);
y_ou_left = y_ou(1:Grenze_x_ou);

x_interp_oo_left = interp1(y_oo_left, x_oo_left, y_interp);
plot(x_oo_left,y_oo_left,'k-',x_interp_oo_left,y_interp,'r-')
hold on
x_interp_ou_left = interp1(y_ou_left, x_ou_left, y_interp);
plot(x_ou_left,y_ou_left,'k-',x_interp_ou_left,y_interp,'g-')
hold on
grid on
axis equal

[Halsdicke_links,n] = min((+x_interp_oo_left-x_interp_ou_left));
hold on
plot(x_interp_oo_left(n),y_interp(n),'o','Color','c','MarkerFaceColor', 'c','MarkerSize', 10)
hold on
plot(x_interp_ou_left(n),y_interp(n),'o','Color','m','MarkerFaceColor', 'm','MarkerSize', 10)


%
%
% Under cut
%
%

f102 = figure(102);
set(f102, 'Name', 'Undercut','NumberTitle','off');



%
% Right
%


x_ou_right = x_ou(Grenze_x_ou:length(x_uo));
y_ou_right = y_ou(Grenze_x_ou:length(x_uo));

x_interp_ou_right = interp1(y_ou_right, x_ou_right, y_interp_ou_right);
plot(x_ou_right,y_ou_right,'k-',x_interp_ou_right,y_interp_ou_right,'g-') 
hold on

[M,I]=max(x_interp_ou_right); 
y_interp_uo = (y_interp_ou_right(I):0.01:3); 

x_uo_right = x_uo(Grenze_x_uo:length(x_uo));
y_uo_right = y_uo(Grenze_x_uo:length(x_uo));


x_interp_uo_right = interp1(y_uo_right, x_uo_right, y_interp_uo);
plot(x_uo_right,y_uo_right,'k-',x_interp_uo_right,y_interp_uo,'r-') % Rot
hold on

Hinterschnitt_rechts = max(x_interp_ou_right)-min(x_interp_uo_right);
hold on

%
% critical points
%

plot(x_interp_ou_right(find(x_interp_ou_right==max(x_interp_ou_right),1,'first')),y_interp_ou_right(find(x_interp_ou_right==max(x_interp_ou_right),1,'first')),'o','Color','c','MarkerFaceColor', 'c','MarkerSize', 10) 
hold on

% 

plot(x_interp_uo_right(find(x_interp_uo_right==min(x_interp_uo_right),1,'first')),y_interp_uo(find(x_interp_uo_right==min(x_interp_uo_right),1,'first')),'o','Color','m','MarkerFaceColor', 'm','MarkerSize', 10)


%
% Left
%

x_ou_left = x_ou(1:Grenze_x_ou);
y_ou_left = y_ou(1:Grenze_x_ou);


x_interp_ou_left = interp1(y_ou_left, x_ou_left, y_interp_ou_left);
plot(x_ou_left,y_ou_left,'k-',x_interp_ou_left,y_interp_ou_left,'g-')
hold on

[M,I]=min(x_interp_ou_left);
y_interp_uo = (y_interp_ou_left(I):0.01:3);


x_uo_left = x_uo(1:Grenze_x_uo);
y_uo_left = y_uo(1:Grenze_x_uo);



x_interp_uo_left = interp1(y_uo_left, x_uo_left, y_interp_uo);
plot(x_uo_left,y_uo_left,'k-',x_interp_uo_left,y_interp_uo,'r-')
hold on
grid on
axis equal

Hinterschnitt_links = max(x_interp_uo_left)-min(x_interp_ou_left);
hold on
plot(x_interp_ou_left(find(x_interp_ou_left==min(x_interp_ou_left),1,'first')),y_interp_ou_left(find(x_interp_ou_left==min(x_interp_ou_left),1,'first')),'o','Color','c','MarkerFaceColor', 'c','MarkerSize', 10)
hold on
plot(x_interp_uo_left(find(x_interp_uo_left==max(x_interp_uo_left),1,'first')),y_interp_uo(find(x_interp_uo_left==max(x_interp_uo_left),1,'first')),'o','Color','m','MarkerFaceColor', 'm','MarkerSize', 10)




end

