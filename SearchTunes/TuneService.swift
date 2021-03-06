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
    
    
    func getTuneResults(withFilter filter: String = "", completionHandler: @escaping (_ data: JSONDictionary) -> (),errorHandler: @escaping (_ error: Error) -> ()){
        
        let urlString = filter.isEmpty ? APIManager.shared.urlString : (APIManager.shared.urlString+" "+filter).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
       
        
        let task = APIManager.shared.session.dataTask(with: URL(string: urlString)!){data, response, error in
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
    func getImageData(fromUrl url: URL, completionHandler: @escaping (_ imageData: Data) -> (),errorHandler: @escaping (_ error: Error) -> ()) {
        APIManager.shared.session.dataTask(with: url) {
            (data, response, error) in
            if let error = error{
                print("DataTask Error: \(error.localizedDescription)\n")
                errorHandler(error)
            } else if let imgData = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                completionHandler(imgData)
            }
            
            }.resume()
    }
    func getTuneURL(fromURL url: URL,completionHandler: @escaping(_ tuneURL: URL)->(), errorHandler:@escaping(_ error:Error)->()){
        APIManager.shared.downloadSession.downloadTask(with: url) { (url, response, error) in
            if let error = error{
                print("DownloadTask Error: \(error.localizedDescription)\n")
                errorHandler(error)
            } else if let tuneURL = url,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                completionHandler(tuneURL)
            }
            
            }.resume()
        
    }


    
    

}
