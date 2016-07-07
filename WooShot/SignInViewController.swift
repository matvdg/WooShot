import UIKit
import Firebase


class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = wooColor
        self.view.tintColor = wooColor
        self.signInButton.layer.cornerRadius = self.signInButton.bounds.height / 2
        self.signInButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.signInButton.layer.borderWidth = 1.0
        self.signInButton.backgroundColor = wooColor
        self.signInButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.emailField.layer.position.x -= self.view.bounds.width
        self.passwordField.layer.position.x -= self.view.bounds.width
        self.signInButton.alpha = 0
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
        UIView.animateWithDuration(1, delay: 0.00, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.emailField.layer.position.x += self.view.bounds.width
            self.passwordField.layer.position.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.30, options: .CurveEaseOut, animations: { self.signInButton.alpha = 1 }, completion: nil)
        

    }
   
    @IBAction func didTapSignIn(sender: UIButton) {
        // Sign In with credentials.
        let email = emailField.text
        let password = passwordField.text
        FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }
    }
    
    @IBAction func didTapSignUp(sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.setDisplayName(user!)
        }
    }
    
    @IBAction func didRequestPasswordReset(sender: UIButton) {
        let prompt = UIAlertController.init(title: NSLocalizedString("RESET_PWD_TITLE", comment: "reset password title"), message: NSLocalizedString("RESET_PWD_MSG", comment: "reset password message"), preferredStyle: UIAlertControllerStyle.Alert)
        prompt.view.tintColor = wooColor
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordResetWithEmail(userInput!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        prompt.addTextFieldWithConfigurationHandler(nil)
        prompt.addAction(okAction)
        presentViewController(prompt, animated: true, completion: nil);
    }
    
    @IBAction func didTapFacebookSignIn(sender: UIButton) {
    }
    
    func setDisplayName(user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.componentsSeparatedByString("@")[0]
        changeRequest.commitChangesWithCompletion(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
    
    func signedIn(user: FIRUser?) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
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
