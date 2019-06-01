#!/usr/bin/python3

import getopt
import os
import sys
import parted
import mountutils


def raw_write(source: str, target: str):
    mountutils.do_umount(target)
    bs: int = 4096
    size: int = 0
    inputFile = open(source, 'rb')
    total_size: float = float(os.path.getsize(source))

    # Check if the ISO can fit ... :)
    device = parted.getDevice(target)
    device_size = device.getLength() * device.sectorSize
    if (device.getLength() * device.sectorSize) < float(os.path.getsize(source)):
        inputFile.close()
        print("nospace")
        exit(3)

    increment = total_size / 100

    written: int = 0
    print("Source: " + str(source))
    print("Target: " + str(target))
    output = open(target, 'wb')
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

    if size == total_size:
        print("1.0")
        exit(0)
    else:
        print("failed")
        exit(4)


def main():
    # parse command line options
    source: str = str()
    target: str = str()

    try:
        opts, args = getopt.getopt(sys.argv[1:], "hs:t:", ["help", "source=", "target="])
    except getopt.error as msg:
        print(msg)
        print("for help use --help")
        sys.exit(2)

    for o, a in opts:
        if o in ("-h", "--help"):
            print("Usage: %s -s source -t target\n" % sys.argv[0])
            print("-s|--source          : source iso path")
            print("-t|--target          : target device path\n")
            print("Example : %s -s /foo/image.iso -t /dev/sdj" % sys.argv[0])
            sys.exit(0)
        elif o in ("-s"):
            source = a
        elif o in ("-t"):
            target = a

    argc = len(sys.argv)
    if argc < 5:
        print("Too few arguments")
        print("for help use --help")
        exit(2)

    raw_write(source, target)


if __name__ == "__main__":
    main()
