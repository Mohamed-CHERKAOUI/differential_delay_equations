% Integration numérique de la DDE
dataset = dde23(@logis,1,10,[0,30]);

% Training data
d = linspace(0,30,500);
index = randperm(length(d));
X_train= d(index(1:350));
Y_train = deval(dataset,X_train);

% Test data
X_test= d(index(350:500)); 
Y_test = deval(dataset,X_test);

% Prédiction
Y_NetWork = network(X_test);

% Calcul de l'erreur
Err_moy = 0;
for i = 1:150 
   Err_moy = Err_moy + ( Y_test(i)-Y_NetWork(i))^2;
end
Err_moy = sqrt(Err_moy)/150;

% Calcul du coefficient d'homogéniété
Coeff_Hom = mean(Y_NetWork)/mean(Y_test);


figure
plot(X_test,Y_test,'g.',X_test,Y_NetWork,'r.');
xlabel('temps');
ylabel('Population');
title('Comparaison des résultats');
legend('Résultats attendus','Résultats du RNA');

figure
plot(Y_test,Y_NetWork,'.');
xlabel('Résultats attendus');
ylabel('Résultats du RNA');
title('Comparaison des résultats');

function derp = logis(t,p,Z)
P0 = 10; %Population initiale
r = 1; %Taux de croissance
K = 40; %capacité biotique
plag = Z(:,1);
derp = r*(1-(plag(1)/K))*p; %P'(t)=r*(1-P(t-1)/K)*P(t)
end

