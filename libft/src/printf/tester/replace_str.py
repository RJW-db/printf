lines = """
testing(index++, "%-+-d!", 42);
testing(index++, "%-+-d!", -42);
testing(index++, "%3d!", 42000);
testing(index++, "%3d!", -42000);
"""

# Split the input into lines
lines = lines.split('\n')

# Iterate through each line and replace index++
for i in range(1, len(lines) + 1):
    if "testing(index++," in lines[i-1]:
        lines[i-1] = lines[i-1].replace("testing(index++,", f"testing({i - 1},")

# Join the modified lines back into a string
modified_lines = '\n'.join(lines)

print(modified_lines)