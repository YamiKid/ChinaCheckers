import UIKit
import SnapKit

class CheckersWorldHelpViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldManImageView: UIImageView!
    var CheckersWorldLabelBackImageView: UIImageView!
    var CheckersWorldTitleLabel: UILabel!
    var CheckersWorldSubtitleLabel: UILabel!
    var CheckersWorldNextButton: UIButton!
    var CheckersWorldManBackImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        setupCheckersWorldUI()
        updateCheckersWorldText()
        CheckersWorldSound.shared.CheckersWorldPlayBackgroundMusic()
        if !UserDefaults.standard.bool(forKey: "Music") {
            CheckersWorldSound.shared.CheckersWorldPauseBackgroundMusic()
        }
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
        
        CheckersWorldLabelBackImageView = UIImageView(image: UIImage(named: "CheckersWorldLabelBack"))
        CheckersWorldLabelBackImageView.contentMode = .scaleToFill
        CheckersWorldLabelBackImageView.isUserInteractionEnabled = true
        view.addSubview(CheckersWorldLabelBackImageView)
        CheckersWorldLabelBackImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.equalTo(350)
            make.height.equalTo(250)
        }
        
        CheckersWorldManImageView = UIImageView(image: UIImage(named: "CheckersWorldMan"))
        CheckersWorldManImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldManImageView)
        CheckersWorldManImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.height.equalTo(350)
        }

        
        CheckersWorldTitleLabel = UILabel()
        CheckersWorldTitleLabel.text = "Welcome to the world of checkers!"
        CheckersWorldTitleLabel.font = UIFont(name: "Joti One", size: 24) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        CheckersWorldTitleLabel.textAlignment = .left
        CheckersWorldTitleLabel.textColor = .white
        CheckersWorldTitleLabel.numberOfLines = 0
        CheckersWorldLabelBackImageView.addSubview(CheckersWorldTitleLabel)
        CheckersWorldTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldLabelBackImageView.snp.top).offset(20)
            make.centerX.equalTo(CheckersWorldLabelBackImageView)
            make.left.equalTo(CheckersWorldLabelBackImageView).offset(20)
            make.right.equalTo(CheckersWorldLabelBackImageView).offset(-20)
        }
        
        CheckersWorldSubtitleLabel = UILabel()
        CheckersWorldSubtitleLabel.text = "Play with friends or join championships to show off your skills"
        CheckersWorldSubtitleLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16)
        CheckersWorldSubtitleLabel.textColor = .white
        CheckersWorldSubtitleLabel.textAlignment = .left
        CheckersWorldSubtitleLabel.numberOfLines = 0
        CheckersWorldLabelBackImageView.addSubview(CheckersWorldSubtitleLabel)
        CheckersWorldSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldTitleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(CheckersWorldLabelBackImageView)
            make.left.equalTo(CheckersWorldLabelBackImageView).offset(20)
            make.right.equalTo(CheckersWorldLabelBackImageView).offset(-20)
        }
        
        CheckersWorldNextButton = UIButton()
        CheckersWorldNextButton.setImage(UIImage(named: "CheckersWorldNext"), for: .normal)
        CheckersWorldNextButton.addTarget(self, action: #selector(CheckersWorldNextButtonTapped), for: .touchUpInside)
        CheckersWorldLabelBackImageView.addSubview(CheckersWorldNextButton)
        CheckersWorldNextButton.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldSubtitleLabel.snp.bottom).offset(20)
            make.left.equalTo(CheckersWorldLabelBackImageView).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    var CheckersWorldCurrentIndex: Int = 0
    
    let CheckersWorldTitles = [
        "Welcome to the world of checkers!",
        "Play with friends online",
        "Take part in championships!",
        "Welcome to the world of checkers!",
        "Find out more about the game!"
    ]
    
    let CheckersWorldSubtitles = [
        "Play with friends or join championships to show off your skills",
        "Create a game or join an existing one. Compete with your friends in real time!",
        "Compete with the best players and climb the ranks to earn unique rewards.",
        "Earn coins in the form of a cherry blossom!",
        "Read interesting facts and strategies to become a checkers master and surprise your opponents!"
    ]
    
    func updateCheckersWorldText() {
        if CheckersWorldCurrentIndex <= 4 {
            CheckersWorldTitleLabel.text = CheckersWorldTitles[CheckersWorldCurrentIndex]
            CheckersWorldSubtitleLabel.text = CheckersWorldSubtitles[CheckersWorldCurrentIndex]
        }
    }
    
    @objc func CheckersWorldNextButtonTapped() {
        CheckersWorldCurrentIndex += 1
        if CheckersWorldCurrentIndex < CheckersWorldTitles.count {
            animateCheckersWorldTextChange()
        } else {
            navigateToCheckersWorldNextController()
        }
    }
    
    func animateCheckersWorldTextChange() {
        UIView.animate(withDuration: 0.3, animations: {
            self.CheckersWorldTitleLabel.alpha = 0
            self.CheckersWorldSubtitleLabel.alpha = 0
        }) { _ in
            self.updateCheckersWorldText()
            UIView.animate(withDuration: 0.3) {
                self.CheckersWorldTitleLabel.alpha = 1
                self.CheckersWorldSubtitleLabel.alpha = 1
            }
        }
    }
    
    func navigateToCheckersWorldNextController() {
        let helpViewController = CheckersWorldHomeViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
}
