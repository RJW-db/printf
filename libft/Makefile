NAME			:=	libft.a
COMPILER		:=	cc
RM				:=	rm -rf

#		Compiler flags
CFLAGS			 =	#-flto -Ofast

#		CFLAGS for testing
CFLAGS			+=	-MMD -MP
# CFLAGS			+=	-Wall -Wextra
# # Werror cannot go together with fsanitize, because fsanitize won't work correctly.
# CFLAGS			+=	-Werror
# CFLAGS			+=	-fsanitize=address
# CFLAGS			+=	-Wunused -Wuninitialized -Wunreachable-code
CFLAGS			+=	-g3

#		Build directory for objects and dependencies
BUILD_DIR		:=	.build/
INC_DIR			:=	include/

#		Directories
SRC_DIR			:=	src/
ALLOC_DIR		:=	$(SRC_DIR)alloc_functions/
ARRAY_DIR		:=	$(SRC_DIR)arrays_nested/
CNVRT_DIR		:=	$(SRC_DIR)conversions/
DYNAR_DIR		:=	$(SRC_DIR)dynamic_array/
G_N_L_DIR		:=	$(SRC_DIR)get_next_line/
LLIST_DIR		:=	$(SRC_DIR)linked_list/
MATH__DIR		:=	$(SRC_DIR)math/
MEDIT_DIR		:=	$(SRC_DIR)memory_edit/
MSRCH_DIR		:=	$(SRC_DIR)memory_search/
PRNTF_DIR		:=	$(SRC_DIR)printf/
PTCHR_DIR		:=	$(SRC_DIR)put_chars/
SCRTE_DIR		:=	$(SRC_DIR)string_create/
SEDIT_DIR		:=	$(SRC_DIR)string_edit/
SSRCH_DIR		:=	$(SRC_DIR)string_search/

#		Source files by category
ALLOC_SRC		:=	calloc.c					deallocation.c					realloc.c
ARRAY_SRC		:=	2d_array.c					2d_array_utils.c				2d_shrink_array.c	\
					splitted.c					split.c							split_set.c
CNVRT_SRC		:=	str_to_number.c
DYNAR_SRC		:=	dynarr.c					dynarr_insert.c
G_N_L_SRC		:=	get_next_line.c
LLIST_SRC		:=	linked_list.c				list_info.c						move_or_remove_nodes.c
MATH__SRC		:=	sign.c						digit_counter.c
MEDIT_SRC		:=	mem_edit.c
MSRCH_SRC		:=	mem_search.c
PRNTF_SRC		:=	printf.c					printf_process_format.c			printf_char.c		\
					printf_count.c				printf_flags.c					printf_int.c		\
					printf_sort_spec.c			printf_str_count.c				printf_str.c		\
					printf_unsigned.c			printf_utils.c
PTCHR_SRC		:=	put_chars_fd.c
SCRTE_SRC		:=	itoa.c						str_dup.c						string_create.c		\
					strjoin.c					strjoin_set_null.c				strtrim.c
SEDIT_SRC		:=	cpy_safe.c					cpy.c str_edit.c				swap_values.c
SSRCH_SRC		:=	str_len.c					str_compare.c					str_null_check.c	\
					str_search.c				str_search_2.c					find_char.c			\
					find_char_not.c				ptr_null_check.c				skip_characters.c	\
					str_len_comparing.c

#		Combine all sources with their directories
SRCS			:=	$(addprefix $(ALLOC_DIR), $(ALLOC_SRC)) \
					$(addprefix $(ARRAY_DIR), $(ARRAY_SRC)) \
					$(addprefix $(CNVRT_DIR), $(CNVRT_SRC)) \
					$(addprefix $(DYNAR_DIR), $(DYNAR_SRC)) \
					$(addprefix $(G_N_L_DIR), $(G_N_L_SRC)) \
					$(addprefix $(LLIST_DIR), $(LLIST_SRC)) \
					$(addprefix $(MATH__DIR), $(MATH__SRC)) \
					$(addprefix $(MEDIT_DIR), $(MEDIT_SRC)) \
					$(addprefix $(MSRCH_DIR), $(MSRCH_SRC)) \
					$(addprefix $(PRNTF_DIR), $(PRNTF_SRC)) \
					$(addprefix $(PTCHR_DIR), $(PTCHR_SRC)) \
					$(addprefix $(SCRTE_DIR), $(SCRTE_SRC)) \
					$(addprefix $(SEDIT_DIR), $(SEDIT_SRC)) \
					$(addprefix $(SSRCH_DIR), $(SSRCH_SRC))

#		Generate object file names
OBJS			:=	$(SRCS:%.c=$(BUILD_DIR)%.o)
#		Generate Dependency files
DEPS			:=	$(OBJS:.o=.d)
#		Header files
HEADERS			:=	$(INC_DIR)libft.h			$(INC_DIR)common_defs.h			$(INC_DIR)ft_printf.h	\
					$(INC_DIR)dynarr.h			$(INC_DIR)is_ctype1.h			$(INC_DIR)is_ctype2.h	\
					$(INC_DIR)validate_ptr.h

#		Remove these created files
DELETE			:=	*.out									\
					.DS_Store								\
					*.dSYM/

#		Default target
all: $(NAME)

#		Main target
$(NAME): $(OBJS)
	@ar rcs $(NAME) $(OBJS)

	@printf "$(CREATED)" $@ $(CUR_DIR)

#		Compile .c files to .o files
$(BUILD_DIR)%.o: %.c $(HEADERS)
	@mkdir -p $(@D)
	$(COMPILER) $(CFLAGS) -I $(INC_DIR) -c $< -o $@

clean:
	@$(RM) $(BUILD_DIR) $(DELETE)
	@printf "$(REMOVED)" $(BUILD_DIR) $(CUR_DIR)$(BUILD_DIR)

no_print_clean:
	@$(RM) $(BUILD_DIR) $(DELETE)

fclean: clean
	@$(RM) $(NAME)
	@printf "$(REMOVED)" $(NAME) $(CUR_DIR)

no_print_fclean:	no_print_clean
	@$(RM) $(NAME)
	@printf "$(REMOVED)" $(NAME) $(CUR_DIR)

re: fclean all

print-%:
	$(info $($*))

#		Include dependencies
-include $(DEPS)

.PHONY: all clean no_print_clean fclean no_print_fclean re print-%

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