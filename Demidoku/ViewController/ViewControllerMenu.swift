//
//  ViewControllerMenu.swift
//  Demidoku
//
//  Created by Florian SCALVINI on 13/12/2018.
//  Copyright © 2018 Florian SCALVINI. All rights reserved.
//

import UIKit

class ViewControllerMenu: UIViewController {


    @IBOutlet weak var playButtonDemineur: UIButton!
    @IBOutlet weak var playButtonSudoku: UIButton!
    @IBOutlet weak var buttonOption: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    playButtonSudoku.titleLabel?.textColor = UIColor.black
        playButtonSudoku.layer.cornerRadius = 5
        playButtonSudoku.layer.borderWidth = 2
        playButtonSudoku.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        playButtonDemineur.titleLabel?.textColor = UIColor.black
        playButtonDemineur.layer.cornerRadius = 5
        playButtonDemineur.layer.borderWidth = 2
        playButtonDemineur.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        buttonOption.titleLabel?.textColor = UIColor.black
        buttonOption.layer.cornerRadius = 5
        buttonOption.layer.borderWidth = 2
        buttonOption.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playButtonSudoku(_ sender: Any) {
       performSegue(withIdentifier: "segueMenuToSudoku", sender: self)
    }
    
    
    @IBAction func playButtonDemi(_ sender: Any) {
         performSegue(withIdentifier: "segueMenuToDemi", sender: self)
    }
    @IBAction func actionButtonOption(_ sender: Any) {
        performSegue(withIdentifier: "segueMenuToOption", sender: self)
    }


}
