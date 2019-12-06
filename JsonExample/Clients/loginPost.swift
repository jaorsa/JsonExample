//
//  ActivityClient.swift
//  JsonExample
//
//  Created by Administrador on 29/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation

let sharedTokenInstance = UserClient()
var token: String?
class UserClient: NSObject{
    var session = URLSession.shared
    var dataStr = ""
    
    class var Tokeninstance: JsonClient{
        return sharedInstance
    }
    
    public func postRequest(url: String, body: [String: Any],completionHandler: @escaping(String) -> Void){
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
            case 200:
                let response = NSString (data: receivedData, encoding: String.Encoding.utf8.rawValue)
                print("SUCESS")
                print(response!)
                
                let items = response!.components(separatedBy: ":")
                //print(items[1])
                token = items[1]
                let start = token!.index((token!.startIndex), offsetBy:1)
                let end = token!.index(token!.endIndex, offsetBy: -2)
                let range = start..<end
                let tmp = token![range]
                print(tmp)
                completionHandler(String(tmp))
            default:
                print("POST request got response \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
    
    public func getUsuarios(url: String, token: String){
        var model = [Users]()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: request){ (data, resp, error ) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            self.dataStr = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
            
            do{
                //let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                
                //guard let jsonArray = jsonResponse as? [[String: Any ]] else {return}
                let decoder = JSONDecoder()
                model = try decoder.decode([Users].self, from: dataResponse)
                print(model)
            } catch let parsingError {
                print("Error", parsingError)
            }
            //completionHandler(true, model, error)
        }
        task.resume()
    }

}
