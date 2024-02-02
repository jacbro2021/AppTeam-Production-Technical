//
//  ProductDetailViewModel.swift
//  Walmart
//
//  Created by jacob brown on 2/1/24.
//

import Foundation

enum ProductDetailLoadingState {
    case idle
    case loading
    case success(commentList: CommentList)
    case error(err: String)
}

@MainActor
class ProductDetailViewModel: ObservableObject {
    @Published var product: Product
    @Published var loadingState = ProductDetailLoadingState.idle

    private var service = SearchService()

    init(product: Product) {
        self.product = product
    }

    func GetComments() {
        loadingState = .loading

        Task {
            do {
                loadingState = try .success(commentList: await service.fetch_comments())
            } catch {
                print(error)
                loadingState = .error(err: error.localizedDescription)
            }
        }
    }
}
