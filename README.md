
# ft_printf
`ft_printf` is a reimplementation of the C standard library `printf()` function as a static library (`printf.a`).  
It focuses on correctness, extensibility, and strict 42 compliance (Norminette, Makefile rules, memory safety).

This implementation supports the mandatory conversions required by the subject and also includes the bonus: flags, width, and precision handling.

Because `ft_putnbr()` and `ft_putstr()` aren’t enough.

## Table of Contents
- [Features](#features)
- [Supported Conversions](#supported-conversions)
- [Bonus (Flags)](#bonus-flags)
- [Technical Choices](#technical-choices)
- [Project Rules (42 Subject)](#project-rules-42-subject)
- [Build](#build)
- [Example](#example)
- [Integration](#integration)
- [Subject compliance](#subject-compliance)
- [Testing checklist](#testing-checklist)


## Features
- Drop-in style API: `ft_printf()` behaves like `printf()` for the supported conversions.
- Extra entry points:
  - `ft_dprintf(int fd, const char *format, ...)`
  - `ft_vprintf(const char *format, va_list args)`
- Robust handling of edge cases (including `NULL` strings/pointers).
- Deterministic formatting pipeline designed to be extensible.

## Supported Conversions
Mandatory conversions (exactly as required by the subject):
- `%c` Print a single character.
- `%s` Print a string.
- `%p` Print a pointer in hexadecimal form.
- `%d` Print a signed decimal integer.
- `%i` Print a signed integer (base 10).
- `%u` Print an unsigned decimal integer.
- `%x` Print an unsigned integer in hexadecimal (lowercase).
- `%X` Print an unsigned integer in hexadecimal (uppercase).
- `%%` Print a literal percent sign.

## Bonus (Flags)
This project includes the bonus requirements:
- Flags: `-`, `0`, `.`, minimum field width (including combinations)
- Additional flags: `#`, `+`, and space

Notes (behavior matches `printf()` for the supported subset):
- `-` left-justifies within field width.
- `0` pads numeric fields with leading zeroes (ignored when `-` is active; also interacts with precision).
- `.` enables precision:
  - For integers: minimum digit count; if value is `0` and precision is `0`, prints nothing.
  - For strings: maximum character count.
- `#` prefixes hex with `0x` / `0X` for non-zero values.
- `+` always prints a sign for signed conversions.
- (space) prints a leading space if no sign is printed.

## Technical Choices
### Single-allocation output model
This `ft_printf` uses a **single malloc** per call to build the final output string, then writes it and frees it.
- Pros: one `write()`, easy cleanup, predictable ownership.
- Tradeoff: requires a counting pass to compute the final length before allocation.

### Two-phase formatting design (count - render)
The internal architecture uses a parsing step + per-specifier handlers:
1. Parse format and flags into a formatting context (`t_p`) and flag state (`t_fl`).
2. Count output size for each conversion/segment.
3. Allocate one buffer of the final size.
4. Render into the buffer, then `write()` and free.

This structure makes it straightforward to extend supported formatting behavior without rewriting the whole printer.

## Project Rules (42 Subject)
This section mirrors the typical 42 `ft_printf` subject requirements.

### General rules
- Must be written in C.
- Must follow the Norm (Norminette). Bonus files/functions are included in the norm check.
- Must not crash unexpectedly (segfault, bus error, double free, etc.), except undefined behavior.
- All heap allocations must be freed properly; memory leaks are not tolerated.

### Mandatory part
- Output: a static library named `printf.a` at the root of the repository.
- Required public header: `ft_printf.h`, containing the prototype of `ft_printf()`.
- Prototype:
  - `int ft_printf(const char *fmt, ...);`
- You must NOT implement the original `printf()` internal buffer management.
- Must handle conversions: `cspdiuxX%`.
- Must use `ar` to create the library (no `libtool`).

### Authorized external functions
- `malloc`, `free`, `write`
- `va_start`, `va_arg`, `va_copy`, `va_end`

### Makefile requirements
Your Makefile must:
- Compile with `-Wall -Wextra -Werror` using `cc`.
- Include rules: `$(NAME)`, `all`, `clean`, `fclean`, `re`.
- Avoid unnecessary relinking.

## Build
Build the static library:

```sh
make          # build printf.a
make clean    # remove build artifacts
make fclean   # clean + remove push_swap checker (and extern deps)
make re       # fclean + build
make valgrind # debug flags
make debug    # debug flags + sanitizers (per Makefile)
```

## Example
Use in a project
```c
#include "ft_printf.h"

int main(void)
{
    ft_printf("Hello %s, value=%+08d hex=%#x\n", "world", 42, 42);
    return (0);
}
```

## Integration:
```sh
cc -I include -Wall -Wextra -Werror main.c printf.a -o demo
```

### Note:
- For static libraries, put object files/sources before the .a if you hit undefined references.


## Subject compliance
- Norminette: all files pass.
- Makefile: includes required rules and flags; does not relink unnecessarily.
- Memory: no leaks; all allocated memory freed (single-allocation output freed after write).
- Stability: no unexpected crashes on valid inputs; `NULL` cases handled gracefully.

## Testing checklist
Compare output vs system `printf()` for:
- width/precision interactions
- sign handling (`+` and space)
- `#` behavior for `%x` / `%X`
- `NULL` handling for `%s` and `%p`
- edge integer values (`INT_MIN`, `0`, etc.)
