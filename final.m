% Integration num�rique de la DDE
dataset = dde23(@logis,1,10,[0,30]);

% Training data
d = linspace(0,30,500);
index = randperm(length(d));
X_train= d(index(1:350));
Y_train = deval(dataset,X_train);

% Test data
X_test= d(index(350:500)); 
Y_test = deval(dataset,X_test);

% Pr�diction
Y_NetWork = network(X_test);

% Calcul de l'erreur
Err_moy = 0;
for i = 1:150 
   Err_moy = Err_moy + ( Y_test(i)-Y_NetWork(i))^2;
end
Err_moy = sqrt(Err_moy)/150;

% Calcul du coefficient d'homog�ni�t�
Coeff_Hom = mean(Y_NetWork)/mean(Y_test);


figure
plot(X_test,Y_test,'g.',X_test,Y_NetWork,'r.');
xlabel('temps');
ylabel('Population');
title('Comparaison des r�sultats');
legend('R�sultats attendus','R�sultats du RNA');

figure
plot(Y_test,Y_NetWork,'.');
xlabel('R�sultats attendus');
ylabel('R�sultats du RNA');
title('Comparaison des r�sultats');

function derp = logis(t,p,Z)
P0 = 10; %Population initiale
r = 1; %Taux de croissance
K = 40; %capacit� biotique
plag = Z(:,1);
derp = r*(1-(plag(1)/K))*p; %P'(t)=r*(1-P(t-1)/K)*P(t)
end

