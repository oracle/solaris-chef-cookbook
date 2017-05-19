pkg_publisher Cookbook
========================
Packages are published by publishers, who can make their packages
available at one or more repositories, or in package archives. pkg
retrieves packages from a publisher's repository or package archives
and installs the packages into an image. With pkg_publisher cookbook 
one can adminster pkg publisher.

Requirements
------------
* Chef 12.5 and above
* Oracle Solaris 11 and above

Attributes
----------
pkg_publisher cookbook attributes.

#### beadm::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>publisher</tt></td>
    <td>String</td>
    <td>Publisher Name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>type</tt></td>
    <td>String</td>
    <td>mirror (or) origin</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>uri</tt></td>
    <td>String</td>
    <td>URI string</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>root</tt></td>
    <td>String</td>
    <td>Alternate Root</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>sticky</tt></td>
    <td>boolean</td>
    <td>true (or) false</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>search_before</tt></td>
    <td>String</td>
    <td>publisher name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>search_after</tt></td>
    <td>String</td>
    <td>publisher name</td>
    <td><tt></tt></td>
  </tr>
 <tr>
    <td><tt>ssl_cert</tt></td>
    <td>String</td>
    <td>SSL certificate</td>
    <td><tt></tt></td>
  </tr>
 <tr>
    <td><tt>ssl_key</tt></td>
    <td>String</td>
    <td>SSL certificate</td>
    <td><tt></tt></td>
  </tr>
 <tr>
    <td><tt>enable</tt></td>
    <td>boolean</td>
    <td>true (or) false</td>
    <td><tt>false</tt></td>
  </tr>
 <tr>	
    <td><tt>disable</tt></td>
    <td>boolean</td>
    <td>true (or) false</td>
    <td><tt>false</tt></td>
  </tr>	
 <tr>
    <td><tt>proxy</tt></td>
    <td>String</td>
    <td>proxy url</td>
    <td><tt></tt></td>
  </tr>
 <tr>	
    <td><tt>syspub</tt></td>
    <td>boolean</td>
    <td>true (or) false</td>
    <td><tt>false</tt></td>
  </tr>	
</table>

Usage
-----
#### pkg_publisher::default

#### Add a new repository
```ruby
pkg_publisher 'solaris' do
  uri "http://pkg.oracle.com/solaris/release"
  action :create
end
```

#### Add a new repository with options on alternate BE
```ruby
pkg_publisher 'solaris' do
  uri "http://pkg.oracle.com/solaris/release"
  proxy "http://www-proxy.internal.com:3128"
  root "/mnt"
  search_before "solarisstudio"
  action :create
end
```
#### Add a mirror
```ruby
pkg_publisher 'solaris' do
  uri "http://internal-mirror/solaris/release"
  type "mirror"
  action :create
end
```

#### Remove a repository
```ruby
pkg_publisher 'solarisstudio' do
  uri "https://pkg.oracle.com/solarisstudio/release"
  action :destroy
end
```
#### Add a new repository with SSL Key & Cert
Make sure key & cert file copied to destination
Machine before calling this routine
```ruby
pkg_publisher 'solaris' do
  uri "https://pkg.oracle.com/solaris11/support/"
  ssl_key "/export/home/vagrant/pkg.key.pem"
  ssl_cert "/export/home/vagrant/pkg.certificate.pem"
  action :create
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
- Author::Pradhap Devarajan([pradhap.devarajan@oracle.com](mailto:pradhap.devarajan@oracle.com))

```text
Copyright::2016 Oracle and/or its affiliates. All rights reserved.

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
