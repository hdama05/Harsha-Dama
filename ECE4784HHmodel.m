% Initialize Time
t = [0:1:100]; %Time

% Constants
gK = 36; %mS/cm^2
gNa = 120; %mS/cm^2
gL = 0.3; %mS/cm^2
EK = -12; %mS/cm^2
ENa = 115; %mV
EL = 10.6; %mV
Vrest = -70; %mV
Cm = 1; %uF/cm^2

% Initial Conditions
Vm = Vrest;
am = 0.1*((25-Vm)/(exp((25-Vm)/10)-1));
bm = 4*exp(-1*Vm/18);
an = 0.01*((10-Vm)/(exp((10-Vm)/10)-1));
bn = 0.125*exp(-1*Vm/80);
ah = 0.07*exp(-1*Vm/20);
bh = 1/(exp((30-Vm)/10)+1);

mo = am/(am+bm);
no = an/(an+bn);
ho = ah/(ah+bh);

I = 0;
INa = (mo^3)*gNa*ho*(Vm-ENa);
IK = (no^4)*gK*(Vm-EK);
IL = gL*(Vm-EL);
Iion = I - INa - IK - IL;













