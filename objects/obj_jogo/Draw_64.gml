/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Desenhando a energia
var _n = 0;
var _alt = 20;
draw_set_halign(0);
var _str = convert_num(global.energy);
draw_text(20, _alt * _n++,_str);
draw_set_halign(1);

//Quero saber quanto dinheiro faço por segundo
var _dinheiro_seg = 0;

//Descobrindo
//Rodando pelas fontes de energia
for (var i = 0; i < array_length(global.fontes); i++)
{
	if (global.fontes[i] != 0)
	{
		//Pegando as informações da fonte atual
		var _atual = global.fontes[i];
		with(_atual)
		{
			if (tenho_manager && comprado)
			{
				_dinheiro_seg += (lucro / tempo);
			}
		}
	}
}
global.energy_seg = _dinheiro_seg;
var _str = convert_num(global.energy_seg)
draw_text(20, _alt * _n++, _str);