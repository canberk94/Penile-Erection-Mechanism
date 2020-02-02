# Penile-Erection-Mechanism
Lumped parameter modeling of penile erection mechanism

This code simulates the penile erection mechanism by directly running the erection_model m-file through a software platform. 
Compliance and resistance values of vascular elements (input parameters) are fed to the function below:

[ ICP, Vcorp, Vven ] = F (Csa, Csv, Ccav, Ccorp, Cven, Rsys, Rhel, Rcav, R(pv,out), Rout)

and intracavernosal pressure (ICP), corporeal and penile venule volumes are calculated (Vcorp and Vven, respectively) for the various erection phases of erectile dysfunction patients. 
Description of all input parameters and output variables are given in the files. An example parameter set for a patient can also be found in the erection_model m-file.
