// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function convert_num(_num)
{
	var _simbolo = "R$: ";
	switch(global.idioma)
	{
		case 1: _simbolo = "$ "; break;
		case 2: _simbolo = "S"; break;
	}
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
	
	var _str2 = _simbolo + string_format(_custo2, 0, 2) + _valores[_i];
	return _str2;
}

//Salvando o jogo
function save_game()
{
	//Abrindo o arquivo
	var _file = file_text_open_write("save.json");
	
	//Salvando os produtos comprados
	//Criando um vetor
	var _produtos = array_create(array_length(global.struct_produtos), 0);
	
	//Ajustando as informações de um outro jeito
	for (var i = 0; i < array_length(_produtos); i++)
	{
		//Criando a estrutura para salvar no array
		var _estrutura = 
		{
			comprado: global.fontes[i].comprado,
			level: global.fontes[i].level,
			tenho_manager: global.fontes[i].tenho_manager
		};
		//show_message(_estrutura);
		//Colocando as informações no array
		_produtos[i] = _estrutura
	}
	
	
	////Criando um metodo para criar a estrutura com os dados de cada produtos
	//var _salva_dados = function(_elemento, _indice)
	//{
	//	//Pegando as informações do elemento
	//	_elemento = 
	//	{
	//		comprado : global.fontes[_indice].comprado,
	//		level : global.fontes[_indice].level,
	//		tenho_manager : global.fontes[_indice].tenho_manager
	//	};
		
	//	return _elemento
	//}
	
	////Iterar pelo array e criar a estrutura com os dados
	//var _produtos = array_map(_qtd_prod, _salva_dados);
	
	//Salvando o dinheiro por segundo
	
	//Pegando o momento que o jogo foi fechado
	var _tempo_atual = date_current_datetime();
	
	//Criando a estrutura do que vai ser salvo
	var _struct = 
	{
		gold : global.energy,
		produtos : _produtos,
		gold_seg : global.energy_seg,
		tempo : _tempo_atual
	};
	
	//Convertendo a struct em String
	var _string = json_stringify(_struct);
	
	//Salvando
	file_text_write_string(_file, _string);
	
	//Fechando o arquivo
	file_text_close(_file);
}

//Carregando o jogo
function load_game()
{
	//Abrindo o arquivo se ele existir
	if (file_exists("save.json"))
	{
		//Abrindo arquivo
		var _file = file_text_open_read("save.json");
	
		//Pegando as informações do arquivo
	
		var _string = file_text_read_string(_file);
	
		//Convertendo a string em uma struct
		var _struct = json_parse(_string);
	
		//Passando a energia para o jogo
		global.energy = _struct.gold;
	
		//Passando as informações dos produtos para o jogo
		global.produtos_info = _struct.produtos;
		
		//Checando quanto tempo passou
		 var _tempo = date_current_datetime();
		 var _dif = date_second_span(_struct.tempo, _tempo)
		 var _dinheiro_feito = _dif * _struct.gold_seg;
		 var _str = convert_num(_dinheiro_feito);
		 if (global.idioma == 0)
		 {
			 show_message("Enquanto você estava fora lucrou: " + string(_str));
		 }
		 else if(global.idioma == 1)
		 {
			 show_message("While you were away profited: " + string(_str));
		 }
		
		//Sabendo quanto dinheiro eu fiz desde que o jogo foi fechado
		
		//Atualizando o gold
		global.energy += _dinheiro_feito;
		
		//Fechando o arquivo
		file_text_close(_file);
	}
}

function carrega_dados(_idioma = 0)
{
	var _arquivo = "dados.json";
	switch(_idioma)
	{
		case 1: _arquivo = "dados_en.json"; break;
		case 2: _arquivo = "dados_es.json"; break;
	}
	
	//Abrindo o meu json
	var _file = file_text_open_read(_arquivo);
	var _text = "";
	//Loop para ler todo o meu file
	while(true)
	{
		//se ele chegou no final do file, ele sai do loop
		if (file_text_eof(_file))
		{
			break;
		}
		else 
		{
			var _linha = file_text_readln(_file);
			_text += _linha;
		}
	}
	//Convertendo esse texto em uma struct
	global.struct_produtos = json_parse(_text).items;

	//fechando o arquivo
	file_text_close(_file);
}