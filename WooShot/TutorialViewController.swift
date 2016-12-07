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
    
    private var step = 0
    private var displayName: String = ""
    private var isMale: Bool?
    private var lovesMen = false
    private var lovesWomen = false
    private let imagePicker = UIImagePickerController()
    private var imageSet = false
    
    
    @IBOutlet weak var activitySpin: UIActivityIndicatorView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonBottom: AppleMusicButton!
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
        selectSex(isMale: true)
    }
    
    @IBAction func femaleSelected(_ sender: AnyObject) {
        selectSex(isMale: false)
    }
    
    @IBAction func nextStep(_ sender: AnyObject) {
        showNextStep()
    }
    
    @IBAction func didTouchProfileImage(_ sender: AnyObject) {
        showSourceSelector()
    }
    
    //app cyclelife methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        genderStackView.isHidden = true
        genderLabel.isHidden = true
        maleLabel.isHidden = true
        femaleLabel.isHidden = true
        elements.layer.zPosition = 1
        nextButton.isHidden = true
        nextButtonBottom.isHidden = true
        view.tintColor = UIColor.white
        greetings.text = NSLocalizedString("GREETINGS", comment: "greetings")
        nextButton.setTitle(NSLocalizedString("NEXT", comment: "next"), for: .normal)
        nextButtonBottom.setTitle(NSLocalizedString("NEXT", comment: "next"), for: .normal)
        
        nameField.textColor = UIColor.white
        nameField.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_NAME", comment: "name"),attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.54)])
        nameField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nextButton.backgroundColor = UIColor.white
        nextButton.setTitleColor(UIColor.wooColor, for: .normal)
        nextButtonBottom.setTitleColor(UIColor.wooColor, for: .normal)
        nextButton.layer.zPosition = 10
    }
    
    //UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        showNextStep()
        return false
        // We do not want UITextField to insert line-breaks.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        nextButton.isHidden = false
        return true
    }
    
    //UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageSet = true
        profileImage.image = chosenImage
        didCompleteLastStep()
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
        guard imageSet == false else { return }
        self.presentErrorAlertViewController(message: NSLocalizedString("PHOTO_ERROR", comment: "photo error"))
    }
    
    //controller's logic methods
    private func showNextStep() {
        switch step {
        case 0:
            didCompleteFirstStep()
        case 1:
            didCompleteSecondStep()
        case 2:
            didCompleteThirdStep()
        case 3:
            uploadDataAndSegue()
        default: break }
    }
    
    private func setDisplayName() {
        
        guard let user = FIRAuth.auth()?.currentUser else { return }
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                self.presentErrorAlertViewController(message: error.localizedDescription)
            }
            
            print(user.email!, user.displayName!)
        }
    }
    
    private func didCompleteFirstStep() {
        if (nameField.text?.isEmpty)! { //error
            self.presentErrorAlertViewController(message: NSLocalizedString("NAME_ERROR", comment: "name error"))
        } else { //name ok
            nameField.resignFirstResponder()
            displayName = nameField.text!
            step += 1
            pageControl.currentPage = 1
            nextButton.isHidden = true
            
            //animations
            UIView.animate(withDuration: 0.25, delay: 0.00, options: UIViewAnimationOptions(), animations: {
                self.greetings.layer.position.x -= self.view.bounds.width
                self.nameField.layer.position.x -= self.view.bounds.width
            }) { done in
                self.maleLabel.alpha = 0
                self.femaleLabel.alpha = 0
                self.genderStackView.alpha = 0
                self.maleLabel.isHidden = false
                self.femaleLabel.isHidden = false
                self.genderLabel.isHidden = false
                self.genderStackView.isHidden = false
                self.greetings.layer.position.x += self.view.bounds.width * 2
                self.genderLabel.layer.position.x += self.view.bounds.width
                self.genderLabel.isHidden = false
                self.greetings.text = "\(NSLocalizedString("GREAT", comment: "just great"))\(self.displayName)"
                self.nameField.isHidden = true
                self.maleLabel.text = NSLocalizedString("MALE", comment: "male")
                self.femaleLabel.text = NSLocalizedString("FEMALE", comment: "female")
                self.genderLabel.text = NSLocalizedString("GENDER", comment: "gender question")
                UIView.animate(withDuration: 0.25, animations: {
                    self.greetings.layer.position.x -= self.view.bounds.width
                    self.genderLabel.layer.position.x -= self.view.bounds.width
                    self.maleLabel.alpha = 1
                    self.femaleLabel.alpha = 1
                    self.genderStackView.alpha = 1
                })
            }
        }
    }
    
    private func didCompleteSecondStep() {
        step += 1
        pageControl.currentPage = 2
        greetings.isHidden = true
        maleLabel.alpha = 0
        femaleLabel.alpha = 0
        genderStackView.alpha = 0
        maleLabel.text = NSLocalizedString("MALE_PREF", comment: "men")
        femaleLabel.text = NSLocalizedString("FEMALE_PREF", comment: "women")
        genderLabel.text = NSLocalizedString("GENDER_PREF", comment: "preferences question")
        maleButton.alpha = 0.5
        maleLabel.alpha = 0.5
        femaleButton.alpha = 0.5
        femaleLabel.alpha = 0.5
        nextButtonBottom.isHidden = true
        
        //animations
        UIView.animate(withDuration: 0.25, animations: {
            self.genderLabel.layer.position.x -= self.view.bounds.width
        }) { (done) in
            self.genderLabel.layer.position.x += self.view.bounds.width * 2
            UIView.animate(withDuration: 0.25, animations: {
                self.genderLabel.layer.position.x -= self.view.bounds.width
                self.maleLabel.alpha = 1
                self.femaleLabel.alpha = 1
                self.genderStackView.alpha = 1
            })
        }
    }
    
    private func didCompleteThirdStep() {
        if !(lovesWomen || lovesMen) { //error
            self.presentErrorAlertViewController(message: NSLocalizedString("PREF_ERROR", comment: "pref error unselected"))
        } else {
            showSourceSelector()
            step += 1
            pageControl.currentPage = 3
            greetings.layer.position.x += view.bounds.width
            greetings.text = NSLocalizedString("PHOTO", comment: "photo upload")
            profileImage.alpha = 0
            profileImage.isHidden = false
            greetings.isHidden = false
            maleLabel.isHidden = true
            femaleLabel.isHidden = true
            genderStackView.isHidden = true
            nextButtonBottom.isHidden = true
            
            //animations
            UIView.animate(withDuration: 0.25, animations: {
                self.genderLabel.layer.position.x -= self.view.bounds.width
            }) { (done) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.greetings.layer.position.x -= self.view.bounds.width
                    self.profileImage.alpha = 1
                })
            }
        }
    }
    
    private func didCompleteLastStep() {
        self.logoImage.image = UIImage(named: "cheers")
        self.greetings.text = NSLocalizedString("PHOTO_END", comment: "photo upload done")
        self.nextButtonBottom.setTitle(NSLocalizedString("TUTO_END", comment: "the end"), for: .normal)
        nextButtonBottom.isHidden = false
    }
    
    private func uploadDataAndSegue() {
        // TODO upload user info
        self.activitySpin.startAnimating()
        Provider.getImageManager().upload(image: self.profileImage.image!, callback: { (err) in
            self.activitySpin.stopAnimating()
            if let error = err {
                self.presentErrorAlertViewController(message: error)
            } else {
                self.performSegue(withIdentifier: "launchApp", sender: self)
            }
        })
    }
    
    private func selectSex(isMale: Bool) {
        nextButtonBottom.isHidden = false
        if step == 1 {
            if isMale { //touched men buttons
                self.isMale = true
                maleButton.alpha = 1
                maleLabel.alpha = 1
                femaleButton.alpha = 0.5
                femaleLabel.alpha = 0.5
            } else { //touched women button
                self.isMale = false
                femaleLabel.alpha = 1
                femaleButton.alpha = 1
                maleButton.alpha = 0.5
                maleLabel.alpha = 0.5
            }
        } else {
            if isMale { //touched men button
                lovesMen = !lovesMen
                if lovesMen {
                    maleButton.alpha = 1
                    maleLabel.alpha = 1
                } else {
                    maleButton.alpha = 0.5
                    maleLabel.alpha = 0.5
                }
            } else { //touched women button
                lovesWomen = !lovesWomen
                if lovesWomen {
                    femaleLabel.alpha = 1
                    femaleButton.alpha = 1
                } else {
                    femaleLabel.alpha = 0.5
                    femaleButton.alpha = 0.5
                }
            }
        }
    }
    
    private func showSourceSelector() {
        let sourceSelector = UIAlertController(title: NSLocalizedString("SOURCE_TITLE", comment: "source text"), message: NSLocalizedString("SOURCE_MSG", comment: "source message"), preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
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
            
            if imageSet {
                sourceSelector.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "dismiss") , style: .cancel, handler: nil ))
            }
            
            present(sourceSelector, animated: true)
        } else {
            print("\n\n SIMULATOR MODE \n\n")
            let chosenImage = #imageLiteral(resourceName: "girl4")
            imageSet = true
            profileImage.image = chosenImage
            didCompleteLastStep()
        }
        
    }
    
    
    
    //unused - keep for later
    private func updateDisplayName(_ user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            print(user.email!, user.displayName!)
        }
    }
    
    
    
}
