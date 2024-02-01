//
//  SearchViewModel.swift
//  Walmart
//
//  Created by jacob brown on 1/31/24.
//

import Foundation

enum SearchState {
    case idle
    case loading
    case success(products: ProductList)
    case error(err: String)
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var loadingState = SearchState.idle
    
    private var service = SearchService()
    
    func get_products() {
        loadingState = .loading
        
        Task {
            do {
                loadingState = .success(products: try await service.fetch_all_products())
            } catch {
                print(error)
                loadingState = .error(err: error.localizedDescription)
            }
        }
    }
    
    func search_products() {
        loadingState = .loading
        
        Task {
            do {
                loadingState = .success(products: try await service.fetch_all_products())
            } catch {
                loadingState = .error(err: error.localizedDescription)
            }
        }
    }
}
