/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if(comprado)
{
	comprado = true;
	if(fazer)
	{
		//Aumentando o timer
		timer += global.framerate;

		if(timer > tempo)
		{
			timer = 0;
			fazer = tenho_manager;
			//Dando o lucro
			global.energy += lucro;
		}
	}
}

//Checando se foi comprado
var _mouse_sobre = position_meeting(mouse_x,mouse_y,id);
var _mouse_click = mouse_check_button_pressed(mb_left);
var _x1 = x + 42;
var _y1 = y + 8;
var _x2 = _x1 + 96;
var _y2 = _y1 + 32;
var _mouse_caixa = point_in_rectangle(mouse_x,mouse_y,_x1,_y1,_x2,_y2);
efeito_comprar = _mouse_caixa;
if(_mouse_sobre)
{
	if(_mouse_click)
	{
		fazer = true;
	}
	//Checando se está posicionado no local de compra
	var _x1 = x + 42;
	var _y1 = y + 8;
	var _x2 = _x1 + 64;
	var _y2 = _y1 + 32;

	if(_mouse_caixa)
	{
		//Ativando o efeito de compra
		//Checando se a pessoa clicou
		if(_mouse_click)
		{
			//Checando se tem energia o suficiente para comprar
			if(global.energy >= custo)
			{
				//Descontando a energia
				global.energy -= custo;
				comprado = true;
				
				//Aumenta o custo
				custo *= 2;
				//Ajustando o lucro
				level++;
				//Lucro com base no lvl e lucro base
				lucro = lucro_base * level;
			}
		}
	}
}