import UIKit
import SnapKit

class CheckersWorldTactics2ViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldBigLabelBackImageView: UIImageView!
    var CheckersWorldScoreBackImageView: UIImageView!
    var CheckersWorldHowImageView: UIImageView!
    var tacticCheckersWorldIndex: Int = 0
    
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
        
        CheckersWorldHowImageView = UIImageView(image: UIImage(named: "CheckersWorldTactics"))
        CheckersWorldHowImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldHowImageView)
        CheckersWorldHowImageView.snp.makeConstraints { make in
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
        
        let CheckersWorldDescImageView = UIImageView(image: UIImage(named: "CheckersWorldDesc11"))
        CheckersWorldDescImageView.contentMode = .scaleToFill
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDescImageView)
        CheckersWorldDescImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(180)
        }
        
        let CheckersWorldTitleLabel = UILabel()
        CheckersWorldTitleLabel.text = "Tactic 1"
        CheckersWorldTitleLabel.numberOfLines = 0
        CheckersWorldTitleLabel.textColor = .white
        CheckersWorldTitleLabel.font = UIFont(name: "Joti One", size: 28) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldTitleLabel.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldTitleLabel)
        CheckersWorldTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldDescImageView.snp.top)
            make.right.equalToSuperview().offset(-30)
            make.left.equalTo(CheckersWorldDescImageView.snp.right).offset(20)
        }
        

        let CheckersWorldDecLabel = UILabel()
        CheckersWorldDecLabel.text = "Black attacked all of White's checkers at once, and if it were Black's turn now, they would destroy their opponent with one blow. But it is White's turn to move and they win: 1.ba3 a:c5 2.b:h6 x"
        CheckersWorldDecLabel.numberOfLines = 0
        CheckersWorldDecLabel.textColor = .white
        CheckersWorldDecLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldDecLabel.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDecLabel)
        CheckersWorldDecLabel.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldDescImageView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-30)
            make.left.equalTo(CheckersWorldDescImageView.snp.right).offset(20)
        }
        
        updateCheckersWorldTacticContent()
    }
    
    func updateCheckersWorldTacticContent() {
        let titleTexts = ["Tactic 1", "Tactic 2", "Tactic 3"]
        let descriptions = [
            "Black attacked all of White's checkers at once, and if it were Black's turn now, they would destroy their opponent with one blow. But it is White's turn to move and they win: 1.ba3 a:c5 2.b:h6 x",
            "One of the types of strike group of checkers is a column, a column of checkers is easy to notice and build during the game",
            "In this situation, a column of checkers allows White to win quickly: 1.gf6 e:g5 2.ef4 g:e3 3.f:d8 x"
        ]
        let imageNames = ["CheckersWorldDesc11", "CheckersWorldDesc12", "CheckersWorldDesc13"]

        CheckersWorldBigLabelBackImageView.subviews.forEach { $0.removeFromSuperview() }

        let CheckersWorldDescImageView = UIImageView(image: UIImage(named: imageNames[tacticCheckersWorldIndex]))
        CheckersWorldDescImageView.contentMode = .scaleToFill
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDescImageView)
        CheckersWorldDescImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(180)
        }
        
        let CheckersWorldTitleLabel = UILabel()
        CheckersWorldTitleLabel.text = titleTexts[tacticCheckersWorldIndex]
        CheckersWorldTitleLabel.numberOfLines = 0
        CheckersWorldTitleLabel.textColor = .white
        CheckersWorldTitleLabel.font = UIFont(name: "Joti One", size: 28) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldTitleLabel.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldTitleLabel)
        CheckersWorldTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldDescImageView.snp.top)
            make.right.equalToSuperview().offset(-30)
            make.left.equalTo(CheckersWorldDescImageView.snp.right).offset(20)
        }

        let CheckersWorldDecLabel = UILabel()
        CheckersWorldDecLabel.text = descriptions[tacticCheckersWorldIndex]
        CheckersWorldDecLabel.numberOfLines = 0
        CheckersWorldDecLabel.textColor = .white
        CheckersWorldDecLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        CheckersWorldDecLabel.textAlignment = .left
        CheckersWorldBigLabelBackImageView.addSubview(CheckersWorldDecLabel)
        CheckersWorldDecLabel.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldTitleLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-30)
            make.left.equalTo(CheckersWorldDescImageView.snp.right).offset(20)
        }
    }
    
    @objc func CheckersWorldBackTapped() {
        self.navigationController?.popViewController(animated: true)
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

