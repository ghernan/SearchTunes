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
    

}
