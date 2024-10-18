//
//  ViewControllerOption.swift
//  Demidoku
//
//  Created by Florian SCALVINI on 17/12/2018.
//  Copyright © 2018 Florian SCALVINI. All rights reserved.
//
import CoreData
import UIKit

class ViewControllerOption: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var choixDiff = ["Facile", "Medium", "Difficile"]
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var slideLong: UISlider!
    @IBOutlet weak var slideLarg: UISlider!
    @IBOutlet weak var pourcentageTextField: UITextField!
    @IBOutlet weak var pickerViewDiff: UIPickerView!
    var largeur = 10
    var longueur = 10
    var pourcentageMine = 20
    var difficulté = "Facile"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerViewDiff.delegate = self
        self.pickerViewDiff.dataSource = self
        self.pourcentageTextField.delegate = self
        getData()
        slideLarg.setValue(Float(largeur), animated: true)
        slideLong.setValue(Float(longueur), animated: true)
        pourcentageTextField.text = String(pourcentageMine)
        self.pourcentageTextField.keyboardType = UIKeyboardType.decimalPad
        if(difficulté == "Facile"){
            pickerViewDiff.selectRow(0, inComponent: 0, animated: true)
        }
        else if(difficulté == "Intermediaire"){
            pickerViewDiff.selectRow(1, inComponent: 0, animated: true)
        }
        else{
            pickerViewDiff.selectRow(2, inComponent: 0, animated: true)
        }
        buttonSave.layer.cornerRadius = 5
        buttonSave.layer.borderWidth = 2
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choixDiff.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choixDiff[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row == 0){
            difficulté = "Facile"
        }
        else if(row == 1){
            difficulté = "Intermediaire"
        }
        else{
            difficulté = "Difficile"
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return  pourcentageTextField.text!.count < 4
    }
    @IBAction func optionToMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sliderLongueur(_ sender: UISlider) {
        longueur = Int(Float(sender.value))
    }
    
    @IBAction func sliderLargeur(_ sender: UISlider) {
        largeur = Int(Float(sender.value))
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pourcentageTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func saveAction(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        pourcentageMine = Int(pourcentageTextField.text!)!
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        newEntity.setValue(longueur, forKey: "longueur")
        newEntity.setValue(pourcentageMine, forKey: "pourcentageMine")
        newEntity.setValue(largeur, forKey: "largeur")
        newEntity.setValue(difficulté, forKey: "difficulte")
        do{
            try context.execute(batchDeleteRequest)
            try context.save()
            print("save")
        } catch{
            print("Failed saving")
        }
    }
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
                difficulté = data.value(forKey: "difficulte") as! String
            }
        }catch{
                print("Failed saving")
        }
    }
}
