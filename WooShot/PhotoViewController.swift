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
        User(displayName: "Julie", imageUrl: "girl1"),
        User(displayName: "Lola", imageUrl: "girl2"),
        User(displayName: "Aurélia", imageUrl: "girl3"),
        User(displayName: "Alicia", imageUrl: "girl4"),
        User(displayName: "Candice", imageUrl: "girl5"),
        User(displayName: "Soraya", imageUrl: "girl6"),
        User(displayName: "Mélissa", imageUrl: "girl7"),
        User(displayName: "Clara", imageUrl: "girl8")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        cell.image.image = UIImage(named: imageUrl)?.getRoundedImage(cornerRadius: nil)
        cell.name.text = name
        
        return cell
    }
    


}
