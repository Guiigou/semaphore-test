[admin@MikroTik] /ip/route> /export
# 2025-11-28 12:06:57 by RouterOS 7.16
# software id = 
#
/interface bridge
add name=bridge-lan vlan-filtering=yes
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
add interface=bridge-lan name=vlan30 vlan-id=30
add interface=bridge-lan name=vlan40 vlan-id=40
add interface=ether1 name=vlan99 vlan-id=99
/ip pool
add name=pool30 ranges=10.10.30.10-10.10.30.254
add name=pool40 ranges=10.10.40.10-10.10.40.254
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge-lan interface=ether2 pvid=30
add bridge=bridge-lan interface=ether3 pvid=30
add bridge=bridge-lan interface=ether4 pvid=30
add bridge=bridge-lan interface=ether5 pvid=40
add bridge=bridge-lan interface=ether6 pvid=40
/interface bridge vlan
add bridge=bridge-lan tagged=bridge-lan untagged=ether2,ether3,ether4 \
    vlan-ids=30
add bridge=bridge-lan tagged=bridge-lan untagged=ether5,ether6 vlan-ids=40
/ip address
add address=10.10.80.2/30 comment="Link to Core" interface=ether1 network=\
    10.10.80.0
add address=10.10.30.1/24 comment="GW VLAN30" interface=vlan30 network=\
    10.10.30.0
add address=10.10.40.1/24 comment="GW VLAN40" interface=vlan40 network=\
    10.10.40.0
add address=10.10.99.2/24 comment="Mgmt Mombasa" interface=vlan99 network=\
    10.10.99.0
/ip dhcp-server
add address-pool=pool30 interface=vlan30 lease-time=8h name=dhcp30
add address-pool=pool40 interface=vlan40 lease-time=8h name=dhcp40
/ip dhcp-server network
add address=10.10.30.0/24 dns-server=8.8.8.8,1.1.1.1 gateway=10.10.30.1
add address=10.10.40.0/24 dns-server=8.8.8.8,1.1.1.1 gateway=10.10.40.1
/ip route
add comment="Default -> Core" dst-address=0.0.0.0/0 gateway=10.10.80.1
/system note
set show-at-login=no

