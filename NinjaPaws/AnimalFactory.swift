//
//  AnimalFactory.swift
//  NinjaPaws
//
//  Created by Andy Bell on 07.11.20.
//

import SwiftUI

enum AnimalType: String {
    case cat
    case dog
}

struct AnimalTrait {
    let description: String
    let color: Color
    let value: CGFloat
    
    // TODO: the random values shoudl bbe assigned from an allocated total- this will ensure each animal has an equal total attack point allocation
    static var traitPawAttack: AnimalTrait {
        AnimalTrait(description: "Paw Attack", color: .red, value: 1.0 - CGFloat.random(in: 0.0...1.0))
    }
    
    static var traitBiteAttack: AnimalTrait {
        AnimalTrait(description: "Bite Attack", color: .blue, value: 1.0 - CGFloat.random(in: 0.0...1.0))
    }
    
    static var traitSpeedAttack: AnimalTrait {
        AnimalTrait(description: "Speed Attack", color: .green, value: 1.0 - CGFloat.random(in: 0.0...1.0))
    }
    
    static var traitCuteAttack: AnimalTrait {
        AnimalTrait(description: "Cute Attack", color: .orange, value: 1.0 - CGFloat.random(in: 0.0...1.0))
    }
}

struct AttackTraits {
    let pawAttack = AnimalTrait.traitPawAttack
    let biteAttack = AnimalTrait.traitBiteAttack
    let speedAttack = AnimalTrait.traitSpeedAttack
    let cuteAttack = AnimalTrait.traitCuteAttack
}

struct AnimalCard: Identifiable {
    let id = UUID()
    let name: String
    let imgUrl: String
    let animalType: AnimalType = .cat
    let attacks = AttackTraits()
    
    static var example: AnimalCard {
        AnimalCard(name: "Example", imgUrl: "")
    }
}

class AnimalFactory {
    
    func generateRandom(_ type: AnimalType, pics: [AnimalPic]) -> [AnimalCard] {
        
        let namesPool = type == .cat ? Self.catNamesPool.shuffled() : Self.dogNamesPool.shuffled()
        let names = namesPool[0..<pics.count]
        
        var cards = [AnimalCard]()
        for (i, pic) in pics.enumerated() {
            let card = AnimalCard(name: names[i], imgUrl: pic.url)
            cards.append(card)
        }
        return cards
    }
    
    static private let dogNamesPool = [
        "Dunkin Butterbeans",
        "Cheesebro",
        "Choo Choo Boo Boo",
        "Empress Tzu Tzu",
        "Farrah Pawcett",
        "Fiona Penny Pickles",
        "Monsieur Le Colonel Moustache",
        "Tango Mango",
        "The Other Dude",
        "Yeti Sphaghetti",
        "Aeiress Patty White",
        "Agnes Gooch",
        "Anna Banana Lovelace",
        "Atticus Theodore Cutbirth",
        "Baby Bam Bam Bono",
        "Baran Of The Midnight Sun",
        "Barfolomew Barfonopolis",
        "Blue Noodle Hans Castellon",
        "Bobolina Pinky Poo",
        "Brewster Chewybear",
        "Casey At The Bat",
        "Cashmere T Mcgrew",
        "Charlie Corgnelius Mcnolegs",
        "Cheeto Batman",
        "Daisy Belle Fluffbottoms",
        "Dale Junebug Jr",
        "Doc Howliday",
        "Dog Marley",
        "Dr Bannana Pancakes Aka Cakes",
        "Driving Miss Fancy",
        "Ezekiel Bakes The Bread",
        "Flupner Dog Lips",
        "G Money James Dean Barkington III",
        "Governor Clarence Bumblesnout",
        "Lucy In The Sky With Diamonds",
        "Ozzy Pawsborn Francis",
        "Sir Nippit Sandport Barksworth",
        "Tiger Copa Khan Ice Cream",
        "Tony The Wrench",
        "Trooper Von Brushyneck",
        "Tuff Stardust Denim",
        "Tumble Bumble",
        "Tupaw Shakur",
        "Turkey Run Dancing Raisin",
        "Webster Doodledoodle",
        "White Magics Icy Hot",
        "Wilber Whiskey Von Doodle",
        "Yukons Gold Grand Slam",
        "Zeus The Deuce",
        "Zyla Blu Whitehead"
    ]

    static private let catNamesPool = [
        "Professor Snafflepuss",
        "Little Booty Ham Sandwich",
        "Dog The Cat",
        "Fifty Shades Of Graham",
        "Isaac Mewton",
        "Jabba The Butt",
        "Ninja Killer Nine Thousand",
        "Obi Wan Catnobi",
        "The Great Catsby",
        "Whiskerus Maximus",
        "Winston Purrchill",
        "Amazes Me Penelope",
        "Bowie Spartacus",
        "Chicken Pants",
        "Cisco Allen Mcflashkitty",
        "Count Wigglybutt",
        "Disco Cheetah",
        "Draco Meowfoy",
        "Dutchess Mouse Mcmittens",
        "Foxy Spreadsheets",
        "Humphrey Bojangles",
        "Jonathan Supersocks",
        "Maximus Mcmarbles",
        "Monochromaticat",
        "Motley Crouton",
        "Mrs. Meowgi",
        "Newton Reginald Schibbelhut",
        "Old Man Hands",
        "Pepper Blue Hotsauce Peters",
        "Pistachio Buttons",
        "Pocket Change",
        "Princess Fairy Boots",
        "Reece Whiskerspoon",
        "Sassy Oil Spot",
        "Scratchy Sir Purr",
        "Sergeant Snuggles",
        "Sir Boots N Pants",
        "Spartacus Creamsicle",
        "Stinky Poo Poos",
        "Sugar Britches",
        "Sunny Summersunburst",
        "The Little Muffin Man",
        "The Princess Sofia Bean The Third Esq",
        "Thumbs Hemingway",
        "Tiny Thursday",
        "Tom Brady The Cat",
        "Toothless Truffle",
        "Trouble Boogers",
        "Tumtum Mcpuff",
        "Tybalt Copperpot",
        "Wendy Wondercat",
    ]
}
