/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Desenhando a energia
var _n = 0;
var _alt = 20;
draw_set_halign(0);
var _str = "R$ " + string_format(global.energy,0,2);
draw_text(20, _alt + _n++,_str);
draw_set_halign(1);