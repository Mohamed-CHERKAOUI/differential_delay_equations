% Integration numérique de la DDE
dataset = dde23(@logis,1,10,[0,30]);

% Training data
X_train=linspace(0,30,7000);
Y_train = deval(dataset,X_train);

% Test data 
X_test=linspace(0,30,150);
Y_test = deval(dataset,X_test);

% Prédiction
Y_NetWork = network(X_test);


% Calcul de l'erreur
Err_moy = 0;
for i = 1:length(X_test)
   Err_moy = Err_moy + ( Y_test(i)-Y_NetWork(i))^2;
end
Err_moy = sqrt(Err_moy)/150;

% Calcul du coefficient d'homogéniété
Coeff_Hom = mean(Y_NetWork)/mean(Y_test);

figure
subplot(1,2,1)
plot(X_test,Y_test,'.');
xlabel('temps');
ylabel('Population');
title('Résultats attendus');
axis([0 35 0 55]);

subplot(1,2,2)
plot(X_test,Y_NetWork,'.');
xlabel('temps');
ylabel('Population');
title('Résultats du RNA');
axis([0 35 0 55]);

figure
plot(X_test,Y_test,'g.',X_test,Y_NetWork,'r.');
xlabel('temps');
ylabel('Population');
title('Comparaison des résultats');
legend('Résultats attendus','Résultats du RNA');
axis([0 35 0 55]);

figure
plot(Y_test,Y_NetWork,'.',Y_test,Y_test,'-');
xlabel('Résultats attendus');
ylabel('Résultats du RNA');
title('Comparaison des résultats');
axis([0 55 0 55]);

function derp = logis(t,p,Z)
P0 = 10; %Population initiale
r = 1; %Taux de croissance
K = 40; %capacité biotique
plag = Z(:,1);
derp = r*(1-(plag(1)/K))*p; %P'(t)=r*(1-P(t-1)/K)*P(t)
end

