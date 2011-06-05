#
#  AppDelegate.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

# TODO:
# - figure out why multiples doesn't work
# - debug pasteboard copy on link editor
# - search box for searching through tabs
# - make tabs sortable by title
# - give the ability to jump to the tab / bring tab to front
# - multiple browser support


framework 'ScriptingBridge'

class AppDelegate
    attr_accessor :window, :open_tabs, :table_view, :destination_manager
    
    def refreshTabsFromSafari
        safari = SBApplication.applicationWithBundleIdentifier("com.apple.Safari")
        
        windows = safari.windows
        
        @open_tabs = []
        
        windows.each do |window|
            window.tabs.each do |tab|
                @open_tabs << TSTab.new({:window => window, :tab => tab})
            end
        end
        
    end
    
    def sync_safari
        refreshTabsFromSafari
        table_view.reloadData
        table_view.setNeedsDisplay(true)
    end
        
    def applicationWillBecomeActive(aNotification)
        sync_safari
    end
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    def awakeFromNib
        # for drag events
        table_view.registerForDraggedTypes( ["TSTab"] )
        
        @open_tabs = []
        refreshTabsFromSafari
        
        
    end
    
    def open_preferences(sender)
        pref_controller = TSPreferencesController.alloc.initWithWindowNibName( "Preferences" )
        pref_controller.showWindow( self )
    end
    
    # tableView delegate stuff
    
    def numberOfRowsInTableView(aTableView)
        @open_tabs.length
    end
    
    def tableView(tableView,
                  objectValueForTableColumn:column,
                  row:row)

        @open_tabs[row].send(column.identifier.to_sym)
        
    end
    
    # drag and drop delegate methods for tab table
    
    def tableView(tableView, 
                  writeRowsWithIndexes:rowIndexes, 
                  toPasteboard:pboard)
        
        
        data = NSKeyedArchiver.archivedDataWithRootObject(rowIndexes)
        pboard.declareTypes( ["TSTab"], owner:self )
        pboard.setData(data, forType:"TSTab")    
        
        return true
    end
    
end

