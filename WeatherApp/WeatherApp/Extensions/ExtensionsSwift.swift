//
//  Extensions.swift
//  WeatherApp
//
//  Created by Егор Потопахин on 15.06.2023.
//

extension Double {

    /// функция переводит градусы Фаренгейта в градусы Цельсия
    func FtoCConvert() -> Double {
        (self - 32) / 1.8
    }
}
