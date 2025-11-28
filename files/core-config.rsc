[admin@MikroTik] > /export
# 2025-11-28 12:06:03 by RouterOS 7.16
# software id = 
#
/interface bridge
add name=bridge-mgmt
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
set [ find default-name=ether7 ] disable-running-check=no
set [ find default-name=ether8 ] disable-running-check=no
/interface vlan
add interface=ether2 name=vlan60 vlan-id=60
add interface=ether2 name=vlan70 vlan-id=70
add interface=ether4 name=vlan99-capetown vlan-id=99
add interface=ether3 name=vlan99-mombasa vlan-id=99
add interface=ether2 name=vlan99-rabat vlan-id=99
/ip pool
add name=pool60 ranges=10.10.60.10-10.10.60.254
add name=pool70 ranges=10.10.70.10-10.10.70.254
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge-mgmt interface=vlan99-rabat
add bridge=bridge-mgmt interface=vlan99-mombasa
add bridge=bridge-mgmt interface=vlan99-capetown
/ip address
add address=10.10.99.1/24 interface=bridge-mgmt network=10.10.99.0
add address=192.168.122.2/24 interface=ether1 network=192.168.122.0
add address=10.10.60.1/24 interface=vlan60 network=10.10.60.0
add address=10.10.70.1/24 interface=vlan70 network=10.10.70.0
add address=10.10.80.1/30 interface=ether3 network=10.10.80.0
add address=10.10.80.5/30 interface=ether4 network=10.10.80.4
/ip dhcp-server
add address-pool=pool60 interface=vlan60 lease-time=8h name=dhcp60
add address-pool=pool70 interface=vlan70 lease-time=8h name=dhcp70
/ip dhcp-server network
add address=10.10.60.0/24 dns-server=8.8.8.8 gateway=10.10.60.1
add address=10.10.70.0/24 dns-server=8.8.8.8 gateway=10.10.70.1
/ip firewall filter
add action=accept chain=forward comment="Allow established/related" \
    connection-state=established,related
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip route
add comment="Default -> ISP" dst-address=0.0.0.0/0 gateway=192.168.122.1
add comment="Mombasa VLAN30" dst-address=10.10.30.0/24 gateway=10.10.80.2
add comment="Mombasa VLAN40" dst-address=10.10.40.0/24 gateway=10.10.80.2
/system note
set show-at-login=no

