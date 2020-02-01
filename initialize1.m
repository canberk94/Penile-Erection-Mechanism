% Initialization script for the circulation

T =0.0125;       %Duration of heartbeat (minutes) normal 80bpm

TS=0.0050;       %Duration of systole	(minutes)
tauS=0.0025;     %CLV time constant during systole (minutes) 
tauD=0.0075;     %CLV time constant during diastole (minutes) 


%*********************RESISTANCES*****************************************
RAo= 0.01;       %aortic valve resistance (mmHg/(liter/minute))              
RTr=0.01;        %tricuspid valve resistance (mmHg/(liter/minute))
RPu=0.01;        %pulmonic valve resistance (mmHg/(liter/minute))
Rp= 1.79;        %pulmonary vascular resistance (mmHg/(liter/minute)) 
RMi=0.01;        %mitral valve resistance (mmHg/(liter/minute)) 

%***************COMPLIANCES*****************************************            
Cpa=0.00412;     %total pulmonary arterial compliance of healthy adult (liters/mmHg) 
Cpv=0.08;        %total pulmonary venous compliance of healthy adult (liters/mmHg) 
     
% For ventricles:
CLVS=0.00003;    %Min (systolic) value of CLV (liters/mmHg) 
CLVD=0.0146;     %Max (diastolic) value of CLV (liters/mmHg)

CRVS=0.0002;     %Min (systolic) value of CRV (liters/mmHg)
CRVD=0.0365;     %Max (diastolic) value of CRV (liters/mmHg) 

%***************DEAD VOLUMES*****************************************
Vsad=0.825;     %Systemic arterial volume at P=O normal adult(liters) 
Vpad=0.0382;    %Pulmonary arterial volume at P=O normal adult (liters)
Vsvd=0;	        %Systemic venous volume at P=O normal adult (liters)
Vpvd=0;	        %Pulmonary venous volume at P=O normal adult (liters)
VLVd=0.027;     %Left ventricular volume at P=O normal adult (liters) 
VRVd=0.027;     %Right ventricular volume at P=O normal adult (liters) 

VClac=0.0225;   %Corpus cavernosum volume at P=O normal adult (liters)
VCave=0.027;    %Cavernosal artery volume at P=O normal adult (liters)      
VCven=0.075;    %Penile venule volume at P=O normal adult (liters)


dt=0.01*T;         %Time step duration (minutes)
                   %This choice implies 100 timesteps per cardiac cycle. 
klokmax=2000*T/dt; %Total number of timesteps
                   %This choice implies simulation of 2000 cardiac cycles. 

%Assign an index to each compliance vessel
%of the model circulation:
iLV=1; 
isa=2; 
isv=3; 
iRV=4; 
ipa=5; 
ipv=6;
icav=7;
ilac=8;
iven=9;
N=9;