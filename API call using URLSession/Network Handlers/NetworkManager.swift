//  Copyright © 2020 annam. All rights reserved.

import Foundation
import UIKit

private var manager : ServiceManager? = nil

class ServiceManager: NSObject {
    class func shared() -> ServiceManager {
        if manager == nil {
            manager = ServiceManager()
        }
        return manager ?? ServiceManager()
    }
    
    //MARK:- Methods
    class func methodType(requestType: RequestMethod,  url: String,
                           params: [String: Any]? = nil,
                           completionHandler:((_ response: Any?, _ status: Bool) -> Void)?) -> Void {
        print("url =====> \(url)")
        let endPointURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        var urlRequest = URLRequest.init(url: URL.init(string: endPointURL!)!)
        if params != nil{
            let postData = try? JSONSerialization.data(withJSONObject: params!, options: .init(rawValue: 0))
            urlRequest.httpBody = postData
            let jsonInputData = try? JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
            let requestBody = String(data:jsonInputData!, encoding:String.Encoding.utf8)
            print("requestBody ====>\(requestBody!)")
        }
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 30
        self.sessionWithRequest(urlRequest: urlRequest, completionHandler: completionHandler)
    }
    
    //MARK:- SessionRequest
    class func sessionWithRequest(urlRequest: URLRequest,
                                  completionHandler:((_ response: Any?, _ status: Bool) -> Void)?){
        let sessionConguration = URLSessionConfiguration.default
        let defaultSession = URLSession.init(configuration: sessionConguration)
        
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            let responseFromServer = response as? HTTPURLResponse
            let code = responseFromServer?.statusCode
            if error == nil && data != nil{
                let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: .init(rawValue: 0))
                print(jsonResponse!)
                if code == 200 {
                    if let jSONData = data{
                        completionHandler!(jSONData, true)
                    }
                    else{
                        print("something went wrong")
                    }
                }else {
                    print(jsonResponse as Any)
                }
            }else{
                print(error.debugDescription)
            }
        }
        dataTask.resume()
    }
}
