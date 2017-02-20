//
//  gameModeVC.swift
//  Pong
//
//  Created by Steven Santiago on 2/13/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

//import Foundation
import UIKit



class gameModeVC: UIViewController {
    
    
    @IBAction func gameMode(_sender : UIButton) {
        let gameMode = _sender.currentTitle
        
        performSegue(withIdentifier: "GameVC", sender: gameMode)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameVC" {
            if let destination = segue.destination as? GameViewController {
                if let info = sender  {
                    destination.mode = info as! String
                }
            }
        }
    }
    
    
}
