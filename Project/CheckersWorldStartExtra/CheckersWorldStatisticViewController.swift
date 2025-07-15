import UIKit
import SnapKit

class CheckersWorldStatisticViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldStatisticImageView: UIImageView!
    
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
        
        CheckersWorldStatisticImageView = UIImageView(image: UIImage(named: "CheckersWorldStatistics"))
        CheckersWorldStatisticImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldStatisticImageView)
        CheckersWorldStatisticImageView.snp.makeConstraints { make in
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
       
        let CheckersWorldIconImageView = UIImageView(image: UIImage(named: "CheckersWorldManIcon"))
        CheckersWorldIconImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldIconImageView)
        CheckersWorldIconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-20)
            make.top.equalTo(CheckersWorldStatisticImageView.snp.bottom).offset(30)
            make.width.height.equalTo(40)
        }
        
        let CheckersWorldIconLabel = UILabel()
        CheckersWorldIconLabel.text = "You"
        CheckersWorldIconLabel.textColor = .white
        CheckersWorldIconLabel.font = UIFont(name: "Joti One", size: 28) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldIconLabel.textAlignment = .center
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldIconLabel)
        CheckersWorldIconLabel.snp.makeConstraints { make in
            make.left.equalTo(CheckersWorldIconImageView.snp.right).offset(15)
            make.centerY.equalTo(CheckersWorldIconImageView.snp.centerY)
        }
        
        let CheckersWorldStatsStackView = UIStackView()
        CheckersWorldStatsStackView.axis = .horizontal
        CheckersWorldStatsStackView.alignment = .center
        CheckersWorldStatsStackView.spacing = 5
        CheckersWorldStatsStackView.distribution = .fillEqually
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldStatsStackView)
        CheckersWorldStatsStackView.snp.makeConstraints { make in
            make.left.equalTo(CheckersWorldBigLabelBackImageView.snp.left).offset(20)
            make.centerY.equalTo(CheckersWorldBigLabelBackImageView.snp.centerY)
            make.right.equalTo(CheckersWorldBigLabelBackImageView.snp.right).offset(20)
            make.height.equalTo(60)
        }

        let statsTitles = ["Games", "Wins", "Money earned", "Days", "Stars"]
        let statsValues = [
            "\(CheckersWorldGamesPlayed)",
            "\(CheckersWorldVictories)",
            "\(CheckersWorldTotalEarnings)",
            "\(CheckersWorldDaysSinceRegistration)",
            "\(CheckersWorldStar)"
        ]

        for (index, title) in statsTitles.enumerated() {
            let verticalStack = UIStackView()
            verticalStack.axis = .vertical
            verticalStack.alignment = .leading
            verticalStack.spacing = 10
            CheckersWorldStatsStackView.addArrangedSubview(verticalStack)

            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
            titleLabel.textColor = UIColor(red: 1.0, green: 0.39, blue: 0.39, alpha: 1.0)
            titleLabel.textAlignment = .left
            verticalStack.addArrangedSubview(titleLabel)

            let valueLabel = UILabel()
            valueLabel.text = statsValues[index]
            valueLabel.font = UIFont(name: "Joti One", size: 24) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
            valueLabel.textColor = .white
            valueLabel.textAlignment = .left
            verticalStack.addArrangedSubview(valueLabel)
        }

       
    }
    @objc func CheckersWorldBackTapped() {
        let helpViewController = CheckersWorldHomeViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
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

