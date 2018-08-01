function [x_oo_final,y_oo_final,x_ou_final,y_ou_final,x_uo_final,y_uo_final,x_uu_final,y_uu_final,achsenabschnitt,Halsdicke_links,Halsdicke_rechts,Hinterschnitt_links,Hinterschnitt_rechts] = CP_Analyse(Dateipfad,Versuchsnummer,Color,M_Node, M_S, M_N, M_U, Vergroesserung)

% test
% display(M_Node)
% test
% display(Vergroesserung)

% for debugging

% 
% if Versuchsnummer == M_Node(1,1)
%     disp('Analysis begins');
% end

%str1 = ['Analyzing test ',Versuchsnummer,'.'];
disp(['Analyzing test ',Versuchsnummer,'.'])

% Summary of this function goes here
% Detailed explanation goes here

Dateiname = sprintf('%s/Output-Nr-%s_oo_start.txt',Dateipfad,Versuchsnummer);
M_start = dlmread(Dateiname,';',0,0);
clearvars Dateiname
Dateiname = sprintf('%s/Output-Nr-%s_oo_final.txt',Dateipfad,Versuchsnummer);
M_final = dlmread(Dateiname,';',0,0);
M = [M_start,M_final];
M = sortrows(M,1);

x_oo = -M(:,4);
y_oo = M(:,5);
z_oo = M(:,6);

% hold on
% plot(x_oo,y_oo,'.')

clearvars Dateiname M_start M_final M

Dateiname = sprintf('%s/Output-Nr-%s_ou_start.txt',Dateipfad,Versuchsnummer);
M_start = dlmread(Dateiname,';',0,0);
clearvars Dateiname
Dateiname = sprintf('%s/Output-Nr-%s_ou_final.txt',Dateipfad,Versuchsnummer);
M_final = dlmread(Dateiname,';',0,0);
M = [M_start,M_final];
M = sortrows(M,1);

x_ou = -M(:,4);
y_ou = M(:,5);
z_ou = M(:,6);

% hold on
% plot(x_ou,y_ou,'.')

clearvars Dateiname M_start M_final M

Dateiname = sprintf('%s/Output-Nr-%s_uo_start.txt',Dateipfad,Versuchsnummer);
M_start = dlmread(Dateiname,';',0,0);
clearvars Dateiname
Dateiname = sprintf('%s/Output-Nr-%s_uo_final.txt',Dateipfad,Versuchsnummer);
M_final = dlmread(Dateiname,';',0,0);
M = [M_start,M_final];
M = sortrows(M,1);

x_uo = -M(:,4);
y_uo = M(:,5);
z_uo = M(:,6);

% hold on
% plot(x_uo,y_uo,'.')

clearvars Dateiname M_start M_final M

Dateiname = sprintf('%s/Output-Nr-%s_uu_start.txt',Dateipfad,Versuchsnummer);
M_start = dlmread(Dateiname,';',0,0);
clearvars Dateiname
Dateiname = sprintf('%s/Output-Nr-%s_uu_final.txt',Dateipfad,Versuchsnummer);
M_final = dlmread(Dateiname,';',0,0);
M = [M_start,M_final];
M = sortrows(M,1);

x_uu = -M(:,4);
y_uu = M(:,5);
z_uu = M(:,6);

% figure(1)
% plot(x_uu,y_uu,'.')


% Ausrichten des Clinchpunktes an Clinchpunktunterseite unten
% Grund: Hinterschnitt und Halsdicke ausrechnen.

% Ermittlung der Verdrehung durch Unterblech Unterseite
% ------------------------------------------------------------------------
[xData, yData] = prepareCurveData( x_uu, y_uu );

% Diese Punkte werden weggenommen
% ------------------------------------------------------------------------
% für unterschiedliche Skalierungen:
% manuel eingeben, versuchen
% Skalierung kann die Nummer unterschiedlich sein


