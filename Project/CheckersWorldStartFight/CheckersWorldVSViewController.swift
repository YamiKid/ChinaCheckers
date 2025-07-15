import UIKit
import SnapKit

class CheckersWorldVSViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldHowImageView: UIImageView!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        setupCheckersWorldUI()
        let CheckersWorldtapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTappedCheckersWorld))
        view.addGestureRecognizer(CheckersWorldtapGesture)
    }
    
    @objc func screenTappedCheckersWorld() {
        let alert = UIAlertController(
            title: "Notice",
            message: "You need to collect 1000 stars to play 1 on 1.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        
        CheckersWorldHowImageView = UIImageView(image: UIImage(named: "CheckersWorldVS"))
        CheckersWorldHowImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldHowImageView)
        CheckersWorldHowImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(CheckersWorldBigLabelBackImageView.snp.top)
            make.width.equalTo(100)
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
        
        let CheckersWorldStar2Label = createCheckersWorldGradientLabel(
            text: "\(CheckersWorldStar) / 1000"
        )
        CheckersWorldStar2Label.adjustsFontSizeToFitWidth = true
        CheckersWorldStar2Label.minimumScaleFactor = 0.5
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldStar2Label)
        CheckersWorldStar2Label.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(CheckersWorldBigWaveImageView.snp.top).offset(-10)
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
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldBarBackImageView)
        CheckersWorldBarBackImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(CheckersWorldStar2Label.snp.top).offset(-5)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(30)
        }
        
        let CheckersWorldRectangleYellowImageView = UIImageView(image: UIImage(named: "CheckersWorldRectangleYellow"))
        CheckersWorldRectangleYellowImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldRectangleYellowImageView)
        let maxStarValue = 1000.0
        let currentStarValue = Double(CheckersWorldStar)
        let percentageWidth = (currentStarValue / maxStarValue) * 200

        CheckersWorldRectangleYellowImageView.snp.makeConstraints { make in
            make.left.equalTo(CheckersWorldBarBackImageView.snp.left)
            make.centerY.equalTo(CheckersWorldBarBackImageView.snp.centerY)
            make.width.equalTo(percentageWidth)
            make.height.equalTo(30)
        }
        
        let CheckersWorldDecLabel = UILabel()
        CheckersWorldDecLabel.text = "You can start playing with your friends through:"
        CheckersWorldDecLabel.numberOfLines = 0
        CheckersWorldDecLabel.textColor = .white
        CheckersWorldDecLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldDecLabel.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDecLabel)
        CheckersWorldDecLabel.snp.makeConstraints { make in
            make.bottom.equalTo(CheckersWorldBarBackImageView.snp.top).offset(-10)
            make.right.equalToSuperview().offset(-20)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let CheckersWorldDec2Label = UILabel()
        CheckersWorldDec2Label.text = "Very soon you will be able to play with your friends and beat them"
        CheckersWorldDec2Label.numberOfLines = 0
        CheckersWorldDec2Label.textColor = .white
        CheckersWorldDec2Label.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldDec2Label.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDec2Label)
        CheckersWorldDec2Label.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(CheckersWorldDecLabel.snp.top).offset(-10)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let CheckersWorldDec3Label = UILabel()
        CheckersWorldDec3Label.text = "Compete with friends online and earn points together"
        CheckersWorldDec3Label.numberOfLines = 0
        CheckersWorldDec3Label.textColor = .white
        CheckersWorldDec3Label.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldDec3Label.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDec3Label)
        CheckersWorldDec3Label.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(CheckersWorldDec2Label.snp.top).offset(-10)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let CheckersWorldSamuraiImageView = UIImageView(image: UIImage(named: "CheckersWorldSamurai"))
        CheckersWorldSamuraiImageView.contentMode = .scaleToFill
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldSamuraiImageView)
        CheckersWorldSamuraiImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.top.equalTo(CheckersWorldDec3Label.snp.top)
            make.width.equalTo(180)
            make.height.equalTo(100)
        }
        
        let CheckersWorldDescImageView = UIImageView(image: UIImage(named: "CheckersWorldDesc1"))
        CheckersWorldDescImageView.contentMode = .scaleToFill
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDescImageView)
        CheckersWorldDescImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(CheckersWorldSamuraiImageView.snp.bottom).offset(10)
            make.width.height.equalTo(100)
        }
        
        let CheckersWorldDesc2ImageView = UIImageView(image: UIImage(named: "CheckersWorldDesc2"))
        CheckersWorldDesc2ImageView.contentMode = .scaleToFill
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDesc2ImageView)
        CheckersWorldDesc2ImageView.snp.makeConstraints { make in
            make.left.equalTo(CheckersWorldDescImageView.snp.right).offset(10)
            make.top.equalTo(CheckersWorldSamuraiImageView.snp.bottom).offset(10)
            make.width.height.equalTo(100)
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

