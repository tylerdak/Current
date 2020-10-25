//
//  Gradients.swift
//  InstantStories
//
//  Created by Tyler Dakin on 6/7/20.
//  Copyright © 2020 Tyler Dakin. All rights reserved.
//

import Foundation
import SwiftUI

let blueDark = Color.init(red: 0, green: 81/255, blue: 225/255)
let blueLight = Color.init(red: 0, green: 192/255, blue: 255/255)
let blueGrade = Gradient(colors: [blueDark,blueLight])

let yellowDark = Color.init(red: 226/255, green: 174/255, blue: 0/255)
let yellowLight = Color.init(red: 245/255, green: 225/255, blue: 0/255)
let yellowGrade = Gradient(colors: [yellowDark,yellowLight])

let greenDark = Color.init(red: 0/255, green: 220/255, blue: 109/255)
let greenLight = Color.init(red: 0/255, green: 252/255, blue: 220/255)
let greenGrade = Gradient(colors: [greenDark,greenLight])

let orangeDark = Color.init(red: 255/255, green: 39/255, blue: 5/255)
let orangeLight = Color.init(red: 226/255, green: 162/255, blue: 0/255)
let orangeGrade = Gradient(colors: [orangeDark,orangeLight])

let redDark = Color.init(red: 163/255, green: 21/255, blue: 2/255)
let redLight = Color.init(red: 255/255, green: 47/255, blue: 0/255)
let redGrade = Gradient(colors: [redDark,redLight])

let purpleDark = Color.init(red: 79/255, green: 30/255, blue: 161/255)
let purpleLight = Color.init(red: 156/255, green: 55/255, blue: 255/255)
let purpleGrade = Gradient(colors: [purpleDark,purpleLight])

let pinkDark = Color.init(red: 155/255, green: 36/255, blue: 161/255)
let pinkLight = Color.init(red: 255/255, green: 58/255, blue: 218/255)
let pinkGrade = Gradient(colors: [pinkDark,pinkLight])

let grayDark = Color.init(red: 56/255, green: 56/255, blue: 56/255)
let grayLight = Color.init(red: 163/255, green: 163/255, blue: 163/255)
let grayGrade = Gradient(colors: [grayDark,grayLight])

let gradientOfColor: [String : Gradient] = [
    "blue": blueGrade,
    "yellow": yellowGrade,
    "green": greenGrade,
    "orange": orangeGrade,
    "red": redGrade,
    "purple": purpleGrade,
    "pink": pinkGrade,
    "gray": grayGrade
]
