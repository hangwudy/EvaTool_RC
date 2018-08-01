function [ Halsdicke_links,Halsdicke_rechts,Hinterschnitt_links,Hinterschnitt_rechts ] = Analysis_SIMULATION( x_oo_final,y_oo_final,x_ou_final,y_ou_final,x_uo_final,y_uo_final )
% Summary of this function goes here
%   Detailed explanation goes here


%
% plot neck thickness
%

f201 = figure(201);
set(f201, 'Name', 'Neck thickness','NumberTitle','off');

Grenze_x = round(length(x_oo_final)/2);



%
% Links
%

y_interp =(0.6:0.01:2.2);


x_oo_links = x_oo_final(Grenze_x:round(length(x_oo_final)*4/5)); 
y_oo_links = y_oo_final(Grenze_x:round(length(y_oo_final)*4/5));
x_ou_links = x_ou_final(Grenze_x:round(length(x_ou_final)*4/5));
y_ou_links = y_ou_final(Grenze_x:round(length(y_ou_final)*4/5));

x_interp_oo_links = interp1(y_oo_links, x_oo_links, y_interp); % y-x-plot
plot(x_oo_links,y_oo_links,'k-',x_interp_oo_links,y_interp,'r-')
hold on
x_interp_ou_links = interp1(y_ou_links, x_ou_links, y_interp);
plot(x_ou_links,y_ou_links,'k-',x_interp_ou_links,y_interp,'g-')


%%%%%%%%%
[Halsdicke_links,n] = min((x_interp_oo_links-x_interp_ou_links)); % get the number of the node
hold on
plot(x_interp_oo_links(n),y_interp(n),'o','Color','c','MarkerFaceColor', 'c','MarkerSize', 10)
hold on
plot(x_interp_ou_links(n),y_interp(n),'o','Color','m','MarkerFaceColor', 'm','MarkerSize', 10)
%
% Rechta
%



x_oo_rechts = x_oo_final(round(length(x_oo_final)*1/5):Grenze_x);
y_oo_rechts = y_oo_final(round(length(y_oo_final)*1/5):Grenze_x);
x_ou_rechts = x_ou_final(round(length(x_ou_final)*1/5):Grenze_x);
y_ou_rechts = y_ou_final(round(length(y_ou_final)*1/5):Grenze_x);

% ------------------------------------------------------------------------

x_interp_oo_rechts = interp1(y_oo_rechts, x_oo_rechts, y_interp);
plot(x_oo_rechts,y_oo_rechts,'k-',x_interp_oo_rechts,y_interp,'r-')
hold on
x_interp_ou_rechts = interp1(y_ou_rechts, x_ou_rechts, y_interp);
plot(x_ou_rechts,y_ou_rechts,'k-',x_interp_ou_rechts,y_interp,'g-')
hold on
grid on
axis equal

[Halsdicke_rechts,n] = min((x_interp_ou_rechts-x_interp_oo_rechts));
hold on
plot(x_interp_oo_rechts(n),y_interp(n),'o','Color','c','MarkerFaceColor', 'c','MarkerSize', 10)
hold on
plot(x_interp_ou_rechts(n),y_interp(n),'o','Color','m','MarkerFaceColor', 'm','MarkerSize', 10)



%
%
% Under cut
%
%

f202 = figure(202);
set(f202, 'Name', 'Undercut','NumberTitle','off');



%
% Right
%

y_interp_ou = (0.6:0.01:1.5);

x_ou_links = x_ou_final(Grenze_x:round(length(x_ou_final)*4/5)); 
y_ou_links = y_ou_final(Grenze_x:round(length(y_ou_final)*4/5));

% ------------------------------------------------------------------------

x_interp_ou_links = interp1(y_ou_links, x_ou_links, y_interp_ou);
plot(x_ou_links,y_ou_links,'k-',x_interp_ou_links,y_interp_ou,'g-') % Grün
hold on

[M,I]=min(x_interp_ou_links); % was bedeutet [M,I]??
y_interp_uo = (y_interp_ou(I):0.01:3); % in order to get I


x_uo_links = x_uo_final(Grenze_x:round(length(x_uo_final)*4/5));
y_uo_links = y_uo_final(Grenze_x:round(length(y_uo_final)*4/5));

% ------------------------------------------------------------------------



x_interp_uo_links = interp1(y_uo_links, x_uo_links, y_interp_uo);
plot(x_uo_links,y_uo_links,'k-',x_interp_uo_links,y_interp_uo,'r-') % Rot
hold on

Hinterschnitt_links = -min(x_interp_ou_links)+max(x_interp_uo_links);
hold on
% kritische Punkte markieren
plot(x_interp_ou_links(find(x_interp_ou_links==min(x_interp_ou_links),1,'first')),y_interp_ou(find(x_interp_ou_links==min(x_interp_ou_links),1,'first')),'o','Color','c','MarkerFaceColor', 'c','MarkerSize', 10) 
hold on
% 
plot(x_interp_uo_links(find(x_interp_uo_links==max(x_interp_uo_links),1,'first')),y_interp_uo(find(x_interp_uo_links==max(x_interp_uo_links),1,'first')),'o','Color','m','MarkerFaceColor', 'm','MarkerSize', 10)

%
% Rechts
%

y_interp_ou = (0.6:0.01:1.3);

x_ou_rechts = x_ou_final(round(length(x_ou_final)*1/5):Grenze_x);
y_ou_rechts = y_ou_final(round(length(y_ou_final)*1/5):Grenze_x);

% ------------------------------------------------------------------------
x_interp_ou_rechts = interp1(y_ou_rechts, x_ou_rechts, y_interp_ou);
plot(x_ou_rechts,y_ou_rechts,'k-',x_interp_ou_rechts,y_interp_ou,'g-')
hold on

[M,I]=max(x_interp_ou_rechts);
y_interp_uo = (y_interp_ou(I):0.01:3);


x_uo_rechts = x_uo_final(round(length(x_uo_final)*1/5):Grenze_x);
y_uo_rechts = y_uo_final(round(length(y_uo_final)*1/5):Grenze_x);


x_interp_uo_rechts = interp1(y_uo_rechts, x_uo_rechts, y_interp_uo);
plot(x_uo_rechts,y_uo_rechts,'k-',x_interp_uo_rechts,y_interp_uo,'r-')
hold on
grid on
axis equal

Hinterschnitt_rechts = max(x_interp_ou_rechts)-min(x_interp_uo_rechts);
hold on
plot(x_interp_ou_rechts(find(x_interp_ou_rechts==max(x_interp_ou_rechts),1,'first')),y_interp_ou(find(x_interp_ou_rechts==max(x_interp_ou_rechts),1,'first')),'o','Color','c','MarkerFaceColor', 'c','MarkerSize', 10)
hold on
plot(x_interp_uo_rechts(find(x_interp_uo_rechts==min(x_interp_uo_rechts),1,'first')),y_interp_uo(find(x_interp_uo_rechts==min(x_interp_uo_rechts),1,'first')),'o','Color','m','MarkerFaceColor', 'm','MarkerSize', 10)









































end

