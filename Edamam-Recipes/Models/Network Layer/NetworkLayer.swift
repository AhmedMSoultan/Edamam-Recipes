//
//  NetworkLayer.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import Foundation
import Alamofire
import UIKit

class NetworkLayer {
    
   static let shared = NetworkLayer()
   private init () {}
   
    let headers: HTTPHeaders = [
        "app_id": "9d40ce84",
        "app_key": "99612783a545e279eda9723c1620eded",
        "type": "public",
        "q": "chicken",
    ]
    
    func get<T> (endPoint: EndPoint, className: T.Type, completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        AF.request(endPoint.url, headers: headers).validate().responseDecodable (of: T.self){ response in
            switch response.result {
            case .success:
                guard let data = response.value else {return}
                completionHandler( .success(data))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
