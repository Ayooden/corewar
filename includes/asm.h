/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   asm.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hwolf <hwolf@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/17 13:34:18 by hwolf             #+#    #+#             */
/*   Updated: 2020/03/17 13:34:19 by hwolf            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef ASM_H
# define ASM_H
# include "libft.h"

typedef struct	s_project
{
	t_mem		*data;
	char		*name;
	char		*prog_size;
	char		*comment;
	char		*program;
	char		*current;
	char		*end;
}				t_project;

int				ft_project_init(char *file_name, t_project **project);
void			ft_usage();
int				ft_disassemble(t_project *project);

#endif
