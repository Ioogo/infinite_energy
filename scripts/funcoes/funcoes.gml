// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function convert_num(_num)
{
	var _custo2 = _num;
	var _valores = ["", "K", "M", "B", "T","Q"];
	var _i = 0;
	
	//Sempre que o valor for maior que 1000, vou tirar 3 zeros dele
	while (_custo2 > 1000) 
	{
		_custo2 /= 1000;
		
		//sempre que eu rodar isso, eu subo para a próxima casa
		_i++;
	}
	
	var _str2 = "R$ "+ string_format(_custo2, 0, 2) + _valores[_i];
	return _str2
}