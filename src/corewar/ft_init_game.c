#include "corewar.h"
#include "libft.h"

static void ft_start_game(t_game *game)
{
	game->cycles_to_die = CYCLE_TO_DIE;
}


t_game *ft_init_game(t_broker *broker)
{
	t_game *game;
	int     temp;

	if (!(game = (t_game*)malloc(sizeof(*game))))
		return (NULL);
	ft_bzero(game, sizeof(*game));
	ft_start_game(game);
	if(!(game->arena = (void*)malloc(MEM_SIZE)))
		return (ft_game_over(&game));
	if(!(game->log = ft_logger_init(NULL)))
		return (ft_game_over(&game));
	ft_bzero(game->arena, MEM_SIZE);
	temp = MEM_SIZE - 1;
	while (temp--)
	    game->color[temp] = grey;
	temp = MAX_PLAYERS;
	while (temp--)
	    game->lives_count[temp] = 0;
	game->doomsday = false;
	game->doomsday_count = 0;
	game->mutex = &(broker->mutex);
	game->cv = &(broker->game_cv);
	game->start = &(broker->game_start);
	game->fps = &(broker->fps);
	game->delay = false;
	return (game);
}