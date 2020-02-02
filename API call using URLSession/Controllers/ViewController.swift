//  Copyright © 2020 annam. All rights reserved.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getWebserviceCall()
//        postWebserviceCall()
    }
}

//MARK: GET Method webservice call
extension ViewController{
    func getWebserviceCall(){
        let requestURL = "https://api.stackexchange.com/2.2/questions?order=desc&sort=votes&site=stackoverflow"
        ServiceManager.methodType(requestType: .GET,
                                  url: requestURL,
                                  completionHandler: { (result,status) in
                                    DispatchQueue.main.async {
                                        if status{
                                            //use stackExchangeAPIResponse whereever it's required
                                            let stackExchangeAPIResponse = try? JSONDecoder().decode(GETMethodModel.self, from: result as! Data)
                                            print(stackExchangeAPIResponse?.quotaMax ?? 0)
                                        }
                                    }
        })
    }
}

//MARK: POST Method webservice call
extension ViewController{
    func postWebserviceCall(){
        //Provide your request 'body' here in Dictionary format
        let parameterDictionary = ["userName": "bhanuAnnam",
                                   "password": "password"]
        ServiceManager.methodType(requestType: .POST,
                                  url: "http://localhost:4567/login", //Provide your 'POST' method endPoint URL here
                                  params: parameterDictionary,
                                  completionHandler: { (result,status) in
                                    DispatchQueue.main.async {
                                        if status{
                                            //use samplePostResponse whereever it's required
                                            let samplePostResponse = try? JSONDecoder().decode(POSTMethodModel.self,
                                                                                                     from: result as! Data)
                                            print(samplePostResponse?.UserID ?? 0)
                                        }}})
    }
}
