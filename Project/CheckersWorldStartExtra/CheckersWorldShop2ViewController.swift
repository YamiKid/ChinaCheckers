import UIKit
import SnapKit

class CheckersWorldShop2ViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldStatisticImageView: UIImageView!
    
    var CheckersWorldThemeButton: UIButton!
    var CheckersWorldBusterButton: UIButton!
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
        
        CheckersWorldStatisticImageView = UIImageView(image: UIImage(named: "CheckersWorldShops"))
        CheckersWorldStatisticImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldStatisticImageView)
        CheckersWorldStatisticImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(CheckersWorldBigLabelBackImageView.snp.top)
            make.width.equalTo(120)
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
        
        CheckersWorldThemeButton = UIButton()
        CheckersWorldThemeButton.setImage(UIImage(named: "CheckersWorldThemeOn"), for: .normal)
        CheckersWorldThemeButton.setImage(UIImage(named: "CheckersWorldThemeOff"), for: .disabled)
        CheckersWorldThemeButton.addTarget(self, action: #selector(CheckersWorldThemeTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldThemeButton)
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldThemeButton)
        CheckersWorldThemeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        CheckersWorldBusterButton = UIButton()
        CheckersWorldBusterButton.isEnabled = false
        CheckersWorldBusterButton.setImage(UIImage(named: "CheckersWorldBusterOn"), for: .normal)
        CheckersWorldBusterButton.setImage(UIImage(named: "CheckersWorldBusterOff"), for: .disabled)
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldBusterButton)
        CheckersWorldBusterButton.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldThemeButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        let stackContainer = UIStackView()
            stackContainer.axis = .horizontal
            stackContainer.alignment = .center
            stackContainer.spacing = 20
            stackContainer.distribution = .fillEqually
            CheckersWorldBigLabelBackImageView.addSubview(stackContainer)

            stackContainer.snp.makeConstraints { make in
                make.left.equalTo(CheckersWorldBusterButton.snp.right).offset(20)
                make.right.equalTo(CheckersWorldBigLabelBackImageView.snp.right).offset(-10)
                make.top.equalTo(CheckersWorldThemeButton.snp.top).offset(20)
            }

        addCheckersWorldShopItemStack(
            to: stackContainer,
            imageName: "CheckersWorldBackwards",
            title: "Move backwards",
            description: "Allows you to go back a step",
            boosterKey: "BackwardsBoosterCount"
        )

        addCheckersWorldShopItemStack(
            to: stackContainer,
            imageName: "CheckersWorldClue",
            title: "Clue",
            description: "Shows where it is better to go",
            boosterKey: "ClueBoosterCount"
        )
    }
    
    var boosterCheckersWorldCountLabels: [String: UILabel] = [:]

    func addCheckersWorldShopItemStack(to parentStack: UIStackView, imageName: String, title: String, description: String, boosterKey: String) {
        let itemStackView = UIStackView()
        itemStackView.axis = .vertical
        itemStackView.alignment = .center
        itemStackView.spacing = 10
        parentStack.addArrangedSubview(itemStackView)

        let itemImageView = UIImageView(image: UIImage(named: imageName))
        itemImageView.contentMode = .scaleToFill
        itemStackView.addArrangedSubview(itemImageView)
        itemImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }

        let countBackImageView = UIImageView(image: UIImage(named: "CheckersWorldCountBack"))
        countBackImageView.contentMode = .scaleToFill
        itemImageView.addSubview(countBackImageView)
        countBackImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.bottom.equalTo(itemImageView.snp.bottom).offset(10)
            make.right.equalTo(itemImageView.snp.right).offset(10)
        }

        let countLabel = UILabel()
        countLabel.text = "\(UserDefaults.standard.integer(forKey: boosterKey))"
        countLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countBackImageView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.center.equalTo(countBackImageView)
        }

        boosterCheckersWorldCountLabels[boosterKey] = countLabel

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Joti One", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        itemStackView.addArrangedSubview(titleLabel)

        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        itemStackView.addArrangedSubview(descriptionLabel)

        let buyButton = UIButton()
        buyButton.setImage(UIImage(named: "CheckersWorldBuy"), for: .normal)
        buyButton.accessibilityIdentifier = boosterKey
        buyButton.addTarget(self, action: #selector(handleBuyButtonTappedCheckersWorld(_:)), for: .touchUpInside)
        CheckersWorldAddSound(to: buyButton)
        buyButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        itemStackView.addArrangedSubview(buyButton)
    }

    @objc func handleBuyButtonTappedCheckersWorld(_ sender: UIButton) {
        guard let boosterKey = sender.accessibilityIdentifier else { return }

        let boosterPrice = getCheckersWorldBoosterPrice(for: boosterKey)

        if CheckersWorldScore < boosterPrice {
            let alert = UIAlertController(title: "Not enough funds", message: "You need \(boosterPrice - CheckersWorldScore) more to buy this booster.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        let alert = UIAlertController(title: "Purchase", message: "Do you want to buy this booster for \(boosterPrice)?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Buy", style: .default, handler: { _ in
            self.CheckersWorldScore -= boosterPrice
            UserDefaults.standard.set(self.CheckersWorldScore, forKey: "CheckersWorldScore")
            self.increaseCheckersWorldBoosterCount(for: boosterKey)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCheckersWorldBoosterPrice(for boosterKey: String) -> Int {
        switch boosterKey {
        case "BackwardsBoosterCount":
            return 2000
        case "ClueBoosterCount":
            return 500
        default:
            return 0
        }
    }


    
    func increaseCheckersWorldBoosterCount(for boosterKey: String) {
        let currentCount = UserDefaults.standard.integer(forKey: boosterKey)
        let updatedCount = currentCount + 1
        UserDefaults.standard.set(updatedCount, forKey: boosterKey)

        if let countLabel = boosterCheckersWorldCountLabels[boosterKey] {
            countLabel.text = "\(updatedCount)"
            CheckersWorldScoreLabel.text = "\(CheckersWorldScore)"
        }
    }
    
    @objc func CheckersWorldBackTapped() {
        let helpViewController = CheckersWorldHomeViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    @objc func CheckersWorldThemeTapped() {
        self.navigationController?.popViewController(animated: false)
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

