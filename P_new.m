%This script calculates the pressure of each compliant chamber at each
%iteration

function P=P_new(P_old, C_old,C,S)
%filename: P_new.m
global G dt CHECK N Pt Pt_old;

%Calculate breathing source term
Nefes=(C_old.*Pt_old-C.*Pt);
%Nefes=0;

A=-dt*((S.*G)+(S.*G)'); 
A=diag(C-(sum(A))')+A;
P=A\(C_old.*P_old - Nefes);

if(CHECK)
  for i=1:N 
    CH(i)=-(C(i)*P(i)-C_old(i)*P_old(i))/dt; 
    for j=1:N
      CH(i)=CH(i)+S(j,i)*G(j,i)*(P(j)-P(i)); 
      CH(i)=CH(i)-S(i,j)*G(i,j)*(P(i)-P(j));
    end
  end
end



