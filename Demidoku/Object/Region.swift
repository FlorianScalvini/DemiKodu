//
//  Region.swift
//  swiftProject
//
//  Created by Florian SCALVINI on 09/12/2018.
//  Copyright © 2018 Florian SCALVINI. All rights reserved.
//

//
// Objet Région : Tableau de 3x3 + Methode de vérification
//
import UIKit

class Region {
    var tabRegion = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    var valeurBloquee = Array(repeating: Array(repeating: false, count: 3), count: 3)
    
    func setValeur(i: Int, j: Int,valeur :Int) {
        tabRegion[i][j]=valeur
    }
    
    func getValeur(i: Int, j:Int) -> Int{
        return tabRegion[i][j]
    }
    
    // Test region
    func testRegion(valeur: Int) -> Bool {
        var i=0,j=0;
        while(i<3) {
            if(tabRegion[i][j]==valeur) {return false}
            else{
                j = j+1
                    if(j==3) {
                        i = i+1
                        j = 0
                    }
                }
            }
        return true;
    }
    //Test ligne
    func testLigne(i : Int,valeur: Int) -> Bool{
    var j=0
    while(j<3) {
        if(tabRegion[i][j]==valeur) {return false}
        j = j+1
    }
    return true;
    }
    //Test colonne
    func testColonne(j : Int,valeur: Int) -> Bool{
        var i=0
        while(i<3) {
            if(tabRegion[i][j]==valeur) {return false}
                i = i+1
            }
        return true;
    }
    //Remplit la region
    func remplirBox() {
        var nombre : Int;
        for i in 0...2{
            for j in 0...2{
                repeat {
                    nombre = Int.random(in: 1...9)
                }while (self.testRegion(valeur: nombre) == false);
                tabRegion[i][j]=nombre;
            }
        }
    }
}

