function plot_robo(xEnt,yEnt,raio,ang,alc);
a = -pi:pi/10:pi;
y = raio * cos(a);
x = raio * sin(a);

plot(xEnt+x, yEnt+y); plot(xEnt+x, yEnt-y);
plot(xEnt-x, yEnt+y); plot(xEnt-x, yEnt-y);

z = ang * pi / 180;
xIni = xEnt + (alc * cos(z));
yIni = yEnt + (alc * sin(z));

if xIni < 0
    AngX = 0
    AngY = yEnt - (xEnt * sin(z) / cos(z));
elseif xIni > 200
    AngX = 200
    AngY = yEnt + ((200 - xEnt) * sin(z) / cos(z));
else
    AngX = xIni; AngY = yIni;
end;

line([xEnt AngX], [yEnt AngY],'Color','green');
