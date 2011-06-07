#
#  TSTab.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSTab 
    attr_accessor :window, :tab, :source
    
    def initialize(opts)
        @window = opts[:window]
        @tab = opts[:tab]
        @source = opts[:source]
    end
    
    def title
        case source
        when :safari
            @tab.name
        when :chrome
            @tab.title
        end
    end
    
    def url
        @tab.URL
    end

    
    def close
        @window.tabs.removeObject(@tab)
    end
end