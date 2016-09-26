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
        self.view.tintColor = UIColor.white
        self.signInButton.isHidden = true
        self.emailField.isHidden = true
        self.passwordField!.isHidden = true
        self.title = NSLocalizedString("LOGIN", comment: "logging in navbar title")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.designAndAnimateButtons()
        self.emailField.becomeFirstResponder()
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
    }
    
    private func designAndAnimateButtons() {
        let whitePlaceholder = UIColor(white: 1, alpha: 0.54)
        let login = self.signInButton!
        let email = self.emailField!
        let password = self.passwordField!
        login.titleLabel?.adjustsFontSizeToFitWidth = true
        login.layer.cornerRadius = login.bounds.height/2
        login.backgroundColor = UIColor.white
        login.setTitleColor(Color.wooColor, for: .normal)
        email.layer.position.x -= self.view.bounds.width
        password.layer.position.x -= self.view.bounds.width
        self.signInButton.alpha = 0
        self.signInButton.isHidden = false
        email.isHidden = false
        email.layer.cornerRadius = 5
        password.layer.cornerRadius = 5
        password.isHidden = false
        email.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_EMAIL", comment: "email"),attributes:[NSForegroundColorAttributeName: whitePlaceholder])
        email.textColor = UIColor.white
        password.textColor = UIColor.white
        password.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_PWD", comment: "password"),attributes:[NSForegroundColorAttributeName: whitePlaceholder])
        
        //animations
        UIView.animate(withDuration: 0.5, delay: 0.00, options: UIViewAnimationOptions(), animations: {
            email.layer.position.x += self.view.bounds.width
            password.layer.position.x += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.30, options: .curveEaseOut, animations: { login.alpha = 1 }, completion: nil)
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
