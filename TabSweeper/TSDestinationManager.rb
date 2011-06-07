#
#  TSDestinationManager.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/4/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#


class TSDestinationManager
    attr_accessor :destinations, :app_delegate
    attr_accessor :instapaper_image, :blog_image, :email_image, :trash_image, :pinboard_image
    
    def initialize
        self.destinations = TSDestination.defaults
    end
    
    def awakeFromNib
        instapaper_image.target_destination = destinations[:instapaper]
        pinboard_image.target_destination = destinations[:pinboard]
        blog_image.target_destination = destinations[:blog]
        email_image.target_destination = destinations[:email]
        trash_image.target_destination = destinations[:close]

    end
end