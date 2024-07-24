/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
alarm[0] = game_get_speed(gamespeed_fps) * 120

//Carregando os dados
//carrega_dados();

//Ao criar o objeto jogo as informações serão carregadas
load_game();

//lista dos produtos

produtos = [];
managers = [];

//Dados da minha surface dos produtos
surf_prod = noone;
prod_w = 860;
prod_h = 500;
prod_x = 48;
prod_y = 48;

//Dados da surface dos managers
surf_man = noone;
man_w = 360;
man_h_base = 500;
man_h = 1;
man_x = 880;
man_y = 48;

base_y = 80;
produtos_y = 0 + base_y;

//criando os produtos dentro da lista dos produtos
cria_produtos = function(_qtd = 1) 
{
	for (var i = 0; i < _qtd; i++)
	{	
		//struct com os meus dados que eu estou pegando do meu json
		var _struct = global.struct_produtos[i];
		
		//Atualizando o manager
		
		produtos[i] = instance_create_layer(0, 0, layer, obj_produto, _struct);
		
		//Passando as informações para os produtos
		//Se eu tenho as informaçõe eu faço essa parte
		if (global.produtos_info[i] != 0)
		{
			//Atualizando o manager
			global.manager[i] = global.produtos_info[i].tenho_manager;
			
			with(produtos[i])
			{
				level = global.produtos_info[i].level;
				comprado = global.produtos_info[i].comprado;
				tenho_manager = global.produtos_info[i].tenho_manager;
				
				//Atualizando as informações
				ajusta_infos();
			}
		}
	}
}

cria_managers = function()
{
	//1 manager para cada produto
	for (var i = 0; i < array_length(produtos); i++)
	{
		var _meu_produto = 
		{
			indice : i
		}
		managers[i] = instance_create_layer(900, 100 + i * 100, layer,obj_manager, _meu_produto);
		
		managers[i].custo = global.fontes[i].custo_base * 10;
		managers[i].indice = i;
	}
}

rolagem_produtos = function() 
{
	if (keyboard_check(vk_up)) produtos_y -= 10;

	if (keyboard_check(vk_down)) produtos_y += 10;
	
	//Descobrindo o valor máximo
	var _qtd = array_length(produtos)
	var _max = (96 * _qtd) + (20 * _qtd) + 20 - room_height;
	
	//limitando a rolagem
	produtos_y = clamp(produtos_y, -_max, base_y)
}

rolagem = function(_val = 10, _x = 0, _y = 0, _w = 0, _h = 0)
{
	var _qtd = 0;
	var _fazer = false;
	
	if (_w != 0)
	{
		_fazer = point_in_rectangle(mouse_x, mouse_y, _x, _y, _x + _w, _y + _h);
	}
	
	if (_fazer) 
	{
		//Rolando a bolinha do mouse
		if (mouse_wheel_down())
		{
			_qtd = -_val;
		}
		if (mouse_wheel_up())
		{
			_qtd = _val;
		}
	}
	
	return _qtd;
}

gerencia_managers = function()
{
	static _meu_y = 0;
	var _alt = sprite_get_height(spr_produtos);
	var _larg = sprite_get_width(spr_produtos);
	var _marg = 20
	_meu_y += rolagem(30, man_x, man_y, man_w, man_h);
	
	var _qtd = array_length(managers);
	var _max = (_alt * _qtd + (_marg * _qtd) + _marg - prod_h)
	
	//Limitando a rolagem
	_meu_y = clamp(_meu_y, -_max, 0)
	
	for (var i = 0; i < _qtd; i++)
	{
		var _x = 0;
		var _y = _meu_y + _marg + (i * _alt) + (i *_marg);
		
		with(managers[i])
		{
			x = _x;
			y = _y + sprite_height/2;
		}
	}
}

gerencia_produtos = function()
{
	static _meu_y = 0;
	var _alt = sprite_get_height(spr_produtos);
	var _larg = sprite_get_width(spr_produtos);
	var _marg = 20
	
	//Checando se o mouse está em cima
	
	_meu_y += rolagem(30, prod_x, prod_y, prod_w/2, prod_h);
	
	var _qtd = array_length(produtos);
	var _max = (_alt * _qtd + (_marg * _qtd) + _marg - prod_h)
	
	//Limitando a rolagem
	_meu_y = clamp(_meu_y, -_max, 0)
	
	for (var i = 0; i < array_length(produtos); i++)
	{
		var _x = 28;
		var _y = _meu_y + _marg + (i * _alt) + (i *_marg);
		with(produtos[i]) 
		{
			x = _x;
			y = _y + sprite_height/2;
		}
	}
}

desenha_managers = function()
{
	
	//Mudando o tamanho da surface com base na global exibe managers
	if(global.exibe_managers)
	{
		man_h = lerp(man_h, man_h_base, .1);
	}
	else
	{
		man_h = lerp(man_h, 1, .1);
	}
	
	if(surface_exists(surf_man))
	{
		surface_set_target(surf_man);
		
		draw_clear_alpha(c_black, 0);
		draw_rectangle_color(0, 0, man_w, man_h, c_black,c_black, c_black, c_black, 0);
		
		if(man_h > 3)
		{
			with(obj_manager)
			{
				desenha_manager();
				meu_x = other.man_x;
				meu_y = other.man_y;
			}
		}
		
		surface_reset_target();
		
		draw_surface(surf_man, man_x, man_y);
		
		surface_resize(surf_man, man_w, man_h);
	}
	else
	{
		surf_man = surface_create(man_w, man_h)
	}
}

//Criando a surface dos produtos
desenha_produtos = function()
{
	//Criando uma surface para desenhar os produtos
	//Checando se a surface existe
	if (surface_exists(surf_prod))
	{
		//fazer coisas na surface
		//Configurando a minha surface
		surface_set_target(surf_prod);
		draw_clear_alpha(c_black, 0);
		
		//draw_rectangle_color(0,0, prod_w, prod_h, c_black,c_black, c_black, c_black, false);
		
		//Desenhando o produto
		with(obj_produto)
		{
			desenha_produto();
			meu_x = other.prod_x;
			meu_y = other.prod_y;
		}
		
		//Resetando o alpha
		
		
		//Resetando a surface
		surface_reset_target();
		
		//Desenhando a surface
		draw_surface(surf_prod, prod_x, prod_y);
	}
	else //Se ela não existe
	{
		surf_prod = surface_create(prod_w, prod_h);
	}
}

//Cria a quantidade de produtos que tem na minha struct
cria_produtos(array_length(global.struct_produtos));
cria_managers();