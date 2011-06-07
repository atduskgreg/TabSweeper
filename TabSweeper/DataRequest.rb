#
#  DataRequest.rb
#  TabSweeper
#
#  Created by Greg Borenstein on 6/6/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#

# from Matt Aimonetti: https://github.com/dj2/Postie/tree/master/lib

class DataRequest
    def get(url, &blk)
        @buf = NSMutableData.new
        @blk = blk
        req = NSURLRequest.requestWithURL(NSURL.URLWithString(url))
        NSURLConnection.alloc.initWithRequest(req, delegate:self)
    end
    
    def connection(conn, didReceiveResponse:resp)
        @response = resp
        @buf.setLength(0)
    end
    
    def connection(conn, didReceiveData:data)
        @buf.appendData(data)
    end
    
    def connection(conn, didFailWithError:err)
        NSLog "Request failed"
    end
    
    def connectionDidFinishLoading(conn)
        @blk.call(NSString.alloc.initWithData @buf, encoding:NSUTF8StringEncoding)
    end
end
