function sol = s
sol = dde23(@crcr,[1,pi/2],ones(3,1),[0, 20]);
figure
plot(sol.x,sol.y);
title('Influence du retard sur le signal')
xlabel('temps (ms)');
ylabel('Angle mesuré (rad)');
legend('R=1','R=pi/2','R=0');
grid on;
%l'équation différentielle est : 
%x'(t)=-x(t-h)
function xp = crcr(t,x,Z)
xlag1 = Z(:,1);
xlag2 = Z(:,2);
xp = [ -xlag1(1)%x'(t)=-x(t-1)
       -xlag2(2)%x'(t)=-x(t-pi/2)
       -x(3)];%x'(t)=-x(t)