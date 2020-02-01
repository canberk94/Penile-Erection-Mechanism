%Erection model function to predict pre- and post-injection intracavernosal
%pressure (ICP) and penile volumes, noninvasively

function par_set=erection_model(Csa,Csv,Rsys,Ccav,Ccorp,Cven,Rhel,Rcav,Rpvout,Rout)

global T TS tauS tauD;
global G dt CHECK N Pt Pt_old pavalve;
global r gamma RT cIO2 ConcO2_max P50 ConcHb ipv iLV isa isv iRV ipa ConcO2 Met bQ Vd C P;

tic

%As an example, the patient specific appropriate parameter set for the
%pre-injection phase of PATIENT 1. Compliance unit: lt/mmHg; Resistance
%unit: mmHg/(liter/minute)

Csa=0.0013;                 %Systemic arterial compliance            
Csv=0.4229;                 %Systemic venous compliance
Rsys=14.0449;               %Systemic vascular resistance
Ccav=1e-6;                  %Cavernosal artery compliance
Ccorp=0.0012;               %Corporeal compliance
Cven=1.0275e-5;             %Penile venules compliance
Rhel=4840.3;                %Helicine arteries resistance
Rcav=15147;                 %Cavernosal arteries resistance
Rpvout=1891;                %Penile venules resistance
Rout=180.8991;              %Systemic venous resistance

%As an example, the patient specific appropriate parameter set for the
%post-injection phase of PATIENT 1

Csa=0.0013;
Csv=0.38;
Rs=14;
Ccav=2.4e-6;
Ccorp=9.34e-4;
Cven=2.19e-5;
Rhel=500;
Rcav=1656;
Rpvout=1750;
Rout=1130;

initialize1
in_circ

mainloop    
sel_val
issa=isa

maxPisa=Psummary(issa,1);       %max pressure of systemic artery (isa)
meanPisa=Psummary(issa,2);      %mean pressure of systemic artery (isa)
minPisa=Psummary(issa,3);       %min pressure of systemic artery (isa)
meanPicav=Psummary(icav,2);     %mean pressure of cavernosal artery (icav)
meanPiven=Psummary(iven,2);     %mean pressure of penis venous (iven)
meanPilac=Psummary(ilac,2);     %mean cavernosal pressure (mmHg)

meanViven=Vsummary(iven,2);     %mean penile venule volume (lt)
meanVilac=Vsummary(ilac,2);     %mean corpus cavernosum volume (lt)
meanVicav=Vsummary(icav,2);     %mean cavernosal artery volume (lt)

maxQjk=Qsummary(jk,1);                              %systolic cavernosal artery flow (lt/min)
minQjk=Qsummary(jk,3);                              %diastolic cavernosal artery flow (lt/min)
meanQjs=Qsummary(js,2)+((maxQjk+minQjk)/2);         %mean aortic (systemic) flow (lt/min)


par_set=[meanPilac, meanVilac, meanViven];

% par_set=[maxPisa, meanPisa, minPisa, meanPicav, meanPilac, meanPiven, ...
%     meanPisv, meanQjp, meanQjs, maxQjk, meanQjk, minQjk, meanQjinlet, ...
%     meanVilac, meanVicav];

t_plot
format long
format short
toc
end