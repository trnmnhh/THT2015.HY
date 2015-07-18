program Smart_Buy_by_Hieu;
uses crt;
var b,c,paid_1,paid_2,quality,paid_for_good,paid_for_med: array[1..10] of byte;
	own: array[1..10] of boolean;
	i,now,pay,good_own, bad_own,med_own,money,max_for_good,max_for_med: byte;
function rate(b,c:byte):byte;
	begin
	if (b>=5) and (c>=4) then exit(1)
		else if (b>=3) or (c>=3) then exit(2)
			 else exit(3);
	end;
procedure read_input; {đọc vào lượt hiện tại, thông số tank hiện đấu, số tiền đã trả và thông số tank đã đấu}
	var fi: text;
	begin
	assign(fi,'buy.inp'); reset(fi);
	while not eof(fi)do
		begin
		readln(fi,now,b[now],c[now]);
		if now>1 then
			for i:=1 to now-1 do
				readln(fi,b[i],c[i],paid_1[i],paid_2[i]);
		end;
	close(fi);
	end;
procedure write_output;
	var fo:text;
	begin
	assign(fo,'buy.out'); rewrite(fo);
	write(fo,pay);
	close(fo);
	end;
procedure cal_own_and_qual; {tính toán chất lượng và sở hữu, số tiền còn lại}
	begin
	good_own:=0;bad_own:=0;med_own:=0; money:=100;{khởi tạo giá trị}
	if now>1 then
		for i:=1 to now-1 do
			begin
			if paid_1[i]>=paid_2[i] then
				begin
				own[i]:=true;
				money:=money-paid_1[i];
				end
			else own[i]:=false;
			quality[i]:=rate(b[i],c[i]);
			if own[i] then
				begin
				if quality[i]=1 then inc(good_own); {tính số xe tốt đã sở hữu}
				if quality[i]=2 then inc(med_own) 
				else inc(bad_own);
				end;
			end
	else quality[1]:=rate(b[1],c[1]);
	end;
procedure review; {khảo sát $ tìm ra giá của đối phương, hiện tại là $ trả cho xe tốt}
	var j,k:integer;
	begin
	if now>1 then
		begin
		j:=0; k:=0;
		for i:=1 to now-1 do
			begin
			if quality[i]=1 then
				begin
				inc(j);
				paid_for_good[j]:=paid_2[i];
				end;
			if quality[i]=2 then
				begin
				inc(k);
				paid_for_med[k]:=paid_2[i];
				end;
			end;
		if j>=1 then max_for_good:=paid_for_good[1]; 
		if k>=1 then max_for_med:=paid_for_med[1];
		if j>=2 then for i:=2 to j do if paid_for_good[i]>max_for_good then max_for_good:=paid_for_good[i];
		if k>=2 then for i:=2 to k do if paid_for_med[i]>max_for_med then max_for_med:=paid_for_med[i];
		end;
	end;
procedure pay_for_good;
	var m: byte;
	begin
	m:=money-max_for_good;
	if good_own<=2 then {sở hữu ít tank tốt thì mua}
		begin
		if m<=0 then pay:=money;
		if(m<5) and (m>0) then pay:=money+m;
		if m>5 then pay:=max_for_good+5;
		end
	else pay:=round(money/(10-now)); {nhiều hơn 2 tank tốt thì mua với giá trung bình}
	end;
procedure pay_for_med;
	var m:byte;
	begin
	m:=money-max_for_med;
	if m<=0 then pay:=money;
	if(m<5) and (m>0) then pay:=money+m;
	if m>5 then pay:=max_for_med+5;
	end;
procedure pay_for_now;
	begin
	if now=1 then if quality[1]=1 then pay:=35
		else if quality[1]=2 then pay:=20
			 else pay:=0;
	if now>1 then
		begin
		if quality[now]=1 then pay_for_good;
		if quality[now]=2 then pay_for_med;
		if quality[now]=3 then pay:=0;
		end;		 
	end;
procedure info_show;
	begin
	writeln(pay);
	writeln('Rate: ',quality[now])
	end;
begin
read_input;
cal_own_and_qual;
review;
pay_for_now;
write_output;
readln;
end.