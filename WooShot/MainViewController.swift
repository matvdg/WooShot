//
//  MainViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 10/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

enum Section: Int {
    case maps = 0
    case main = 1
    case profile = 2
}

class MainViewController: UIViewController  {

   
    @IBOutlet weak var maps: UIImageView!
    @IBOutlet weak var main: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var container: UIView!
    
    var pageVC: PageViewController? {
        return self.childViewControllers.flatMap {$0 as? PageViewController}.first
    }
    
    
    var currentSection = Section.maps {
        didSet {
            self.pageVC?.currentSection = currentSection
        }
    }
    
    let scale: CGFloat = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displaySection(section: currentSection)
    }
    
    
    private func displaySection(section: Section) {
        switch section {
        case .maps:
            self.currentSection = .maps
            UIView.animate(withDuration: 0.25, animations: {
                self.main.alpha = 0.3
                self.maps.alpha = 1
                self.profile.alpha = 0.3
                self.maps.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.main.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                self.profile.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            })

        case .profile:
            self.currentSection = .profile
            UIView.animate(withDuration: 0.25, animations: {
                self.main.alpha = 0.3
                self.maps.alpha = 0.3
                self.profile.alpha = 1
                self.maps.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                self.main.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                self.profile.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        case .main:
            self.currentSection = .main
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
