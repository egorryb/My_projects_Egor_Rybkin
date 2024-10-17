function open_file(v,N)
%Запишем всю информацию о структуре вершин в файл для дальнейшей работы 
k=fopen('Graphs.txt','wt+');
r='V';
s ='distance';
s1='parent';
s2='obstacle';
s4='coordinate X';
s5 =' coordinate Y';
s3 = 'Смежна справа';
s31 = 'Смежна слева';
s32 = 'Смежна сверху';
s33 = 'Смежна снизу';
fprintf(k,'%s %10s %10s %10s %10s %10s %10s %10s %10s %10s\n' ,r,s,s1,s2,s3 ,s31 ,s32 ,s33, s4,s5);
for i=1:N
fprintf(k,'%d %7d %10d %10d', i,v(i).d,v(i).parent,v(i).obstacle);
fprintf(k,'%12d %12d %12d %12d',v(i).sm(1),v(i).sm(2),v(i).sm(3),v(i).sm(4));
fprintf(k,'%13d %13d\n', v(i).coordinate(1), v(i).coordinate(2));
end
fclose(k);