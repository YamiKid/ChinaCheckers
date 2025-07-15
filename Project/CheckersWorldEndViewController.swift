import UIKit
import SnapKit

class CheckersWorldEndViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldChestImageView: UIImageView!
    var CheckersWorldStarLabel: UILabel!
    var CheckersWorldFlowerLabel: UILabel!
    var CheckersWorldRewardButton: UIButton!
    var gameResult: String = ""
    
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
        updateUIBasedOnResult()
    }
    
    func setupCheckersWorldUI() {
        CheckersWorldMainBackImageView = UIImageView(image: UIImage(named: "CheckersWorldBonusBack"))
        CheckersWorldMainBackImageView.contentMode = .scaleAspectFill
        view.addSubview(CheckersWorldMainBackImageView)
        CheckersWorldMainBackImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        CheckersWorldScoreBackImageView = UIImageView(image: UIImage(named: "CheckersWorldScoreBack"))
        CheckersWorldScoreBackImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldScoreBackImageView)
        CheckersWorldScoreBackImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(300)
        }
        
        let CheckersWorldScoreStackView = UIStackView()
        CheckersWorldScoreStackView.axis = .horizontal
        CheckersWorldScoreStackView.alignment = .center
        CheckersWorldScoreStackView.spacing = 10
        CheckersWorldScoreStackView.distribution = .equalSpacing
        CheckersWorldScoreBackImageView.addSubview(CheckersWorldScoreStackView)

        CheckersWorldScoreStackView.snp.makeConstraints { make in
            make.center.equalTo(CheckersWorldScoreBackImageView.snp.center)
            make.width.lessThanOrEqualTo(CheckersWorldScoreBackImageView.snp.width).multipliedBy(0.9)
            make.height.equalTo(CheckersWorldScoreBackImageView.snp.height)
        }

        let CheckersWorldStarImageView = UIImageView(image: UIImage(named: "CheckersWorldStar"))
        CheckersWorldStarImageView.contentMode = .scaleAspectFit
        CheckersWorldStarImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        CheckersWorldScoreStackView.addArrangedSubview(CheckersWorldStarImageView)

        CheckersWorldStarLabel = createCheckersWorldGradientLabel(
            text: "\(CheckersWorldStar)"
        )
        CheckersWorldStarLabel.adjustsFontSizeToFitWidth = true
        CheckersWorldStarLabel.minimumScaleFactor = 0.5
        CheckersWorldScoreStackView.addArrangedSubview(CheckersWorldStarLabel)

        let CheckersWorldFlowerImageView = UIImageView(image: UIImage(named: "CheckersWorldFlower"))
        CheckersWorldFlowerImageView.contentMode = .scaleAspectFit
        CheckersWorldFlowerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        CheckersWorldScoreStackView.addArrangedSubview(CheckersWorldFlowerImageView)

        CheckersWorldFlowerLabel = createCheckersWorldGradientLabel(
            text: "\(CheckersWorldScore)"
        )
        CheckersWorldFlowerLabel.adjustsFontSizeToFitWidth = true
        CheckersWorldFlowerLabel.minimumScaleFactor = 0.5
        CheckersWorldScoreStackView.addArrangedSubview(CheckersWorldFlowerLabel)

        
        
        CheckersWorldChestImageView = UIImageView()
        CheckersWorldChestImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldChestImageView)
        CheckersWorldChestImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-200)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        CheckersWorldRewardButton = UIButton()
        CheckersWorldRewardButton.addTarget(self, action: #selector(handleCheckersWorldRewardButtonTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldRewardButton)
        view.addSubview(CheckersWorldRewardButton)
        CheckersWorldRewardButton.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldScoreBackImageView.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    
    func updateUIBasedOnResult() {
        switch gameResult {
        case "win":
            CheckersWorldChestImageView.image = UIImage(named: "CheckersWorldWin")
            CheckersWorldRewardButton.setImage(UIImage(named: "CheckersWorldClaimReward"), for: .normal)
            CheckersWorldScore += 10000
            CheckersWorldStar += 3
            CheckersWorldVictories += 1
            CheckersWorldTotalEarnings += 10000
            CheckersWorldFlowerLabel?.text = "\(10000)"
            CheckersWorldStarLabel?.text = "\(3)"
            CheckersWorldPlayWinSound()
            addGreenWaves()
        case "lose":
            CheckersWorldChestImageView.image = UIImage(named: "CheckersWorldLose")
            CheckersWorldRewardButton.setImage(UIImage(named: "CheckersWorldPlayAgain"), for: .normal)
            CheckersWorldFlowerLabel?.text = "\(0)"
            CheckersWorldStarLabel?.text = "\(0)"
            CheckersWorldPlayLoseSound()
        case "draw":
            CheckersWorldChestImageView.image = UIImage(named: "CheckersWorldDraw")
            CheckersWorldRewardButton.setImage(UIImage(named: "CheckersWorldPlayAgain"), for: .normal)
            CheckersWorldFlowerLabel?.text = "\(0)"
            CheckersWorldStarLabel?.text = "\(0)"
            CheckersWorldPlayLoseSound()
        default:
            break
        }
        

    }
    
    func addGreenWaves() {
        let topWave = UIImageView(image: UIImage(named: "CheckersWorldgreenWave"))
        topWave.contentMode = .scaleToFill
        view.addSubview(topWave)
        topWave.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        let bottomWave = UIImageView(image: UIImage(named: "CheckersWorldgreenWave1"))
        bottomWave.contentMode = .scaleToFill
        view.addSubview(bottomWave)
        bottomWave.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    @objc func handleCheckersWorldRewardButtonTapped() {
        if gameResult == "draw" || gameResult == "lose" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let homeViewController = CheckersWorldGameViewController()
                self.navigationController?.setViewControllers([homeViewController], animated: true)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let homeViewController = CheckersWorldHomeViewController()
                self.navigationController?.setViewControllers([homeViewController], animated: true)
            }
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
