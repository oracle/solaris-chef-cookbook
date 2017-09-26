pkg_facet
=========

       pkg is  the  retrieval  client  for the  Image  Packaging System. With a
       valid configuration, pkg can be invoked to create locations for packages
       to  be  installed, called images, and install packages into those images.
       
       Packages are published by publishers, who can make their packages available
       at one or more repositories, or in package archives. pkg retrieves packages 
       from a publisher's repository or package archives and installs the packages 
       into an image.


Requirements
============

     * Chef Client 12.16.42
     * Oracle Solaris 11.3 SRU19


Attributes
==========

pkg_facet Cookbook attributes.

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
    <td><tt>path_or_uri</tt></td>
    <td>String</td>
    <td></td> 
    <td><tt></tt></td>
  </tr>
   <tr>
    <td><tt>no_index</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>request_operation</tt></td>
    <td>String</td>
    <td>request_operation</td> 
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>sync_actuators</tt></td>
    <td>Boolean</td>
    <td>sync_actuators</td> 
    <td>false</td>
  </tr>
  <tr>
    <td><tt>timeout</tt></td>
    <td>Integer</td>
    <td>Time</td> 
    <td><tt></tt></td>
  </tr>
</table>

Usage
=====
  
Showing and Changing Facet Values
---------------------------------
```ruby
 
pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value false
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_backup_be true
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  accept  "accept"
   action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_be_activate true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_refresh true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_backup_be true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  require_backup_be true
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  be_name true  
  bname  "gust1"
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_index true
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value true
  no_refresh true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
   require_new_be true
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  sync_actuators_timeout true
  timeout 10
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value false
  backup_name "oracle"  
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value true
  path_or_uri "http://ipkg.uk.oracle.com/solaris11/support/"   
  action :change_facet
end
end
```


   

Contributing
============

    * Fork the repository on Mercurial
    * Create a named feature branch 
    * Write your Changes
    * Write tests for your change
    * Submit a pull Request Using Mercurial
 

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
