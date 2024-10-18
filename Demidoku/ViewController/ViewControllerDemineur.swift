//
//  ViewControllerDemineur.swift
//  Demidoku
//
//  Created by Florian SCALVINI on 13/12/2018.
//  Copyright © 2018 Florian SCALVINI. All rights reserved.
//

import UIKit
import CoreData
import AVKit

class ViewControllerDemineur: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITabBarDelegate, UICollectionViewDelegateFlowLayout{
    
    
    
    var largeur  = 10
    var longueur = 10
    var pourcentageMine = 20
    var demineur : Demineur?
    var loose  = false
    var flag : Bool?
    var boomSound : AVAudioPlayer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var labelNbMine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        collectionView.delegate = self
        collectionView.dataSource = self
        tabBar.delegate = self
        demineur = Demineur(nbCaseLargeur: largeur, nbCaseLongueur: longueur)
        labelNbMine.layer.borderWidth = 1
        labelNbMine.layer.cornerRadius = 5
        labelNbMine.text = "Number of mines : " + String(demineur!.generationMine(pourcentageMine: pourcentageMine))
        flag = false
        guard let path = Bundle.main.path(forResource: "boom",ofType: "mp3")
            else {return}
        let url = URL(fileURLWithPath: path)
        boomSound = try? AVAudioPlayer(contentsOf: url, fileTypeHint: nil)
        boomSound?.prepareToPlay()
        boomSound?.setVolume(1, fadeDuration: 0.1)
        
    }
    // Définition du nb de case en Lar et Long
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / CGFloat(largeur) - 5
        let yourHeight = collectionView.bounds.height / CGFloat(longueur) - 5
        
        return CGSize(width: yourWidth, height: yourHeight)
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
        return largeur*longueur
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellDemineur = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cellDemineur.buttonDemi.setTitle(" ", for: .normal)
        cellDemineur.buttonDemi.setTitleColor(UIColor.black, for: .normal)
        cellDemineur.layer.borderWidth = 1
        cellDemineur.layer.cornerRadius = 4
        cellDemineur.buttonDemi.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cellDemineur.buttonDemi.isEnabled = true
        return cellDemineur
    }
    
    // Button de la grille Pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        if(loose == false){
            let hitPoint = sender.convert(CGPoint.zero, to: collectionView)
            if var indexPath = collectionView.indexPathForItem(at: hitPoint){
                var cellDemineur = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                if(flag == false && cellDemineur.buttonDemi.title(for: .normal) != "🚩"){
                    demineur!.printOrNotPrint(i: indexPath.item/largeur, j: indexPath.item%largeur)
                    for i in 0..<longueur*largeur{
                        indexPath.item = i
                        if(demineur!.arrayDemiPrint[i/largeur][i%largeur] == true){
                            cellDemineur = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                            if(cellDemineur.buttonDemi.title(for: .normal) == "🚩"){
                                demineur?.arrayDemiPrint[i/largeur][i%largeur] = false
                            }
                            else if(demineur!.arrayDemi[i/largeur][i%largeur] == 0){
                                cellDemineur.buttonDemi.setTitle(" ", for: .normal)
                                cellDemineur.buttonDemi.backgroundColor = UIColor.gray
                                cellDemineur.buttonDemi.isEnabled = false
                            }
                            else if(demineur!.arrayDemi[i/largeur][i%largeur] == -1){
                                cellDemineur.buttonDemi.backgroundColor = UIColor.red
                                cellDemineur.buttonDemi.setTitle("💣", for: .normal)
                                boomSound?.play()
                                let alert = UIAlertController(title: "Try Again", message: "Boooooom Booom Boom", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                                self.present(alert, animated: true)
                                loose = true
                                
                            }
                            else{
                                cellDemineur.buttonDemi.setTitle(String(demineur!.arrayDemi[i/largeur][i%largeur]), for: .normal)
                                cellDemineur.buttonDemi.setTitleColor(UIColor.blue, for: .normal)
                                cellDemineur.buttonDemi.isEnabled = false
                            }
                        }
                    }
                }
                else if(cellDemineur.buttonDemi.title(for: .normal) == "🚩"){
                    cellDemineur.buttonDemi.setTitle("  ", for: .normal)
                }
                else {
                    cellDemineur.buttonDemi.setTitle("🚩", for: .normal)
                }
            }
        }
    }
    // Différentes function de la tabBar
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let item = tabBar.items?.index(of: item)
        if(item! == 0){
            if(flag == false){
                flag = true
                tabBar.items?[0].title = "Mine"
                tabBar.items?[0].image = UIImage(named: "mine")
                tabBar.items?[0].selectedImage = UIImage(named: "mine")
            }
            else {
                flag = false
                tabBar.items?[0].title = "Flag"
                tabBar.items?[0].image = UIImage(named: "flag")
                tabBar.items?[0].selectedImage = UIImage(named: "flag")
            }
        }
        if(item! == 1){
            Validation()
        }
        if(item! == 2){
            geneDemi()
            loose = false
        }
    }
    
    //Button Home
    @IBAction func demineurToMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Chargement des values CoreData
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                largeur = data.value(forKey: "largeur") as! Int
                longueur = data.value(forKey: "longueur") as! Int
                pourcentageMine = data.value(forKey: "pourcentageMine") as! Int
            }
        }catch{
            print("Failed saving")
        }
    }
    //Génération du démineur
    func geneDemi() {
        labelNbMine.text  = "Number of mines: " + String(demineur!.generationMine(pourcentageMine: pourcentageMine))
        var index : IndexPath = [0,0]
        for i in 0..<longueur*largeur {
            index.item = i
            let cellDemineur = collectionView.cellForItem(at: index) as! CollectionViewCell
            cellDemineur.buttonDemi.isEnabled = true
            cellDemineur.buttonDemi.setTitle("  ", for: .normal)
            cellDemineur.buttonDemi.backgroundColor = UIColor.white
            cellDemineur.buttonDemi.setTitleColor(UIColor.white, for: .normal)
        }
    }
    //Vérification du démineur
    func Validation() {
        var test = true
        var i = 0
        while (i < largeur*longueur && test == true){
                if (demineur?.arrayDemiPrint[i/largeur][i%largeur]  == false && demineur?.arrayDemi[i/largeur][i%largeur] != -1) {
                    test = false
                }
            i += 1
        }
        print(test)
        if (test == false){
            let alert = UIAlertController(title: "Error", message: "Démineur non résolu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Bravo", message: "Démineur résolu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            geneDemi()
        }
    }
    
    

}
