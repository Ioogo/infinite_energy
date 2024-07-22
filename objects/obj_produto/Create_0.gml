/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Meu level
level = 0;

//Mais informações do produto
timer = 0;

meu_x = 0;
meu_y = 0;

//Definindo se devo fazer
fazer = false;
infos = false;

//Manager
if (array_length(global.fontes) <= indice)
{
	tenho_manager = global.fontes[indice];
}
else 
{
	array_push(global.fontes, 0);
	tenho_manager = 0;
}

//Meus custos
custo = custo_base; 

comprado = false;
efeito_comprar = false;

lucro = lucro_base;

//Me inserindo na lista de fontes de energia
global.fontes[indice] =	id;

incremento = 1.07

comprar = function() 
{
	//Descontando a energia
	global.energy -= custo;
	comprado = true;
	
	var _custo_atual = floor(custo_base * (power(incremento, level)));
	//show_message(_custo_atual);
	
	//Aumenta o custo
	custo += _custo_atual;
	//Ajustando o lucro
	level++;
	//Lucro com base no lvl e lucro base
	lucro = lucro_base * level;
}

acao = function() 
{
	timer = 0;
	fazer = tenho_manager;
	//Dando o lucro
	global.energy += lucro;
}

//Desenhando o produto
desenha_produto = function()
{
	//Me desenhando
	draw_self();
	draw_set_font(fnt_texto);

	//Desenhando o produto na minha esquerda
	draw_sprite(spr_item, indice, x, y - 16);
	
	//Alinhando o meu texto
	draw_set_valign(1);
	draw_set_halign(1);

	//Desenhando o meu level
	//Fazendo uma caixa de texto
	var _x = x;
	var _y = y + 24;
	draw_ellipse_color(_x - 24, _y - 16,_x + 24,_y + 16,c_dkgray,c_dkgray,false);
	
	//Configurando o alpha
	gpu_set_colorwriteenable(1, 1, 1, 0);
	draw_text(x,_y,level);
	//Resetando o alpha
	gpu_set_colorwriteenable(1, 1, 1, 1);
	
	//Desenhando a barra de progresso
	var _x1 = x + 42;
	var _y1 = y - 32;
	var _larg = sprite_width /1.2;
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
	var _str = convert_num(lucro);
	gpu_set_colorwriteenable(1, 1, 1, 0);
	draw_text(_x2 - 4,_y1 + sprite_height / 8, _str)
	//Voltando o alinhamento para o centro
	draw_set_halign(1);
	//Desenhando o meu preço
	//Desenhando o quadrado do preço
	_x1 = x + 42;
	_y1 = y + 8;
	var _larg = sprite_width / 2;
	_x2 = _x1 + _larg;
	_y2 = _y1 + 32;
	//Definindo a cor com base nas opções
	var _cor = global.energy >= custo ? c_green : c_gray;
	var _str = convert_num(custo);
	//Desenhando o efito de compra
	if(efeito_comprar)
	{
		draw_rectangle_color(_x1 - 1, _y1 - 1, _x2 + 1, _y2 + 1,c_yellow,c_yellow,c_yellow,c_yellow,false);
	}
	draw_rectangle_color(_x1 , _y1 , _x2, _y2,_cor,_cor,_cor,_cor,false);
	draw_text_transformed(_x1 + _larg/2, _y1 + 16, _str,1,1,0);
	
	
	//Desenhando o tempo de venda
	//Descobrindo quantos segundos
	var _s = floor((tempo - timer) % 60);
	var _m = floor((tempo - timer) div 60) % 60;
	var _h = ((tempo - timer) div 60) div 60;
	draw_set_halign(2)
	//Definindo a formatação
	var _seg = _s > 9 ? _s : "0" + string(_s);
	var _min = _m > 9 ? _m : "0" + string(_m);
	var _hor = _h > 9 ? _h : "0" + string(_h);
	draw_text(x + sprite_width - 24,_y1 + 20, string("{0}:{1}:{2}", _hor, _min, _seg ));

	gpu_set_colorwriteenable(1, 1, 1, 1);
	
	draw_set_halign(1)
	//Resetanod o alinhamento do meu texto
	draw_set_valign(-1); 
	draw_set_halign(-1);
	
	if (infos)
	{
		exibe_info();
	}
	
	draw_set_font(-1);
}

//Exibindo as informações do produto
exibe_info = function()
{
	var _x1 = x + sprite_width + 12;
	var _y1 = y - sprite_height / 2;
	var _marg = 8;
	
	//Desenhando a minha caixinha
	draw_sprite_stretched(spr_info, 0, _x1, _y1, sprite_width, sprite_height);
	gpu_set_colorwriteenable(1, 1, 1, 0);
	draw_text(_x1 + _marg, _y1 + _marg, nome);
	
	//Descrição
	draw_text_ext(_x1 + _marg, _y1 + 30, descricao, 20, sprite_width - _marg * 2);
	gpu_set_colorwriteenable(1, 1, 1, 1);
}
