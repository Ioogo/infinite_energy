/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//lista dos produtos

produtos = [];

base_y = 80;
produtos_y = 0 + base_y;

//criando os produtos dentro da lista dos produtos
cria_produtos = function(_qtd = 1) 
{
	for (var i = 0; i < _qtd; i++)
	{
		produtos[i] = instance_create_layer(0, 0, layer, obj_produto, {indice : i});
		with(produtos[i])
		{
			indice = i;
			tempo = i + 1; 
			custo = i + 1;
			lucro_base = i + 1;
			
			//Atualizando 
		}
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

gerencia_produtos = function()
{
	rolagem_produtos()
	
	for (var i = 0; i < array_length(produtos); i++)
	{
		var _marg = 20;
		var _x = 160;
		var _y = produtos_y + _marg + (i * 96) + (i *_marg);
		with(produtos[i]) 
		{
			x = _x;
			y = _y + sprite_height/2;
		}
	}
}

cria_produtos(10);

show_message(global.fontes)