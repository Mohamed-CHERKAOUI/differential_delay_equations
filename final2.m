% Integration num�rique de la DDE
dataset = dde23(@logis,1,10,[0,30]);

% Training data
X_train=linspace(0,30,7000);
Y_train = deval(dataset,X_train);

X_train2 = linspace(0,2,7000);
Y_train2 = deval(dataset,X_train2);

X_train3 = linspace(0,1.2,7000);
Y_train3 = deval(dataset,X_train3);

% Test data 
X_test=linspace(2,30,150);
Y_test = deval(dataset,X_test);

X_test2 = linspace(1.2,2,30);
Y_test2 = deval(dataset,X_test2);

X_test3 = linspace(0,1.2,30);
Y_test3 = deval(dataset,X_test3);

% Pr�diction
Y_NetWork = network(X_test);

Y_NetWork2 = network2(X_test2);

Y_NetWork3 = network3(X_test3);

% Calcul de l'erreur
Err_moy = 0;
for i = 1:length(X_test)
   Err_moy = Err_moy + ( Y_test(i)-Y_NetWork(i))^2;
end
Err_moy = sqrt(Err_moy)/150;

% Calcul du coefficient d'homog�ni�t�
Coeff_Hom = mean(Y_NetWork)/mean(Y_test);

X = [X_test3 X_test2 X_test];
Y = [Y_test3 Y_test2 Y_test];
YN = [Y_NetWork3 Y_NetWork2 Y_NetWork];
figure
subplot(1,2,1)
plot(X,Y,'.');
xlabel('temps');
ylabel('Population');
title('R�sultats attendus');
axis([0 35 0 55]);

subplot(1,2,2)
plot(X,YN,'.');
xlabel('temps');
ylabel('Population');
title('R�sultats du RNA');
axis([0 35 0 55]);

figure
plot(X,Y,'g.',X,YN,'r.');
xlabel('temps');
ylabel('Population');
title('Comparaison des r�sultats');
legend('R�sultats attendus','R�sultats du RNA');
axis([0 35 0 55]);

figure
plot(Y,YN,'.',Y,Y,'-');
xlabel('R�sultats attendus');
ylabel('R�sultats du RNA');
title('Comparaison des r�sultats');
axis([0 55 0 55]);

figure
plot(X_test3,Y_test3,'g.',X_test3,Y_NetWork3,'r.');
xlabel('temps');
ylabel('Population');
title('Comparaison des r�sultats');
legend('R�sultats attendus','R�sultats du RNA');
axis([0 3 0 55]);

function derp = logis(t,p,Z)
P0 = 10; %Population initiale
r = 1; %Taux de croissance
K = 40; %capacit� biotique
plag = Z(:,1);
derp = r*(1-(plag(1)/K))*p; %P'(t)=r*(1-P(t-1)/K)*P(t)
end

