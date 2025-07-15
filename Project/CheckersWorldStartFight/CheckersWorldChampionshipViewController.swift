import UIKit
import SnapKit

class CheckersWorldChampionshipViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldChampionshipVImageView: UIImageView!
    var CheckersWorldBarBackImageView: UIImageView!
    
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
    
    
    var CheckersWorldRegisterButton: UIButton!
    
    
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
        
        CheckersWorldChampionshipVImageView = UIImageView(image: UIImage(named: "CheckersWorldChampionships"))
        CheckersWorldChampionshipVImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldChampionshipVImageView)
        CheckersWorldChampionshipVImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(CheckersWorldBigLabelBackImageView.snp.top)
            make.width.equalTo(250)
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
        
        CheckersWorldRegisterButton = UIButton()
        CheckersWorldRegisterButton.setImage(UIImage(named: "CheckersWorldChampionshipRegister"), for: .normal)
        CheckersWorldRegisterButton.addTarget(self, action: #selector(showheckersWorldRegistrationSuccessMessage), for: .touchUpInside)
        CheckersWorldAddSound(to: CheckersWorldRegisterButton)
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldRegisterButton)
        CheckersWorldRegisterButton.snp.makeConstraints { make in
            make.bottom.equalTo(CheckersWorldBigWaveImageView.snp.top).offset(-20)
            make.left.equalTo(CheckersWorldBigLabelBackImageView.snp.left).offset(20)
            make.width.equalTo(230)
            make.height.equalTo(40)
        }
        
        let CheckersWorldStar2Label = createCheckersWorldGradientLabel(
            text: "\(CheckersWorldStar) / 1000"
        )
        CheckersWorldStar2Label.adjustsFontSizeToFitWidth = true
        CheckersWorldStar2Label.minimumScaleFactor = 0.5
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldStar2Label)
        CheckersWorldStar2Label.snp.makeConstraints { make in
            make.right.equalTo(CheckersWorldRegisterButton.snp.right)
            make.bottom.equalTo(CheckersWorldRegisterButton.snp.top).offset(-20)
        }
        
        let CheckersWorldStar2ImageView = UIImageView(image: UIImage(named: "CheckersWorldStar"))
        CheckersWorldStar2ImageView.contentMode = .scaleAspectFit
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldStar2ImageView)
        CheckersWorldStar2ImageView.snp.makeConstraints { make in
            make.right.equalTo(CheckersWorldStar2Label.snp.left).offset(-5)
            make.centerY.equalTo(CheckersWorldStar2Label.snp.centerY)
            make.width.height.equalTo(30)
        }
        
        CheckersWorldBarBackImageView = UIImageView(image: UIImage(named: "CheckersWorldRectangleRed"))
        CheckersWorldBarBackImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldBarBackImageView)
        CheckersWorldBarBackImageView.snp.makeConstraints { make in
            make.right.equalTo(CheckersWorldRegisterButton.snp.right)
            make.bottom.equalTo(CheckersWorldStar2Label.snp.top).offset(-5)
            make.width.equalTo(230)
            make.height.equalTo(30)
        }
        
        let CheckersWorldRectangleYellowImageView = UIImageView(image: UIImage(named: "CheckersWorldRectangleYellow"))
        CheckersWorldRectangleYellowImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldRectangleYellowImageView)
        let maxStarValue = 1000.0
        let currentStarValue = Double(CheckersWorldStar)
        let percentageWidth = (currentStarValue / maxStarValue) * 230.0

        CheckersWorldRectangleYellowImageView.snp.makeConstraints { make in
            make.left.equalTo(CheckersWorldBarBackImageView.snp.left)
            make.centerY.equalTo(CheckersWorldBarBackImageView.snp.centerY)
            make.width.equalTo(percentageWidth)
            make.height.equalTo(30)
        }
        
        let CheckersWorldIconImageView = UIImageView(image: UIImage(named: "CheckersWorldManIcon"))
        CheckersWorldIconImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldIconImageView)
        CheckersWorldIconImageView.snp.makeConstraints { make in
            make.left.equalTo(CheckersWorldBarBackImageView.snp.left)
            make.bottom.equalTo(CheckersWorldBarBackImageView.snp.top).offset(-20)
            make.width.height.equalTo(40)
        }
        
        let CheckersWorldIconLabel = UILabel()
        CheckersWorldIconLabel.text = "You"
        CheckersWorldIconLabel.textColor = .white
        CheckersWorldIconLabel.font = UIFont(name: "Joti One", size: 28) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldIconLabel.textAlignment = .center
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldIconLabel)
        CheckersWorldIconLabel.snp.makeConstraints { make in
            make.left.equalTo(CheckersWorldIconImageView.snp.right).offset(5)
            make.centerY.equalTo(CheckersWorldIconImageView.snp.centerY)
        }
        
        let CheckersWorldDecLabel = UILabel()
        CheckersWorldDecLabel.text = "Compete with opponents and get the coveted stars, thanks to which you will soon be able to participate in an online tournament with real players"
        CheckersWorldDecLabel.numberOfLines = 0
        CheckersWorldDecLabel.textColor = .white
        CheckersWorldDecLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldDecLabel.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDecLabel)
        CheckersWorldDecLabel.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldIconImageView.snp.top)
            make.right.equalToSuperview().offset(-20)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let CheckersWorldDec2Label = UILabel()
        CheckersWorldDec2Label.text = "Collect the required number of stars to get the 'Newbie' status and start your journey to the top of the leaderboard"
        CheckersWorldDec2Label.numberOfLines = 0
        CheckersWorldDec2Label.textColor = .white
        CheckersWorldDec2Label.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldDec2Label.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDec2Label)
        CheckersWorldDec2Label.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(CheckersWorldDecLabel.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
    }
    
    @objc func showheckersWorldRegistrationSuccessMessage() {
        let alert = UIAlertController(title: "Success", message: "The user has been successfully registered!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

