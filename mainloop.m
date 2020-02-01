%Mainloop that simulate and trigger the penile erection mechanism

for klok=1:klokmax
    t=klok*dt;
if (t>12)               %erection is triggered
        C(isa)=Csa;
        C(isv)=Csv;
        C(icav)=Ccav;
        C(ilac)=Ccorp;
        C(iven)=Cven;
        
      G(isa,isv)=1/Rsys;
      G(isv,isa)=1/Rsys;
      
      G(icav,ilac)=1/Rhel;
      G(ilac,icav)=1/Rhel;
      
      G(isv,iven)=1/Rout;
      G(iven,isv)=1/Rout;
      
      G(isa,icav)=1/Rhel;
      G(icav,isa)=1/Rhel;
      
      G(ilac,iven)=1/Rpvout;
      G(iven,ilac)=1/Rpvout;

Csa=0.0013;
Csv=5000;
Rsys=14.0256;
Ccav=2.4039e-6;
Cven=2.1889e-5;
Ccorp=0.0013-(5.2694e-6)*P(ilac);

Rhel=500;
Rcav=1656.3;
Rpvout=1750.3;
Rout=1130.3;
end
    
for j=1:Nflows
  Gf(j)=G(iU(j),iD(j));  %forward conductance
  Gr(j)=G(iD(j),iU(j));  %reverse conductance
end

  P_old=P;
  C_old=C;
  Pt_old=Pt;
  
  %find current values of left and right 
  %ventricular compliance and store each 
  %of them in the appropriate slot in the array C:
  C(iLV)=CV_now(t,CLVS,CLVD);
  C(iRV)=CV_now(t,CRVS,CRVD);

  %find self-consistent valve states and pressures: 
  set_valves
  
  %update flowrate matrix based on old resistances
  Pdiff=P(iU)-P(iD); %pressure differences
                     %for flows of interest:

  Q=(Gf.*(Pdiff>0)+Gr.*(Pdiff<0)).*Pdiff;
  
  %update flowrate matrix FOR ALL BRANCHES
  for i=1:N
    for j=1:bNflows
        if(i==j) %put a dummy number
            bPdiff(j,i)= 0; %pressure difference matrix
          
        else  
            bPdiff(j,i)=P(biU(j,i))-P(biD(j,i)); %pressure difference matrix
        end
    end             
  end
    bQ=(bGf.*(bPdiff>0)+bGr.*(bPdiff<0)).*bPdiff;
  
  % bQ(j,i) is the branch flows (j=1:bnflows) for the ith compliance/column
  bQ;
  Q;
  
  %store variables in arrays for future plotting:
  
  t_plot(klok)=t;
  C_plot(:,klok)=C;
  P_plot(:,klok)=P;
  
  V(ilac)=P(ilac)*(Ccorp+0.0005);
  V(iven)=VCven-(V(ilac)-VClac);
  
  V_plot(:,klok)=V;
  Pt_plot(:,klok)=Pt;
  Q_plot(:,klok)=Q;
 
 format short
end