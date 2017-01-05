require 'coverband'
Coverband.configure


module Coverband
  class Base

    def self.instance
      Thread.current[:coverband_instance] ||= Coverband::Base.new
    end
  end
end
