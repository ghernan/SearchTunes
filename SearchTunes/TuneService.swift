//
//  TuneService.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/5/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

class TuneService{
    // implement completion handler
    typealias JSONDictionary = [String: Any?]
    
    func getTuneResults(withFilter filter: String = "", completionHandler: @escaping (_ data: JSONDictionary) -> (),
                        errorHandler: @escaping (_ error: Error) -> ()){
        let url:String
        if filter.isEmpty{
            url = APIManager.shared.url
        }else{
            url =  (APIManager.shared.url+" "+filter).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
       
        print("Esta es la:\(url)")
        let task = APIManager.shared.session.dataTask(with: URL(string: url)!){data, response, error in
            if let error = error{
                print("DataTask Error: \(error.localizedDescription)\n")
                errorHandler(error)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONDictionary
                    completionHandler(dict)
                } catch let parseError as NSError {
                    print("JSONSerialization error: \(parseError.localizedDescription)\n")
                    
                    
                }
            }
        }
        task.resume()
        
    }

    
    

}
