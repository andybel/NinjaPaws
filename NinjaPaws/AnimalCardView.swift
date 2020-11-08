//
//  AnimalCardView.swift
//  NinjaPaws
//
//  Created by Andy Bell on 07.11.20.
//

import SwiftUI

struct AnimalCardView: View {
    var animalCard: AnimalCard
    
    var body: some View {
        NavigationLink(destination: AnimalDetailView(animalCard: animalCard)) {
            VStack {
                RemoteImage(url: animalCard.imgUrl)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                Text(animalCard.name)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14.0))
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50, alignment: .center)
            }
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 150, alignment: .center)
        }
    }
}

struct AnimalCardView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalCardView(animalCard: AnimalCard.example)
    }
}
