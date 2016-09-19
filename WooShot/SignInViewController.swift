import UIKit
import Firebase

class SignInViewController: WooShotViewController, UITextFieldDelegate {
    
    @IBOutlet weak var elements: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var resetPwdButton: UIButton!
    @IBOutlet weak var activitySpin: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elements.layer.zPosition = 1
        self.view.tintColor = Color.wooColor
        self.view.backgroundColor = Color.wooColor
        self.signInButton.isHidden = true
        self.emailField.isHidden = true
        self.passwordField.isHidden = true
        self.title = NSLocalizedString("LOGIN", comment: "logging in navbar title")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.designAndAnimateButtons()
    }
    
    private func designAndAnimateButtons() {
        let login = self.signInButton!
        login.titleLabel?.adjustsFontSizeToFitWidth = true
        login.layer.borderWidth = 1
        login.layer.borderColor = UIColor.white.cgColor
        login.layer.cornerRadius = login.bounds.height/2
        login.backgroundColor = UIColor.clear
        login.setTitleColor(UIColor.white, for: .normal)
        self.emailField.layer.position.x -= self.view.bounds.width
        self.passwordField.layer.position.x -= self.view.bounds.width
        self.signInButton.alpha = 0
        self.signInButton.isHidden = false
        self.emailField.isHidden = false
        self.passwordField.isHidden = false
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
        //animations
        UIView.animate(withDuration: 1, delay: 0.00, options: UIViewAnimationOptions(), animations: {
            self.emailField.layer.position.x += self.view.bounds.width
            self.passwordField.layer.position.x += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 1.5, delay: 0.30, options: .curveEaseOut, animations: { self.signInButton.alpha = 1 }, completion: nil)
    }
   
    @IBAction func didTapSignIn(_ sender: UIButton) {
        self.activitySpin.startAnimating()
        // Sign In with credentials.
        let email = emailField.text!
        let password = passwordField.text!
        if email.isEmpty || password.isEmpty {
            // create alert controller
            let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: NSLocalizedString("EMPTY", comment: "empty field"), preferredStyle: UIAlertControllerStyle.alert)
            myAlert.view.tintColor = Color.wooColor
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(myAlert, animated: true, completion: nil)
            self.activitySpin.stopAnimating()

        } else {
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    // create alert controller
                    let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    myAlert.view.tintColor = Color.wooColor
                    // add "OK" button
                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    // show the alert
                    self.present(myAlert, animated: true, completion: nil)
                    self.activitySpin.stopAnimating()
                    return
                }
                self.signedIn(user!)
            }
        }
    }
    
    @IBAction func didRequestPasswordReset(_ sender: UIButton) {
        let prompt = UIAlertController.init(title: NSLocalizedString("RESET_PWD_TITLE", comment: "reset password title"), message: NSLocalizedString("RESET_PWD_MSG", comment: "reset password message"), preferredStyle: UIAlertControllerStyle.alert)
        prompt.view.tintColor = Color.wooColor
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                // create alert controller
                let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: NSLocalizedString("EMPTY", comment: "empty field"), preferredStyle: UIAlertControllerStyle.alert)
                myAlert.view.tintColor = Color.wooColor
                // add "OK" button
                myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(myAlert, animated: true, completion: nil)
                return
            }
            FIRAuth.auth()?.sendPasswordReset(withEmail: userInput!) { (error) in
                if let error = error {
                    // create alert controller
                    let myAlert = UIAlertController(title: NSLocalizedString("ERROR", comment: "error"), message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    myAlert.view.tintColor = Color.wooColor
                    // add "OK" button
                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    // show the alert
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else {
                    // create alert controller
                    let myAlert = UIAlertController(title: NSLocalizedString("RESET_PWD_SENT_TITLE", comment: "reset done title"), message: NSLocalizedString("RESET_PWD_SENT_MSG", comment: "reset done message"), preferredStyle: UIAlertControllerStyle.alert)
                    myAlert.view.tintColor = Color.wooColor
                    // add "OK" button
                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    // show the alert
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }
            }
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }
    
    func setDisplayName(_ user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
    
    func signedIn(_ user: FIRUser?) {
        self.activitySpin.stopAnimating()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1
        // Try to find next responder
        let nextResponder: UIResponder? = textField.superview?.viewWithTag(nextTag)
        
        if ((nextResponder) != nil) {
            // Found next responder, so set it.
            nextResponder!.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false
        // We do not want UITextField to insert line-breaks.
    }
    
}
