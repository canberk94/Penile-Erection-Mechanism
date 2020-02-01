%Enter parameters and initial values
%into correct slots in arrays.
%Note that the code that follows is independent
%of the specific numbering scheme chosen above. 

%Pressure vector (initial values) at end of diastole: 
P=zeros(N,1);                            %This makes P a column vector of length N.
P(iLV)= 59;
P(isa)= 40;
P(isv)= 2; 
P(iRV)= 2; 
P(ipa)= 8;
P(ipv)= 5;
P(icav)= 5;
P(ilac)= 5;
P(iven)= 5;
P;                    %This writes the result on the screen.


%Thoracic Pressure vector (initial values) at end of diastole: 
Pt=zeros(N,1);        %This makes P a column vector of length N.
Pt(iLV)= 0;
Pt(isa)= 0; 
Pt(isv)= 0;  
Pt(iRV)= 0;  
Pt(ipa)= 0;
Pt(ipv)= 0;
Pt(icav)= 0;
Pt(ilac)= 0;
Pt(iven)= 0;
Pt;

%Compliance vector:
C=zeros(N,1);
C(iLV)=CV_now(0,CLVS,CLVD); %initial value 
C(isa)=Csa;
C(isv)=Csv;
C(iRV)=CV_now(0,CRVS,CRVD); %initial value 
C(ipa)=Cpa;
C(ipv)=Cpv;
C(icav)= Ccav;
C(ilac)= Ccorp;
C(iven)= Cven;
C;                           %This writes the result on the screen.

%Vector of dead volumes (volume at zero pressure);
%Note: Vd is only needed for output purposes. 
%It drops out of the equations we solve for P, 
%but we need it if we want to output (e.g., plot) 
%the volume of any compliance vessel.
Vd=zeros (N,1);
%This makes Vd a column vector of length N. 
Vd(iLV)=VLVd;
Vd(isa)=Vsad;
Vd(isv)=Vsvd;
Vd(iRV)=VRVd;
Vd(ipa)=Vpad;
Vd(ipv)=Vpvd;

Vd(icav)= VCave;
Vd(ilac)= VClac;
Vd(iven)= VCven;

%Conductance matrix:
G=zeros(N,N);
%This makes G an NxN matrix filled with zeros. 
%Any element of G that is not explicitly
%made nonzero remains zero,
%thus modeling an infinite resistance connection, 
%that is, no connection at all. 
G(iLV,isa)=1/RAo; %But G(isa,iLV)=O (no leak) 
G(isa,isv)=1/Rs;  %no valve
G(isv,isa)=1/Rs;  %no valve
G(isv,iRV)=1/RTr; %But G(iRV,isv)=O; (no leak) 
G(iRV,ipa)=1/RPu; %But G(ipa,iRV)=O; (no leak) 
G(ipa,ipv)=1/Rp;  %no valve
G(ipv,ipa)=1/Rp;  %no valve
G(ipv,iLV)=1/RMi; %But G(iLV,ipv)=O; (no leak) 

G(isa,icav)=1/Rhel;
G(icav,isa)=1/Rhel;

G(ilac,icav)=1/Rcav;
G(icav,ilac)=1/Rcav;

G(ilac,iven)=1/Rpvout;
G(iven,ilac)=1/Rpvout;

G(isv,iven)=1/Rout;
G(iven,isv)=1/Rout;
G;                  %This writes the result on the screen. 

%Matrix of initial valve states:
S=zeros(N,N);
%This makes S an NxN matrix filled with zeros 
%(and writes it on the screen).
%Start with all valves closed.
%Valves will adjust to pressures
%during first time step.
%Initialize arrays to store data for plotting:
t_plot=zeros(1,klokmax); 
C_plot=zeros(N,klokmax); 
P_plot=zeros(N,klokmax);
CO2_plot=zeros(N,klokmax);
CCO2_plot=zeros(N,klokmax);
%Other variables that we might want to plot 
%can be found from these.
%For self-checking in P_new, set CHECK=l. 
%To skip self-checking set CHECK=0.
%(should be much faster with CHECK=0)
CHECK=0;
jAo=1 ;
js =2;
jTr=3; 
jPu=4; 
jp =5; 
jMi=6;
jk=7; 
jinlet=8; 
jlacout =9; 
jouf=10;
Nflows=10;

%note index of upstream and downstream chamber 
%for each flow:
iU=zeros(Nflows,1);
iD=zeros(Nflows,1);
iU(jAo)=iLV;
iD(jAo)=isa; 
iU(js )=isa; 
iD(js )=isv; 
iU(jTr)=isv; 
iD(jTr)=iRV; 
iU(jPu)=iRV; 
iD(jPu)=ipa; 
iU(jp )=ipa;
iD(jp )=ipv; 
iU(jMi)=ipv; 
iD(jMi)=iLV;

iU(jk)=isa; 
iD(jk)=icav;

iU(jinlet)=icav; 
iD(jinlet)=ilac;

iU(jlacout)=ilac; 
iD(jlacout)=iven;

iU(jouf)=iven; 
iD(jouf)=isv;

%extract the conductances from the matrix G: 
Gf=zeros(Nflows,1);
Gr=zeros(Nflows,1);
for j=1:Nflows
  Gf(j)=G(iU(j),iD(j));  %forward conductance
  Gr(j)=G(iD(j),iU(j)); %reverse conductance
end
%create arrays to store current pressure differences 
%and history over time of the net flows: 
Pdiff=zeros(Nflows,1);
Q_plot=zeros(Nflows,klokmax);

%Define upstream directions and flows for each lumped compliace i
    bNflows=N; % actulally there is N-1 flow possibilities for each i 
    biU=zeros(bNflows,N);
    biD=zeros(bNflows,N);

    bGf=zeros(bNflows,N); % extract conductance matrix
    bGr=zeros(bNflows,N);
    
for i=1:N
    for j=1:bNflows
        if(i==j) %put a dummy number
        biU(j,i)=-1;
        biD(j,i)=-1;
        else  
        biU(j,i)=j;
        biD(j,i)=i;
        end

    end     
end     

for i=1:N
    for j=1:bNflows
        if(i==j) %put a dummy number
            bGf(j,i)=0 ;  %forward conductance
            bGr(j,i)=0 ;  %reverse conductance
        else  
          bGf(j,i)=G(biU(j,i),biD(j,i));  %forward conductance
          bGr(j,i)=G(biD(j,i),biU(j,i));  %reverse conductance
        end
    end             
end