import UIKit
import SnapKit

class CheckersWorldBonusViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldChestImageView: UIImageView!
    var CheckersWorldStarLabel: UILabel!
    var CheckersWorldFlowerLabel: UILabel!
    
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

        
        CheckersWorldChestImageView = UIImageView(image: UIImage(named: "CheckersWorldChest"))
        CheckersWorldChestImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldChestImageView)
        CheckersWorldChestImageView.snp.makeConstraints { make in
            make.bottom.equalTo(CheckersWorldScoreBackImageView.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        let CheckersWorldRewardButton = UIButton()
        CheckersWorldRewardButton.setImage(UIImage(named: "CheckersWorldReward"), for: .normal)
        CheckersWorldRewardButton.addTarget(self, action: #selector(handleCheckersWorldRewardButtonTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldRewardButton)
        view.addSubview(CheckersWorldRewardButton)
        CheckersWorldRewardButton.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldScoreBackImageView.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    @objc func handleCheckersWorldRewardButtonTapped() {
        let rewards = [1000, 1500, 2000]
        let randomReward = rewards.randomElement() ?? 1000
        
        CheckersWorldScore += randomReward
        CheckersWorldTotalEarnings += randomReward
        
        CheckersWorldFlowerLabel.text = "\(CheckersWorldScore)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let helpViewController = CheckersWorldHomeViewController()
            self.navigationController?.setViewControllers([helpViewController], animated: true)
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

