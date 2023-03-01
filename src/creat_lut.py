import math

# Define constants
size = 1024
amplitude = 32767

# Define lookup table for sin(x)
sin_table = [int(amplitude * math.sin(2 * math.pi * i / size)) for i in range(size)]

# Define lookup table for cos(x)
cos_table = [int(amplitude * math.cos(2 * math.pi * i / size)) for i in range(size)]

# Print the lookup tables
print("type t_sin_table is array (0 to %d-1) of integer range -32768 to 32767;" % size)
print("constant c_sin_table: t_sin_table := (")
for i in range(size):
    print("%5d, " % sin_table[i], end='')
    if (i+1) % 16 == 0:
        print("")
print(");")

print("type t_cos_table is array (0 to %d-1) of integer range -32768 to 32767;" % size)
print("constant c_cos_table: t_cos_table := (")
for i in range(size):
    print("%5d, " % cos_table[i], end='')
    if (i+1) % 16 == 0:
        print("")
print(");")
