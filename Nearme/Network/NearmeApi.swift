//
//  NearmeApi.swift
//  Nearme
//
//  Created by Alumnos on 6/6/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import Alamofire
import os

class NearmeApi {
    static let BASE_URL="https://nearme-api-rest.herokuapp.com"
    static let categoryURL="\(BASE_URL)/categories"
    static let commentURL="\(BASE_URL)/comments"
    static let enterpriseURL="\(BASE_URL)/enterprises"
    static let typeUserURL="\(BASE_URL)/type_users"
    static let userURL="\(BASE_URL)/users"
    static let loginURL="\(userURL)/search"
    static let TAG: String="NearmeApi"
    
    static private func put<T: Decodable>(
        from urlString: String,
        bodyParameter: Data,
        key: String,
        responseHandler: @escaping ((T)->Void),
        errorHandler: @escaping ((Error)->Void)){
        guard let url = URL(string: urlString) else{
            let message = "Error on URL"
            os_log("%@",message)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyParameter
        request.addValue(key, forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request).validate().responseJSON(
            completionHandler:
            { response in
                switch response.result {
                case .success( _):
                    do{
                        let decoder = JSONDecoder()
                        if let data = response.data{
                            let dataResponse = try decoder.decode(T.self, from: data)
                            responseHandler(dataResponse)
                        }
                    } catch{
                        errorHandler(error)
                    }
                case .failure(let error):
                    errorHandler(error)
                }
        })
    }
    
    static private func post<T: Decodable>(
        from urlString: String,
        bodyParameter: Data,
        key: String,
        responseHandler: @escaping ((T)->Void),
        errorHandler: @escaping ((Error)->Void)){
        guard let url = URL(string: urlString) else{
            let message = "Error on URL"
            os_log("%@",message)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyParameter
        request.addValue(key, forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request).validate().responseJSON(
            completionHandler:
                { response in
                    switch response.result {
                    case .success( _):
                        do{
                            let decoder = JSONDecoder()
                            if let data = response.data{
                                let dataResponse = try decoder.decode(T.self, from: data)
                                responseHandler(dataResponse)
                            }
                        } catch{
                            errorHandler(error)
                        }
                    case .failure(let error):
                        errorHandler(error)
                    }
            })
    }
    
    static private func get<T: Decodable>(
        from urlString: String,
        headers: [String: String],
        responseHandler: @escaping (([T])->Void),
        errorHandler: @escaping ((Error)->Void)){
        guard let url = URL(string: urlString) else{
            let message = "Error on URL"
            os_log("%@",message)
            return
        }
        Alamofire.request(url,headers: headers).validate().responseJSON(
            completionHandler: { response in
                switch response.result{
                case .success( _):
                    do{
                        let decoder = JSONDecoder()
                        if let data = response.data{
                            let dataResponse = try decoder.decode([T].self, from: data)
                            responseHandler(dataResponse)
                        }
                    } catch{
                        errorHandler(error)
                    }
                case .failure(let error):
                    errorHandler(error)
                }
        })
    }
    
    static private func login(
        from urlString: String,
        headers: [String: String],
        responseHandler: @escaping ((User)->Void),
        errorHandler: @escaping ((Error)->Void)){
        guard let url = URL(string: urlString) else{
            let message = "Error on URL"
            os_log("%@",message)
            return
        }
        Alamofire.request(url,headers: headers).validate().responseJSON(
            completionHandler: { response in
                switch response.result{
                case .success( _):
                    do{
                        let decoder = JSONDecoder()
                        if let data = response.data{
                            let dataResponse = try decoder.decode(User.self, from: data)
                            responseHandler(dataResponse)
                        }
                    } catch{
                        errorHandler(error)
                    }
                case .failure(let error):
                    errorHandler(error)
                }
        })
    }
    
    static func loginUser(username: String,password: String,responseHandler: @escaping ((User?) -> Void),
                          errorHandler: @escaping ((Error) -> Void),Key: String) {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Key)"]
        
        let url = "\(loginURL)/\(username)/\(password)"
        self.login(from: url,headers: headers , responseHandler: responseHandler, errorHandler: errorHandler)    }
    
    static func getTypeUsers(responseHandler: @escaping (([Type_User]?) -> Void),
                          errorHandler: @escaping ((Error) -> Void),Key: String) {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Key)"]
        
        self.get(from: typeUserURL, headers: headers , responseHandler: responseHandler, errorHandler: errorHandler)    }
    
    static func postUser(obj: User, responseHandler: @escaping ((User?) -> Void),
                             errorHandler: @escaping ((Error) -> Void),Key: String) {
        let k = "Bearer \(Key)"
        
        let json = obj.toJson()
        print("json: ")
        print(json)
        self.post(from: userURL, bodyParameter: json, key: k, responseHandler: responseHandler, errorHandler: errorHandler)    }
    
    static func putUser(obj: User, responseHandler: @escaping ((User?) -> Void),
                         errorHandler: @escaping ((Error) -> Void),Key: String) {
        let k = "Bearer \(Key)"
        
        let json = obj.toJson()
        print("json: ")
        print(json)
        self.put(from: userURL, bodyParameter: json, key: k, responseHandler: responseHandler, errorHandler: errorHandler)    }
}
