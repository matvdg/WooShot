//
//  ProfileViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 12/10/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    private let imagePicker = UIImagePickerController()
    private let headerHeight: CGFloat = 44
    private let footerHeight: CGFloat = 21
    private let imageManager = Provider.getImageManager()
    private let userManager = Provider.getUserManager()
    private var displayName = ""
    private var imageUrl = ""
    private var isMale = false
    private var lovesMen = false
    private var lovesWomen = false
    private var headerCell: HeaderTableViewCell?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: RoundedImageView!
    
    @IBAction func didEditProfileImage(_ sender: AnyObject) {
        showSourceSelector()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.clear
        loadCurrentUserInfos()
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
    
    private func loadCurrentUserInfos() {
        guard let user = userManager.getCurrentUser() else {
            print("fatal error: no current user")
            return
        }
        self.imageUrl = user.imageUrl
        self.displayName = user.displayName
        self.isMale = user.isMale
        self.lovesWomen = user.lovesFemale
        self.lovesMen = user.lovesMale
        self.profileImage.image = imageManager.loadImage(imageUrl: self.imageUrl)
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
        cell.imageView?.image = nil
        switch indexPath.section {
        case 1: //sex
            if indexPath.row == 0 {
                cell.textLabel!.text = NSLocalizedString("PROFILE_SEX_MALE", comment: "man")
                cell.accessoryType = self.isMale ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
            } else {
                cell.textLabel!.text = NSLocalizedString("PROFILE_SEX_FEMALE", comment: "woman")
                cell.accessoryType = self.isMale ? UITableViewCellAccessoryType.none : UITableViewCellAccessoryType.checkmark
            }
        case 2: //pref
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            if indexPath.row == 0 {
                cell.textLabel!.text = NSLocalizedString("PROFILE_PREF_MALE", comment: "men")
                cell.accessoryType = self.lovesMen ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
            } else {
                cell.textLabel!.text = NSLocalizedString("PROFILE_PREF_FEMALE", comment: "women")
                cell.accessoryType = self.lovesWomen ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
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
        headerCell.backgroundColor = UIColor.blueBackground
        tableView.backgroundColor = UIColor.blueBackground
        headerCell.editNameButton.isHidden = true
        headerCell.textField.isHidden = true
        headerCell.textLabel!.textColor = UIColor.white
        headerCell.textField.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_NAME", comment: "name"),attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.54)])
        headerCell.textLabel!.isHidden = false
        
        switch section {
        case 0: //name
            headerCell.editNameButton.isHidden = false
            headerCell.editNameButton.setBackgroundImage(UIImage(named: "pencil2"), for: .normal)
            headerCell.editNameButton.layer.zPosition = 10
            headerCell.textLabel!.text = self.displayName
            self.headerCell = headerCell
            headerCell.editNameButton.addTarget(self, action: #selector(didTapEditNameButton), for: UIControlEvents.touchUpInside)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        switch indexPath.section {
        case 1: //sex
            if indexPath.row == 0 {
                if cell!.accessoryType == .none {
                    isMale = true
                    userManager.updateSex(isMale: isMale)
                }
            } else {
                if cell!.accessoryType == .none {
                    isMale = false
                    userManager.updateSex(isMale: isMale)
                }
            }
            tableView.reloadData()
        case 2: //pref
            if indexPath.row == 0 {
                if cell!.accessoryType == .none {
                    lovesMen = true
                } else {
                    lovesMen = false
                }
                userManager.updatePrefMale(lovesMen: lovesMen)
            } else {
                
                if cell!.accessoryType == .none {
                    lovesWomen = true
                } else {
                    lovesWomen = false
                }
                userManager.updatePrefFemale(lovesWomen: lovesWomen)
            }
            tableView.reloadData()
        case 3: //other
            switch indexPath.row {
            case 0: //help
                self.performSegue(withIdentifier: "showHelp", sender: self)
            case 1: //policy
                self.performSegue(withIdentifier: "showPolicy", sender: self)
            case 2: //sign off
                signoff()
            case 3: //log out
                logout()
            default:
                break
            }

        default:
            break
        }

    }
    
    private func logout() {
        let root = self.view.window!.rootViewController!
        root.dismiss(animated: false, completion: {
            if let navVC = root as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            }
        })
    }
    
    private func signoff() {
        print("do signing off stuff...")
        logout()
    }
    
    func didTapEditNameButton() {
        let nameLabel = headerCell!.textLabel!
        let nameField = headerCell!.textField!
        let editButton = headerCell!.editNameButton!
        
        if nameField.isHidden { //edit mode
            nameLabel.isHidden = true
            nameField.isHidden = false
            editButton.setBackgroundImage(UIImage(named: "done"), for: .normal)
            nameField.becomeFirstResponder()
            nameField.delegate = self
        } else { //label mode
            nameField.resignFirstResponder()
            updateDisplayName(textField: nameField)
            self.tableView.reloadData()
        }
    }
    
    //UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateDisplayName(textField: textField)
        self.tableView.reloadData()
        return false
        // We do not want UITextField to insert line-breaks.
    }
    
    private func updateDisplayName(textField: UITextField) {
        guard let name = textField.text else { return }
        guard name != "" else { return }
        self.displayName = name
        userManager.updateDisplayName(displayName: self.displayName)
    }
    


}
