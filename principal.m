clf;
hold on;
%Universo de discurso principal
xi = 0; xf = 200; yi = 0; yf = 100; RObjeto=2.5;
axis([xi xf yi-40 yf+40]);
plot([xi xf xf xi xi],[yi yi yf yf yi]);
NumeroObjetos = input('Quantos obstaculos?(de 0 a 5): ');
while NumeroObjetos < 0 || NumeroObjetos > 5
    NumeroObjetos = input('Valor invalido!');
 end;
for i=1:NumeroObjetos
    xObjeto(i) = 15 + (i * 4 * RObjeto);
    YObjeto(i) = RObjeto + (rand * (100 - RObjeto));
    xObjeto(1)=40; YObjeto(1)=48;xObjeto(2)=50; YObjeto(2)=58;
    plot_obstaculos(xObjeto(i), YObjeto(i), RObjeto);
end;
RaioCirculo  =  5; RaioAlcance   = 30; SequenciaPassosDist =  2;
k = ['(entre ' num2str(yi+RaioCirculo) ' e ' num2str(yf-RaioCirculo) '): '];
RX = RaioCirculo
RY = input(['Ponto de Partida?(de 5 a 95) ' k]);
while RY < (yi+RaioCirculo) || RY > (yf-RaioCirculo)
    RY = input(['Dado invalido. ' k]);
end; 
if RY < RaioCirculo
    RY = RaioCirculo;
end;
if RY > (yf-RaioCirculo)
    RY = yf - RaioCirculo;
end;
AnguloRobo = input('Qual o angulo inicial do robo?(-180 a 180)');
while (AnguloRobo < -180) || (AnguloRobo > 180)
    AnguloRobo = input('Angulo invalido.');
end;
if abs(AnguloRobo) > 90
    RX = RaioCirculo * 2;end;
AnguloRoboRad = AnguloRobo * pi/180;
meta = xf - RaioCirculo - SequenciaPassosDist
SequenciaPassos = 0;
plot_robo(RX,RY,RaioCirculo,AnguloRobo,RaioAlcance)
fis_robo = readfis('robo_dir');
fis_pos_gir = readfis('posicao_girar');
while RX < meta
    Distancia = 300;
    NumeroObjetost = 0;
    for i=1:NumeroObjetos
        dX = xObjeto(i) - RX;     
        dY = YObjeto(i) - RY;
        DistanciaObj = sqrt((dX * dX) + (dY * dY));
        angObstRad = AnguloRoboRad - atan(dY/dX); 
        DistanciaJ = DistanciaObj * sin(angObstRad);
        DistanciaL = DistanciaObj * cos(angObstRad);
        if (DistanciaObj <= RaioAlcance) & (DistanciaL > 0) & (abs(DistanciaJ) < (RaioCirculo+RObjeto)) & (DistanciaL < Distancia)
            NumeroObjetost = i;
            Distancia = DistanciaL
            DistanciaObjanciaK = abs(DistanciaObj);
            MAngObj = angObstRad;
        end;
    end;
    if NumeroObjetost > 0
        MAngObj2 = -MAngObj *180 / pi;
        giro = evalfis([DistanciaObjanciaK,MAngObj2], fis_pos_gir);
    else
        giro = evalfis([AnguloRobo], fis_robo);
    end;       
    AnguloRobo = AnguloRobo + giro;
    AnguloRoboRad = AnguloRobo * pi / 180;     
    NRX = RX + (SequenciaPassosDist * cos(AnguloRoboRad));
    NRY = RY + (SequenciaPassosDist * sin(AnguloRoboRad));
    if anda(NRX, NRY, RaioCirculo, RObjeto, AnguloRoboRad, NumeroObjetost, xObjeto, YObjeto) == 1
        RX = NRX;
        RY = NRY;
    end;    
    SequenciaPassos = SequenciaPassos + 1;
    xlabel(['Passo: ' int2str(SequenciaPassos)]);
    plot_robo(RX,RY,RaioCirculo,AnguloRobo,RaioAlcance) 
    pause (0.01);
end;