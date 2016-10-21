//
//  MainViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 10/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

   
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var maps: UIImageView!
    @IBOutlet weak var main: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var shareDrink: UIButton!
    @IBOutlet weak var mapsVC: UIView!
    @IBOutlet weak var profileVC: UIView!
    
    enum section {
        case maps
        case main
        case profile
    }
    
    var demo = [
        User(displayName: "Julie", imageUrl: "girl1"),
        User(displayName: "Lola", imageUrl: "girl2"),
        User(displayName: "Aurélia", imageUrl: "girl3"),
        User(displayName: "Alicia", imageUrl: "girl4"),
        User(displayName: "Candice", imageUrl: "girl5"),
        User(displayName: "Soraya", imageUrl: "girl6"),
        User(displayName: "Mélissa", imageUrl: "girl7"),
        User(displayName: "Clara", imageUrl: "girl8")
    ]
    
    var currentSection = section.main
    let scale: CGFloat = 0.7
    var currentPhotoIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designTopBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.designButton()
    }
    
    private func designTopBar() {
        self.shareDrink.isHidden = true
        self.maps.alpha = 0.5
        self.profile.alpha = 0.5
        self.maps.transform = CGAffineTransform(scaleX: scale, y: scale)
        self.profile.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    private func designButton() {
        shareDrink.backgroundColor = Color.wooColor
        shareDrink.setTitleColor(UIColor.white, for: .normal)
        shareDrink.isHidden = false
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
    
    private func displayErrorAlertController(localizedString: String) {
        // create alert controller
        let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: localizedString, preferredStyle: UIAlertControllerStyle.alert)
        myAlert.view.tintColor = Color.wooColor
        // add "OK" button
        myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // show the alert
        present(myAlert, animated: true)
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
    
    @IBAction func didSwipePhotoLeft(_ sender: UISwipeGestureRecognizer) {
        
        if self.currentPhotoIndex < demo.count {
            print("didSwipePhotoLeft", currentPhotoIndex)
            self.currentPhotoIndex += 1
            self.photoCollection.beginInteractiveMovementForItem(at: IndexPath(item: self.currentPhotoIndex, section: 0))
        }
    }
    
    @IBAction func didSwipePhotoRight(_ sender: UISwipeGestureRecognizer) {
        
        if self.currentPhotoIndex > 0 {
            print("didSwipePhotoRight", currentPhotoIndex)
            self.currentPhotoIndex -= 1
            self.photoCollection.beginInteractiveMovementForItem(at: IndexPath(item: self.currentPhotoIndex, section: 0))
        }
    }
    
    
    
    //UICollectionViewDataSource delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return demo.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let imageUrl = demo[indexPath.row].imageUrl
        let name = demo[indexPath.row].displayName
        cell.image.image = UIImage(named: imageUrl)?.getRoundedImage()
        cell.name.text = name
        
        return cell
    }
    
    //privacy methods
    private func askForNotifications() {
            }
    
    private func askForLocalization() {
        
    }
    
}
