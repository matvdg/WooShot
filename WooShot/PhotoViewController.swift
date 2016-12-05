//
//  PhotoViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 22/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var demo = [
        User(displayName: "Julie"),
        User(displayName: "Lola"),
        User(displayName: "Aurélia"),
        User(displayName: "Alicia"),
        User(displayName: "Candice"),
        User(displayName: "Soraya"),
        User(displayName: "Mélissa"),
        User(displayName: "Clara")
    ]

    @IBOutlet weak var currentPlaceLabel: CornerRadiusLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentIndex: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding swipe gestures to the collection view
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.direction = .left
        swipeLeft.addTarget(self, action: #selector(didSwipe))
        self.collectionView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.direction = .right
        swipeRight.addTarget(self, action: #selector(didSwipe))
        self.collectionView.addGestureRecognizer(swipeRight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    //UICollectionViewDataSource delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return demo.count + 2
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row == 0 || indexPath.row == demo.count + 1 {
            cell.isHidden = true
        } else {
            cell.isHidden = false
            let name = demo[indexPath.row - 1].displayName
            let random: Int = Int(arc4random() % 8 + 1)
            let imageName = "girl\(random)"
            cell.image.image = UIImage(named: imageName)?.getSquaredImage()
            cell.name.text = name
            cell.shareButton.tag = indexPath.row - 1
            cell.shareButton.addTarget(self, action: #selector(didTouchShare), for: .touchUpInside)
            
        }
        return cell
    }
    
    // methods
    func didTouchShare(sender: UIButton) {
        if sender.tag + 1 == self.currentIndex {
            print(demo[sender.tag].displayName)
        }
        
    }
    
    func didSwipe(sender: UISwipeGestureRecognizer){
        if sender.direction == .left {
            if self.currentIndex < demo.count {
                self.currentIndex += 1
                let indexPath = IndexPath(item: self.currentIndex, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        } else if sender.direction == .right {
            if self.currentIndex > 1 {
                self.currentIndex -= 1
                let indexPath = IndexPath(item: self.currentIndex, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
        
        
    }
    
    


}
