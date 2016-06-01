function plot_obstaculos(xEnt,yEnt,raio);

a = -pi:pi/10:pi;

y = raio * cos(a);

x = raio * sin(a);

plot(xEnt+x, yEnt+y); plot(xEnt+x, yEnt-y);

plot(xEnt-x, yEnt+y); plot(xEnt-x, yEnt-y);