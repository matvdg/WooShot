//
//  MainViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 10/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController  {

   
    @IBOutlet weak var maps: UIImageView!
    @IBOutlet weak var main: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var mapsVC: UIView!
    @IBOutlet weak var profileVC: UIView!
    @IBOutlet weak var photoVC: UIView!
    
    
    enum section {
        case maps
        case main
        case profile
    }
    
    
    
    var currentSection = section.maps
    let scale: CGFloat = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func displaySection(section: section) {
        switch section {
        case .maps:
            self.profileVC.isHidden = true
            self.mapsVC.alpha = 0
            self.mapsVC.isHidden = false
            self.currentSection = .maps
            UIView.animate(withDuration: 0.25, animations: {
                self.mapsVC.alpha = 1
                self.main.alpha = 0.3
                self.maps.alpha = 1
                self.profile.alpha = 0.3
                self.maps.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.main.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                self.profile.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            })

        case .profile:
            self.mapsVC.isHidden = true
            self.profileVC.alpha = 0
            self.profileVC.isHidden = false
            self.currentSection = .profile
            UIView.animate(withDuration: 0.25, animations: {
                self.main.alpha = 0.3
                self.maps.alpha = 0.3
                self.profile.alpha = 1
                self.profileVC.alpha = 1
                self.maps.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                self.main.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                self.profile.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        case .main:
            self.currentSection = .main
            self.mapsVC.isHidden = true
            self.profileVC.isHidden = true
            UIView.animate(withDuration: 0.25, animations: {
                self.main.alpha = 1
                self.maps.alpha = 0.3
                self.profile.alpha = 0.3
                self.maps.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                self.main.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.profile.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                
            })
        }
    }
    
    @IBAction func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if self.currentSection == .maps {
                self.displaySection(section: .main)
            } else if self.currentSection == .main {
                self.displaySection(section: .profile)
            }
        }
    }
    
    @IBAction func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if self.currentSection == .profile {
                self.displaySection(section: .main)
            } else if self.currentSection == .main {
                self.displaySection(section: .maps)
            }
        }
    }
    
    @IBAction func didTouchMaps(_ sender: AnyObject) {
        self.displaySection(section: .maps)
    }

    @IBAction func didTouchProfile(_ sender: AnyObject) {
        self.displaySection(section: .profile)
    }
    
    @IBAction func didTouchMain(_ sender: AnyObject) {
        self.displaySection(section: .main)
    }
    
        
}
