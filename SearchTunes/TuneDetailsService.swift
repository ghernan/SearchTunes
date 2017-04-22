//
//  TuneDetailsService.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/22/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

class TuneDetailsService{
    
    func getData(fromUrl url: URL, completionHandler: @escaping (_ data: Data) -> (),errorHandler: @escaping (_ error: Error) -> ()) {
        APIManager.shared.session.dataTask(with: url) {
            (data, response, error) in
            if let error = error{
                print("DataTask Error: \(error.localizedDescription)\n")
                errorHandler(error)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                completionHandler(data)
            }
            
            }.resume()
    }

}