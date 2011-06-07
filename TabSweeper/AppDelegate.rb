#
#  AppDelegate.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

# TODO:
# defects:
# - debug multiples
# improvements:
# - destination targets should highlight when dragged over
# - search box for searching through tabs
# - make tabs sortable by title
# - pinboard integration
# - give the ability to jump to the tab / bring tab to front
# - deal with being offline (i.e. gray out instapaper)
# - feedback on copy
# - add firefox support (except their applescript support sucks)
# - add an icon and column to show which browser the tab is in
# - HOT FEATURE: automatic detecting of duplicate tabs

framework 'ScriptingBridge'

class AppDelegate
    attr_accessor :window, :open_tabs, :table_view, :destination_manager
    

    def getTabsFromBrowserWithBundleIdentifier( bundle_id )
        browser = SBApplication.applicationWithBundleIdentifier( bundle_id )
        
        result = []

        if(browser.isRunning)
        
            windows = browser.windows
        
        
            windows.each do |window|
                window.tabs.each do |tab|
                    result << TSTab.new({:window => window, :tab => tab, :source_bundle_id => bundle_id})
                end
            end
        end
        
        result
    end
    
    def refreshTabsFromSafari
        getTabsFromBrowserWithBundleIdentifier("com.apple.Safari")
    end
    
    def refreshTabsFromChrome
        getTabsFromBrowserWithBundleIdentifier("com.google.Chrome")
    end
    
    # one day maybe: right now their apple script support sucks. No obvious way to get tabs.
    #def refreshTabsFromFirefox
        #result = []
        
        #browser = SBApplication.applicationWithBundleIdentifier( "org.mozilla.Firefox" )
        #NSLog(browser.windows.first.class.inspect)
        #NSLog(browser.windows.collect{|w| w.curl}.inspect)
        #NSLog(browser.windows.collect{|w| w.tabs.collect{|t| "#{t.title} - #{t.url}"}}.inspect)

    #   result
    #end
    
    def sync_safari

        @open_tabs = refreshTabsFromChrome + refreshTabsFromSafari
        
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

