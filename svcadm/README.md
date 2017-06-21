SVCADM Cookbook
==============
 
 	   svcadm  issues  requests  for  actions on services executing within the
       service management facility. Actions  for  a  service  are carried  out
       by its assigned service restarter agent. The default service restarter 
       is svc.startd.
       
       If the -r option is specified, svcadm enables each  service instance and 
       recursively enables its dependencies
       
       If the -s  option is specified, svcadm  enables each  service instance.
       
       If  the  -t   option  is  specified,  svcadm  temporarily enables  each 
       service  instance.
       
       If instance_state is "maintenance", then for  each  service specified by
       the operands
 

Requirements
============

     * Chef Client 12.16.42
     * Oracle Solaris 11.3 SRU19


Attributes
==========

Svcadm Cookbook attributes.
---------------------------

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
    <td><tt>temporary</tt></td>
    <td>Boolean</td>
    <td>temporarily enables each 
       service instance</td> 
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>recursive</tt></td>
    <td>Boolean</td>
    <td>service instance and 
       recursively</td>
    <td>false</td>
  </tr>
  <tr>
    <td><tt>service</tt></td>
    <td>Boolean</td>
    <td>Service</td>
    <td>false</td>
  </tr>
  <tr>
    <td><tt>Maintenance</tt></td>
    <td>String</td>
    <td>Maintenance</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>Degraded</tt></td>
    <td>String</td>
    <td>Degraded</td>
    <td><tt></tt></td>
  </tr>
</table>


Usage
=====

To enable a service instance
----------------------------
```ruby
svcadm 'svc:/application/management/net-snmp:default' do
  temporary true 
  service true
  recursive true
  action :enable
end
```

To disable a service instance
----------------------------- 
```ruby
svcadm 'svc:/application/management/net-snmp:default' do
  temporary true 
  service  true
  action :disable
end
```
To restart a service instance
------------------------------
```ruby
svcadm 'svc:/application/management/net-snmp:default' do
  service  true
  action :restart
end
```
To refresh a service instance
-----------------------------
```ruby
svcadm 'svc:/application/management/net-snmp:default' do
  service  true
  action :refresh
end
```
To maintenance service
----------------------
```ruby
svcadm 'svc:/application/management/net-snmp:default' do
  state 'maintenance'
  service true
  action :mark
end
```
To clear service
-----------------------
```ruby
svcadm 'svc:/application/management/net-snmp:default' do
  service  true
  action :clear
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
