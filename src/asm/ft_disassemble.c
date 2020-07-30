/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_disassemble.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hwolf <hwolf@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/17 13:34:18 by hwolf             #+#    #+#             */
/*   Updated: 2020/03/17 13:34:19 by hwolf            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "corewar_op.h"
#include "ft_printf.h"
#include "asm.h"
#include "corewar.h"

int32_t		ft_get_code(char *head, size_t *address, int op, int arg_type)
{
	int	arg;

	arg = 0;
	if (arg_type == DIR_CODE)
	{
		if (g_op_tab[op].dir_size == 2)
			arg = ft_atoi_vm(head, address,
					g_op_tab[op].dir_size).v_2;
		else
			arg = ft_atoi_vm(head, address,
					g_op_tab[op].dir_size).v_4;
	}
	if (arg_type == IND_CODE)
		arg = ft_atoi_vm(head, address, IND_SIZE).v_2;
	if (arg_type == REG_CODE)
		arg = ft_atoi_vm(head, address, REG_LEN).v_1;
	return (arg);
}

static void	ft_check_type(t_project *project, union u_types *type,
							int op, size_t *current)
{
	type->value = ft_atoi_vm(project->current, current, TYPE_LEN).v_1;
	type->args.arg1 == REG_CODE ? ft_printf("r") : ft_printf("%%");
	ft_printf("%d", ft_get_code(project->current, current,
										op, type->args.arg1));
	if (g_op_tab[op].arg_count > 1)
	{
		type->args.arg2 == REG_CODE ? ft_printf(", r") : ft_printf(", %%");
		ft_printf("%d", ft_get_code(project->current, current,
											op, type->args.arg2));
	}
	if (g_op_tab[op].arg_count > 2)
	{
		type->args.arg3 == REG_CODE ? ft_printf(", r") : ft_printf(", %%");
		ft_printf(", %d", ft_get_code(project->current, current,
												op, type->args.arg3));
	}
	ft_printf("\n");
}

int			ft_disassemble(t_project *project)
{
	int				op;
	union u_types	type;
	size_t			current;
	int32_t			arg;

	op = *project->current - 1;
	if (op >= 0 && op < 16)
	{
		ft_printf("%s ", g_op_tab[op].name);
		current = OP_LEN;
		if (g_op_tab[op].arg_type)
			ft_check_type(project, &type, op, &current);
		else
		{
			arg = ft_get_code(project->current, &current, op, DIR_CODE);
			ft_printf("%%%d\n", arg);
		}
		project->current += current;
		return (1);
	}
	ft_printf("err\n");
	project->current++;
	return (0);
}
