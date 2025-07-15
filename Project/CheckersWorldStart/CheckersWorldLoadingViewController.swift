import UIKit
import SnapKit

class CheckersWorldLoadingViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldCircleImageView: UIImageView!
    var CheckersWorldManBackImageView: UIImageView!
    var CheckersWorldManImageView: UIImageView!
    
    var CheckersWorldScore: Int {
        get { UserDefaults.standard.integer(forKey: "CheckersWorldScore") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckersWorldScore")
        }
    }

    var CheckersWorldStar: Int {
        get { UserDefaults.standard.integer(forKey: "CheckersWorldStar") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckersWorldStar")
        }
    }
    
    var CheckersWorldGamesPlayed: Int {
        get { UserDefaults.standard.integer(forKey: "CheckersWorldGamesPlayed") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckersWorldGamesPlayed")
        }
    }

    var CheckersWorldVictories: Int {
        get { UserDefaults.standard.integer(forKey: "CheckersWorldVictories") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckersWorldVictories")
        }
    }

    var CheckersWorldTotalEarnings: Int {
        get { UserDefaults.standard.integer(forKey: "CheckersWorldTotalEarnings") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckersWorldTotalEarnings")
        }
    }

    var CheckersWorldDaysSinceRegistration: Int {
        get { UserDefaults.standard.integer(forKey: "CheckersWorldDaysSinceRegistration") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckersWorldDaysSinceRegistration")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        setupCheckersWorldUI()
        animateCheckersWorldMan()
        navigateToCheckersWorldHelpViewController()
    }
    
    func setupCheckersWorldUI() {
        CheckersWorldMainBackImageView = UIImageView(image: UIImage(named: "CheckersWorldMainBack"))
        CheckersWorldMainBackImageView.contentMode = .scaleAspectFill
        view.addSubview(CheckersWorldMainBackImageView)
        CheckersWorldMainBackImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        CheckersWorldManImageView = UIImageView(image: UIImage(named: "CheckersWorldManBack"))
        CheckersWorldManImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldManImageView)
        CheckersWorldManImageView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalToSuperview()
            make.width.equalTo(350)
        }
        
        CheckersWorldManImageView = UIImageView(image: UIImage(named: "CheckersWorldMan"))
        CheckersWorldManImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldManImageView)
        CheckersWorldManImageView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(350)
        }
        
        CheckersWorldCircleImageView = UIImageView(image: UIImage(named: "CheckersWorldCircle"))
        CheckersWorldCircleImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldCircleImageView)
        CheckersWorldCircleImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-50)
            make.width.height.equalTo(175)
        }
    }
    
    func animateCheckersWorldMan() {
        let swingAnimation = CABasicAnimation(keyPath: "transform.rotation")
        swingAnimation.fromValue = -Double.pi / 8
        swingAnimation.toValue = Double.pi / 8
        swingAnimation.duration = 0.6
        swingAnimation.autoreverses = true
        swingAnimation.repeatCount = .infinity
        CheckersWorldManImageView.layer.add(swingAnimation, forKey: "swingAnimation")
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 2
        rotationAnimation.repeatCount = .infinity
        CheckersWorldCircleImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }

    func navigateToCheckersWorldHelpViewController() {
        let hasVisited = UserDefaults.standard.bool(forKey: "CheckersWorldHasVisited")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if hasVisited {
                let homeViewController = CheckersWorldHomeViewController()
                self.navigationController?.setViewControllers([homeViewController], animated: true)
            } else {
                UserDefaults.standard.set(true, forKey: "CheckersWorldHasVisited")
                UserDefaults.standard.set(true, forKey: "Music")
                UserDefaults.standard.set(true, forKey: "Sound")
                UserDefaults.standard.set(true, forKey: "Vibrations")
                self.CheckersWorldScore = 10000
                self.CheckersWorldStar = 40
                self.CheckersWorldGamesPlayed = 0
                self.CheckersWorldVictories = 0
                self.CheckersWorldTotalEarnings = 10000
                self.CheckersWorldDaysSinceRegistration = 1
                let helpViewController = CheckersWorldHelpViewController()
                self.navigationController?.setViewControllers([helpViewController], animated: true)
            }
        }
    }
}
