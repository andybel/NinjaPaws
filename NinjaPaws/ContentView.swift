//
//  ContentView.swift
//  NinjaPaws
//
//  Created by Andy Bell on 29.10.20.
//

import Combine
import SwiftUI

struct CatPic: Decodable, Identifiable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

struct ContentView: View {
    @StateObject var dataSource = CatPicsDataSource()
    
    var body: some View {
        NavigationView {
            List(dataSource.items) { cat in
                RemoteImage(url: cat.url)
                    .aspectRatio(CGFloat(Double(cat.width) / Double(cat.height)), contentMode: .fit)
                    .onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: cat)
                    }
            }
            .navigationTitle("Ninja-Paws")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
