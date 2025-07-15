import UIKit
import SnapKit

class CheckersWorldSettingViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    
    var heckersWorldvibroLabel: UILabel!
    var heckersWorldsoundLabel: UILabel!
    
    var vibroCheckersWorldOffButton: UIButton!
    var vibroCheckersWorldOnButton: UIButton!
    var soundCheckersWorldOffButton: UIButton!
    var soundCheckersWorldOnButton: UIButton!
    var musicCheckersWorldOffButton: UIButton!
    var musicCheckersWorldOnButton: UIButton!
    
    var CheckersWorldSettingImageView: UIImageView!
    var CheckersWorldTermsButton: UIButton!
    var CheckersWorldPrivacyButton: UIButton!
    var CheckersWorldContactButton: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        setupCheckersWorldUI()
    }
    
    func setupCheckersWorldUI() {
        CheckersWorldMainBackImageView = UIImageView(image: UIImage(named: "CheckersWorldMainBack"))
        CheckersWorldMainBackImageView.contentMode = .scaleAspectFill
        view.addSubview(CheckersWorldMainBackImageView)
        CheckersWorldMainBackImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        CheckersWorldScoreBackImageView = UIImageView(image: UIImage(named: "CheckersWorldScoreBack"))
        CheckersWorldScoreBackImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldScoreBackImageView)
        CheckersWorldScoreBackImageView.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        let CheckersWorldScoreLabel = createCheckersWorldGradientLabel(
            text: "\(CheckersWorldScore)"
        )
        CheckersWorldScoreBackImageView.addSubview(CheckersWorldScoreLabel)
        CheckersWorldScoreLabel.adjustsFontSizeToFitWidth = true
        CheckersWorldScoreLabel.minimumScaleFactor = 0.5
        CheckersWorldScoreLabel.snp.makeConstraints { make in
            make.right.equalTo(CheckersWorldScoreBackImageView.snp.right).offset(-10)
            make.centerY.equalTo(CheckersWorldScoreBackImageView)
            make.width.lessThanOrEqualTo(CheckersWorldScoreBackImageView.snp.width).multipliedBy(0.3)
        }
        
        let CheckersWorldFlowerImageView = UIImageView(image: UIImage(named: "CheckersWorldFlower"))
        CheckersWorldFlowerImageView.contentMode = .scaleAspectFit
        CheckersWorldScoreBackImageView.addSubview(CheckersWorldFlowerImageView)
        CheckersWorldFlowerImageView.snp.makeConstraints { make in
            make.right.equalTo(CheckersWorldScoreLabel.snp.left).offset(-5)
            make.centerY.equalTo(CheckersWorldScoreBackImageView)
            make.width.height.equalTo(30)
        }
        
        let CheckersWorldStarLabel = createCheckersWorldGradientLabel(
            text: "\(CheckersWorldStar)"
        )
        CheckersWorldStarLabel.adjustsFontSizeToFitWidth = true
        CheckersWorldStarLabel.minimumScaleFactor = 0.5
        CheckersWorldScoreBackImageView.addSubview(CheckersWorldStarLabel)
        CheckersWorldStarLabel.snp.makeConstraints { make in
            make.right.equalTo(CheckersWorldFlowerImageView.snp.left).offset(-10)
            make.centerY.equalTo(CheckersWorldScoreBackImageView)
            make.width.lessThanOrEqualTo(CheckersWorldScoreBackImageView.snp.width).multipliedBy(0.3)
        }
        
        let CheckersWorldStarImageView = UIImageView(image: UIImage(named: "CheckersWorldStar"))
        CheckersWorldStarImageView.contentMode = .scaleAspectFit
        CheckersWorldScoreBackImageView.addSubview(CheckersWorldStarImageView)
        CheckersWorldStarImageView.snp.makeConstraints { make in
            make.right.equalTo(CheckersWorldStarLabel.snp.left).offset(-5)
            make.centerY.equalTo(CheckersWorldScoreBackImageView)
            make.width.height.equalTo(30)
        }
        
        let CheckersWorldBackButton = UIButton()
        CheckersWorldBackButton.setImage(UIImage(named: "CheckersWorldBack"), for: .normal)
        CheckersWorldBackButton.addTarget(self, action: #selector(CheckersWorldBackTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldBackButton)
        view.addSubview(CheckersWorldBackButton)
        CheckersWorldBackButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.height.equalTo(50)
        }
        
        CheckersWorldBigLabelBackImageView = UIImageView(image: UIImage(named: "CheckersWorldBigLabelBack"))
        CheckersWorldBigLabelBackImageView.isUserInteractionEnabled = true
        CheckersWorldBigLabelBackImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldBigLabelBackImageView)
        CheckersWorldBigLabelBackImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        CheckersWorldSettingImageView = UIImageView(image: UIImage(named: "CheckersWorldSettings"))
        CheckersWorldSettingImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldSettingImageView)
        CheckersWorldSettingImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(CheckersWorldBigLabelBackImageView.snp.top)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        let CheckersWorldBigWaveImageView = UIImageView(image: UIImage(named: "CheckersWorldBigWave"))
        CheckersWorldBigWaveImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldBigWaveImageView)
        CheckersWorldBigWaveImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        heckersWorldvibroLabel = UILabel()
        heckersWorldvibroLabel.text = "Vibrations"
        heckersWorldvibroLabel.font = UIFont(name: "Joti One", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)
        heckersWorldvibroLabel.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        CheckersWorldBigLabelBackImageView.addSubview(heckersWorldvibroLabel)
        heckersWorldvibroLabel.snp.makeConstraints { make in
            make.bottom.equalTo(CheckersWorldBigWaveImageView.snp.top).offset(-20)
            make.left.equalTo(CheckersWorldBigLabelBackImageView.snp.left).offset(20)
        }
        
        CheckersWorldContactButton = UIButton()
        CheckersWorldContactButton.setImage(UIImage(named: "CheckersWorldContact"), for: .normal)
        CheckersWorldContactButton.addTarget(self, action: #selector(CheckersWorldopenExampleURL), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldContactButton)
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldContactButton)
        CheckersWorldContactButton.snp.makeConstraints { make in
            make.centerY.equalTo(heckersWorldvibroLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }

        let isActive = UserDefaults.standard.bool(forKey: "Vibrations")

        vibroCheckersWorldOffButton = UIButton()
        vibroCheckersWorldOffButton.setImage(UIImage(named: isActive ? "CheckersWorldOff" : "CheckersWorldOffSelect"), for: .normal)
        vibroCheckersWorldOffButton.addTarget(self, action: #selector(CheckersWorldvibroOffTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: vibroCheckersWorldOffButton)
        CheckersWorldBigLabelBackImageView.addSubview(vibroCheckersWorldOffButton)
        vibroCheckersWorldOffButton.snp.makeConstraints { make in
            make.centerY.equalTo(heckersWorldvibroLabel.snp.centerY)
            make.left.equalTo(heckersWorldvibroLabel.snp.right).offset(20)
            make.width.height.equalTo(40)
        }

        vibroCheckersWorldOnButton = UIButton()
        vibroCheckersWorldOnButton.setImage(UIImage(named: isActive ? "CheckersWorldOnSelect" : "CheckersWorldOn"), for: .normal)
        vibroCheckersWorldOnButton.addTarget(self, action: #selector(CheckersWorldvibroOnTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: vibroCheckersWorldOnButton)
        CheckersWorldBigLabelBackImageView.addSubview(vibroCheckersWorldOnButton)
        vibroCheckersWorldOnButton.snp.makeConstraints { make in
            make.centerY.equalTo(heckersWorldvibroLabel.snp.centerY)
            make.left.equalTo(vibroCheckersWorldOffButton.snp.right).offset(10)
            make.width.height.equalTo(40)
        }

        setupSoundSection()
        setupMusicSection()
    }
    
    func setupMusicSection() {
        let musicLabel = UILabel()
        musicLabel.text = "Music"
        musicLabel.font = UIFont(name: "Joti One", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)
        musicLabel.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        CheckersWorldBigLabelBackImageView.addSubview(musicLabel)
        musicLabel.snp.makeConstraints { make in
            make.bottom.equalTo(heckersWorldsoundLabel.snp.top).offset(-20)
            make.left.equalTo(CheckersWorldBigLabelBackImageView.snp.left).offset(20)
        }
        
        CheckersWorldTermsButton = UIButton()
        CheckersWorldTermsButton.setImage(UIImage(named: "CheckersWorldTerms"), for: .normal)
        CheckersWorldTermsButton.addTarget(self, action: #selector(CheckersWorldopenExampeURL), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldTermsButton)
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldTermsButton)
        CheckersWorldTermsButton.snp.makeConstraints { make in
            make.centerY.equalTo(musicLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        let isMusicActive = UserDefaults.standard.bool(forKey: "Music")
        
        musicCheckersWorldOffButton = UIButton()
        musicCheckersWorldOffButton.setImage(UIImage(named: isMusicActive ? "CheckersWorldOff" : "CheckersWorldOffSelect"), for: .normal)
        musicCheckersWorldOffButton.addTarget(self, action: #selector(CheckersWorldmusicOffTapped(_:)), for: .touchUpInside)
        CheckersWorldAddSound(to: musicCheckersWorldOffButton)
        CheckersWorldBigLabelBackImageView.addSubview(musicCheckersWorldOffButton)
        musicCheckersWorldOffButton.snp.makeConstraints { make in
            make.centerY.equalTo(musicLabel.snp.centerY)
            make.left.equalTo(vibroCheckersWorldOffButton.snp.left)
            make.width.height.equalTo(40)
        }
        
        musicCheckersWorldOnButton = UIButton()
        musicCheckersWorldOnButton.setImage(UIImage(named: isMusicActive ? "CheckersWorldOnSelect" : "CheckersWorldOn"), for: .normal)
        musicCheckersWorldOnButton.addTarget(self, action: #selector(CheckersWorldmusicOnTapped(_:)), for: .touchUpInside)
        CheckersWorldAddSound(to: musicCheckersWorldOnButton)
        CheckersWorldBigLabelBackImageView.addSubview(musicCheckersWorldOnButton)
        musicCheckersWorldOnButton.snp.makeConstraints { make in
            make.centerY.equalTo(musicLabel.snp.centerY)
            make.left.equalTo(musicCheckersWorldOffButton.snp.right).offset(10)
            make.width.height.equalTo(40)
        }
        
    }

    func setupSoundSection() {
        heckersWorldsoundLabel = UILabel()
        heckersWorldsoundLabel.text = "Sound"
        heckersWorldsoundLabel.font = UIFont(name: "Joti One", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)
        heckersWorldsoundLabel.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        CheckersWorldBigLabelBackImageView.addSubview(heckersWorldsoundLabel)
        heckersWorldsoundLabel.snp.makeConstraints { make in
            make.bottom.equalTo(heckersWorldvibroLabel.snp.top).offset(-20)
            make.left.equalTo(CheckersWorldBigLabelBackImageView.snp.left).offset(20)
        }
        
        CheckersWorldPrivacyButton = UIButton()
        CheckersWorldPrivacyButton.setImage(UIImage(named: "CheckersWorldPrivacy"), for: .normal)
        CheckersWorldPrivacyButton.addTarget(self, action: #selector(CheckersWorldopenExamplURL), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldPrivacyButton)
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldPrivacyButton)
        CheckersWorldPrivacyButton.snp.makeConstraints { make in
            make.centerY.equalTo(heckersWorldsoundLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        let isSoundActive = UserDefaults.standard.bool(forKey: "Sound")
        
        soundCheckersWorldOffButton = UIButton()
        soundCheckersWorldOffButton.setImage(UIImage(named: isSoundActive ? "CheckersWorldOff" : "CheckersWorldOffSelect"), for: .normal)
        soundCheckersWorldOffButton.addTarget(self, action: #selector(CheckersWorldsoundOffTapped(_:)), for: .touchUpInside)
        CheckersWorldAddSound(to: soundCheckersWorldOffButton)
        CheckersWorldBigLabelBackImageView.addSubview(soundCheckersWorldOffButton)
        soundCheckersWorldOffButton.snp.makeConstraints { make in
            make.centerY.equalTo(heckersWorldsoundLabel.snp.centerY)
            make.left.equalTo(vibroCheckersWorldOffButton.snp.left)
            make.width.height.equalTo(40)
        }
        
        soundCheckersWorldOnButton = UIButton()
        soundCheckersWorldOnButton.setImage(UIImage(named: isSoundActive ? "CheckersWorldOnSelect" : "CheckersWorldOn"), for: .normal)
        soundCheckersWorldOnButton.addTarget(self, action: #selector(CheckersWorldsoundOnTapped(_:)), for: .touchUpInside)
        CheckersWorldAddSound(to: soundCheckersWorldOnButton)
        CheckersWorldBigLabelBackImageView.addSubview(soundCheckersWorldOnButton)
        soundCheckersWorldOnButton.snp.makeConstraints { make in
            make.centerY.equalTo(heckersWorldsoundLabel.snp.centerY)
            make.left.equalTo(soundCheckersWorldOffButton.snp.right).offset(10)
            make.width.height.equalTo(40)
        }
    }

    
    @objc func CheckersWorldBackTapped() {
        let helpViewController = CheckersWorldHomeViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    @objc func CheckersWorldvibroOffTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "Vibrations")
        vibroCheckersWorldOffButton.setImage(UIImage(named: "CheckersWorldOffSelect"), for: .normal)
        vibroCheckersWorldOnButton.setImage(UIImage(named: "CheckersWorldOn"), for: .normal)
    }
    
    @objc func CheckersWorldvibroOnTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "Vibrations")
        vibroCheckersWorldOffButton.setImage(UIImage(named: "CheckersWorldOff"), for: .normal)
        vibroCheckersWorldOnButton.setImage(UIImage(named: "CheckersWorldOnSelect"), for: .normal)
    }
    
    @objc func CheckersWorldmusicOffTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "Music")
        musicCheckersWorldOffButton.setImage(UIImage(named: "CheckersWorldOffSelect"), for: .normal)
        musicCheckersWorldOnButton.setImage(UIImage(named: "CheckersWorldOn"), for: .normal)
        CheckersWorldSound.shared.CheckersWorldPauseBackgroundMusic()
    }

    @objc func CheckersWorldmusicOnTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "Music")
        musicCheckersWorldOffButton.setImage(UIImage(named: "CheckersWorldOff"), for: .normal)
        musicCheckersWorldOnButton.setImage(UIImage(named: "CheckersWorldOnSelect"), for: .normal)
        CheckersWorldSound.shared.CheckersWorldPlayBackgroundMusic()
    }

    @objc func CheckersWorldsoundOffTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "Sound")
        soundCheckersWorldOffButton.setImage(UIImage(named: "CheckersWorldOffSelect"), for: .normal)
        soundCheckersWorldOnButton.setImage(UIImage(named: "CheckersWorldOn"), for: .normal)
    }

    @objc func CheckersWorldsoundOnTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "Sound")
        soundCheckersWorldOffButton.setImage(UIImage(named: "CheckersWorldOff"), for: .normal)
        soundCheckersWorldOnButton.setImage(UIImage(named: "CheckersWorldOnSelect"), for: .normal)
    }
    
    @objc func CheckersWorldopenExampleURL() {
        if let url = URL(string: "https://www.example.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @objc func CheckersWorldopenExamplURL() {
        if let url = URL(string: "https://www.example.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc func CheckersWorldopenExampeURL() {
        if let url = URL(string: "https://www.example.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }


    
    func createCheckersWorldGradientLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont(name: "Joti One", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        return label
    }
}

