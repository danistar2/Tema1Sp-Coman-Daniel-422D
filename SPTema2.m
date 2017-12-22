%Numarul meu este 7=> semnal dreptunghiular x de perioada 40s, durata 7s, factor de umplere
%7/T*100
T=40 %perioada semnalului
w0=(2*pi)/T %perioada semnalului
t=0:0.1:100
x=square(w0*t, 7/T*100)%S-emnalul initial.Componenta de dupa virgula este reprezentata de factorul de umplere 


N=25 %numarul coeficientilor pozitivi/negativi
%C=matricea coeficientilor 
C=zeros(size(2*N+1))%se initializeaza matricea cu 0
%x2 va fi semnalul reconstruit
x2=0
%for pt calculul coeficientilor de la -25 la 25
for k=-N:N
    %integrala de la 0 la 7 unde semnalul este 1
    fun2=@(t) 1.*exp(-1j*k*w0*t)
    %integrala de la 7 la 40 unde semnalul este -1
    fun3=@(t) (-1).*exp(-1j*k*w0*t)
    %formula de calcul a coeficientilor (integrala pe o perioada
    C(k+N+1)=1/T*(integral(fun2, 0, 7)+integral(fun3, 7, 40))
    re=real(C(k+N+1))
    im=imag(C(k+N+1))
    %se pun coeficientii in matrice
    C(k+N+1)=re+1j*im
    %semnalul va fi suma modulelor coeficientilor
    x2=x2+real(C(k+N+1)*exp(1j*k*w0*t))
end

%reprezentarea grafica a spectrului de amplitudine
subplot(2, 1, 1)
stem((-N:N), abs(C)); title('Spectru de amplitudini');
subplot(2, 1, 2); 
%reprezentarea semnalului initial
plot(t, x, '-')
hold on %reprezentam semnalul initial si reconstruit in aceeasi figura
%reprezentarea semnalului reconstruit
plot(t, x2, '.'); title('Semnalul reconstruit si cel initial. Cel initial cu "-" iar cel reconstruit cu "."');
hold off
% Teoria seriilor Fourier (trigonometrica, armonica si complexa) ne spune
% ca orice semnal periodic poate fi aproximat printr-o suma infinita de coeficienti.
% Acesti coeficienti reprezinta practic spectrul.
% Semnalul reconstruit folosind un numar finit de termeni se apropie ca
% forma de semnalul original cu o anumita marja de eroare. Cu cat marim
% numarul de coeficienti, aceasta marja de eroare va fi din ce in ce mai
% mica.