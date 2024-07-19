/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
atualiza_tempo();

//Deixando o jogo mais rápido
if(keyboard_check(vk_space))
{
	global.game_spd = 10;
}
else
{
	global.game_spd = 1;
}

if (keyboard_check_pressed(ord("L")))
{
	global.energy += 1000
}

gerencia_produtos()