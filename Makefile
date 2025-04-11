NAME			:=	printf.a

#	Compiler and Flags
COMPILER		:=	gcc
CFLAGS			+=	-Wall -Wextra
CFLAGS			+=	-Werror
# CFLAGS			+=	-Wunreachable-code -Wpedantic -Wconversion -Wshadow
CFLAGS			+=	-Wunreachable-code -Wconversion -Wshadow
CFLAGS			+=	-MMD -MP
# CFLAGS			+=	-g
#	Werror cannot go together with fsanitize, because fsanitize won't work correctly.
# CFLAGS			+=	-fsanitize=address

#	Utilities
RM				:=	rm -rf

#		Base Directories
SRC_DIR			:=	src/
INC_DIR			:=	include/
BUILD_DIR		:=	.build/

#		Source files by category
PRNTF			:=	printf.c					printf_process_format.c			printf_char.c			\
					printf_count.c				printf_flags.c					printf_int.c			\
					printf_sort_spec.c			printf_str_count.c				printf_str.c			\
					printf_unsigned.c			printf_utils.c

#		Extra Sources
PRINTF_SRCS		:=	$(addprefix $(SRC_DIR), $(PRNTF))

#		Generate object file names
PRINTF_OBJS		:=	$(PRINTF_SRCS:%.c=$(BUILD_DIR)%.o)

#		Generate Dependency files
DEPS			:=	$(PRINTF_OBJS:.o=.d)

#		Header files
HEADERS			:=	$(INC_DIR)ft_printf.h

#		Remove these created files
DELETE			:=	*.out			**/*.out			.DS_Store										\
					**/.DS_Store	.dSYM/				**/.dSYM/

#		Default target
all: $(NAME)

#		Main target
$(NAME): $(PRINTF_OBJS)
	@ar rcs $(NAME) $(PRINTF_OBJS)
	@printf "$(CREATED)" $@ $(CUR_DIR)

#		Compile .c files to .o files
$(BUILD_DIR)%.o: %.c $(HEADERS)
	@mkdir -p $(@D)
	$(COMPILER) $(CFLAGS) -I $(INC_DIR) -c $< -o $@

clean:
	@$(RM) $(BUILD_DIR) $(DELETE)
	@printf "$(REMOVED)" $(BUILD_DIR) $(CUR_DIR)$(BUILD_DIR)

fclean: clean
	@$(RM) $(NAME) $(DELETE)
	@printf "$(REMOVED)" $(NAME) $(CUR_DIR)

re: fclean all

print-%:
	$(info $($*))

#		Include dependencies
-include $(DEPS)

.PHONY:	all clean fclean re print-%

# ----------------------------------- colors --------------------------------- #
BOLD			=	\033[1m
GREEN			=	\033[32m
MAGENTA			=	\033[35m
CYAN			=	\033[36m
RESET			=	\033[0m

R_MARK_UP		=	$(MAGENTA)$(BOLD)
CA_MARK_UP		=	$(GREEN)$(BOLD)

# ----------------------------------- messages ------------------------------- #
CUR_DIR			:=	$(dir $(abspath $(firstword $(MAKEFILE_LIST))))
REMOVED			:=	$(R_MARK_UP)REMOVED $(CYAN)%s$(MAGENTA) (%s) $(RESET)\n
CREATED			:=	$(CA_MARK_UP)CREATED $(CYAN)%s$(GREEN) (%s) $(RESET)\n