% if isempty(M_Node)
%     excluded = [1:45, 95:140]; % für Skalierung = 1, für unterschiedliche
% else
[Test_row,] = find(M_Node(:,1) == str2double(Versuchsnummer));
% display(Test_row);
node_1 = M_Node(Test_row,2);
node_2 = M_Node(Test_row,3);
node_end = M_Node(Test_row,4);
excluded = [1:node_1, node_2:node_end];
% test
% display(excluded);
clearvars Test_row node_1 node_2
% end

% ------------------------------------------------------------------------

% Set up fittype and options.
ft = fittype( 'm*x+c', 'independent', 'x', 'dependent', 'y' ); % linearisieren
ex = excludedata( xData, yData, 'Indices', excluded ); % A vector of indices specifying the data points to be excluded.
opts = fitoptions( 'Method', 'NonlinearLeastSquares' ); % Create Fit Options for Linear Least Squares
opts.Display = 'Off';
opts.StartPoint = [0.530632706642293 0.913375856139019];
opts.Exclude = ex; % Points to exclude from the fit

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts ); % fitresult ist Steigung? --> m = Steigung, c = Konstante, die beiden in Gleichung m*x+c


% Plot fit with data.
% =========================================================================
% =========================================================================
f100 = figure(100);
set(f100, 'Name', 'Line fitting', 'NumberTitle','off');
% =========================================================================
% =========================================================================
% handles_of_AuswertungsGUI = guihandles(Auswertungstool);
% axes(handles_of_AuswertungsGUI.axes1);

hold on
plot( fitresult, xData, yData, ex )
legend('off')
hold on
grid on
axis equal
hold off
alpha = -atan(fitresult.m); % Steigung
achsenabschnitt = fitresult.c; % c-Konstante
% Drehung um alpha -> Drehmatrix -> http://www.mathebibel.de/drehmatrix
% im Uhrzeigersinn? --> Ja
x_oo_gedreht = x_oo*cos(alpha)-y_oo*sin(alpha);
y_oo_gedreht = x_oo*sin(alpha)+y_oo*cos(alpha);
x_ou_gedreht = x_ou*cos(alpha)-y_ou*sin(alpha);
y_ou_gedreht = x_ou*sin(alpha)+y_ou*cos(alpha);
x_uo_gedreht = x_uo*cos(alpha)-y_uo*sin(alpha);
y_uo_gedreht = x_uo*sin(alpha)+y_uo*cos(alpha);
x_uu_gedreht = x_uu*cos(alpha)-y_uu*sin(alpha);
y_uu_gedreht = x_uu*sin(alpha)+y_uu*cos(alpha);

% Boden zu y=0 verschieben
% Set up fittype and options.
[xData, yData] = prepareCurveData( x_uu_gedreht, y_uu_gedreht );

ft = fittype( 'm*x+c', 'independent', 'x', 'dependent', 'y' );
ex = excludedata( xData, yData, 'Indices', excluded );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.530632706642293 0.913375856139019];
opts.Exclude = ex;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts ); % returns goodness-of-fit statistics in the structure gof

x_oo_final = x_oo_gedreht;
y_oo_final = y_oo_gedreht-fitresult.c;
x_ou_final = x_ou_gedreht;
y_ou_final = y_ou_gedreht-fitresult.c;
x_uo_final = x_uo_gedreht;
y_uo_final = y_uo_gedreht-fitresult.c;
x_uu_final = x_uu_gedreht;
y_uu_final = y_uu_gedreht-fitresult.c;

i=1;
j=1;

% Schnitt des interessanten Bereichs, original: 1.0 bis 1.8 mm Höhe. 

% ------------------------------------------------------------------------

% while i<=length(x_uu_final)
%     if y_uu_final(i)<1.8 && y_uu_final(i)>1 && x_uu_final(i)<0 
%         x_delta(j)=x_uu_final(i);
%         j=j+1;
%     end
% i=i+1;
% end
% ------------------------------------------------------------------------
% M_S Scope
% test
% display(M_S)

x_uu_1 = M_S(1,1);
x_uu_2 = M_S(1,2);
y_uu_1 = M_S(2,1);
y_uu_2 = M_S(2,2);



