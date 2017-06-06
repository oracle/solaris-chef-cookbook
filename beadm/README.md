beadm Cookbook
==============
Beadm cookbook is for managing ZFS Boot Environments (BEs), cookbook
intended to be used by system administrators for managing multiple 
Oracle Solaris instances on a single system.


Requirements
------------
- Chef 12.5 or higher
- Oracle Solaris 11 and above


Attributes
----------
Beadm cookbook attributes.

#### beadm::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>name</tt></td>
    <td>String</td>
    <td>BE name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>new_be</tt></td>
    <td>String</td>
    <td>Target BE name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>mountpoint</tt></td>
    <td>String</td>
    <td>filesystem mountpoint</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>activate</tt></td>
    <td>boolean</td>
    <td>activate BE</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>options</tt></td>
    <td>Hash</td>
    <td>ZFS properties</td>
    <td><tt>true</tt></td>
  </tr>


</table>

Usage
-----
#### beadm::default

#### Create a newbe
```ruby
beadm 'newbe' do
        action :create
end
```

#### Rename a BE
```ruby
beadm 'testbe' do
        action :rename
	new_be "testing"
end
```

#### Set ZFS options when creating a BE
```ruby
beadm 'newbe2' do
  options ({
             'recordsize' => '128K', 'compression' => 'on'
           })
  action :create
end
```

#### Mount a BE
```ruby
beadm 'newbe2' do
  mountpoint "/mnt"
  action :mount
end
```

#### Unmount a BE
```ruby
beadm 'newbe2' do
  action :umount
end
```

#### Pattern based destroy of a BE
```ruby
beadm 'newbe*' do
  action :destroy_pattern
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
- Author::Pradhap Devarajan ([pradhap.devarajan@oracle.com](mailto:pradhap.devarajan@oracle.com))

```text
Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.

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
