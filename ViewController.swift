//
//  ViewController.swift
//  WLtest
//
//  Created by Kaplinskiy Alexander on 22.01.2018.
//  Copyright © 2018 Kaplinskiy Alexander. All rights reserved.
//

import UIKit // Библиотека элементов UI

class ViewController: UIViewController { // Описание класса контроллера вида
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards) // Создание объекта игры, lazy для использования еще не объявленных переменных
    
    var numberOfPairsOfCards: Int { // Кол-во карт для игры - определяеться кол-вом карт созданных в Main.Storyboard
        return ((cardButtons.count + 1 ) / 2) // Возвращаем кол-во (на всякий случай прибавляем 1 если вдруг кол-во карт нечетное)
    }
    
    private(set) var flipCount = 0 { // Объявляем счетчик кол-ва переворота карт
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLable.attributedText =  attributedString
    }
    
    @IBOutlet private weak var flipCountLable: UILabel! {// Связываем объект для отображения кол-ва переворотов карт
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]! // Связываем объекты для всех карт
    
    @IBAction private func touchCard(_ sender: UIButton) { // Функция обработчик ля всех карт вызываемая при нажатии на карту
        flipCount += 1 // Увеличиваем счетчик кол-ва переворотов карт на 1
        if let cardNumber = cardButtons.index(of: sender) { // Берем индекс нажатой карты в CardNumber
            game.chooseCard(at: cardNumber) // Фузываем функцию обрабатывающую нажатие на карту
            updateViewModel() // Обновляем экран
        } else {
            print("Card Not Found") // Печатаем если вдруг ошибка и карта не найдена
        }
        
    }
    
    private func updateViewModel() { // Обновление вида
        for index in cardButtons.indices { // Для всех карт которые не убраны
            let button = cardButtons[index] // Пусть button это карта на экране
            let card = game.cards[index] // Пусть card это карта которая соответствует кнопке
            if card.isFaceUp { // Если карта лицом вверх
                button.setTitle(emoji(for: card), for: UIControlState.normal) // Изобразить на карте символ картинки
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // На белом фоне
            } else { // Если карта лицом вниз
                button.setTitle("", for: UIControlState.normal) // Убрать изображение с карты
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.87227512, green: 1, blue: 0.8685269373, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) // И изобразить ораньжевый фон или если карты уже нет то сделать ее прозначной
            }
        }
        
    }
    
 //   private var emojiChoices = ["👺","👻","🤡","💀","🎃","🧟‍♂️","⛄️","👀","😈","🤖"] // Набор всех картинок
    private var emojiChoices = "👺👻🤡💀🎃🧟‍♂️⛄️👀😈🤖" // Набор всех картинок
    
    private var emoji = [Card:String]() // Массив содержащий номер и картинку
    
    private func emoji(for card: Card) -> String { // Функция изменения
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "😟"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

