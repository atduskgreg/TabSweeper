#
#  TSTab.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSTab 
    attr_accessor :window, :tab
    
    def initialize(opts)
        @window = opts[:window]
        @tab = opts[:tab]
    end
    
    def title
        @tab.name
    end
    
    def url
        @tab.URL
    end

    
    def close
        @window.tabs.removeObject(@tab)
    end
end