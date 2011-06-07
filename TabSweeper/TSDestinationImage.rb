#
#  TSDestinationImage.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/5/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSDestinationImage < NSImageView
    attr_accessor :target_destination, :app_delegate
   
    def awakeFromNib
        self.registerForDraggedTypes( ["TSTab"] )
    end
    
    def draggingEntered(sender)
        true
    end
    
    def prepareForDragOperation(sender)
        true
    end
    
    def performDragOperation(sender)
        pboard = sender.draggingPasteboard
        rowData = pboard.dataForType( "TSTab" )
        
        rowIndexes = NSKeyedUnarchiver.unarchiveObjectWithData( rowData )
                
        tabs = []
        
        rowIndexes.enumerateIndexesUsingBlock(Proc.new do |i, stop|
          NSLog(i.inspect)
          tabs << app_delegate.open_tabs[i]
        
        end)
        
        NSLog(tabs.length.inspect)
        
        target_destination.deliver_multiple(tabs)
        
        app_delegate.sync_safari   
    end
    

end