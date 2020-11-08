//
//  AnimalDetailView.swift
//  NinjaPaws
//
//  Created by Andy Bell on 08.11.20.
//

import SwiftUI

struct AnimatedRing: View {
    @Binding var val: CGFloat
    let col: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 10,
                                                       lineCap: .round,
                                                       lineJoin: .round))
                .opacity(0.4)
            Circle()
                .trim(from: val, to: 1.0)
                .stroke(col, style: StrokeStyle(lineWidth: 10,
                                                       lineCap: .round,
                                                       lineJoin: .round))
                .rotationEffect(.degrees(90))
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .animation(.easeOut(duration: 1))
        }
        .frame(width: 100, height: 100)
    }
}

struct AttackView: View {
    
    @Binding var ringVal: CGFloat
    var attack: AnimalTrait
    
    var body: some View {
        VStack {
            ZStack {
                Text(String(format: "%.02f", 1.0 - ringVal))
                    .font(.headline)
                AnimatedRing(val: $ringVal, col: attack.color)
            }
            Text(attack.description)
                .font(.body)
                .multilineTextAlignment(.center)
        }
    }
}

struct AnimalDetailView: View {
    
    var animalCard: AnimalCard
    
    @State private var ringOneVal: CGFloat = 0.99
    @State private var ringTwoVal: CGFloat = 0.99
    @State private var ringThreeVal: CGFloat = 0.99
    @State private var ringFourVal: CGFloat = 0.99
    
    var body: some View {
        VStack {
            Color(.black)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 50)

            RemoteImage(url: animalCard.imgUrl)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .offset(y: -130)
                    .padding(.bottom, -130)

            VStack {
                Text(animalCard.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                HStack(alignment: .top) {
                    Spacer()
                    AttackView(ringVal: $ringOneVal, attack: animalCard.attacks.pawAttack)
                    Spacer()
                    AttackView(ringVal: $ringTwoVal, attack: animalCard.attacks.biteAttack)
                    Spacer()
                }
                .padding(.bottom, 30)
                HStack(alignment: .top) {
                    Spacer()
                    AttackView(ringVal: $ringThreeVal, attack: animalCard.attacks.speedAttack)
                    Spacer()
                    AttackView(ringVal: $ringFourVal, attack: animalCard.attacks.cuteAttack)
                    Spacer()
                }
            }
            .padding()

            Spacer()
        }
        .onAppear {
            
            ringOneVal = animalCard.attacks.pawAttack.value
            ringTwoVal = animalCard.attacks.biteAttack.value
            ringThreeVal = animalCard.attacks.speedAttack.value
            ringFourVal = animalCard.attacks.cuteAttack.value
            
        }
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailView(animalCard: AnimalCard.example)
    }
}
