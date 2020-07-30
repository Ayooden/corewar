/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   op_live.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hwolf <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/17 13:34:18 by hwolf             #+#    #+#             */
/*   Updated: 2020/03/17 13:34:19 by hwolf            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"
#include "corewar.h"

t_err	op_live(t_game *game)
{
	t_cursor	*cursor;
	int32_t		arg;

	cursor = game->cursor;
	cursor->current = ft_mod(cursor->pc + OP_LEN, MEM_SIZE);
	arg = ft_get_data(game, DIR_CODE);
	game->check_live++;
	cursor->alive = true;
	if ((-arg > 0 && -arg <= MAX_PLAYERS) &&
		game->input->hero_list[-arg - 1].id == -arg)
	{
		game->winner = game->input->hero_list - arg - 1;
		if (!game->input->quiet)
			ft_set_color(white - arg);
		cursor->color = white - arg + 5;
		game->color[cursor->pc % MEM_SIZE] = cursor->color + 5;
		game->lives_count[-arg - 1]++;
		if (!game->input->quiet)
			ft_printf("A process shows that player %d (\"%s\") is alive"
			RESET"\n",
			-arg, (game->winner)->header.prog_name);
	}
	return (success);
}
