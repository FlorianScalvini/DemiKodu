//
//  Demineur.swift
//  swiftProject
//
//  Created by Florian SCALVINI on 13/12/2018.
//  Copyright © 2018 Florian SCALVINI. All rights reserved.
//
import UIKit

class Demineur {
    var arrayDemi : [[Int]] = []
    var arrayDemiPrint : [[Bool]] = []
    var nbCaseLargeur : Int
    var nbCaseLongueur : Int
    
    init(nbCaseLargeur : Int, nbCaseLongueur : Int) {
        self.nbCaseLongueur = nbCaseLongueur
        self.nbCaseLargeur = nbCaseLargeur
        arrayDemi = Array(repeating: Array(repeating: 0, count: nbCaseLargeur), count: nbCaseLongueur)
        arrayDemiPrint = Array(repeating: Array(repeating: false, count: nbCaseLargeur), count: nbCaseLongueur)
    }
    
    // Génération de la grille
    func generationMine(pourcentageMine : Int ) -> Int{
        var count = 0
        for i in 0..<nbCaseLongueur{
            for j in 0..<nbCaseLargeur{
                if(Int.random(in: 1...100) < pourcentageMine ){
                    arrayDemi[i][j] = -1
                    count += 1
                }
                else{
                    arrayDemi[i][j] = 0
                }
                arrayDemiPrint[i][j] = false
            }
        }
        for i in 0..<nbCaseLongueur{
            for j in 0..<nbCaseLargeur{
                if(arrayDemi[i][j] != -1 ){
                    arrayDemi[i][j] = self.countValue(i: i, j: j)
                }
            }
        }
        return count
    }
    // Compte les mines avoisinante
    func countValue(i : Int , j : Int) -> Int {
        var count = 0
        if(i>0 && j > 0 && arrayDemi[i-1][j-1] == -1) {count += 1}
        if(i>0 && arrayDemi[i-1][j] == -1) {count += 1}
        if(i>0 && j<nbCaseLargeur-1 && arrayDemi[i-1][j+1] == -1) {count += 1}
        if(j>0 && arrayDemi[i][j-1] == -1) {count += 1}
        if(j<nbCaseLargeur-1 && j<nbCaseLargeur-1 && arrayDemi[i][j+1] == -1) {count += 1}
        if(i<nbCaseLongueur-1 && j>0 && arrayDemi[i+1][j-1] == -1) {count += 1}
        if(i<nbCaseLongueur-1 && arrayDemi[i+1][j] == -1) {count += 1}
        if(i<nbCaseLongueur-1 && j<nbCaseLargeur-1 && arrayDemi[i+1][j+1] == -1) {count += 1}
        return count
    }
    // Affchage console pour debug
    func affiche() {
        var text = ""
        for i in 0..<nbCaseLongueur{
            for j in 0..<nbCaseLargeur{
                text += String(arrayDemi[i][j]) + " "
            }
            text += "\n"
        }
        print(text)
    }
    
    // Affiche ou pas les éléments
    func printOrNotPrint(i : Int , j : Int) {
        if(i>=0 && j>=0 && i<nbCaseLongueur && j<nbCaseLargeur && arrayDemiPrint[i][j] == false ){
            arrayDemiPrint[i][j] = true
            if(arrayDemi[i][j] == 0){
                for x in -1...1{
                    for y in -1...1{
                        printOrNotPrint(i: i+x, j: j+y)
                    }
                }
            }
        }
    }
}
