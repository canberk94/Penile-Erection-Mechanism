% This script writes the average flows and pressures for the last few
% converged cycles

ti_av=0.5;
klokav=klokmax-500;

mean(P_plot(:,klokav:klokmax),2);
mean(V_plot(:,klokav:klokmax),2);
mean(Q_plot(:,klokav:klokmax),2);
mean(C_plot(:,klokav:klokmax),2);

Psummary=[max(P_plot(:,klokav:klokmax),[],2), mean(P_plot(:,klokav:klokmax),2), min(P_plot(:,klokav:klokmax),[],2)];
Qsummary=[max(Q_plot(:,klokav:klokmax),[],2), mean(Q_plot(:,klokav:klokmax),2), min(Q_plot(:,klokav:klokmax),[],2)];
Csummary=[max(C_plot(:,klokav:klokmax),[],2), mean(C_plot(:,klokav:klokmax),2), min(C_plot(:,klokav:klokmax),[],2)];
Vsummary=[max(V_plot(:,klokav:klokmax),[],2), mean(V_plot(:,klokav:klokmax),2), min(V_plot(:,klokav:klokmax),[],2)];
