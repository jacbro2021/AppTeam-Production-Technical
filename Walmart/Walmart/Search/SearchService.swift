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
    
    func fetch_all_products() async throws -> ProductList {
         guard var components = URLComponents(string: "https://dummyjson.com/products") else {
            /*
             This error could be handled better, however if something
             goes wrong here it is likely my fault, so I am just
             handling it like so.
            */
            fatalError("Failed to create url components.")
        }
        
        components.queryItems = [
            URLQueryItem(name: "limit", value: "0")
        ]
        
        guard let url = components.url else {
            // Same reasoning for fatal error usage as above
            fatalError("Failed to create url.")
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await session.data(for: request)
        let productList = try decoder.decode(ProductList.self, from: data)
       
        return productList
    }
    
    func search_products(_ searchTerm: String) async throws -> ProductList {
        guard var components = URLComponents(string: "https://dummyjson.com/products/search") else {
            /*
             This error could be handled better, however if something
             goes wrong here it is likely my fault, so I am just
             handling it like so.
            */
            fatalError("Failed to create url components.")
        }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: searchTerm)
        ]
        
        guard let url = components.url else {
            // Same reasoning for fatal error usage as above
            fatalError("Failed to create url.")
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await session.data(for: request)
        let productList = try decoder.decode(ProductList.self, from: data)
        
        return productList
    }
    
    func fetch_comments() async throws -> CommentList {
        guard let components = URLComponents(string: "https://dummyjson.com/comments") else {
            // Using fatal error for the same reason described in above comments.
            fatalError("Failed to create URL components.")
        }
        
        guard let url = components.url else {
            // Using fatal error for the same reason described in above comments.
            fatalError("Failed to create url.")
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await session.data(for: request)
        let commentList = try decoder.decode(CommentList.self, from: data)
        
        return commentList
    }
}
