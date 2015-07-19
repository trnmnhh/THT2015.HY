program Smart_Buy_by_Hieu;
uses crt;
var a,b,c,paid_1,paid_2,quality,paid_for_good,paid_for_med: array[1..10] of byte;
	own: array[1..10] of boolean;
	i,now,pay,good_own,med_own,money,max_for_good,max_for_med: byte;
function rate(b,c:byte):byte;
	begin
	if (b>=5) and (c>=4) then rate:=1
		else if (b>=3) or (c>=3) then rate:=2;
	if (b<=2) and (c<=2) then rate:=3;
	end;
procedure read_input;
	var fi: text;
	begin
	assign(fi,'buy.inp'); reset(fi);
	while not eof(fi)do
		begin
		for i:=1 to 10 do
		readln(fi,a[i],b[i],c[i]);
		readln(fi,now);
		if now>1 then
			for i:=1 to now-1 do
				readln(fi,paid_1[i],paid_2[i]);
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
procedure cal_own_and_qual;
	begin
	good_own:=0;med_own:=0; money:=100;{khởi tạo giá trị}
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
				if quality[i]=1 then inc(good_own);
				if quality[i]=2 then inc(med_own) ;
				end;
			end;
	quality[now]:=rate(b[now],c[now]);
	quality[1]:=rate(b[1],c[1]);
	end;
procedure review;
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
	var m,num: byte; 
	begin
	m:=money-max_for_good;
	num:=0;
	if good_own<=2 then {sở hữu ít tank tốt thì mua}
		begin
		for i:=1 to now-1 do if quality[i]=1 then inc(num);
		if  num=0 then
			begin
			if money<35 then pay:=money
			else pay:=35;
			end
		else begin
			if m<=0 then pay:=money;
			if(m<5) and (m>0) then pay:=money+m;
			if m>5 then pay:=max_for_good+5;
			end;
		end
	else pay:=round(money/(10-now-1))-1;
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
	if now=1 then if quality[1]=1 then pay:=33
		else if quality[1]=2 then pay:=15
			 else pay:=0;
	if now>1 then
		begin
		if quality[now]=1 then pay_for_good;
		if quality[now]=2 then pay_for_med;
		if quality[now]=3 then pay:=0;
		end;		 
	end;
begin
read_input;
cal_own_and_qual;
review;
pay_for_now;
write_output;
end.
