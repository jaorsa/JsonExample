//
//  ActivityClient.swift
//  JsonExample
//
//  Created by Administrador on 29/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation

let sharedActivitiesInstance = ActivityClient()

class ActivityClient: NSObject{
    var session = URLSession.shared
    var dataStr = ""
    
    class var Activitiesinstance: JsonClient{
        return sharedInstance
    }
    
    public func postRequest(url: String, body: [String: Any]){
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        let task = session.dataTask(with: request) {data,response,error in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data else{
                print(print("error: not a valid http response"))
                return
            }
            switch (httpResponse.statusCode)
            {
            case 201:
                let response = NSString (data: receivedData, encoding: String.Encoding.utf8.rawValue)
                print("SUCESS")
                print(response!)
            default:
                print("POST request got response \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
    
    public func putRequest(url: String, id: String, body: [String:Any],completionHandler: @escaping(Bool) -> Void){
        var request = URLRequest(url: URL(string: url + id)!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "PUT"
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        let task = session.dataTask(with: request) {data,response,error in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data else{
                print(print("error: not a valid http response"))
                return
            }
            switch (httpResponse.statusCode)
            {
            case 200:
                let response = NSString (data: receivedData, encoding: String.Encoding.utf8.rawValue)
                print("SUCESS")
                print(response!)
                completionHandler(true)
            default:
                print("PUT request got response \(httpResponse.statusCode)")
                completionHandler(false)
            }
        }
        task.resume()
    }
    
    public func deleteRequest(url:String, id: String, completionHandler: @escaping(Bool) -> Void ){
        var request = URLRequest(url: URL(string: url + id)!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "DELETE"
        let task = session.dataTask(with: request) {data,response,error in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data else{
                print(print("error: not a valid http response"))
                return
            }
            switch (httpResponse.statusCode)
            {
            case 200:
                //let response = NSString (data: receivedData, encoding: String.Encoding.utf8.rawValue)
                print("SUCESS")
                print(response!)
                completionHandler(true)
            default:
                print("Delete request got response \(httpResponse.statusCode)")
                completionHandler(false)
            }
            completionHandler(true)
        }
        task.resume()
    }

}
