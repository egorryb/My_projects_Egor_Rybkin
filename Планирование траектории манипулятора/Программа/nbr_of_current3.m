%% Функция поиска соседей
function [ArrayOfNbr, NeProhod] = nbr_of_current3(current,CLOSED,MIN_X,MIN_Y,MAX_X,MAX_Y,Alg,v,L1,L2,x0,y0,R,num)
ArrayOfNbr = [];
NeProhod = [];
Nbr_count = 1;
Nbr_NeProhod = 1;
for i = 1:-1:-1
    for j = 1:-1:-1
        if i ~= j && i ~= -j % Только вверх вниз вправо влево
            nbr_x = (current(1,1) + i);
            nbr_y = (current(1,2) + j);
            if( (nbr_x >=MIN_X && nbr_x <=MAX_X) && (nbr_y >=MIN_Y && nbr_y <= MAX_Y))%сосед не выходит за границы
                IsNbrInClosed = 0;
                for r = 1:size(CLOSED,1)
                    if(nbr_x == CLOSED(r,1) && nbr_y == CLOSED(r,2))
                        IsNbrInClosed=1;
                    end
                end
               for k = 1:num - 1
                [x1,y1,x2,y2] = pzk(nbr_x ,nbr_y,L1,L2);
                [Dm Dm1] = DistMin(x2,y2,x1, y1,x0,y0,k);
                if Dm  - R <= 0 || Dm1 - R <= 0
                     IsNbrInClosed = 1;
                     NeProhod(Nbr_NeProhod,1) = nbr_x;
                    NeProhod(Nbr_NeProhod,2) = nbr_y;
                    Nbr_NeProhod =  Nbr_NeProhod + 1;
                end
               end
                if IsNbrInClosed == 0
                    ArrayOfNbr(Nbr_count,1) = nbr_x;
                    ArrayOfNbr(Nbr_count,2) = nbr_y;
                    if Alg == 2
                        ArrayOfNbr(Nbr_count,3) = v+1;
                    end
                    Nbr_count = Nbr_count+1;
                end
            end
        end
    end
end
end
