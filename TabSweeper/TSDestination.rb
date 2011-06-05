#
#  TSDestination.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

require 'rubygems'
require 'instapaper'

class TSDestination
    attr_accessor :name, :deliverator
    
    def initialize(opts)
        @name = opts[:name]
        @deliverator = opts[:deliverator]
    end
    
    def self.defaults
        [self.new(:name => "Close Tab", :deliverator => TSCloseTabDeliverator), 
        self.new(:name => "Instapaper", :deliverator => TSInstapperDeliverator),
        self.new(:name => "Blog Post"),
        self.new(:name => "Email Links")]
    end

    def deliver(tab)
      self.deliverator.deliver(tab)
    end

    def deliver_multiple(tabs)
        self.deliverator.deliver_multiple(tabs)
    end

end

class TSDeliverator
    
    def self.deliver_multiple(tabs)
        tabs.each do |tab|
            deliver(tab)
        end
    end
    
    def self.deliver(tab)
        # implemented in sub-classes
        # tab is a TSTab
    end
end

class TSCloseTabDeliverator < TSDeliverator
    def self.deliver(tab)
        NSLog(tab.inspect)
        tab.close
    end
end

class TSInstapperDeliverator < TSDeliverator

    def self.deliver(tab)
        puts "delivering #{tab.inspect}"
    
        url = URI.parse("http://www.instapaper.com/api/add")
        req = Net::HTTP::Post.new(url.path)
        
        # TODO: obvs, this should come in from preferences
        req.basic_auth preferences.user.instapaper_username, preferences.user.instapaper_password
    
        req.set_form_data({'title' => "#{tab.title}", 'url' => "#{tab.url}"})
    
        Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    
        tab.close

    end

end