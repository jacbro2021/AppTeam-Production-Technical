//
//  SearchService.swift
//  Walmart
//
//  Created by jacob brown on 1/31/24.
//

import Foundation

class SearchService {
    // Session to make network calls
    private var session = URLSession.shared
    // Decoder to decode data recieved from network calls
    private var decoder = JSONDecoder()
    
    func fetch_categories() {}
    
    func fetch_products_by_category() {}
    
    func search_products() {}
}
