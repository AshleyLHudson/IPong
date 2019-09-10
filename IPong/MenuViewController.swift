//
//  MenuViewController.swift
//  IPong
//
//  Created by Ash on 09/07/2019.
//  Copyright © 2019 Ash. All rights reserved.
//

import Foundation
import UIKit

// Used to specify the game type
enum gameType {
    case easy
    case medium
    case difficult
    case player2
}

class MenuViewController : UIViewController {
    
    // Calls to each case statement so that the menu view controller can easly access the game view controller.
    @IBAction func Player2(_ sender: Any) {
        self.animateView(sender as! UIView)
        moveToGame(game: .player2)
    }
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    @IBAction func Difficult(_ sender: Any) {
        moveToGame(game: .difficult)
    }
    
    
    // Moves the Menu View Controller to the Game View Controller
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    fileprivate func animateView(_ viewToAnimate:UIView){
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn , animations:{
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
    }
}
}
