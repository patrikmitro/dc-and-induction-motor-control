%% Riadenie jednosmerného cudzobudeného motora
% Regulované pohony 2026/2027
% 07.10.2026
% Zadanie 1 - motor 7. dvojica
clear; clc;
format compact;

%% Parametre motora (7. dvojica)
Ua=420;                    % napatie kotvy [V]
n=2810;                    % nominalne otacky [ot/min]
P=46;                      % vykon [kW]
M=156;                     % nominalny moment [Nm]
JM=0.29;                   % moment zotrvacnosti motora [kgm2]
J=6*JM;                    % celkovy moment zotrvacnosti [kgm2]
I=121;                     % nominalny prud [A]
Ra=0.131;                  % odpor kotvoveho vinutia [Ohm]
La=0.0020;                 % indukcnost kotvoveho vinutia [H]
Ka=1/Ra                    % zosilnenie kotvy [1/Ohm]
Ta=La/Ra                   % casova konstanta kotvy [s]
w=n/9.55;                  % nominalna uhlova rychlost [rad/s]
cfi=(Ua-Ra*I)/w            % konstanta motora [Vs/rad]
Ktm=100;                   % zosilnenie tyristoroveho menica [V/V]
Ttm=0.005;                 % casova konstanta tyristoroveho menica [s]
Imax=2*I;                  % maximalny pripustny prud [A]

%% Pomocné výpočty
KI=10/Imax                 % prenos snimaca prudu [V/A]
Kw=10/(1.5*w)                    % prenos snimaca rychlosti [Vs/rad] (bez odbudzovania: wmax = wN)
UIamax=KI*Imax             % obmedzenie zelaneho prudu (vystup reg. rychlosti) [V]

%% Kritérium optimálneho modulu - regulátor prúdu kotvy
% kompenzuje sa vacsia casova konstanta (Ta > Ttm)
TR=Ta                              % pomocna casova konstanta regulatora [s]
Kr=Ta/(2*Ttm*Ktm*Ka*KI)            % zosilnenie regulatora [-]
Ti=TR/Kr                           % integracna casova konstanta [s]
% PI regulator: F_R(s) = Kr + 1/(s*Ti) = Kr*(1+s*TR)/(s*TR)

%% Kritérium symetrického optima - regulátor rýchlosti
% podradena prudova slucka zjednodusena na (1/KI)/(1+s*2*Ttm)
% T1 = 2*Ttm (mensia), T2 = J, K = cfi*Kw/KI
TRw=4*(2*Ttm)                      % pomocna casova konstanta regulatora [s]
KRw=J*KI/(2*(2*Ttm)*cfi*Kw)        % zosilnenie regulatora [-]
TIw=TRw/KRw                        % integracna casova konstanta [s]
Tt=TIw                             % konstanta ARW (back-calculation) [s]

Ktm = 100;
Ttm = 0.005;
