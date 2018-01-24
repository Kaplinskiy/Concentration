//
//  Card.swift
//  WLtest
//
//  Created by Kaplinskiy Alexander on 22.01.2018.
//  Copyright © 2018 Kaplinskiy Alexander. All rights reserved.
//

import Foundation // Базовая библиотека

struct Card: Hashable // Структура (объект) карта
{
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false // Флаг положения карты (рубашка вверх - True, рубашка вниз - False)
    var isMatched = false // Флаг состояния карты (найдена - True, не найдена - False)
    private var identifier: Int // Идентификатор (номер) карты
    
    private static var identifierFactory = 0 // Сквозной идентификатор (общий для всех карт, он же кол-во карт)
    
    private static func getUniqueIdentifier() -> Int { // Функция получения уникального идентификатора для карты, возвращает значение типа INT
        Card.identifierFactory += 1 // Увеличение счетчика кол-ва карт (идентификатор)
        return Card.identifierFactory // Возвращаем идентификатор (кол-во карт)
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier() // Присваиваем идентификатор = текущие кол-во карт
    }
}
