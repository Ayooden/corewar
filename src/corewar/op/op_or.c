#include "corewar.h"

t_err op_or(t_game* game)
{
	union u_types type;
	t_cursor *cursor;
	int32_t arg1;
	int32_t arg2;
	int32_t arg3;

	cursor = game->cursor;
	cursor->current = ft_mod(cursor->current + OP_LEN, MEM_SIZE);
	type.value = ft_atoi_vm(game->arena, &cursor->current, TYPE_LEN).v_1;
	arg1 = ft_get_arg(game, type.arg1, true);
	arg2 = ft_get_arg(game, type.arg2, true);
	arg3 = ft_get_data(game, type.arg3);
	cursor->regs[arg3 - 1] = arg1 | arg2;
	cursor->carry = cursor->regs[arg3 - 1] ? false : true;
	return (success);
}