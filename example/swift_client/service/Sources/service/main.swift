import Foundation

var c = Haberdasher_Haberdasher()
c.hostname = "http://127.0.0.1:9000"

var req = Haberdasher_Size()
req.inches = 10
c.makeHat(size: req) { resp in
    print(resp)
}

sleep(2)
