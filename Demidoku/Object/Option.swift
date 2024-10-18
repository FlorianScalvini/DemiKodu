//
//  Option.swift
//  Demidoku
//
//  Created by Florian SCALVINI on 19/12/2018.
//  Copyright © 2018 FlorianSc. All rights reserved.
//

import UIKit

class Option {
    var largeur : Int
    var longueur : Int
    var pourcentageMine: Int
    var difficulté : String
    init(largeur: Int, longueur: Int, poucentageMine: Int, difficulté: String) {
        self.largeur = largeur
        self.longueur = longueur
        self.pourcentageMine = poucentageMine
        self.difficulté = difficulté
    }
}
