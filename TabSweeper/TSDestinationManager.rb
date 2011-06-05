#
#  TSDestinationManager.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSDestinationManager
    attr_accessor :destinations, :app_delegate
    attr_accessor :instapaper_image, :blog_image, :email_image, :trash_image
    
    def initialize
        self.destinations = TSDestination.defaults
    end
    
    def awakeFromNib
        # for drop events
        # table_view.registerForDraggedTypes( ["TSTab"] )
        
        blog_image.setImage(NSImage.alloc.initByReferencingFile(destinations[:blog].image_path))
        email_image.setImage(NSImage.alloc.initByReferencingFile(destinations[:email].image_path))
        instapaper_image.setImage(NSImage.alloc.initByReferencingFile(destinations[:instapaper].image_path))
        trash_image.setImage(NSImage.alloc.initByReferencingFile(destinations[:close].image_path))
    end
    
    #def numberOfRowsInTableView(aTableView)
    #   @destinations.length
    #end
    
    #def tableView(tableView,
    #              objectValueForTableColumn:column,
    #              row:row)
    #    
    #    @destinations[row].name
    #    
    #end
    
    # drag and drop methods
    
    # validate a drop
    #def tableView(tableView, 
    #              validateDrop:info, 
    #              proposedRow:row, 
    #              proposedDropOperation:op)
        
        
        
    #    return NSDragOperationEvery
    #end
        
    # accept a drop
    #def tableView(tableView, 
    #              acceptDrop:info,
    #              row:row,
    #              dropOperation:operation)
        
    #    pboard = info.draggingPasteboard
    #    rowData = pboard.dataForType( "TSTab" )

    #    rowIndexes = NSKeyedUnarchiver.unarchiveObjectWithData( rowData )
        
    #    target_destination = @destinations[row]
        
    #    tabs = []
        
    #    rowIndexes.enumerateIndexesUsingBlock(Proc.new do |i, stop|
          
    #      tabs << app_delegate.open_tabs[i]
                                                                                            
    #    end)
        
    #    target_destination.deliver_multiple(tabs)

        
        
    #    app_delegate.sync_safari        
    #end
    
    
end