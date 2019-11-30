//
//  ResourceController.swift
//  JsonExample
//
//  Created by Administrador on 17/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

let sharedTeamInstance = TeamController()

class TeamController: NSObject{
    var session = URLSession.shared
    var dataStr = ""
    
    class var Teaminstance: JsonClient{
        return sharedInstance
    }
    
    public func getRequest(url: String, completionHandler: @escaping(String,[Teams], Error?) -> Void ){
        var model = [Teams]()
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let task = session.dataTask(with: request){ (data, resp, error ) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            self.dataStr = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
            
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [[String: Any ]] else {return}
                let decoder = JSONDecoder()
                model = try decoder.decode([Teams].self, from: dataResponse)
                
                //print(model)
                //print(jsonArray)
                /*
                for dic in jsonArray {
                    model.append(ResourceTypes(dic))
                    print(model)
                    print(model[0].id)
                    
                    guard let title = dic["title"] as? String else{return}
                    print(title)
                    self.resultArray.append(title)
                    
                }*/
            } catch let parsingError {
                print("Error", parsingError)
            }
            completionHandler(self.dataStr, model, error)
        }
        task.resume()
    }
    
    public func getByIdRequest(url: String, id: String, completionHandler: @escaping(Teams, Error?) -> Void ){
        var model: Teams?
        var request = URLRequest(url: URL(string: url + id)!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let task = session.dataTask(with: request){ (data, resp, error ) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            self.dataStr = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
            print(dataResponse)
            do{
                //let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                //guard let jsonArray = jsonResponse as? [[String: Any ]] else {return}
                let decoder = JSONDecoder()
                model = try decoder.decode(Teams.self, from: dataResponse)
                print(model)
                //print(jsonArray)
            } catch let parsingError {
                print("Error", parsingError)
            }
            completionHandler(model!, error)
        }
        task.resume()
    }
    
    public func postRequest(url: String, body: [String: Any], completionHandler: @escaping(Bool)->Void){
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
                completionHandler(true)
            default:
                print("POST request got response \(httpResponse.statusCode)")
                completionHandler(false)
            }
            
        }
        task.resume()
    }
    
    public func putRequest(url: String, id: String, name: String, description: String,completionHandler: @escaping(Bool)->Void){
        var request = URLRequest(url: URL(string: url + id)!)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "PUT"
        let tmp = [ "name": name, "description": description] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: tmp, options: [])
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
    
    public func deleteRequest(url:String, id: String, completionHandler: @escaping(Bool)->Void){
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
                let response = NSString (data: receivedData, encoding: String.Encoding.utf8.rawValue)
                print("SUCESS")
                print(response!)
                completionHandler(true)
            default:
                print("Delete request got response \(httpResponse.statusCode)")
                completionHandler(false)
            }
        }
        task.resume()
    }
    
    
}
