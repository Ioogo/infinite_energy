// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//Configurando o tempo do jogo?
//Definindo os frames por segundo (fps) do jogo
#macro FRAMES 160
game_set_speed(FRAMES,gamespeed_fps);

//Usando o deltatime para ajustar o tempo do meu jogo
//Velocidade do jogo
global.game_spd = 1;
//Definindo o framerate do jogo
global.framerate = global.game_spd/FRAMES;
//Identificando a duração de 1 segundo no jogo
global.gamesegundos = 0;

//Função para atualizar o tempo do jogo

function atualiza_tempo()
{
	//Pegando o tempo em segundos
	global.gamesegundos = delta_time / 1000000;
	global.framerate = global.gamesegundos * global.game_spd;
}

global.exibe_managers = false;

//Dinheiro
global.energy = 4;

//Informações dos manager
global.manager = [0,0,0,0,0,0,0,0];

//Lista das fontes de energia
global.fontes = [0,0,0,0,0,0,0,0];

//Abrindo o meu json
var _file = file_text_open_read("dados.json");
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

//show_message(_struct.items[0]);