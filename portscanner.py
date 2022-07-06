#Simple Python port scanner for when nmap isn't available

import socket

ip = input("Enter the IP address: ")

for port in range(1,1000):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex((ip, port))
    if result == 0:
        print("Port {} is open".format(port))
    sock.close()
