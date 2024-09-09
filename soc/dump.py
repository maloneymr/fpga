import sys

START_ADDR = 0x20_0000

def dump_binary_to_hex(input_file: str, output_file: str):
    try:
        with open(input_file, 'rb') as bin_file, open(output_file, 'w') as text_file:
            for _ in range(START_ADDR):
                print('00', file=text_file)
            byte = bin_file.read(1)  # Read one byte at a time
            while byte:
                # Convert byte to hexadecimal and write to the text file
                text_file.write(f"{int.from_bytes(byte, 'big'):02X}\n")
                byte = bin_file.read(1)  # Read the next byte
        print(f"Dumped binary content from {input_file} to {output_file} successfully.")
    except FileNotFoundError:
        print(f"Error: File {input_file} not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

input_binary_file = sys.argv[1]
output_text_file = sys.argv[2]

dump_binary_to_hex(input_binary_file, output_text_file)
