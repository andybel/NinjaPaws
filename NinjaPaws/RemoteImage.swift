//
//  RemoteImage.swift
//  NinjaPaws
//
//  Created by Andy Bell on 29.10.20.
//

import SwiftUI

class ImageDataCache {
    static let instance = ImageDataCache()
    var cache = [String: Data]()
}

struct RemoteImage: View {
    
    private enum LoadState {
        case loading, success, failure
    }
    
    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading
        
        init(url: String) {
            
            if let cachedData = ImageDataCache.instance.cache[url] {
                self.data = cachedData
                self.state = .success
                return
            }
            
            guard let parsedURL = URL(string: url) else {
                print("Invalid img URL: \(url)")
                state = .failure
                return
            }
            
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                    
                    ImageDataCache.instance.cache[url] = data
                    
                } else {
                    self.state = .failure
                }
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
    
    @StateObject private var loader: Loader
    var loadingImage: Image
    var failureImage: Image
    
    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loadingImage = loading
        self.failureImage = failure
    }
    
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loadingImage
        case .failure:
            return failureImage
        default:
            if let img = UIImage(data: loader.data) {
                return Image(uiImage: img)
            } else {
                return failureImage
            }
        }
    }
    
    var body: some View {
        selectImage()
            .resizable()
    }
}
