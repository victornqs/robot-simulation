function resp = anda(x, y, rbRaio, obRaio, angRad, nObs, obX, obY)

if (x-rbRaio) < 0
    resp = 0;
elseif (y+rbRaio) > 100
    resp = 0;
elseif (y-rbRaio) < 0
    resp = 0;
else
    resp = 1;    
    for i=1:nObs
        dX = obX(i) - x;     
        dY = obY(i) - y;
        obDist = sqrt((dX * dX) + (dY * dY));
        if obDist < (rbRaio + obRaio)
            resp = 0;
        end;
    end;
end;   

