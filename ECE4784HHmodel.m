% Initialize Time
stepsize = 1;
t = [0:stepsize:100]; %Time

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
Vm =ones(1,length(t)).*Vrest;
am = 0.1*((25-Vrest)/(exp((25-Vrest)/10)-1));
bm = 4*exp(-1*Vrest/18);
an = 0.01*((10-Vrest)/(exp((10-Vrest)/10)-1));
bn = 0.125*exp(-1*Vrest/80);
ah = 0.07*exp(-1*Vrest/20);
bh = 1/(exp((30-Vrest)/10)+1);

mo = am/(am+bm);
no = an/(an+bn);
ho = ah/(ah+bh);

I = 0; %Injected current
INa = (mo^3)*gNa*ho*(Vrest-ENa);
IK = (no^4)*gK*(Vrest-EK);
IL = gL*(Vrest-EL);
Iion = I - INa - IK - IL;

m(1) = mo;
n(1) = no;
h(1) = ho;

%Vm(1) = (Iion/Cm);

for i = 2:length(t)
    m(i) = (am*(1-m(i-1)))-(bm*m(i-1));
    n(i) = (an*(1-n(i-1)))-(bn*n(i-1));
    h(i) = (ah*(1-h(i-1)))-(bh*h(i-1));
    
    INa = ((m(i))^3)*gNa*h(i)*(Vrest-ENa);
    IK = (n((i))^4)*gK*(Vrest-EK);
    
    IL = 0;%gL*(Vrest-EL);
    
    Iion = I - INa - IK - IL;
    dVm = (Iion/Cm)*stepsize;
    Vm(i) = Vm(i-1)+(dVm);
    
    
    
end
plot(t,Vm)










