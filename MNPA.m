
%Muhammad Shabeeh Raza Abbas 
%101092004
set(0,'DefaultFigureWindowStyle','docked'); 
close all


%G = 1/R

% Given Paramters
R1 = 1;
C1 = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
al = 100;
R4 = 0.1; 
R0 = 1000; 


%Using MNA equations (ELEV 4506) to set up matric for C (capacitors)and G ((1/R) also
%inductor)

 G = [1 0 0 0 0 0 0;
     1/R1 -((1/R1) + (1/L)) 1/L 0 0 0 0;
     0 1 -1 0 0 0 0; 
     0 0 1/R3 0 0 0 -1; 
     0 0 0 1 0 0 -al; 
     0 0 0 1 0 -al 0; 
     0 0 0 1/R4 -((1/R4) + (1/R0)) 0 0];
 
 C = [0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0];
 

%adding capacitor values to C matrix 
C(2, 1) = C1; 
C(2, 2) = -C1;
C(3, 6) = -L;


V1 = zeros(100, 1);
V0 = zeros(100, 1);
V3 = zeros(100, 1);

% Setting a 7x1 F matrix 
F = zeros(7, 1);
%voltage = 0
Volt = 0;



% V1 = -10v --> +10v
 for Vin = -10:10       
     
    Volt = Volt + 1; %%%%%%%
    F(1) = Vin;
    
    V = G\F;
    
    V1(Volt) = Vin;
    
    V0(Volt) = V(5);
    
    V3(Volt) = V(3);
    
end

%Plot for V1 -10v to +10v 
figure(1)
subplot(2,2,1);
plot(V1, V0, 'g');
hold on;
plot(V1, V3, 'r');
xlabel('Vin')
ylabel('V')



F = [10; 0; 0; 0; 0; 0; 0];

V2 = zeros(100, 1); 
w = zeros(1000, 1);
g = zeros(1000, 1);

for acF = linspace(0,100,1000)
    
    Volt = Volt+1;
    
    Vf = (G+1j*acF*C)\F;
    
    w(Volt) = acF;
    
    V2(Volt) = norm(Vf(5));
    
    g(Volt) = norm(Vf(5))/10;
    

    
end 
  
%Plotting the omega v Gain plot
subplot(2,2,2);
plot(w, V2, 'g')
hold on;
plot(w, g, 'r' )
xlim([0 100])
xlabel('w')
ylabel('Gain')



w = pi;  % Ω = π 

CArry = zeros(100,1);

Gain_Arry = zeros(100,1);

for iter = 1:1000
    
    std = 0.5;
    CGen = C1 + std*randn();
    
    C(2, 1) = CGen; 
    
    C(2, 2) = -CGen;
    
    C(3, 3) = L;
    
    Vf2 = (G+1i*w*C)\F;
    
    CArry(iter) = CGen;
    
    Gain_Arry(iter) = norm(Vf2(5))/10;
    
end

s

%Plotting the Histogram Capcitor value and numbers
subplot(2,2,3);
histogram(CArry,15)
xlabel('C');
ylabel('Number'); 

%Histogram of the Gian 
subplot(2,2,4);
histogram(Gain_Arry,15)
xlabel('Vo / Vi');
ylabel('Number'); 