/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
comprado = global.manager[indice];
meu_y = 0;
meu_x = 0;
desenha_manager = function() 
{
	draw_self();
	//Colocando o custo
	draw_set_valign(1);
	draw_set_halign(1);
	var _str = convert_num(custo);
	var _txt = comprado == true ? "Comprado" : _str;
	gpu_set_colorwriteenable(1, 1, 1, 0);
	draw_text(x + sprite_width / 2,y,_txt);
	gpu_set_colorwriteenable(1, 1, 1, 1);
	draw_set_valign(-1);
	draw_set_halign(-1);
	}