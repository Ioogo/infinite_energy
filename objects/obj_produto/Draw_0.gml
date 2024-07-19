/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

draw_text(x, y, tenho_manager);

//Só vou aparecer se a pessoa tiver dinheiro para me comprar
if (global.energy > custo/2 or comprado)
{
	desenha_produto();
}
else 
{
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_gray, .6);
}

draw_set_color(c_black);
draw_text(x, y, tenho_manager);
draw_set_color(-1);