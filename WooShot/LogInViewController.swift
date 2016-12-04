import UIKit
import Firebase

class LogInViewController: WooShotViewController, UITextFieldDelegate {
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var elements: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var resetPwdButton: UIButton!
    @IBOutlet weak var activitySpin: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elements.layer.zPosition = 1
        view.tintColor = UIColor.white
        signInButton.isHidden = true
        emailField.isHidden = true
        separator.isHidden = true
        resetPwdButton.isHidden = true
        passwordField!.isHidden = true
        title = NSLocalizedString("LOGIN", comment: "logging in navbar title")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        designAndAnimateButtons()
        emailField.becomeFirstResponder()
        if let user = FIRAuth.auth()?.currentUser {
            signedIn(user)
        }
    }
    
    private func designAndAnimateButtons() {
        let whitePlaceholder = UIColor(white: 1, alpha: 0.54)
        let login = signInButton!
        let email = emailField!
        let password = passwordField!
        let separator = self.separator!
        let reset = self.resetPwdButton!
        login.backgroundColor = UIColor.white
        login.setTitleColor(UIColor.wooColor, for: .normal)
        email.layer.position.x -= view.bounds.width
        password.layer.position.x -= view.bounds.width
        separator.layer.position.x -= view.bounds.width
        login.alpha = 0
        reset.alpha = 0
        separator.isHidden = false
        login.isHidden = false
        email.isHidden = false
        password.isHidden = false
        reset.isHidden = false
        email.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_EMAIL", comment: "email"),attributes:[NSForegroundColorAttributeName: whitePlaceholder])
        email.textColor = UIColor.white
        password.textColor = UIColor.white
        password.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("PLACEHOLDER_PWD", comment: "password"),attributes:[NSForegroundColorAttributeName: whitePlaceholder])
        
        //animations
        UIView.animate(withDuration: 0.25) {
            email.layer.position.x += self.view.bounds.width
            password.layer.position.x += self.view.bounds.width
            separator.layer.position.x += self.view.bounds.width
            login.alpha = 1
            reset.alpha = 1
        }
    }
   
    @IBAction func didTapSignIn(_ sender: UIButton) {
        performSegue(withIdentifier: "launchApp", sender: self)
        activitySpin.startAnimating()
        // Sign In with credentials.
        let email = emailField.text!
        let password = passwordField.text!
        if email.isEmpty || password.isEmpty {
            self.presentErrorAlertViewController(message: NSLocalizedString("EMPTY", comment: "empty field"))
            activitySpin.stopAnimating()

        } else {
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.presentErrorAlertViewController(message: error.localizedDescription)
                    self.activitySpin.stopAnimating()
                    return
                }
                self.signedIn(user!)
            }
        }
    }
    
    @IBAction func didRequestPasswordReset(_ sender: UIButton) {
        let prompt = UIAlertController.init(title: NSLocalizedString("RESET_PWD_TITLE", comment: "reset password title"), message: NSLocalizedString("RESET_PWD_MSG", comment: "reset password message"), preferredStyle: UIAlertControllerStyle.alert)
        prompt.view.tintColor = UIColor.wooColor
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                self.presentErrorAlertViewController(message: NSLocalizedString("EMPTY", comment: "empty field"))
                return
            }
            FIRAuth.auth()?.sendPasswordReset(withEmail: userInput!) { (error) in
                if let error = error {
                    self.presentErrorAlertViewController(message: error.localizedDescription)
                    return
                } else {
                    self.presentAlertViewController(title: NSLocalizedString("RESET_PWD_SENT_TITLE", comment: "reset done title"), message: NSLocalizedString("RESET_PWD_SENT_MSG", comment: "reset done message"))
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
        activitySpin.stopAnimating()
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
