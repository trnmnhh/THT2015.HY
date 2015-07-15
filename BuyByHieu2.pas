program Smart_Buy_by_Hieu
uses crt;
var b,c,tien_da_tra_1,tien_da_tra_2,chat_luong: array[1..10] of byte;
	so_huu: array[1..10] of boolean;
	i,j,luot_hien_tai,gia_dua_ra,xe_tot_so_huu, tien_con_lai: byte;
	fi,fo: text;
function phan_loai(b,c:byte):byte;
	begin
	if (b>=5) and (c>=4) then exit(1)
		else if (b>=3) and (c=3) then exit(2)
			 else exit(3);
	end;
procedure doc_du_lieu {đọc vào lượt hiện tại, thông số tank hiện đấu, số tiền đã trả và thông số tank đã đấu}
	begin
	assign(fi,'buy.inp'); reset(fi);
	while not eof(fi)do
		begin
		readln(fi,luot_hien_tai,b[luot_hien_tai],c[luot_hien_tai]);
		for i:=1 to luot_hien_tai-1 do
			readln(b[i],c[i]),tien_da_tra_1[i],tien_da_tra_2[i]);
		end;
	close(fi);
	end;
procedure so_huu_chat_luong; {tính toán chất lượng và sở hữu, số tiền còn lại}
	begin
	xe_tot_so_huu:=0; tien_con_lai:=100;{khởi tạo giá trị}
	for i:=1 to luot_hien_tai-1 do
		begin
		if tien_da_tra_1[i]>=tien_da_tra_2[i] then
			begin
			so_huu[i]:=true;
			tien_con_lai:=tien_con_lai-tien_con_lai[i];
			end;
		else so_huu[i]:=false;
		chat_luong[i]:=phan_loai(b[i],c[i]);
		if so_huu[i] and (chat_luong[i]=1) then inc(xe_tot_so_huu); {tính số xe tốt đã sở hữu}
		end;
	end;
procedure khao_sat_gia;
	begin
	
	end;
begin

end.