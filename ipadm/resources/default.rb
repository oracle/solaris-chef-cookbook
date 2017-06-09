actions :create_addr, :delete_addr, :down_addr, :refresh, :reset_addrprop, :set_addrprop, 
        :up_addr, :enable_if, :disable_if, :create_ip, :delete_ip, :disable_addr, :enable_addr, :create_ip, :delete_ip


attribute :name, kind_of: String
attribute :addresstype, kind_of: String
attribute :ipaddress, kind_of: String
attribute :temporary, kind_of: [TrueClass, FalseClass], :default => false
attribute :inform, kind_of: [TrueClass, FalseClass], :default => false
attribute :create_ip, kind_of: String
attribute :info, kind_of: Mixlib::ShellOut
attribute :options, kind_of: Hash
attribute :property, kind_of: String

