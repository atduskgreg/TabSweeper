#
#  TSDestination.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

require 'rubygems'
require 'instapaper'
require 'erb'

class TSDestination
    attr_accessor :name, :deliverator, :image_path
    
    def initialize(opts)
        @name = opts[:name]
        @deliverator = opts[:deliverator]
        @image_path = opts[:image_path]
    end
    
    def self.defaults
    {:close     => self.new(:name => "Close Tab", 
                            :deliverator => TSCloseTabDeliverator), 
    :instapaper => self.new(:name => "Instapaper", 
                            :deliverator => TSInstapperDeliverator),
    
    :pinboard   => self.new(:name => "Pinboard", 
                            :deliverator => TSPinboardDeliverator),
    
    :blog       => self.new(:name => "Blog Post", 
                            :deliverator => TSBlogPostDeliverator),
    
    :email      => self.new(:name => "Email Links", 
                            :deliverator => TSEmailDeliverator)}
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
        tab.close
    end
end

class TSTextBasedDeliverator < TSDeliverator
    def self.template
        # implemented in sub-classes
        # this should return an erb template
        # that is ready to rendered with @tabs
        # set to an array of TSTabs
    end

    def self.deliver_multiple(tabs)
        @tabs = tabs
        text = self.template.result(binding)


        text_editor = TSLinkTextEditorController.alloc.initWithWindowNibName( "LinkTextEditor" )
        text_editor.text = text
        
        tabs.each{|t| t.close }

        text_editor.showWindow( self )
    end
end

class TSBlogPostDeliverator < TSTextBasedDeliverator
    
    def self.template
        ERB.new <<-TTT
<ul>
<% for tab in @tabs %>
  <li><a href="<%= tab.url %>"><%= tab.title %></a></li>
<% end %>
</ul>
        TTT
    end
end

class TSEmailDeliverator < TSTextBasedDeliverator
    def self.template
    ERB.new <<-TTT
<% for tab in @tabs %>
<%= tab.title %>
<%= tab.url %>
<% end %>
    TTT
end
end

class TSPinboardDeliverator < TSDeliverator
    def self.deliver(tab)
        description = URI.encode( tab.title )
        url = URI.encode( tab.url )
    
        auth = "#{preferences.user.pinboard_username}:#{preferences.user.pinboard_password}"
        params = "url=#{url}&description=#{description}"
         
    
        DataRequest.new.get("https://#{auth}@api.pinboard.in/v1/posts/add?#{params}") do |data|
            NSLog(data)
        end

        tab.close
    end
end

class TSInstapperDeliverator < TSDeliverator

    def self.deliver(tab)
    
        url = URI.parse("http://www.instapaper.com/api/add")
        req = Net::HTTP::Post.new(url.path)
        
        # TODO: obvs, this should come in from preferences
        req.basic_auth preferences.user.instapaper_username, preferences.user.instapaper_password
    
        req.set_form_data({'title' => "#{tab.title}", 'url' => "#{tab.url}"})
    
        Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    
        tab.close

    end

end