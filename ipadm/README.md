IPADM Cookbook
==============
 
     Ipadm manages IP interfaces and IP addresses more efficiently by being
     the tool uniquely for IP interface administration, unlike the ifconfig 
     command that is used for purposes other than interface configuration.

     Ipadm provides an option to implement persistent interface and address
     configuration settings.


Requirements
============

     * Chef Client 12.16.42
     * Oracle Solaris 11.3 SRU19


Attributes
==========

Ipadm Cookbook attributes.

<table border="1" bgcolor="#8080cc">
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>name</tt></td>
    <td>String</td>
    <td>name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>addresstype</tt></td>
    <td>String</td>
    <td>static|dhcp|addrconf</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>ipaddress</tt></td>
    <td>String</td>
    <td>ipaddress</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>temporary</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr>
</table>


Usage
=====


To set static IP on interface net1/v4
-------------------------------------
```ruby
ipadm 'net1/v4' do
  addresstype "static"
  ipaddress    "192.168.208.5/24"
 action :create_addr
end
```

To set static IP on interface as net1/v4 as temporary
-----------------------------------------------------
```ruby
ipadm 'net1/v4' do
  addresstype "static"
  ipaddress    "192.168.208.5/24"
  temporary true
 action :create_addr
end
```

To remove address on net1/v4
------------------------------
```ruby
ipadm 'net1/v4' do
  action :delete_addr
end
```

To disable address on net1/v4
-----------------------------
```ruby
ipadm 'net1/v4' do
  action :disable_addr
end
```
To enable disabled address on net1/v4 
-------------------------------------
```ruby
ipadm 'net1/v4' do
  action :enable_addr
end
```
To bring down an address on net1/v4
-------------------------------------
```ruby
ipadm 'net1/v4' do
  temporary true
  action :down_addr
end
```
To bring up an address on net1/v4
---------------------------------
```ruby
ipadm 'net1/v4' do
  temporary true
  action :up_addr
end
```
To disable interface net1
-------------------------
```ruby
ipadm 'net1' do
  action :disable_if
end
```
To enable interface net1
-------------------------
```ruby
ipadm 'net1' do
  action :enable_if
end
```
To delete IP on net1
---------------------
```ruby
ipadm 'net1' do
  action :delete_ip
end
```
To create IP on net1
--------------------
```ruby
ipadm 'net1' do
    action :create_ip
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

