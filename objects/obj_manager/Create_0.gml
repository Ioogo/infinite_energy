/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
comprado = global.manager[indice];

desenha_manager = function() 
{
	draw_self();
	//Colocando o custo
	draw_set_valign(1);
	draw_set_halign(1);
	var _str = "R$ " + string_format(custo, 0,2);
	var _txt = comprado == true ? "Comprado" : _str;
	draw_text(x + sprite_width / 2,y,_txt);
	draw_set_valign(-1);
	draw_set_halign(-1);
	}