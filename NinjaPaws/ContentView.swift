//
//  ContentView.swift
//  NinjaPaws
//
//  Created by Andy Bell on 29.10.20.
//

//import Combine
import SwiftUI

struct Player {
    var name: String
    var cards = [AnimalCard]()
}

enum GameState: String {
    case readyToStart
    case loadingGame
    case inProgress
    case won
}

class ViewModel: ObservableObject {
    
    @Published var gameState: GameState = .readyToStart
    
    var playerOne = Player(name: "Cats")
    var playerTwo = Player(name: "Dogs")
    
    private let animalFactory = AnimalFactory()
    private let picsLoader = AnimalPicsLoader()
    
    func reloadPlayerCards() {
        
        gameState = .loadingGame
        
        // Mock network call...
//        playerOne.cards = animalFactory.generateRandom(.cat, count: 3)
//        playerTwo.cards = animalFactory.generateRandom(.dog, count: 3)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.gameState = .inProgress
//        }
        
        let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=6")!
        
        picsLoader.fetch(url, default: [AnimalPic]()) { result in
            
            switch result {
            case .success(let pics):
                self.processIncomingImages(pics)
            case .failure(let error):
                print("FETCH ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    private func processIncomingImages(_ pics: [AnimalPic]) {
        
        guard pics.count > 5 else {
            print("pic count is less than 6! - \(pics.count)")
            return
        }
        
        // For now just load cats
        let playerOneCards = animalFactory.generateRandom(.cat, pics: Array(pics[0...2]))
        let playerTwoCards = animalFactory.generateRandom(.cat, pics: Array(pics[3...5]))
        
        playerOne.cards = playerOneCards
        playerTwo.cards = playerTwoCards
        
        DispatchQueue.main.async {
            self.gameState = .inProgress
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView() {
            VStack {
                Text("State: \(viewModel.gameState.rawValue)")
                
                Spacer()
                
                switch viewModel.gameState {
                case .readyToStart:
                    Button("Start Game") {
                        viewModel.reloadPlayerCards()
                    }
                case .loadingGame:
                    ProgressView()
                    Text("Loading...")
                case .inProgress:
                    
                    Text("Player 1")
                        .font(.headline)
                    HStack {
                        ForEach(viewModel.playerOne.cards) { card in
                            Spacer()
                            AnimalCardView(animalCard: card)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    Text("Vs.")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Spacer()
                    
                    Text("Player 2")
                        .font(.headline)
                    HStack {
                        ForEach(viewModel.playerTwo.cards) { card in
                            Spacer()
                            AnimalCardView(animalCard: card)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Button("End Game") {
                        viewModel.gameState = .won
                    }
                case .won:
                    Button("Reset") {
                        viewModel.gameState = .readyToStart
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
