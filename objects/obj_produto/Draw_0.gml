/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Me desenhando
draw_self();

//Desenhando o produto na minha esquerda
draw_sprite(spr_item, 0, x, y - 16);

//Alinhando o meu texto
draw_set_valign(1);
draw_set_halign(1);

//Desenhando o meu level
//Fazendo uma caixa de texto
var _x = x;
var _y = y + 24;
draw_ellipse_color(_x - 24, _y - 16,_x + 24,_y + 16,c_dkgray,c_dkgray,false);
draw_text(x,_y,level);

//Desenhando a barra de 
var _x1 = x + 42;
var _y1 = y - 32;
var _larg = sprite_width /1.5;
var _x2 = _x1 + _larg;
var _y2 = _y1 + sprite_height / 4;
//Desenhando as bordas da barra
draw_rectangle_color(_x1 -1, _y1 -1, _x2+1, _y2+1,c_black,c_black,c_black,c_black,false);

//Desenhando o fundo da barra
draw_rectangle_color(_x1 , _y1 , _x2, _y2,c_gray,c_gray,c_gray,c_gray,false);
//Desenhando o progresso da barra
var _progresso = (timer/tempo)*_larg;
draw_rectangle_color(_x1 , _y1 , _x1 + _progresso, _y2,c_green,c_green,c_green,c_green,false);
//Desenhando o lucro
//Ajustando o alinhamento
draw_set_halign(2);
var _str = "R$ " + string_format(lucro,0,2); 
draw_text(_x2,_y1 + sprite_height / 8, _str)
//Voltando o alinhamento para o centro
draw_set_halign(1);
//Desenhando o meu preço
//Desenhando o quadrado do texto
_x1 = x + 42;
_y1 = y + 8;
_x2 = _x1 + 96;
_y2 = _y1 + 32;
//Definindo a cor com base nas opções
var _cor = global.energy >= custo ? c_green : c_gray;
var _str = string_format(custo,0,0);
//Desenhando o efito de compra
if(efeito_comprar)
{
	draw_rectangle_color(_x1 - 1, _y1 - 1, _x2 + 1, _y2 + 1,c_yellow,c_yellow,c_yellow,c_yellow,false);
}
draw_rectangle_color(_x1 , _y1 , _x2, _y2,_cor,_cor,_cor,_cor,false);
draw_text_transformed(_x1 + 48, _y1 + 16,"R$ " + _str,1,1,0);

//Desenhando o tempo de venda
//Descobrindo quantos segundos
var _s = floor((tempo - timer) % 60);
var _m = floor((tempo - timer) div 60);
draw_set_halign(2)
//Definindo a formatação
var _seg = _s > 9 ? _s : "0" + string(_s)
var _min = _m > 9 ? _m : "0" + string(_m);
draw_text(x + sprite_width - 5,_y1 + 20, string("{0}:{1}", _min,_seg ));

draw_set_halign(1)
//Resetanod o alinhamento do meu texto
draw_set_valign(-1); 
draw_set_halign(-1);