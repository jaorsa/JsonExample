//
//  NetworkManager.swift
//  JsonExample
//
//  Created by Administrador on 15/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//
/*
import Foundation
class NetworkManager: NSObject{
    static let sharedInstance = NetworkManager()
    var resultArray = [ResourceType]()
    var foundStr = ""
    var dataStr = ""

    
    func getResourceTypeRequest(byId resourcetypeRequestId: String, completion: @escaping (ResourceType?) -> Void) {
        let urlString = "http://localhost:10010/resourcetypes/" + resourcetypeRequestId
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        var session = URLSession.shared
        let task = session.dataTask(with: request){ (data, resp, error ) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
        let session = URLSession.shared
        let task = session.dataTask(with: request){ (data, response, error) in
            self.dataStr = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
            do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                    
                    guard let jsonArray = jsonResponse as? [ResourceType] else {return}
                    for dic in jsonArray {
                        //guard let title = dic["name"] as? String else{return}
                        self.resultArray.append(dic)
                    }
                } catch let parsingError {
                    print("Error", parsingError)
                }
                completionHandler(self.dataStr, self.resultArray, error)
            }
            task.resume()
        }
    }
}
*/
