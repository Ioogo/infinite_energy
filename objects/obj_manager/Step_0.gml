/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
var _mouse_sobre = position_meeting(mouse_x,mouse_y,id);
var _mouse_click = mouse_check_button_pressed(mb_left);

if(_mouse_sobre)
{
	if(_mouse_click)
	{
		if(global.energy >= custo)
		{
			global.energy -= custo;
			//Avisando que foi comprado
			global.manager[indice] = true;
			comprado = true;
			
			//Colocando função no manager
			global.fontes[indice].fazer = true;
			global.fontes[indice].tenho_manager = true;
		}
	}
}