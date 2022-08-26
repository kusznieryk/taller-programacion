program IntegerToBinary;
	
	procedure readAndWriteBinary();
		procedure writeInBinary(num:integer);
		begin
			if(num <> 0) then
				begin
					writeInBinary(num div 2);
					write(num mod 2);
				end
		end;
		var num:integer;
		begin
			repeat
				write('Ingresar un numero Entero: ');
				readln(num);
				writeInBinary(num);
				writeln(' ')
			until num=0;
	end;
begin
	readAndWriteBinary()
end.