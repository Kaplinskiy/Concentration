//
//  Concentration.swift
//  WLtest
//
//  Created by Kaplinskiy Alexander on 22.01.2018.
//  Copyright © 2018 Kaplinskiy Alexander. All rights reserved.
//

import Foundation // Базовая библиотека

struct Concentration // Описание базового класса игры
{
    private(set) var cards = [Card]() // Игра содержит массив типа Card содержащий карты
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//-*            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    
    
    mutating func chooseCard(at index: Int) { // Функция вызываемая при обработке нажатия на любую карту
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) { // Создание массива карт (добавляем по две карты, в соответствии со смыслом игры)
        assert(numberOfPairsOfCards>0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards { // Цикл - сколько разных карт есть в игре
            let card = Card() // Создаем пустой объект типа Card запуская его инициализатор
            cards += [card, card] // Добавляем в массив карт по две карты, в соответствии со смыслом игры
        }
        // TODO: Shuffle the cards
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
