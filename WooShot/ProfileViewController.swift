//
//  ProfileViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 12/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    private let imagePicker = UIImagePickerController()
    private let headerHeight: CGFloat = 44
    private let footerHeight: CGFloat = 21
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: RoundedImageView!
    
    @IBAction func didEditProfileImage(_ sender: AnyObject) {
        showSourceSelector()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.clear        
    }
    
    private func showSourceSelector() {
        let sourceSelector = UIAlertController(title: NSLocalizedString("SOURCE_TITLE", comment: "source text"), message: NSLocalizedString("SOURCE_MSG", comment: "source message"), preferredStyle: .actionSheet)
        
        sourceSelector.addAction(UIAlertAction(title: NSLocalizedString("SOURCE_CAMERA", comment: "upload from camera") , style: .default, handler: { (action) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            self.imagePicker.cameraDevice = .front
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        sourceSelector.addAction(UIAlertAction(title: NSLocalizedString("SOURCE_LIBRARY", comment: "upload from library") , style: .default, handler: { (action) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        sourceSelector.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "dismiss") , style: .cancel, handler: nil))
        
        present(sourceSelector, animated: true)
    }
    
    //UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = chosenImage
        dismiss(animated:true, completion: nil)
    }


    //Table view delegates methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: //name
            return 0
        case 1: //sex
            return 2
        case 2: //pref
            return 2
        case 3: //other
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setting", for: indexPath)
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.adjustsFontSizeToFitWidth = true
        
        switch indexPath.section {
        case 0: //name
            cell.accessoryType = UITableViewCellAccessoryType.none
            cell.textLabel!.text = "Robert"
        case 1: //sex
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            if indexPath.row == 0 {
                cell.textLabel!.text = NSLocalizedString("PROFILE_SEX_MALE", comment: "man")
            } else {
                cell.textLabel!.text = NSLocalizedString("PROFILE_SEX_FEMALE", comment: "woman")
            }
        case 2: //pref
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            if indexPath.row == 0 {
                cell.textLabel!.text = NSLocalizedString("PROFILE_PREF_MALE", comment: "men")
            } else {
                cell.textLabel!.text = NSLocalizedString("PROFILE_PREF_FEMALE", comment: "women")
            }
        case 3: //other
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            switch indexPath.row {
            case 0: //help
                cell.textLabel!.text = NSLocalizedString("PROFILE_HELP", comment: "help")
                cell.imageView?.image = UIImage(named: "help")
            case 1: //policy
                cell.textLabel!.text = NSLocalizedString("POLICY", comment: "policy")
            case 2: //sign off
                cell.textLabel!.text = NSLocalizedString("PROFILE_SIGN_OFF", comment: "sign off")
            case 3: //log out
                cell.textLabel!.text = NSLocalizedString("LOGOUT", comment: "log out")
                cell.imageView?.image = UIImage(named: "logout")
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != 3 {
            return footerHeight
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // custom view for header. will be adjusted to default or specified header height
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "settingHeader") as? HeaderTableViewCell else { return UITableViewCell() }
        headerCell.textLabel!.textColor = UIColor.white
        headerCell.textLabel!.adjustsFontSizeToFitWidth = true
        headerCell.backgroundColor = Color.blueBackground
        tableView.backgroundColor = Color.blueBackground
        headerCell.editNameButton.isHidden = true
        headerCell.textField.isHidden = true
        
        switch section {
        case 0: //name
            headerCell.editNameButton.isHidden = false
            headerCell.editNameButton.layer.zPosition = 10
            headerCell.textLabel!.text = "Robert"
            headerCell.textLabel!.textColor = UIColor.white
        case 1: //sex
            headerCell.textLabel!.text = NSLocalizedString("PROFILE_SEX_HEADER", comment: "I am")
            headerCell.textLabel!.textColor = UIColor(white: 1, alpha: 0.54)
        case 2: //pref
            headerCell.textLabel!.text = NSLocalizedString("PROFILE_PREF_HEADER", comment: "I wanna meet")
            headerCell.textLabel!.textColor = UIColor(white: 1, alpha: 0.54)
        case 3: //other
            headerCell.textLabel!.text = ""
        default:
            break
        }
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != 3 {
            let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width , height: footerHeight))
            let separator = UIView(frame: CGRect(x: 16, y: 10, width: tableView.bounds.width - 32 , height: 1))
            separatorView.addSubview(separator)
            separator.backgroundColor = UIColor(white: 1, alpha: 0.54)
            return separatorView
        } else {
            return nil
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
