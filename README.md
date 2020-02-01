# Penile-Erection-Mechanism
Lumped parameter modeling of penile erection mechanism

This code simulates the penile erection mechanism through the erection_model m-file. 
Compliances and resistances of vascular elements (input parameters) are fed to the function below:

[ ICP, Vcorp, Vven ] = F (Csa, Csv, Ccav, Ccorp, Cven, Rsys, Rpul, Rcav, Rhel, R(pv,out))

and intracavernosal pressure (ICP), corporeal and penile venule volumes are calculated (Vcorp and Vven, respectively) for the various erection phases of erectile dysfunction patients. 
Description of the input parameters and an example parameter set for a patient are given in the erection_model m-file.
