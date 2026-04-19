
import UIKit

class loginViewController: UIViewController {

    // --- OUTLETS ---
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var LogoImageView: UIImageView!
    @IBOutlet weak var TituloLabel: UILabel!
    @IBOutlet weak var SubtituloLabel: UILabel!

    // --- UI ---
    let gradientLayer = CAGradientLayer()
    let buttonGradient = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        applyStyles()
        styleLogo()
        styleTitle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.frame = view.bounds
        buttonGradient.frame = loginButton.bounds
        
        // IMPORTANTE: mejora rendimiento y evita sombras raras
        applyShadowPath(loginButton)
        applyShadowPath(googleButton)
        applyShadowPath(appleButton)
    }

    // --- BACKGROUND ---
    func setupBackground() {
        gradientLayer.colors = [
            UIColor(red: 0.10, green: 0.60, blue: 0.70, alpha: 0.4).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // --- MAIN STYLE ---
    func applyStyles() {
        
        styleTextField(emailTextField)
        styleTextField(passwordTextField)
        
        setupTextFieldIcon(emailTextField, iconName: "envelope")
        setupTextFieldIcon(passwordTextField, iconName: "lock")
        addShowPasswordButton()

        styleGradientButton(loginButton)

        styleSocialButton(googleButton, iconName: "descarga", title: "Google")
        styleSocialButton(appleButton, iconName: "apple_logo", title: "Apple Cloud")
    }

    // --- TEXTFIELDS ---
    func styleTextField(_ textField: UITextField) {
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        textField.layer.cornerRadius = 25
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 6
        
        textField.clipsToBounds = false
        textField.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }

    // --- ICONOS ---
    func setupTextFieldIcon(_ textField: UITextField, iconName: String) {
        let iconView = UIImageView()
        iconView.image = UIImage(systemName: iconName)
        iconView.tintColor = .systemTeal
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 55))
        iconView.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        
        container.addSubview(iconView)
        textField.leftView = container
        textField.leftViewMode = .always
    }

    // --- PASSWORD ---
    func addShowPasswordButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        passwordTextField.rightView = button
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
    }

    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let image = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        (passwordTextField.rightView as? UIButton)?
            .setImage(UIImage(systemName: image), for: .normal)
    }

    // --- LOGIN BUTTON ---
    func styleGradientButton(_ button: UIButton) {
        
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = false
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 8)
        button.layer.shadowRadius = 10

        buttonGradient.removeFromSuperlayer()
        buttonGradient.frame = button.bounds
        buttonGradient.cornerRadius = 25
        buttonGradient.colors = [
            UIColor(red: 0.0, green: 0.45, blue: 0.85, alpha: 1).cgColor,
            UIColor(red: 0.10, green: 0.70, blue: 0.70, alpha: 1).cgColor
        ]
        
        button.layer.insertSublayer(buttonGradient, at: 0)
        
        button.setTitle("Iniciar Sesión", for: .normal)
        button.setTitleColor(.white, for: .normal)
    }

    // --- LOGO PERFECTO (FIX REAL) ---
    func styleLogo() {
        LogoImageView.layer.cornerRadius = 25
        LogoImageView.clipsToBounds = true
        
        LogoImageView.layer.shadowColor = UIColor.black.cgColor
        LogoImageView.layer.shadowOpacity = 0.25
        LogoImageView.layer.shadowOffset = CGSize(width: 0, height: 8)
        LogoImageView.layer.shadowRadius = 12
        
        LogoImageView.layer.masksToBounds = false
    }

    // --- TITULO MODERNO ---
    func styleTitle() {
        let text = "ANIMAL PLANET"
        let attr = NSMutableAttributedString(string: text)
        
        attr.addAttributes([
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .kern: 1.2
        ], range: NSRange(location: 0, length: text.count))
        
        TituloLabel.attributedText = attr
        TituloLabel.textColor = UIColor.systemBlue
        TituloLabel.textAlignment = .center
        
        SubtituloLabel.text = "Veterinaria & Pet Shop"
        SubtituloLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        SubtituloLabel.textColor = UIColor.systemTeal
        SubtituloLabel.textAlignment = .center
    }

    // --- SOCIAL BUTTONS ---
    func styleSocialButton(_ button: UIButton, iconName: String, title: String) {
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 6)
        button.layer.shadowRadius = 8
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.setImage(UIImage(named: iconName), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
    }

    // --- MEJORA SOMBRAS ---
    func applyShadowPath(_ view: UIView) {
        view.layer.shadowPath = UIBezierPath(
            roundedRect: view.bounds,
            cornerRadius: view.layer.cornerRadius
        ).cgPath
    }

    // --- ACTIONS ---
    @IBAction func loginTapped(_ sender: UIButton) {
        print("Login tapped")
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        print("Go to register")
    }
}
