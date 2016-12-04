//
//  PageViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 04/12/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var currentSection = Section.maps {
        didSet {
            if currentSection.rawValue < oldValue.rawValue {
                self.setViewControllers([self.getViewController(section: currentSection)], direction: .reverse, animated: true, completion: nil)
            } else {
                self.setViewControllers([self.getViewController(section: currentSection)], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
    
    private func getViewController(section: Section) -> UIViewController {
        var id = ""
        switch section {
        case .main:
            id = "photos"
        case .profile:
            id = "profile"
        case .maps:
            id = "maps"
        }
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id)
    }

}
