#
#  TSLinkTexEditorController.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/5/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSLinkTextEditorController < NSWindowController
   attr_accessor :text_view, :copy_button, :done_button
    
   def awakeFromNib
       NSLog("link text editor woke up")
   end
    
   def copy_text_to_clipboard(sender)
   end
    
   def close_window(sender)
       sender.window.close
   end
end