#
#  TSPreferencesController.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/5/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSPreferencesController < NSWindowController
    attr_accessor :instapaper_save_button
    attr_accessor :instapaper_username_field, :instapaper_password_field
    attr_accessor :pinboard_save_button
    attr_accessor :pinboard_username_field, :pinboard_password_field
        
    def awakeFromNib
        instapaper_username_field.stringValue = preferences.user.instapaper_username
        instapaper_password_field.stringValue = preferences.user.instapaper_password
        
        pinboard_username_field.stringValue = preferences.user.pinboard_username
        pinboard_password_field.stringValue = preferences.user.pinboard_password
    end
    
    def save_instapaper_preferences(sender)
        preferences.user.instapaper_username = instapaper_username_field.stringValue
        preferences.user.instapaper_password = instapaper_password_field.stringValue
    end
    
    def save_pinboard_preferences(sender)
        preferences.user.pinboard_username = pinboard_username_field.stringValue
        preferences.user.pinboard_password = pinboard_password_field.stringValue        
    end
    


end