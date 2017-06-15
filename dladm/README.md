Dladm Cookbook
==============

     Dladm is used  to configure datalinks. The dladm  command is used to manage 
     the following types of network configuration: Physical interfaces – Ethernet,
     wireless, and InfiniBand.
     
     Dladm is the admin utility for Data-Link Interface which helps to display 
     informarthe like Link Status (UP/DOWN), Speed, Duplex, MTU, VLAN Tagged and 
     crucially statistics of network traffic on each of the interfaces historically
     as well as in real time.


Requirements
============
- Chef Client 12.16.42
- Oracle Solaris 11.3 SRU19

Attributes
==========

	Dladm Cookbook attributes 
	=========================

Bridge Attributes
=================

<table border="1" bgcolor="#8080dd">
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>Name</tt></td>
    <td>String</td>
    <td>name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>linkbridge</tt></td>
    <td>Array</td>
    <td>links</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>New Linkname</tt></td>
    <td>String</td>
    <td>link</td>
    <td><tt></tt></td>
  </tr>
</table>


VNIC Attributes
===============
<table border="1" bgcolor="#8080cc">
<head> Dladm cookbook VNIC Datatypes</head>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>Name</tt></td>
    <td>String</td>
    <td>name</td>
    <td><tt></tt></td>
  </tr>
 <tr>
    <td><tt>temporary</tt></td>
    <td>boolean </td>
    <td>temporary</td>
    <td>False</td>
  </tr>

  <tr>
    <td><tt>Slotid</tt></td>
    <td>Integer</td>
    <td>slot-id</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>Prefix</tt></td>
    <td>String</td>
    <td>prefix</td>
    <td><tt></tt></td>
  </tr>
 <tr>
    <td><tt>vrid</tt></td>
    <td>Integer</td>
    <td>vrid</td>
    <td><tt></tt></td>
  </tr>

  <tr>
    <td><tt>iptype</tt></td>
    <td>String</td>
    <td>iptype</td>
    <td><tt></tt></td>
  </tr>
</table>

VLAN Attributes
===============

<table border="1" bgcolor="#8080cc">
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>Name</tt></td>
    <td>String</td>
    <td>name</td>
    <td><tt></tt></td>
  </tr>
 <tr>
    <td><tt>temporary</tt></td>
    <td>boolean </td>
    <td>temporary</td>
    <td>false</td>
  </tr>
 <tr>
    <td><tt>force</tt></td>
    <td>boolean</td>
    <td>force</td>
    <td>false</td>
  </tr>
 <tr>
    <td><tt>Vid</tt></td>
    <td>Integer</td>
    <td>Vid</td>
    <td></td>
  </tr>
</table>


VXLAN attributes
================
 
 <table border="1" bgcolor="#8080cc">
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>Name</tt></td>
    <td>String</td>
    <td>name</td>
    <td><tt></tt></td>
  </tr>
 <tr>
    <td><tt>temporary</tt></td>
    <td>boolean </td>
    <td>temporary</td>
    <td>false</td>
  </tr>
 <tr>
    <td><tt>ip_address</tt></td>
    <td>String</td>
    <td>ip_address</td>
    <td><tt></tt></td>
  </tr>
 <tr>
    <td><tt>interface</tt></td>
    <td>String</td>
    <td>interface</td>
    <td></td>
  </tr>
</table>


Bridge
======
      To Create Bridge Instance
      -------------------------
```ruby 
dladm 'brooklyn' do
  protect "stp"
  forward_delay "12"
  linkbridge  %w[net0]
  action :create_bridge
end
```
     To Remove Bridge Instance
     ------------------------- 
```ruby
dladm 'brooklyn' do
  linkbridge %w[net0]
  action :remove_bridge
end
```
    To Deleting a Bridge Instance
    -----------------------------
 ```ruby
dladm 'brooklyn' do
  action :delete_bridge
end
```

VNIC
====

  To Delete the VNIC
  ------------------ 
```ruby
dladm 'vnic1' do 
  action :delete_vnic 
end 
```

  To Delete the VNIC 
  ------------------
```ruby
dladm 'vnic6' do
  action :delete_vnic 
end 
```
  To Create the VNIC
  ------------------
```ruby 
dladm 'vnic1' do 
  temporary true
  link "net0"
  mvalue "vrrp"
  vrid "100"
  iptype "inet"
  action :create_vnic 
end
```
  To Create the VNIC
   ------------------
```ruby
dladm 'vnic5' do
  temporary true
  link  "net0"
  mvalue "random"
  action :create_vnic
end
```
    To Create the VNIC
    ------------------
```ruby
dladm 'vnic6' do
  temporary true
  link  "net0"
  action :create_vnic
end
```
  To Modify the VNIC
  ------------------
```ruby
dladm 'vnic6' do
  temporary true
  mvalue "vrrp"
  vrid "110"
  iptype "inet"
  action :modify_vnic
end
```
  To Modify the VNIC
  ------------------
```ruby
dladm 'vnic5' do
  temporary true
  mvalue  "random"
  action :modify_vnic
end
```
VLAN
====

  To Delete the VLAN Configuration
  ---------------------------------
```ruby
dladm 'web1' do
  action :delete_vlan
end
```
  To Create the VLAN
  -------------------
```ruby
dladm 'web1' do 
  link "net0"
  force true
  temporary true
  vid "100"
  action :create_vlan
end
```
  To Modify the VLAN
  ------------------
```ruby
dladm 'web1' do 
  temporary true
  vid "150"
  action :modify_vlan
end
```

VXLAN
======

   To Delete the VXLAN
   -------------------
```ruby
dladm 'vxlan5' do
  action :delete_vxlan
end
```

  To Create the VXLAN
  --------------------
```ruby
dladm 'vxlan5' do
  temporary true
  ip_address "10.10.12.5"
  interface "net0"
  vni "10"
  action :create_vxlan
end
```
  To Delete the VXLAN
  -------------------
```ruby
dladm 'actg4' do
  action :delete_vxlan
end
```
  To Modify the VXLAN
  -------------------
```ruby
dladm 'web1' do
  temporary true
  vid "400"
  action :modify_vlan
end
```
  To Delete the VXLAN
  --------------------  
```ruby
dladm 'vxlan4' do
  action :delete_vxlan
end
```


Contributing
------------
Process for contributing.

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
     
License and Authors
-------------------
```text
- Author:: Pradhap Devarajan ([pradhap.devarajan@oracle.com](mailto:pradhap.devarajan@oracle.com))
	
	
Copyright:: 2017 Oracle and/or its affiliates. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
