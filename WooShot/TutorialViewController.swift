//
//  TutorialViewController.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 27/09/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit
import Firebase

class TutorialViewController: WooShotViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var step = 0
    var displayName: String = ""
    var isMale: Bool?
    var lovesMen = false
    var lovesWomen = false
    let imagePicker = UIImagePickerController()

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var greetings: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var elements: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var genderStackView: UIStackView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var maleLabel: UILabel!
    
    //@IBAction methods
    @IBAction func maleSelected(_ sender: AnyObject) {
        self.selectSex(isMale: true)
    }
    
    @IBAction func femaleSelected(_ sender: AnyObject) {
        self.selectSex(isMale: false)
    }
    
    @IBAction func nextStep(_ sender: AnyObject) {
        self.showNextStep()
    }
    
    //app cyclelife methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.genderStackView.isHidden = true
        self.genderLabel.isHidden = true
        self.maleLabel.isHidden = true
        self.femaleLabel.isHidden = true
        self.elements.layer.zPosition = 1
        self.nextButton.isHidden = true
        self.view.tintColor = UIColor.white
        self.greetings.text = NSLocalizedString("GREETINGS", comment: "greetings")
        self.nextButton.setTitle(NSLocalizedString("NEXT", comment: "next"), for: .normal)
        self.nameField.textColor = UIColor.white
        self.nameField.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_NAME", comment: "name"),attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.54)])

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.nameField.becomeFirstResponder()
        self.nextButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.nextButton.layer.cornerRadius = self.nextButton.bounds.height/2
        self.nextButton.backgroundColor = UIColor.white
        self.nextButton.setTitleColor(Color.wooColor, for: .normal)
        self.nextButton.layer.zPosition = 10
    }
    
    //UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.showNextStep()
        return false
        // We do not want UITextField to insert line-breaks.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.nextButton.isHidden = false
        return true
    }
    
    
    //controller's logic methods
    private func showNextStep() {
        switch self.step {
        case 0:
            self.didCompleteFirstStep()
        case 1:
            self.didCompleteSecondStep()
        case 2:
            self.didCompleteThirdStep()
        default: break
        }
        

    }
    
    private func setDisplayName() {
        
        guard let user = FIRAuth.auth()?.currentUser else { return }
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                // create alert controller
                let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                myAlert.view.tintColor = Color.wooColor
                // add "OK" button
                myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(myAlert, animated: true, completion: nil)
                print(error.localizedDescription)
                return
            }

            print(user.email, user.displayName)
        }
    }
    
    private func didCompleteFirstStep() {
        if (self.nameField.text?.isEmpty)! { //error
            // create alert controller
            let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: NSLocalizedString("NAME_ERROR", comment: "name error"), preferredStyle: UIAlertControllerStyle.alert)
            myAlert.view.tintColor = Color.wooColor
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(myAlert, animated: true, completion: nil)
        } else { //name ok
            self.nameField.resignFirstResponder()
            self.displayName = self.nameField.text!
            self.step += 1
            self.pageControl.currentPage = 1
            self.greetings.text = "\(NSLocalizedString("GREAT", comment: "just great"))\(self.displayName)"
            self.maleLabel.text = NSLocalizedString("MALE", comment: "male")
            self.femaleLabel.text = NSLocalizedString("FEMALE", comment: "female")
            self.genderLabel.text = NSLocalizedString("GENDER", comment: "gender question")
            self.nameField.isHidden = true
            self.maleLabel.isHidden = false
            self.femaleLabel.isHidden = false
            self.genderLabel.isHidden = false
            self.genderStackView.isHidden = false
            self.nextButton.isHidden = true
            self.nextButton.frame = CGRect(x: self.view.bounds.midX - 100, y: self.view.bounds.maxY - 100, width: 200, height: 50)
        }
    }
    
    private func didCompleteSecondStep() {
        self.step += 1
        self.pageControl.currentPage = 2
        self.greetings.isHidden = true
        self.maleLabel.text = NSLocalizedString("MALE_PREF", comment: "men")
        self.femaleLabel.text = NSLocalizedString("FEMALE_PREF", comment: "women")
        self.genderLabel.text = NSLocalizedString("GENDER_PREF", comment: "preferences question")
        self.maleButton.alpha = 0.5
        self.maleLabel.alpha = 0.5
        self.femaleButton.alpha = 0.5
        self.femaleLabel.alpha = 0.5
        self.nextButton.isHidden = true
    }
    
    private func didCompleteThirdStep() {
        if !(self.lovesWomen || self.lovesMen) { //error
            // create alert controller
            let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: NSLocalizedString("PREF_ERROR", comment: "pref error unselected"), preferredStyle: UIAlertControllerStyle.alert)
            myAlert.view.tintColor = Color.wooColor
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(myAlert, animated: true, completion: nil)
        } else {
            self.step += 1
            self.pageControl.currentPage = 3
            self.greetings.text = NSLocalizedString("PHOTO", comment: "photo upload")
            self.profileImage.isHidden = false
            self.greetings.isHidden = false
            self.genderLabel.isHidden = true
            self.nameField.isHidden = true
            self.maleLabel.isHidden = true
            self.femaleLabel.isHidden = true
            self.genderStackView.isHidden = true
            self.nextButton.isHidden = true
            
            let sourceSelector = UIAlertController(title: NSLocalizedString("SOURCE_TITLE", comment: "source text"), message: NSLocalizedString("SOURCE_MSG", comment: "source message"), preferredStyle: UIAlertControllerStyle.actionSheet)
            sourceSelector.addAction(UIAlertAction(title: NSLocalizedString("SOURCE_CAMERA", comment: "upload from camera") , style: UIAlertActionStyle.default, handler: { (action) in
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.present(self.imagePicker, animated: true, completion: nil)

            }))
            sourceSelector.addAction(UIAlertAction(title: NSLocalizedString("SOURCE_LIBRARY", comment: "upload from library") , style: UIAlertActionStyle.default, handler: { (action) in
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)

            }))
                
            self.present(sourceSelector, animated: true)
        }
    }
    
    private func selectSex(isMale: Bool) {
        self.nextButton.isHidden = false
        if step == 1 {
            if isMale { //touched men button
                self.isMale = true
                self.maleButton.alpha = 1
                self.maleLabel.alpha = 1
                self.femaleButton.alpha = 0.5
                self.femaleLabel.alpha = 0.5
            } else { //touched women button
                self.isMale = false
                self.femaleLabel.alpha = 1
                self.femaleButton.alpha = 1
                self.maleButton.alpha = 0.5
                self.maleLabel.alpha = 0.5
            }
        } else {
            if isMale { //touched men button
                self.lovesMen = !self.lovesMen
                if self.lovesMen {
                    self.maleButton.alpha = 1
                    self.maleLabel.alpha = 1
                } else {
                    self.maleButton.alpha = 0.5
                    self.maleLabel.alpha = 0.5
                }
            } else { //touched women button
                self.lovesWomen = !self.lovesWomen
                if self.lovesWomen {
                    self.femaleLabel.alpha = 1
                    self.femaleButton.alpha = 1
                } else {
                    self.femaleLabel.alpha = 0.5
                    self.femaleButton.alpha = 0.5
                }
            }
        }
    }
    
    private func showSourceSelector() {
        
    }

    
//    private func updateDisplayName(_ user: FIRUser) {
//        let changeRequest = user.profileChangeRequest()
//        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
//        changeRequest.commitChanges(){ (error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            
//            print(user.email, user.displayName)
//        }
//    }

    

}
