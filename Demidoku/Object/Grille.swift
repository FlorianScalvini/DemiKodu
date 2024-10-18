//
//  Grille.swift
//  swiftProject
//
//  Created by Florian SCALVINI on 09/12/2018.
//  Copyright © 2018 Florian SCALVINI. All rights reserved.
//

//
// Objet Grille : Tableau d'objet Région + gestion de la grille : Solution, Verification, Clear, Set or Get value
//
import UIKit

class Grille: NSObject{
    
    var tabGrille = [[Region(), Region(), Region()],[Region(), Region(), Region()],[Region(), Region(), Region()]]
    
    func getValeurGrille(i: Int, j: Int)->Int {
        return tabGrille[i/3][j/3].getValeur(i: i%3,j: j%3)
    }
    func setValeurGrille(i : Int, j: Int, valeur: Int) {
        tabGrille[i/3][j/3].setValeur(i: i%3,j: j%3, valeur: valeur)
    }
    
    
    /* méthode de test */
    func testLigne(i: Int,valeur: Int) -> Bool{
        var j=0
        while(j<3) {
            if(!tabGrille[i/3][j].testLigne(i: i%3,valeur: valeur)) {return false}
            j += 1
        }
        return true
    }
    func testColonne(j: Int,valeur: Int) -> Bool {
        var i=0
        while(i<9) {
            if(!tabGrille[i/3][j/3].testColonne(j: j%3,valeur:  valeur)) {return false}
            i += 1
        }
        return true
    }
    
    //Test les différents conditions d'une grille de sudoku (Ligne,region,colonne)
    func testCondition(i: Int, j: Int, valeur: Int) -> Bool{
        if(!testColonne(j: j,valeur:  valeur) || !testLigne(i: i,valeur: valeur) || !tabGrille[i/3][j/3].testRegion(valeur: valeur)){return false}
        else {return true}
    }
    
    /* Methode solution grille */
    func solution() -> Bool
    {
        var i=0
        var j = Int()
        var valeur = Int()
        
        while(i>=0 && i<9) {
            j=0
            while(j>=0 && j<9) {
                if(tabGrille[i/3][j/3].getValeur(i: i%3,j: j%3)==0){
                    valeur = 1
                    while(valeur<10){
                        if(testCondition(i: i,j: j,valeur: valeur)){
                            tabGrille[i/3][j/3].setValeur(i: i%3,j: j%3,valeur: valeur)
                            if ( solution() == true) {
                                return true
                            }
                            else {tabGrille[i/3][j/3].setValeur(i: i%3,j: j%3,valeur:  0)}
                        }
                        valeur += 1
                    }
                    return false
                }
                j += 1
                }
            i += 1
        }
        return true;
    }
    //Remplit les diagonales de la grille
    func remplirDiagonal() {
        for n in 0...2 {
            tabGrille[n][n].remplirBox()
        }
    }
    
    //Convertit un mode de difficulté en un entier
    class func convertModeDifficultetoValue(modeDifficulte: String) -> Int{
        if(modeDifficulte.elementsEqual("Difficile")) {return 50}
        else if(modeDifficulte.elementsEqual("Intermediaire")) {return 45}
        else {return 40}
    }
    //Efface les valeurs de la grille
    func eraseGrille() {
        for i in 0...8 {
            for j in 0...8 {
                tabGrille[i/3][j/3].setValeur(i: i%3,j: j%3,valeur: 0)
            }
        }
    }
}
