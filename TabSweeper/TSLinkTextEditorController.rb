#
#  TSLinkTexEditorController.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/5/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSLinkTextEditorController < NSWindowController
   attr_accessor :text_view, :copy_button, :done_button, :text
    
   def awakeFromNib
       
       
       NSLog("link text editor woke up")
       
       text_view.insertText( self.text )
   end
    
   def copy_text_to_clipboard(sender)
       pasteBoard = NSPasteboard.generalPasteboard
       pasteBoard.declareTypes([NSStringPboardType], owner: nil)
       pasteBoard.setString(text_view.string, forType:NSStringPboardType)
   end
    
   def close_window(sender)
       sender.window.close
   end
end