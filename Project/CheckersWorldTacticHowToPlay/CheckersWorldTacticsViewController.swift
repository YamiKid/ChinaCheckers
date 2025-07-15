import UIKit
import SnapKit

class CheckersWorldTacticsViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldTacticImageView: UIImageView!
    
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
        
        CheckersWorldTacticImageView = UIImageView(image: UIImage(named: "CheckersWorldTactics"))
        CheckersWorldTacticImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldTacticImageView)
        CheckersWorldTacticImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(CheckersWorldBigLabelBackImageView.snp.top)
            make.width.equalTo(200)
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
        
        let centerStack = UIStackView()
        centerStack.axis = .vertical
        centerStack.alignment = .center
        centerStack.spacing = 10
        CheckersWorldBigLabelBackImageView.addSubview(centerStack)

        centerStack.snp.makeConstraints { make in
            make.center.equalTo(CheckersWorldBigLabelBackImageView.snp.center)
        }

        let centerImageView = UIImageView(image: UIImage(named: "CheckersWorldDesc12"))
        centerImageView.contentMode = .scaleAspectFit
        centerStack.addArrangedSubview(centerImageView)

        centerImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }

        let centerTextLabel = UILabel()
        centerTextLabel.text = "Tactic 2"
        centerTextLabel.font = UIFont(name: "Joti One", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        centerTextLabel.textColor = .white
        centerTextLabel.textAlignment = .center
        centerStack.addArrangedSubview(centerTextLabel)

        let centerButton = UIButton()
        centerButton.setImage(UIImage(named: "CheckersWorldRead"), for: .normal)
        centerButton.addTarget(self, action: #selector(centerCheckersWorldTacticTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: centerButton)
        centerStack.addArrangedSubview(centerButton)

        centerButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
        }

        let leftStack = UIStackView()
        leftStack.axis = .vertical
        leftStack.alignment = .center
        leftStack.spacing = 10
        CheckersWorldBigLabelBackImageView.addSubview(leftStack)

        leftStack.snp.makeConstraints { make in
            make.centerY.equalTo(centerStack.snp.centerY)
            make.right.equalTo(centerStack.snp.left).offset(-20)
        }

        let leftImageView = UIImageView(image: UIImage(named: "CheckersWorldDesc12"))
        leftImageView.contentMode = .scaleAspectFit
        leftStack.addArrangedSubview(leftImageView)

        leftImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }

        let leftTextLabel = UILabel()
        leftTextLabel.text = "Tactic 1"
        leftTextLabel.font = UIFont(name: "Joti One", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        leftTextLabel.textColor = .white
        leftTextLabel.textAlignment = .center
        leftStack.addArrangedSubview(leftTextLabel)

        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "CheckersWorldRead"), for: .normal)
        leftButton.addTarget(self, action: #selector(leftCheckersWorldTacticTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: leftButton)
        leftStack.addArrangedSubview(leftButton)

        leftButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
        }

        let rightStack = UIStackView()
        rightStack.axis = .vertical
        rightStack.alignment = .center
        rightStack.spacing = 10
        CheckersWorldBigLabelBackImageView.addSubview(rightStack)

        rightStack.snp.makeConstraints { make in
            make.centerY.equalTo(centerStack.snp.centerY)
            make.left.equalTo(centerStack.snp.right).offset(20)
        }

        let rightImageView = UIImageView(image: UIImage(named: "CheckersWorldDesc13"))
        rightImageView.contentMode = .scaleAspectFit
        rightStack.addArrangedSubview(rightImageView)

        rightImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }

        let rightTextLabel = UILabel()
        rightTextLabel.text = "Tactic 3"
        rightTextLabel.font = UIFont(name: "Joti One", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        rightTextLabel.textColor = .white
        rightTextLabel.textAlignment = .center
        rightStack.addArrangedSubview(rightTextLabel)

        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "CheckersWorldRead"), for: .normal)
        rightButton.addTarget(self, action: #selector(rightCheckersWorldTacticTapped), for: .touchUpInside)
        CheckersWorldAddSound(to: rightButton)
        rightStack.addArrangedSubview(rightButton)

        rightButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
        }

    }
    
    @objc func centerCheckersWorldTacticTapped() {
        let helpViewController = CheckersWorldTactics2ViewController()
        helpViewController.tacticCheckersWorldIndex = 1
        self.navigationController?.pushViewController(helpViewController, animated: true)

    }

    @objc func leftCheckersWorldTacticTapped() {
        let helpViewController = CheckersWorldTactics2ViewController()
        helpViewController.tacticCheckersWorldIndex = 0
        self.navigationController?.pushViewController(helpViewController, animated: true)
    }

    @objc func rightCheckersWorldTacticTapped() {
        let helpViewController = CheckersWorldTactics2ViewController()
        helpViewController.tacticCheckersWorldIndex = 2
        self.navigationController?.pushViewController(helpViewController, animated: true)
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

