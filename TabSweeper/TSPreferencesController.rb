#
#  TSPreferencesController.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/5/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSPreferencesController < NSWindowController
    attr_accessor :instapaper_save_button
    attr_accessor :username_field, :password_field
        
    def awakeFromNib
        username_field.stringValue = preferences.user.instapaper_username
        password_field.stringValue = preferences.user.instapaper_password
    end
    
    def save_instapaper_preferences(sender)
        preferences.user.instapaper_username = username_field.stringValue
        preferences.user.instapaper_password = password_field.stringValue
        
        sender.window.close
    end
    


end