%
while i<=length(x_uu_final)
    if y_uu_final(i)<y_uu_2 && y_uu_final(i)>y_uu_1 && x_uu_final(i)<x_uu_2  && x_uu_final(i) > x_uu_1
        x_delta(j)=x_uu_final(i);
        j=j+1;
    end
i=i+1;
end

x_deltamean = mean(x_delta); % negativ

x_oo_final = x_oo_gedreht-x_deltamean; % nach rechts verschieben?
x_ou_final = x_ou_gedreht-x_deltamean;
x_uo_final = x_uo_gedreht-x_deltamean;
x_uu_final = x_uu_gedreht-x_deltamean;

% Berechnung Halsdicke
% Auswahl der Knoten für Halsdickenberechnung
% =========================================================================
% =========================================================================
f101 = figure(101);
set(f101, 'Name', 'Neck thickness','NumberTitle','off');
%figure('Name', 'Halsdicke')
% =========================================================================
% =========================================================================

% handles_of_AuswertungsGUI = guihandles(Auswertungstool);
% axes(handles_of_AuswertungsGUI.axes_2);


Grenze_x = round(length(x_oo_gedreht)/2);

% für Blechdicke = 1 mm?
% M_N Neck Thickness
% test
% display(M_N)

if isempty(M_N)
    y_interp =(0.8:0.01:3);
else
    y_nt_1 = M_N(1,1);
    y_nt_2 = M_N(1,2);
    y_interp =(y_nt_1:0.01:y_nt_2);
    clearvars y_nt_1 y_nt_2
end
% (1.2:0.01:3);

% n=1;
% Punkte links
% ------------------------------------------------------------------------
% original:
if Vergroesserung
    x_oo_links = x_oo_final(Grenze_x:length(x_oo_gedreht));
    y_oo_links = y_oo_final(Grenze_x:length(x_oo_gedreht));
    x_ou_links = x_ou_final(Grenze_x:length(x_oo_gedreht));
    y_ou_links = y_ou_final(Grenze_x:length(x_oo_gedreht));
else
    x_oo_links = x_oo_final(Grenze_x:round(length(x_oo_gedreht)*4/5)); 
    y_oo_links = y_oo_final(Grenze_x:round(length(x_oo_gedreht)*4/5));
    x_ou_links = x_ou_final(Grenze_x:round(length(x_oo_gedreht)*4/5));
    y_ou_links = y_ou_final(Grenze_x:round(length(x_oo_gedreht)*4/5));
end


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

% n=1; % ???
% Punkte rechts
% ------------------------------------------------------------------------
if Vergroesserung
    x_oo_rechts = x_oo_final(1:Grenze_x);
    y_oo_rechts = y_oo_final(1:Grenze_x);
    x_ou_rechts = x_ou_final(1:Grenze_x);
    y_ou_rechts = y_ou_final(1:Grenze_x);
else
    x_oo_rechts = x_oo_final(round(length(x_oo_gedreht)*1/5):Grenze_x);
    y_oo_rechts = y_oo_final(round(length(x_oo_gedreht)*1/5):Grenze_x);
    x_ou_rechts = x_ou_final(round(length(x_oo_gedreht)*1/5):Grenze_x);
    y_ou_rechts = y_ou_final(round(length(x_oo_gedreht)*1/5):Grenze_x);
end


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



% Berechnung Hinterschnitt
% Auswahl der Knoten für Hinterschnittberechnung
% =========================================================================
% =========================================================================
f102 = figure(102);
set(f102, 'Name', 'Undercut','NumberTitle','off');
% =========================================================================
% =========================================================================

% handles_of_AuswertungsGUI = guihandles(Auswertungstool);
% axes(handles_of_AuswertungsGUI.axes_3);



% Punkte links



% M_U Undercut
% test
% display(M_U)

if isempty(M_U)
    y_interp_ou = (0.6:0.01:1.5);% für Skalierung = 1
