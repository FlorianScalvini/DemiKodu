//
//  ViewControllerSudoku.swift
//  Demidoku
//
//  Created by Florian SCALVINI on 04/12/2018.
//  Copyright © 2018 Florian SCALVINI. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerSudoku: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITabBarDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var arrayChoix = [" ","1","2","3","4","5","6","7","8","9"]
    var alpha = Game()
    var difficulte = ""
    var array = Array(repeating: "0", count: 81)
    var arrayCopy = Array(repeating: "0", count: 81)
    var solutionPrint = false; // Solution affichée ou non
    var select : IndexPath?


    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        tabBar.delegate = self
        alpha.geneGrilleJouable(modeDifficulte: difficulte)
        for i in 0...80{
            array[i] = alpha.getValeurGrille(i: i/9, j: i%9)
        }
    }
    // Like Démineur
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let largeur : CGFloat
        let hauteur : CGFloat
        if(collectionView == self.secondCollectionView){
             largeur = secondCollectionView.bounds.width / 5 - 5
             hauteur = secondCollectionView.bounds.height / 2 - 5
        }
        else{
             largeur = CollectionView.bounds.width / 9 - 5
             hauteur = CollectionView.bounds.height / 9 - 5
        }
        return CGSize(width: largeur, height: hauteur)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.secondCollectionView){
            return arrayChoix.count
        }
        else {
            return array.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.secondCollectionView){
            let cellChoix = collectionView.dequeueReusableCell(withReuseIdentifier: "cellChoix", for: indexPath) as! CollectionViewCell
                cellChoix.layer.cornerRadius = 5
                cellChoix.layer.borderWidth = 1
                cellChoix.buttonChoix.setTitle(arrayChoix[indexPath.item], for: .normal)
                cellChoix.buttonChoix.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                return cellChoix
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1
            cell.Button.setTitle(array[indexPath.item], for: .normal)
            cell.Button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            if(array[indexPath.item] != " "){
                cell.Button.isEnabled = false
            }
            else{
                cell.Button.isEnabled = true
            }
            return cell
        }
    }
    //Like démineur
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        let item = tabBar.items?.index(of: item)
        if (item == 0){
            if(solutionPrint == false){
                for i in 0...80 {arrayCopy[i] = alpha.getValeurGrille(i: i/9, j: i%9)}
                let result = alpha.solution()
                print(result)
                if(result == false){
                    AlertResult(resultat: -1)
                }
                else{
                    solutionPrint = true
                }
            }
            else{
                for i in 0...80 {alpha.setValeurGrille(i: i/9, j: i%9,valeur: arrayCopy[i])}
                solutionPrint = false
            }
        }
        if( item == 1){
            let result = alpha.check()
            AlertResult(resultat: result)
        }
        else if( item == 2){
            alpha.geneGrilleJouable(modeDifficulte: difficulte)
            solutionPrint = false
        }
        else if( item == 3){
            alpha.eraseGame()
            solutionPrint = false
            for i in 0...80 {
                array[i] = " "
            }
        }
        var index : IndexPath
        var text : String
        for i in 0...80{
            index = [0,i]
            text = alpha.getValeurGrille(i: i/9, j: i%9)
            let cell = CollectionView.cellForItem(at: index) as! CollectionViewCell
                cell.Button.setTitle(text, for: .normal)
                if(item == 3 || item == 2 && text == " "){
                    cell.Button.isEnabled = true
                }
            
        }
        
    }
    
    
    
    // AlertBox en fonction des status de la vérification de la grille
    func AlertResult(resultat : Int) {
        var alert : UIAlertController
        if (resultat == -1){
            alert = UIAlertController(title: "Erreur", message: "Vous avez entrer des erreurs ou une grille incorrecte", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        }
        if(resultat == 0){
            alert = UIAlertController(title: "Bravo", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        }
        else if (resultat == 1){
            alert = UIAlertController(title: "Erreur", message: "Entrer une grille complete", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        }
        else {
            alert = UIAlertController(title: "Erreur", message: "Vous avez entrer une erreur", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        }
        self.present(alert, animated: true)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if(solutionPrint == false){
            let hitPoint = sender.convert(CGPoint.zero, to: CollectionView)
            if let indexPath = CollectionView.indexPathForItem(at: hitPoint){
                if(select != nil){
                    let cell = CollectionView.cellForItem(at: select!) as! CollectionViewCell
                    cell.layer.borderColor = UIColor.black.cgColor
                    if(cell.Button.isEnabled == true){cell.Button.titleLabel!.textColor = UIColor.red}
                }
                select = indexPath
                if(select != nil){
                    let cell = CollectionView.cellForItem(at: select!) as! CollectionViewCell
                    cell.layer.borderColor = UIColor.red.cgColor
                }
            }
        }
    }
    @IBAction func buttonChoixPressed(_ sender: UIButton) {
        let hitPoint = sender.convert(CGPoint.zero, to: secondCollectionView)
        if let indexPath = secondCollectionView.indexPathForItem(at: hitPoint){
            if(select != nil && solutionPrint == false){
                let valeur = select!
                alpha.setValeurGrille(i: valeur.item/9, j: valeur.item%9, valeur: String(indexPath[1]))
                let cell = CollectionView.cellForItem(at: valeur) as! CollectionViewCell
                if(indexPath[1] == 0){
                    cell.Button.setTitle(" ", for: .normal)
                }
                else {
                    cell.Button.setTitle(String(indexPath[1]), for: .normal)
                }
            }
        }
    }
    //Button Home
    @IBAction func sudokuToMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // Get value core data
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                difficulte = data.value(forKey: "difficulte") as! String
            }
        }catch{
            print("Failed saving")
        }
    }
    
}

