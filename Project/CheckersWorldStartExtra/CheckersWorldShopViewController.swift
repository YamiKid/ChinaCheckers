import UIKit
import SnapKit

class CheckersWorldShopViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldStatisticImageView: UIImageView!
    
    var CheckersWorldThemeButton: UIButton!
    var CheckersWorldBusterButton: UIButton!
    var shopCheckersWorldButtons: [UIButton] = []
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
        initializeCheckersWorldShopState()
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
        CheckersWorldThemeButton.isEnabled = false
        CheckersWorldThemeButton.setImage(UIImage(named: "CheckersWorldThemeOff"), for: .disabled)
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldThemeButton)
        CheckersWorldThemeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        CheckersWorldBusterButton = UIButton()
        CheckersWorldBusterButton.setImage(UIImage(named: "CheckersWorldBusterOn"), for: .normal)
        CheckersWorldBusterButton.setImage(UIImage(named: "CheckersWorldBusterOff"), for: .disabled)
        CheckersWorldBusterButton.addTarget(self, action: #selector(CheckersWorldBusterTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldBusterButton)
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldBusterButton)
        CheckersWorldBusterButton.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldThemeButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        let CheckersWorldShopStackView = UIStackView()
        CheckersWorldShopStackView.axis = .horizontal
        CheckersWorldShopStackView.alignment = .center
        CheckersWorldShopStackView.spacing = 5
        CheckersWorldShopStackView.distribution = .fillEqually
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldShopStackView)
        CheckersWorldShopStackView.snp.makeConstraints { make in
            make.left.equalTo(CheckersWorldBusterButton.snp.right).offset(20)
            make.right.equalTo(CheckersWorldBigLabelBackImageView.snp.right).offset(-10)
            make.top.equalTo(CheckersWorldThemeButton.snp.top).offset(20)
        }
        
        
        addSCheckersWorldhopItem(to: CheckersWorldShopStackView, iconName: "CheckersWorldShop1Icon", price: "10000",itemName: "CheckersWorldShop1Icon")
        addSCheckersWorldhopItem(to: CheckersWorldShopStackView, iconName: "CheckersWorldShop2Icon", price: "100000",itemName: "CheckersWorldShop2Icon")
        addSCheckersWorldhopItem(to: CheckersWorldShopStackView, iconName: "CheckersWorldShop3Icon", price: "10000",itemName: "CheckersWorldShop3Icon")
    }

    let CheckersWorldselectedPurchaseKey = "SelectedPurchase"
    let CheckersWorldpurchasedItemsKey = "PurchasedItems"

    func addSCheckersWorldhopItem(to stackView: UIStackView, iconName: String, price: String, itemName: String) {
        let itemStackView = UIStackView()
        itemStackView.axis = .vertical
        itemStackView.alignment = .center
        itemStackView.spacing = 10
        stackView.addArrangedSubview(itemStackView)

        let iconImageView = UIImageView(image: UIImage(named: iconName))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        itemStackView.addArrangedSubview(iconImageView)

        let priceStackView = UIStackView()
        priceStackView.axis = .horizontal
        priceStackView.alignment = .center
        priceStackView.spacing = 5
        itemStackView.addArrangedSubview(priceStackView)

        let flowerImageView = UIImageView(image: UIImage(named: "CheckersWorldFlower"))
        flowerImageView.contentMode = .scaleAspectFit
        flowerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        priceStackView.addArrangedSubview(flowerImageView)

        let priceLabel = UILabel()
        priceLabel.text = price
        priceLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
        priceLabel.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        priceStackView.addArrangedSubview(priceLabel)

        let buyButton = UIButton()
        CheckersWorldAddSound(to: buyButton)
        buyButton.accessibilityIdentifier = itemName
        CheckersWorldconfigureBuyButton(buyButton, for: itemName)
        shopCheckersWorldButtons.append(buyButton)
        buyButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        itemStackView.addArrangedSubview(buyButton)
    }
    
    func initializeCheckersWorldShopState() {
        let purchasedItems = UserDefaults.standard.array(forKey: CheckersWorldpurchasedItemsKey) as? [String] ?? []
        let selectedPurchase = UserDefaults.standard.string(forKey: CheckersWorldselectedPurchaseKey)
        if !purchasedItems.contains("CheckersWorldShop1Icon") {
            var updatedPurchasedItems = purchasedItems
            updatedPurchasedItems.append("CheckersWorldShop1Icon")
            UserDefaults.standard.set(updatedPurchasedItems, forKey: CheckersWorldpurchasedItemsKey)
            if selectedPurchase == nil {
                UserDefaults.standard.set("CheckersWorldShop1Icon", forKey: CheckersWorldselectedPurchaseKey)
            }
        }
        CheckersWorldupdateUI()
    }

    func CheckersWorldconfigureBuyButton(_ button: UIButton, for itemName: String) {
        let purchasedItems = UserDefaults.standard.array(forKey: CheckersWorldpurchasedItemsKey) as? [String] ?? []
        let selectedPurchase = UserDefaults.standard.string(forKey: CheckersWorldselectedPurchaseKey)
        
        if purchasedItems.contains(itemName) {
            if selectedPurchase == itemName {
                button.setImage(UIImage(named: "CheckersWorldUsed"), for: .normal)
                button.isEnabled = false
            } else {
                button.setImage(UIImage(named: "CheckersWorldUse"), for: .normal)
                button.isEnabled = true
            }
        } else {
            button.setImage(UIImage(named: "CheckersWorldBuy"), for: .normal)
            button.isEnabled = true
        }
        button.accessibilityIdentifier = itemName
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(handleShopCheckersWorldButtonTapped(_:)), for: .touchUpInside)
    }

    
    @objc func handleShopCheckersWorldButtonTapped(_ sender: UIButton) {
        guard let buttonImage = sender.image(for: .normal),
              let itemName = sender.accessibilityIdentifier else { return }
        
        if buttonImage == UIImage(named: "CheckersWorldBuy") {
            CheckersWorldprocessPurchase(for: itemName, with: sender)
        } else if buttonImage == UIImage(named: "CheckersWorldUse") {
            CheckersWorldsetItemAsSelected(itemName: itemName, button: sender)
        }
    }
    
    func CheckersWorldprocessPurchase(for itemName: String, with button: UIButton) {
        let itemPrice = getCheckersWorldPrice(for: itemName)
        if CheckersWorldScore < itemPrice {
            showAlertCheckersWorld(message: "You don't have enough balance to buy this item.")
            return
        }

        let alert = UIAlertController(title: "Confirm Purchase", message: "Are you sure you want to buy this item for \(itemPrice)?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Buy", style: .default, handler: { _ in
            self.CheckersWorldScore -= itemPrice
            UserDefaults.standard.set(self.CheckersWorldScore, forKey: "CheckersWorldScore")

            var purchasedItems = UserDefaults.standard.array(forKey: self.CheckersWorldpurchasedItemsKey) as? [String] ?? []
            if !purchasedItems.contains(itemName) {
                purchasedItems.append(itemName)
                UserDefaults.standard.set(purchasedItems, forKey: self.CheckersWorldpurchasedItemsKey)
            }

            UserDefaults.standard.set(itemName, forKey: self.CheckersWorldselectedPurchaseKey)

            self.CheckersWorldupdateUI()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func CheckersWorldsetItemAsSelected(itemName: String, button: UIButton) {
        UserDefaults.standard.set(itemName, forKey: CheckersWorldselectedPurchaseKey)
        CheckersWorldupdateUI()
    }
    
    func CheckersWorldupdateUI() {
        shopCheckersWorldButtons.forEach { button in
            guard let itemName = button.accessibilityIdentifier else { return }
            CheckersWorldconfigureBuyButton(button, for: itemName)
        }
        CheckersWorldScoreLabel.text = "\(CheckersWorldScore)"
    }

    
    func showAlertCheckersWorld(message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCheckersWorldPrice(for itemName: String) -> Int {
        switch itemName {
        case "CheckersWorldShop1Icon":
            return 10000
        case "CheckersWorldShop2Icon":
            return 100000
        case "CheckersWorldShop3Icon":
            return 10000
        default:
            return 0
        }
    }

    @objc func CheckersWorldselectItem(_ sender: UIButton) {
        guard let itemName = sender.accessibilityIdentifier else { return }

        UserDefaults.standard.set(itemName, forKey: CheckersWorldselectedPurchaseKey)

        let shopStackView = sender.superview?.superview as? UIStackView
        shopStackView?.arrangedSubviews.forEach { subview in
            guard let itemStackView = subview as? UIStackView,
                  let button = itemStackView.arrangedSubviews.last as? UIButton,
                  let itemNameForButton = button.accessibilityIdentifier else { return }
            CheckersWorldconfigureBuyButton(button, for: itemNameForButton)
        }
    }

    
    @objc func CheckersWorldBackTapped() {
        let helpViewController = CheckersWorldHomeViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }
    
    @objc func CheckersWorldBusterTapped() {
        let helpViewController = CheckersWorldShop2ViewController()
        self.navigationController?.pushViewController(helpViewController, animated: false)
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

