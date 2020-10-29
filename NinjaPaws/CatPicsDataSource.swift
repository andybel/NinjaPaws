//
//  CatPicsDataSource.swift
//  NinjaPaws
//
//  Created by Andy Bell on 29.10.20.
//

import Combine
import SwiftUI

class CatPicsDataSource: ObservableObject {
    
    @Published var items = [CatPic]()
    @Published var isLoading = false
    
    @State private var requests = Set<AnyCancellable>()
    
    private var currentPage = 1
    private var canLoadMorePages = true
    
    init() {
        loadMoreContent()
    }
    
    func loadMoreContentIfNeeded(currentItem item: CatPic?) {
        guard let item = item else {
            loadMoreContent()
            return
        }
        
        let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
        if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    private func loadMoreContent() {
        
        print("request to loadMoreContent. Current page: \(currentPage)")
        
        guard !isLoading && canLoadMorePages else {
            return
        }
        isLoading = true
    
        let url = URL(string: "https://api.thecatapi.com/v1/images/search?page=\(currentPage)&limit=10&order=desc")!
        
        URLSession.shared.dataTaskPublisher(for: url)
              .map(\.data)
              .decode(type: [CatPic].self, decoder: JSONDecoder())
              .receive(on: DispatchQueue.main)
              .handleEvents(receiveOutput: { response in
                //self.canLoadMorePages = response.hasMorePages
                self.isLoading = false
                self.currentPage += 1
              })
              .map({ response in
                return self.items + response
              })
              .catch({ _ in Just(self.items) })
            .assign(to: &$items)
    }
    
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) {
        
        let decoder = JSONDecoder()
        
        print("fetch: \(url.absoluteString)")
        
        URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            //.replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                print("We completed! - \($0)")
            }, receiveValue: {
                print("here?")
                completion($0)
            })
            .store(in: &requests)
    }
}
