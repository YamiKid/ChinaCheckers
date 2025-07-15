import UIKit
import SnapKit

class CheckersWorldHomeViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldManBackImageView: UIImageView!
    var CheckersWorldManImageView: UIImageView!
    var CheckersWorldSettingButton: UIButton!
    var CheckersWorldChampionshipButton: UIButton!
    var CheckersWorldStackView: UIStackView!
    var CheckersWorldHowToPlayImageView: UIImageView!
    var CheckersWorldTacticsImageView: UIImageView!
    var CheckersWorldStatisticImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    
    var CheckersWorld1v1ImageView: UIImageView!
    var CheckersWorldBonusImageView: UIImageView!
    
    var CheckersWorldReadButton1: UIButton!
    var CheckersWorldReadButton2: UIButton!
    var CheckersWorldReadButton3: UIButton!
    var CheckersWorldPlayButton1: UIButton!
    var CheckersWorldClaimButton1: UIButton!
    
    var CheckersWorldPlayButton: UIButton!
    var CheckersWorldShopButton: UIButton!
    var CheckersWorldScoreLabel: UILabel!
    
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
    
    var CheckersWorldTotalEarnings: Int {
        get { UserDefaults.standard.integer(forKey: "CheckersWorldTotalEarnings") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckersWorldTotalEarnings")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        setupCheckersWorldUI()
        if CheckersWorldScore < 150 {
            CheckersWorldScore += 10000
            CheckersWorldTotalEarnings += 10000
            CheckersWorldScoreLabel.text = "\(CheckersWorldScore)"
        }
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
        
        CheckersWorldManImageView = UIImageView(image: UIImage(named: "CheckersWorldMan"))
        CheckersWorldManImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldManImageView)
        CheckersWorldManImageView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(350)
        }
        
        CheckersWorldSettingButton = UIButton()
        CheckersWorldSettingButton.setImage(UIImage(named: "CheckersWorldSetting"), for: .normal)
        CheckersWorldSettingButton.addTarget(self, action: #selector(CheckersWorldSettingTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldSettingButton)
        view.addSubview(CheckersWorldSettingButton)
        CheckersWorldSettingButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.height.equalTo(50)
        }
        
        CheckersWorldScoreBackImageView = UIImageView(image: UIImage(named: "CheckersWorldScoreBack"))
        CheckersWorldScoreBackImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldScoreBackImageView)
        CheckersWorldScoreBackImageView.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.centerY.equalTo(CheckersWorldSettingButton.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        CheckersWorldChampionshipButton = UIButton()
        CheckersWorldChampionshipButton.setImage(UIImage(named: "CheckersWorldChampionship"), for: .normal)
        CheckersWorldChampionshipButton.addTarget(self, action: #selector(CheckersWorldChampionshipTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldChampionshipButton)
        view.addSubview(CheckersWorldChampionshipButton)
        CheckersWorldChampionshipButton.snp.makeConstraints { make in
            make.centerY.equalTo(CheckersWorldSettingButton)
            make.leading.equalTo(CheckersWorldSettingButton.snp.trailing).offset(20)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        CheckersWorldHowToPlayImageView = UIImageView(image: UIImage(named: "CheckersWorldHowToPlay"))
        CheckersWorldHowToPlayImageView.contentMode = .scaleToFill
        
        CheckersWorldTacticsImageView = UIImageView(image: UIImage(named: "CheckersWorldTactic"))
        CheckersWorldTacticsImageView.contentMode = .scaleToFill
        
        CheckersWorldStatisticImageView = UIImageView(image: UIImage(named: "CheckersWorldStatistic"))
        CheckersWorldStatisticImageView.contentMode = .scaleToFill
        
        CheckersWorldStackView = UIStackView(arrangedSubviews: [
            CheckersWorldHowToPlayImageView,
            CheckersWorldTacticsImageView,
            CheckersWorldStatisticImageView
        ])
        CheckersWorldStackView.axis = .horizontal
        CheckersWorldStackView.distribution = .fillEqually
        CheckersWorldStackView.alignment = .center
        CheckersWorldStackView.spacing = 3
        view.addSubview(CheckersWorldStackView)
        
        CheckersWorldStackView.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalTo(CheckersWorldManImageView.snp.trailing).offset(5)
            make.height.equalTo(80)
        }
        
        CheckersWorldReadButton1 = UIButton()
        CheckersWorldReadButton1.setImage(UIImage(named: "CheckersWorldRead"), for: .normal)
        CheckersWorldReadButton1.addTarget(self, action: #selector(CheckersWorldRead1Tapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldReadButton1)
        view.addSubview(CheckersWorldReadButton1)
        CheckersWorldReadButton1.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldHowToPlayImageView.snp.bottom).offset(5)
            make.centerX.equalTo(CheckersWorldHowToPlayImageView.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        CheckersWorldReadButton2 = UIButton()
        CheckersWorldReadButton2.setImage(UIImage(named: "CheckersWorldRead"), for: .normal)
        CheckersWorldReadButton2.addTarget(self, action: #selector(CheckersWorldRead2Tapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldReadButton2)
        view.addSubview(CheckersWorldReadButton2)
        CheckersWorldReadButton2.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldTacticsImageView.snp.bottom).offset(5)
            make.centerX.equalTo(CheckersWorldTacticsImageView.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        CheckersWorldReadButton3 = UIButton()
        CheckersWorldReadButton3.setImage(UIImage(named: "CheckersWorldRead"), for: .normal)
        CheckersWorldReadButton3.addTarget(self, action: #selector(CheckersWorldRead3Tapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldReadButton3)
        view.addSubview(CheckersWorldReadButton3)
        CheckersWorldReadButton3.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldStatisticImageView.snp.bottom).offset(5)
            make.centerX.equalTo(CheckersWorldStatisticImageView.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        CheckersWorld1v1ImageView = UIImageView(image: UIImage(named: "CheckersWorld1vs1"))
        CheckersWorld1v1ImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorld1v1ImageView)
        CheckersWorld1v1ImageView.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldSettingButton.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.equalTo(CheckersWorldHowToPlayImageView.snp.width)
            make.height.equalTo(80)
        }
        
        CheckersWorldPlayButton1 = UIButton()
        CheckersWorldPlayButton1.setImage(UIImage(named: "CheckersWorldPlay"), for: .normal)
        CheckersWorldPlayButton1.addTarget(self, action: #selector(CheckersWorldPlay1Tapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldPlayButton1)
        view.addSubview(CheckersWorldPlayButton1)
        CheckersWorldPlayButton1.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorld1v1ImageView.snp.bottom).offset(5)
            make.centerX.equalTo(CheckersWorld1v1ImageView.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        CheckersWorldBonusImageView = UIImageView(image: UIImage(named: "CheckersWorldBonus"))
        CheckersWorldBonusImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldBonusImageView)
        CheckersWorldBonusImageView.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldScoreBackImageView.snp.bottom).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.equalTo(CheckersWorldHowToPlayImageView.snp.width)
            make.height.equalTo(80)
        }
        CheckersWorldClaimButton1 = UIButton()
        CheckersWorldClaimButton1.setImage(UIImage(named: "CheckersWorldClaim"), for: .normal)
        CheckersWorldClaimButton1.addTarget(self, action: #selector(CheckersWorldClaimTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldClaimButton1)
        view.addSubview(CheckersWorldClaimButton1)
        CheckersWorldClaimButton1.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldBonusImageView.snp.bottom).offset(5)
            make.centerX.equalTo(CheckersWorldBonusImageView.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        CheckersWorldPlayButton = UIButton()
        CheckersWorldPlayButton.setImage(UIImage(named: "CheckersWorldBigPlay"), for: .normal)
        CheckersWorldPlayButton.addTarget(self, action: #selector(CheckersWorldPlayTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldPlayButton)
        view.addSubview(CheckersWorldPlayButton)
        CheckersWorldPlayButton.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldBonusImageView.snp.top)
            make.right.equalTo(CheckersWorldBonusImageView.snp.left).offset(-3)
            make.left.equalTo(CheckersWorldHowToPlayImageView.snp.left)
            make.height.equalTo(60)
        }
        
        CheckersWorldShopButton = UIButton()
        CheckersWorldShopButton.setImage(UIImage(named: "CheckersWorldShop"), for: .normal)
        CheckersWorldShopButton.addTarget(self, action: #selector(CheckersWorldShopTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldShopButton)
        view.addSubview(CheckersWorldShopButton)
        CheckersWorldShopButton.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldPlayButton.snp.bottom).offset(10)
            make.right.equalTo(CheckersWorldBonusImageView.snp.left).offset(-3)
            make.left.equalTo(CheckersWorldHowToPlayImageView.snp.left)
            make.height.equalTo(60)
        }


        CheckersWorldScoreLabel = createCheckersWorldGradientLabel(
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
    }
    
    @objc func CheckersWorldSettingTapped() {
        let helpViewController = CheckersWorldSettingViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    @objc func CheckersWorldChampionshipTapped() {
        let helpViewController = CheckersWorldChampionshipViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    @objc func CheckersWorldPlay1Tapped() {
        let helpViewController = CheckersWorldVSViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    @objc func CheckersWorldRead1Tapped() {
        let helpViewController = CheckersWorldHowToPlayViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    @objc func CheckersWorldRead2Tapped() {
        let helpViewController = CheckersWorldTacticsViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    @objc func CheckersWorldRead3Tapped() {
        let helpViewController = CheckersWorldStatisticViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    @objc func CheckersWorldPlayTapped() {
        let helpViewController = CheckersWorldDifficultyGameViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    @objc func CheckersWorldClaimTapped() {
        let currentDate = Date()
        let userDefaultsKey = "CheckersWorldLastClaimDate"
        
        if let lastClaimDate = UserDefaults.standard.object(forKey: userDefaultsKey) as? Date {
            let oneDayInSeconds: TimeInterval = 24 * 60 * 60
            let timeSinceLastClaim = currentDate.timeIntervalSince(lastClaimDate)
            
            if timeSinceLastClaim >= oneDayInSeconds {
                let helpViewController = CheckersWorldBonusViewController()
                self.navigationController?.setViewControllers([helpViewController], animated: true)
                UserDefaults.standard.set(currentDate, forKey: userDefaultsKey)
            } else {
                let remainingTime = oneDayInSeconds - timeSinceLastClaim
                let hoursRemaining = Int(remainingTime / 3600)
                let minutesRemaining = Int((remainingTime.truncatingRemainder(dividingBy: 3600)) / 60)
                let alertMessage = "You need to wait \(hoursRemaining) hours and \(minutesRemaining) minutes before claiming again."
                showAlert(message: alertMessage)
            }
        } else {
            let helpViewController = CheckersWorldBonusViewController()
            self.navigationController?.setViewControllers([helpViewController], animated: true)
            UserDefaults.standard.set(currentDate, forKey: userDefaultsKey)
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Please Wait", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    @objc func CheckersWorldShopTapped() {
        let helpViewController = CheckersWorldShopViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    func createCheckersWorldGradientLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Joti One", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        return label
    }

}

