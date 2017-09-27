pkg_mediator
============

	Multiple versions of an application or tool in the same  image. If the
	different versions of the application are delivered as part of the same
	mediation, then  one  can easily reset the  version that is the default
	or preferred version.
		
	A mediation is a set of links to different implementations of an application,
	where each of the links has the same mediator name and the same link path but
	different target link paths.
		
	Example java, python and gcc etc can have multiple versions can	be delivered 
	as part of the image. 


Requirements
============

     * Chef Client 12.16.42
     * Oracle Solaris 11.3 SRU19


Attributes
==========

pkg_mediator Cookbook attributes.

<table border="1" bgcolor="#8080cc">
<tr>
    <td><tt>name</tt></td>
    <td>String</td>
    <td>name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>version</tt></td>
    <td>String</td>
    <td>version</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>no_be_activate</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr>
   <tr>
    <td><tt>no_backup_be</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>deny_new_be</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>be_name</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td>false</td>
  </tr>
</table>


Usage
=====
  
change the mediation Values
----------------------------

```ruby
 
pkg_mediator "java" do
  version "1.8"
  action :mediator
end
```

```ruby
pkg_mediator "java" do
  version "1.10"
  no_be_activate true
  action :mediator
end
```

```ruby
pkg_mediator "xxx" do
  version "1.15"
  no_backup_be true
  action :mediator
end
```

```ruby
pkg_mediator "java" do
    version "1.9"
  deny_new_be true
  action :mediator
end
```


```ruby
pkg_mediator "java" do
  version "1.8"
  require_new_be true
  action :mediator
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

Author:: Pradhap Devarajan ([pradhap.devarajan@oracle.com](mailto:pradhap.devarajan@oracle.com))


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
