//
//  DummyJSON.swift
//  Walmart
//
//  Created by jacob brown on 1/31/24.
//

import Foundation

struct ProductList: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}

struct CommentList: Codable {
    let comments: [Comment]
    let total, skip, limit: Int
}

struct Comment: Codable, Identifiable {
    let id: Int
    let body: String
    let postId: Int
    let user: User
}

struct User: Codable {
    let id: Int
    let username: String
}
