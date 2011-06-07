#
#  TSTab.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSTab 
    attr_accessor :window, :tab, :source_bundle_id
    
    def initialize(opts)
        @window = opts[:window]
        @tab = opts[:tab]
        @source_bundle_id = opts[:source_bundle_id]
    end
    
    def title        
        case @source_bundle_id
        when "com.apple.Safari"
            @tab.name
        when "com.google.Chrome"
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