else
    y_uc_left_1 = M_U(1,1);
    y_uc_left_2 = M_U(1,2);
    y_interp_ou = (y_uc_left_1:0.01:y_uc_left_2);
    clearvars y_uc_left_1 y_uc_left_2
end





% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% y_interp_ou = (0.25:0.01:0.8); % für Versuchsnummer 200 bis 203

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ------------------------------------------------------------------------
% original:
% 
% y_interp_ou = (0.6:0.01:1.5);
if Vergroesserung
    x_ou_links = x_ou_final(Grenze_x:length(x_uo_gedreht));
    y_ou_links = y_ou_final(Grenze_x:length(x_uo_gedreht));
else
    x_ou_links = x_ou_final(Grenze_x:round(length(x_uo_gedreht)*4/5)); 
    y_ou_links = y_ou_final(Grenze_x:round(length(x_uo_gedreht)*4/5));
end
% ------------------------------------------------------------------------

x_interp_ou_links = interp1(y_ou_links, x_ou_links, y_interp_ou);
plot(x_ou_links,y_ou_links,'k-',x_interp_ou_links,y_interp_ou,'g-') % Grün
hold on

[M,I]=min(x_interp_ou_links); % was bedeutet [M,I]??
y_interp_uo = (y_interp_ou(I):0.01:3); % in order to get I
% ------------------------------------------------------------------------
% original:
%
if Vergroesserung
    x_uo_links = x_uo_final(Grenze_x:length(x_uo_gedreht));
    y_uo_links = y_uo_final(Grenze_x:length(x_uo_gedreht));
% ------------------------------------------------------------------------

else
    x_uo_links = x_uo_final(Grenze_x:round(length(x_uo_gedreht)*4/5));
    y_uo_links = y_uo_final(Grenze_x:round(length(x_uo_gedreht)*4/5));
end

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

% Punkte rechts
% ------------------------------------------------------------------------



if isempty(M_U)
    y_interp_ou = (0.6:0.01:1.3); %(0.6:0.01:1.5); % für Skalierung = 1
else
    y_uc_right_1 = M_U(2,1);
    y_uc_right_2 = M_U(2,2);
    y_interp_ou = (y_uc_right_1:0.01:y_uc_right_2);
    clearvars y_uc_right_1 y_uc_right_2
end

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% y_interp_ou = (0.25:0.01:1.0); % für Versuchsnummer 200 bis 203

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% original:
if Vergroesserung
    x_ou_rechts = x_ou_final(1:Grenze_x);
    y_ou_rechts = y_ou_final(1:Grenze_x);

% ------------------------------------------------------------------------
else
    x_ou_rechts = x_ou_final(round(length(x_uo_gedreht)*1/5):Grenze_x);
    y_ou_rechts = y_ou_final(round(length(x_uo_gedreht)*1/5):Grenze_x);
end
% ------------------------------------------------------------------------
x_interp_ou_rechts = interp1(y_ou_rechts, x_ou_rechts, y_interp_ou);
plot(x_ou_rechts,y_ou_rechts,'k-',x_interp_ou_rechts,y_interp_ou,'g-')
hold on

[M,I]=max(x_interp_ou_rechts);
y_interp_uo = (y_interp_ou(I):0.01:3);



% ------------------------------------------------------------------------
% original:
% 
if Vergroesserung
    x_uo_rechts = x_uo_final(1:Grenze_x);
    y_uo_rechts = y_uo_final(1:Grenze_x);

% ------------------------------------------------------------------------
else
    x_uo_rechts = x_uo_final(round(length(x_uo_gedreht)*1/5):Grenze_x);
    y_uo_rechts = y_uo_final(round(length(x_uo_gedreht)*1/5):Grenze_x);
end
% ------------------------------------------------------------------------

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

% str2 = ['The analysis of test ',Versuchsnummer, ' is accomplished.'];
display(['The analysis of test ',Versuchsnummer, ' is accomplished.']);

% if Versuchsnummer == M_Node(end,1)
%     disp('Analysis is accomplished');
% end
end