
import Foundation;
import SwiftProtobuf;
//abstract class Haberdasher {
//
//	Future<Haberdasher_Hat>makeHat(Haberdasher_Size size);
//
//	Future<Haberdasher_Hat>buyHat(Haberdasher_Hat hat);
//
//}

struct Haberdasher_Haberdasher {
	var hostname: String = ""
    //Requester _requester;
	var pathPrefix: String = "/twirp/haberdasher.Haberdasher/"

    
	func makeHat(size:Haberdasher_Size, callback: @escaping (Haberdasher_Hat?) -> Void) -> Void {
		var url = hostname + pathPrefix + "MakeHat"
		var uri = URL(string: url)!
    	var req = URLRequest.init(url:uri);
		req.setValue("application/protobuf", forHTTPHeaderField: "Content-Type")
		//req.method = HTTPMethod(rawValue: "POST")
		req.httpMethod = "POST"

		let data = try! size.serializedData()
		req.httpBody = data
		let task = URLSession.shared.dataTask(with: req) {data, response, err in
        	guard let data = data else {
            	return
        	}
        	let resp = try? Haberdasher_Hat.init(serializedData: data)
        	callback(resp)
    	}
    
    	task.resume()
		return
	}
    
	func buyHat(hat:Haberdasher_Hat, callback: @escaping (Haberdasher_Hat?) -> Void) -> Void {
		var url = hostname + pathPrefix + "BuyHat"
		var uri = URL(string: url)!
    	var req = URLRequest.init(url:uri);
		req.setValue("application/protobuf", forHTTPHeaderField: "Content-Type")
		//req.method = HTTPMethod(rawValue: "POST")
		req.httpMethod = "POST"

		let data = try! hat.serializedData()
		req.httpBody = data
		let task = URLSession.shared.dataTask(with: req) {data, response, err in
        	guard let data = data else {
            	return
        	}
        	let resp = try? Haberdasher_Hat.init(serializedData: data)
        	callback(resp)
    	}
    
    	task.resume()
		return
	}
    

	//Exception twirpException(Response response) {
    //	try {
    //  		var value = json.decode(response.body);
    //  		return new TwirpJsonException.fromJson(value);
    //	} catch (e) {
    //  		return new TwirpException(response.body);
    //	}
  	//}
}



