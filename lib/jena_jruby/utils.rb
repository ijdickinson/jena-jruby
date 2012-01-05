module Jena
  module Util
    # Return the given prefix map object as a `PrefixMapping`. Convert a hash
    # to a `PrefixMapping` if necessary
    def self.as_prefix_map( map )
      return nil unless map
      return map if map.is_a? com.hp.hpl.jena.shared.PrefixMapping
      pm = com.hp.hpl.jena.shared.impl.PrefixMappingImpl.new
      map.each_pair do |k,v|
        pm.setNsPrefix k.to_s, v.to_s
      end
      pm
    end

    # Return a new resource URN made from a UUID
    def self.uuid_resource
      Core::ResourceFactory.createResource( Util::JenaUUID.factory.generate.asURN )
    end

    # Return the current time as a literal
    def self.now
      cal = java.util.Calendar.getInstance
      cal.setTime( java.util.Date.new )
      Core::ResourceFactory.createTypedLiteral( cal )
    end
  end
end