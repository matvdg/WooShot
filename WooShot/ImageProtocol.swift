//
//  ImageProtocol.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 06/12/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

protocol ImageProtocol {
    
    func upload(image: UIImage, callback: @escaping (String?) -> ())
    func download(callback: @escaping (String?, UIImage?) -> ())
    
}
