//
//  TuneDetailsManager.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/22/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class TuneDetailsManager{
    let detailsService = TuneDetailsService()
    
    func downloadImage(withURL url: URL, completionHandler: @escaping(_ image:UIImage)->(), errorHandler:@escaping(_ error:Error)->()){
        detailsService.getData(fromUrl: url,
                               completionHandler: { (imgData) in
                                completionHandler(UIImage(data:imgData)!)
                                
                                },
                               errorHandler: {error in
                                errorHandler(error)
                                })
    
     }
    func downloadTune(fromURL url: URL, completionHandler: @escaping(_ image:URL)->(), errorHandler:@escaping(_ error:Error)->()){
        detailsService.getTuneData(fromURL: url,
                                   completionHandler: { (ulr) in
                                    completionHandler(url)
            
                                    },
                                   errorHandler: {error in
                                    errorHandler(error)
                                    })
    }
    func openLink(withURL url: URL){
        UIApplication.shared.open(url, options: [:]) { (opened) in
            print("URL did open: \(opened)")
        }
    }
}
