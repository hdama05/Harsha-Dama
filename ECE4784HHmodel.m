% Initialize Time
stepsize = 1/100;
t = [0:stepsize:1000]; %Time

% Constants
gKcon = 36; %mS/cm^2
gNacon = 120; %mS/cm^2
gL = 0.3; %mS/cm^2
EK = -12; %mS/cm^2
ENa = 115; %mV
EL = 10.6; %mV
Vrest = -70; %mV
Cm = 1; %uF/cm^2

% Initial Conditions
Vm =ones(1,length(t)).*0;
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
%INa = (mo^3)*gNa*ho*(Vrest-ENa);
%IK = (no^4)*gK*(Vrest-EK);
%IL = gL*(Vrest-EL);
%Iion = I - INa - IK - IL;

m(1) = mo;
n(1) = no;
h(1) = ho;
gNa(1) = ((m(1))^3)*gNacon*h(1);
gK(1) = (n((1))^4)*gKcon; 

%Vm(1) = (Iion/Cm);

for i = 2:length(t)
    m(i) = m(i-1)+stepsize*((am*(1-m(i-1)))-(bm*m(i-1)));
    n(i) = n(i-1)+stepsize*((an*(1-n(i-1)))-(bn*n(i-1)));
    h(i) = h(i-1)+stepsize*((ah*(1-h(i-1)))-(bh*h(i-1)));
    
    gNa(i) = ((m(i-1))^3)*gNacon*h(i-1);
    gK(i) = (n((i-1))^4)*gKcon; 
    
    
    INa = ((m(i-1))^3)*gNacon*h(i-1)*(Vm(i-1)-ENa);
    IK = (n((i-1))^4)*gKcon*(Vm(i-1)-EK);
    IL = gL*(Vm(i-1)-EL);
    
    Iion(i) = I - INa - IK - IL;
    
   % if(Iion(i) == Iion(i-1)) 
        dVm = 0;
    %else
        dVm = (Iion(i)/Cm)*stepsize;
   % end
    
    Vm(i) = Vm(i-1)+(dVm);
       
end

Vmm = Vm+ones(1,length(t))*-70;
figure
plot(t,Vmm)
figure
plot(t,gNa,'r')
figure
plot(t,gK,'b')

