//
//  game.swift
//  swiftProject
//
//  Created by Florian SCALVINI on 09/12/2018.
//  Copyright © 2018 Florian SCALVINI. All rights reserved.
//

//
// Objet Game : Interfacage entre l'objet Grille et le viewControllerSudoku
//
import UIKit

class Game : NSObject{
    
    var alpha = Grille()
    //Méthode permettant de générer une grille
    func geneGrilleJouable(modeDifficulte: String) { // Methode permettant de generer une grille
        alpha.eraseGrille() //Efface la grille
        alpha.remplirDiagonal() // Remplit les régions diagonales de la grille
        let test = alpha.solution();  //Résout la grille
        if (!test) {print("Error")}
        else {
            for i in 0...8 {
                for j in 0...8 {
                    if(Int.random(in: 1...81) < Grille.convertModeDifficultetoValue(modeDifficulte: modeDifficulte)) { //Supprime ou non la valeur de la case en fonction de la difficulté
                        alpha.setValeurGrille(i: i, j: j, valeur: 0)
                    }
                }
            }
        }
 
    }
    //Verification de la grille
    func check() -> Int {//Test ou non si la grille est complete en fonction de choix
        var i=0
        var j = Int()
        var memo = Int()
        var test = 0
        while(i<9 && test == 0) {
            j = 0
                while(j<9 && test == 0) {
                    memo = alpha.getValeurGrille(i: i, j: j);
                    if( memo == 0) {test = 1}
                    else {
                        alpha.setValeurGrille(i: i, j: j, valeur: 0);
                        if( memo == 0  || (!alpha.testCondition(i: i, j: j, valeur: memo) && memo != 0)) {test = 2 }
                        alpha.setValeurGrille(i: i, j: j, valeur: memo);
                        j += 1
                    }
                }
            i += 1
        }
        return test;
    }
    // Méthode solution
    func solution() -> Bool{
        return alpha.solution();
    }
    // Méthode nettoyage de la grille
    func eraseGame() { //Nettoye la fenetre en appelant la méthode eraseGrille
        alpha.eraseGrille()
        print(alpha.getValeurGrille(i: 0, j: 0))
    }
    // Méthode permettant d'obtenir la valeur de la grille
    func getValeurGrille(i: Int,j: Int) -> String {
        let nombre = String(alpha.getValeurGrille(i: i, j: j))
        if (nombre == "0") {
            return " "
        }
        else {
            return nombre
        }
    }
    // Méthode permettant d'affecter une valeur de la grille
    func setValeurGrille(i: Int,j: Int, valeur: String) {
        if(valeur == " ") {
            alpha.setValeurGrille(i: i, j: j, valeur: 0)
        }
        else {
            alpha.setValeurGrille(i: i, j: j, valeur: Int(valeur)!)
        }
    }
    
    
}
