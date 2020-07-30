# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ayooden <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/05 14:59:34 by ayooden           #+#    #+#              #
#    Updated: 2020/03/17 14:41:38 by ayooden          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COREWAR_SRC	=	src/corewar/ft_usage.c \
				src/corewar/ft_print_error.c \
				src/corewar/ft_init_game.c \
				src/corewar/ft_game_orver.c \
				src/corewar/ft_print_arena.c \
				src/corewar/ft_parse_input.c \
				src/corewar/ft_parse_hero.c \
				src/corewar/ft_past_heroes.c \
				src/corewar/ft_init_cursors.c \
				src/corewar/ft_battle.c \
				src/corewar/ft_doomsday.c \
				src/corewar/ft_execute.c \
				src/corewar/ft_options_2.c \
				src/corewar/ft_get_heroes.c \
				src/corewar/ft_check_opt.c \
				src/corewar/ft_get_heroes_file.c \
				src/corewar/ft_print_resualt.c \
				src/corewar/ft_atoin.c \
				src/corewar/ft_new_cursor.c \
				src/corewar/ft_get_op.c \
				src/corewar/op/op_live.c \
				src/corewar/op/op_add.c \
				src/corewar/op/op_ld.c \
				src/corewar/op/utils.c \
				src/corewar/op/op_st.c \
				src/corewar/op/op_zjmp.c \
				src/corewar/op/op_sti.c \
				src/corewar/op/op_fork.c \
				src/corewar/op/op_sub.c \
				src/corewar/op/op_and.c \
				src/corewar/op/op_or.c \
				src/corewar/ft_print_arena_utils.c \
				src/corewar/ft_past_reg.c \
				src/corewar/op/op_xor.c \
				src/corewar/op/op_ldi.c \
				src/corewar/op/op_lld.c \
				src/corewar/op/op_lldi.c \
				src/corewar/op/op_lfork.c \
				src/corewar/op/op_aff.c \
				src/corewar/ft_options.c \
				src/logger/logger.c \
				src/corewar/corewar.c

VIS_SRC =		src/vis/ft_delete_window.c \
				src/vis/ft_draw_line.c \
				src/vis/ft_draw_rectangle.c \
				src/vis/ft_init_window.c \
				src/vis/ft_close_window.c \
				src/vis/ft_key_press.c \
				src/vis/ft_put_logo.c \
				src/vis/ft_draw_grid.c \
				src/vis/ft_get_color.c \
				src/vis/ft_draw_champions.c \
				src/vis/ft_redraw_game_filed.c \
				src/vis/ft_rewrite_point.c \
				src/vis/ft_draw_circle.c \
				src/vis/ft_put_info.c \
				src/vis/ft_check_color.c \
				src/vis/ft_draw_heart.c \
				src/vis/ft_check_lives.c \
				src/vis/ft_draw_start_field.c \
				src/vis/ft_draw_game_field.c

VIS_OBJ	=		$(VIS_SRC:.c=.o)
COREWAR_OBJ	=	$(COREWAR_SRC:.c=.o)

VM_NAME			=	corewar

LIBFTDIR		=	lib/libft
LFTFLAG			=	-L$(LIBFTDIR) -lft
LFT				=	$(LIBFTDIR)libft.a

PRINTF			=	ft_printf
PRINTFDIR		= 	lib/ft_printf
PRINTFFLAG		=	-L$(PRINTFDIR) -lftprintf

MLXDIR			=	minilibx
MLXFLAG			=	-L$(MLXDIR) -lmlx
MLX				= 	$(MLXDIR)/libmlx.a

INCLS			=	-Iincludes/ -I$(LIBFTDIR)/includes -I$(MLXDIR) -I$(PRINTFDIR)/includes
DEPS			=	includes/

CC              =   clang
CFLAGS			=	-Wall -Werror -Wextra

FRAMEWORK		=	-framework OpenGL -framework AppKit

.PHONY: all clean fclean re

all: $(LFT) $(MLX) $(PRINTF) $(VM_NAME)

%.o:%.c $(DEPS)
				$(CC) $(CFLAG) $(INCLS) -c $< -o $@

$(LFT):
				@$(MAKE) -C $(LIBFTDIR)

$(MLX):
				@$(MAKE) -C $(MLXDIR)

$(PRINTF):
				@$(MAKE) -C $(PRINTFDIR)

$(VM_NAME): $(COREWAR_OBJ) $(VIS_OBJ)
				$(CC) $(CFLAGS) $(VIS_OBJ) $(COREWAR_OBJ) $(INCL) $(LFTFLAG) $(MLXFLAG) $(PRINTFFLAG) $(FRAMEWORK) -o $(VM_NAME)

clean:
				rm -f $(VIS_OBJ)
				rm -f $(COREWAR_OBJ)
				make clean -C $(LIBFTDIR)/
				make clean -C $(PRINTFDIR)/

fclean:				
				rm -f $(VIS_OBJ)
				rm -f $(COREWAR_OBJ)
				rm -f $(VM_NAME)
				make clean -C $(MLXDIR)/
				make fclean -C $(PRINTFDIR)/
				make fclean -C $(LIBFTDIR)/

re: 			fclean all
