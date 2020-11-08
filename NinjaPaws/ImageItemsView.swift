//
//  ImageItemsView.swift
//  NinjaPaws
//
//  Created by Andy Bell on 07.11.20.
//

import SwiftUI

struct ImageItemsView: View {
    @StateObject var dataSource = CatPicsDataSource()
    
    var body: some View {
        NavigationView {
            List(dataSource.items) { cat in
                RemoteImage(url: cat.url)
                    .aspectRatio(cat.widthToHeightRatio, contentMode: .fit)
                    .onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: cat)
                    }
            }
            .navigationTitle("Ninja-Paws")
        }
    }
}

struct ImageItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageItemsView()
    }
}
