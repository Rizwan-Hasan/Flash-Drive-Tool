import os

source: str = "/run/media/rizwan/Softwares/Xiaopan 6.4.1.iso"
target: str = "/dev/sdc"

bs: int = 4096
size: int = 0

inputFile = open(source, 'rb')
output = open(target, 'wb')

written: int = 0
total_size: float = float(os.path.getsize(source))
increment = total_size / 100

while True:
    buffer = inputFile.read(bs)

    if len(buffer) == 0:
        break

    output.write(buffer)

    size = size + len(buffer)
    written = written + len(buffer)
    print(size / total_size)
    if (written >= increment):
        output.flush()
        os.fsync(output.fileno())
        written = 0

output.flush()
os.fsync(output.fileno())
inputFile.close()
output.close()
