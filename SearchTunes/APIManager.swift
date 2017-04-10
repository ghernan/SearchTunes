//
//  APIManager.swift
//  SearchTunes
//
//  Created by Antonio  Hernandez  on 4/5/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

public class APIManager{

    static let shared: APIManager = APIManager()
    let url = "https://itunes.apple.com/search?media=music&entity=song&term=abba"
    let session = URLSession(configuration: .default)
   
}
