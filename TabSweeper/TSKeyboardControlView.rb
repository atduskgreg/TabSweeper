#
#  TSKeyboardControlView.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/6/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSKeyboardControlView < NSView
    attr_accessor :app_delegate
    
    def acceptsFirstResponder
        window.makeFirstResponder(self)
        true
    end
    
    def keyDown(theEvent)
        
        target_destination = case theEvent.characters
        when "i"
            app_delegate.destination_manager.destinations[:instapaper]
        when "p"
            app_delegate.destination_manager.destinations[:pinboard]
        when "b"
            app_delegate.destination_manager.destinations[:blog]
        when "e"
            app_delegate.destination_manager.destinations[:email]
        when "c"
            app_delegate.destination_manager.destinations[:close]
        end

        tabs = []
    
        app_delegate.table_view.selectedRowIndexes.enumerateIndexesUsingBlock(Proc.new do |i, stop|
            tabs << app_delegate.open_tabs[i]
        end)
        
        target_destination.deliver_multiple( tabs )
        app_delegate.sync_safari

    end

end