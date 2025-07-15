import UIKit
import SnapKit

class CheckersWorldGameViewController: UIViewController {
    
    var CheckersWorldMainBackImageView: UIImageView!
    var CheckersWorldCostPlay = 0
    var buttonGrid: [[UIButton]] = []
    var selectedButton: UIButton?
    var selectedRow: Int?
    var selectedColumn: Int?
    
    var whiteCountLabel: UILabel!
    var blackCountLabel: UILabel!
    
    let shopselected = UserDefaults.standard.string(forKey: "SelectedPurchase") ?? "CheckersWorldShop1Icon"
    let imageSets: [String: [String: String]] = [
        "CheckersWorldShop1Icon": [
            "RedCell": "CheckersWorldRedCell",
            "RedCellWhite": "CheckersWorldRedCellWhite",
            "RedCellWhiteQuine": "CheckersWorldRedCellWhiteQuine",
            "RedCellBlack": "CheckersWorldRedCellBlack",
            "RedCellBlackQuine": "CheckersWorldRedCellBlackQuine",
            "WhiteCell": "CheckersWorldWhiteCell"
        ],
        "CheckersWorldShop2Icon": [
            "RedCell": "CheckersWorldRedCell2",
            "RedCellWhite": "CheckersWorldRedCellWhite2",
            "RedCellWhiteQuine": "CheckersWorldRedCellWhiteQuine2",
            "RedCellBlack": "CheckersWorldRedCellBlack2",
            "RedCellBlackQuine": "CheckersWorldRedCellBlackQuine2",
            "WhiteCell": "CheckersWorldWhiteCell2"
        ],
        "CheckersWorldShop3Icon": [
            "RedCell": "CheckersWorldRedCell3",
            "RedCellWhite": "CheckersWorldRedCellWhite3",
            "RedCellWhiteQuine": "CheckersWorldRedCellWWhiteQuine3",
            "RedCellBlack": "CheckersWorldRedCellBlack3",
            "RedCellBlackQuine": "CheckersWorldRedCellBlackQuine3",
            "WhiteCell": "CheckersWorldWhiteCell3"
        ]
    ]
    
    
    
    
    
    var boardStates: [[String]] = Array(repeating: Array(repeating: "CheckersWorldRedCell", count: 8), count: 8)
    
    var CheckersWorldGamesPlayed: Int {
        get { UserDefaults.standard.integer(forKey: "CheckersWorldGamesPlayed") }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckersWorldGamesPlayed")
        }
    }
    
    override func viewDidLoad() {
        CheckersWorldGamesPlayed += 1
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        boardStates = Array(repeating: Array(repeating: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell", count: 8), count: 8)
        setupCheckersWorldUI()
    }
    
    func setupCheckersWorldUI() {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        CheckersWorldMainBackImageView = UIImageView(image: UIImage(named: "CheckersWorldGameBack"))
        CheckersWorldMainBackImageView.contentMode = .scaleToFill
        view.addSubview(CheckersWorldMainBackImageView)
        CheckersWorldMainBackImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        let CheckersWorldDescImageView = UIImageView(image: UIImage(named: "CheckersWorldDescBack"))
        CheckersWorldDescImageView.contentMode = .scaleToFill
        CheckersWorldDescImageView.isUserInteractionEnabled = true
        view.addSubview(CheckersWorldDescImageView)
        CheckersWorldDescImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.height.equalTo(320)
        }
        
        func calculatePieceCount(for pieceType: String) -> Int {
            var count = 0
            for row in boardStates {
                for cell in row {
                    if cell == pieceType || cell == (selectedImageSet["\(pieceType)Quine"] ?? "\(pieceType)Quine") {
                        count += 1
                    }
                }
            }
            return count
        }
        
        func updatePieceCounts() {
            let blackCount = calculatePieceCount(for: selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack")
            blackCountLabel.text = "x\(blackCount)"
            
            let whiteCount = calculatePieceCount(for: selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite")
            whiteCountLabel.text = "x\(whiteCount)"
        }
        
        func moveSelectedPiece(toRow targetRow: Int, toColumn targetColumn: Int, fromRow row: Int, fromColumn column: Int) {
            saveCurrentBoardState()
            resetHighlightedMoves()
            
            let sourceButton = buttonGrid[row][column]
            let targetButton = buttonGrid[targetRow][targetColumn]
            
            if targetRow == 0 && boardStates[row][column] == (selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite") {
                boardStates[targetRow][targetColumn] = selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine"
                updateButtonState(button: targetButton, state: selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine", row: targetRow, column: targetColumn)
            } else if targetRow == 7 && boardStates[row][column] == (selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack") {
                boardStates[targetRow][targetColumn] = selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine"
                updateButtonState(button: targetButton, state: selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine", row: targetRow, column: targetColumn)
            } else {
                boardStates[targetRow][targetColumn] = boardStates[row][column]
                updateButtonState(button: targetButton, state: boardStates[row][column], row: targetRow, column: targetColumn)
            }
            
            boardStates[row][column] = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
            updateButtonState(button: sourceButton, state: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell", row: row, column: column)
            
            selectedButton = nil
            selectedRow = nil
            selectedColumn = nil
            
            updatePieceCounts()
            moveRandomBlackPiece()
        }
        
        let buttonGridStack = UIStackView()
        buttonGridStack.axis = .vertical
        buttonGridStack.alignment = .fill
        buttonGridStack.distribution = .fillEqually
        buttonGridStack.spacing = 0
        CheckersWorldDescImageView.addSubview(buttonGridStack)
        buttonGridStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        let giveUpButton = UIButton(type: .custom)
        giveUpButton.setImage(UIImage(named: "CheckersWorldGiveUp"), for: .normal)
        giveUpButton.addTarget(self, action: #selector(handleGiveUp), for: .touchUpInside)
        CheckersWorldAddSound(to: giveUpButton)
        view.addSubview(giveUpButton)
        giveUpButton.snp.makeConstraints { make in
            make.centerY.equalTo(CheckersWorldDescImageView.snp.centerY).offset(-30)
            make.right.equalTo(CheckersWorldDescImageView.snp.left).offset(-75)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        let resetButton = UIButton(type: .custom)
        resetButton.setImage(UIImage(named: "CheckersWorldReset"), for: .normal)
        resetButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        CheckersWorldAddSound(to: resetButton)
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.centerY.equalTo(CheckersWorldDescImageView.snp.centerY).offset(-30)
            make.right.equalTo(giveUpButton.snp.left).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        let backwardsButton = UIButton(type: .custom)
        backwardsButton.setImage(UIImage(named: "CheckersWorldBackwards"), for: .normal)
        backwardsButton.addTarget(self, action: #selector(handleBackwards), for: .touchUpInside)
        CheckersWorldAddSound(to: backwardsButton)
        view.addSubview(backwardsButton)
        backwardsButton.snp.makeConstraints { make in
            make.centerY.equalTo(resetButton.snp.centerY).offset(50)
            make.right.equalTo(resetButton.snp.right).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        let clueButton = UIButton(type: .custom)
        clueButton.setImage(UIImage(named: "CheckersWorldClue"), for: .normal)
        clueButton.addTarget(self, action: #selector(handleClue), for: .touchUpInside)
        CheckersWorldAddSound(to: clueButton)
        view.addSubview(clueButton)
        clueButton.snp.makeConstraints { make in
            make.centerY.equalTo(giveUpButton.snp.centerY).offset(50)
            make.left.equalTo(giveUpButton.snp.left).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        let backwardsCountBackImageView = UIImageView(image: UIImage(named: "CheckersWorldCountBack"))
        backwardsCountBackImageView.contentMode = .scaleToFill
        backwardsButton.addSubview(backwardsCountBackImageView)
        backwardsCountBackImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.bottom.equalTo(backwardsButton.snp.bottom).offset(10)
            make.right.equalTo(backwardsButton.snp.right).offset(10)
        }
        
        let backwardsCountLabel = UILabel()
        let backwardsBoosterKey = "BackwardsBoosterCount"
        backwardsCountLabel.text = "\(UserDefaults.standard.integer(forKey: backwardsBoosterKey))"
        backwardsCountLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        backwardsCountLabel.textColor = .white
        backwardsCountLabel.textAlignment = .center
        backwardsCountBackImageView.addSubview(backwardsCountLabel)
        backwardsCountLabel.snp.makeConstraints { make in
            make.center.equalTo(backwardsCountBackImageView)
        }
        boosterCheckersWorldCountLabels[backwardsBoosterKey] = backwardsCountLabel
        
        let clueCountBackImageView = UIImageView(image: UIImage(named: "CheckersWorldCountBack"))
        clueCountBackImageView.contentMode = .scaleToFill
        clueButton.addSubview(clueCountBackImageView)
        clueCountBackImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.bottom.equalTo(clueButton.snp.bottom).offset(5)
            make.right.equalTo(clueButton.snp.right).offset(5)
        }
        
        let clueCountLabel = UILabel()
        let clueBoosterKey = "ClueBoosterCount"
        clueCountLabel.text = "\(UserDefaults.standard.integer(forKey: clueBoosterKey))"
        clueCountLabel.font = UIFont(name: "Joti One", size: 12) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        clueCountLabel.textColor = .white
        clueCountLabel.textAlignment = .center
        clueCountBackImageView.addSubview(clueCountLabel)
        clueCountLabel.snp.makeConstraints { make in
            make.center.equalTo(clueCountBackImageView)
        }
        boosterCheckersWorldCountLabels[clueBoosterKey] = clueCountLabel
        
        for row in 0..<8 {
            var buttonRow: [UIButton] = []
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.alignment = .fill
            rowStack.distribution = .fillEqually
            rowStack.spacing = 0
            buttonGridStack.addArrangedSubview(rowStack)
            
            for column in 0..<8 {
                let button = UIButton()
                let isLocked = (row + column) % 2 == 0
                let state: String
                
                if row < 3 && !isLocked {
                    state = selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"
                } else if row > 4 && !isLocked {
                    state = selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"
                } else if isLocked {
                    state = selectedImageSet["WhiteCell"] ?? "CheckersWorldWhiteCell"
                    button.isEnabled = false
                } else {
                    state = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
                }
                updateButtonState(button: button, state: state, row: row, column: column)
                button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
                CheckersWorldAddSound(to: button)
                rowStack.addArrangedSubview(button)
                buttonRow.append(button)
            }
            buttonGrid.append(buttonRow)
        }
        blackCountLabel = UILabel()
        whiteCountLabel = UILabel()
        
        let CheckersWorldDescEnemyImageView = UIImageView(image: UIImage(named: "CheckersWorldEnemy"))
        CheckersWorldDescEnemyImageView.contentMode = .scaleToFill
        CheckersWorldDescEnemyImageView.isUserInteractionEnabled = true
        view.addSubview(CheckersWorldDescEnemyImageView)
        CheckersWorldDescEnemyImageView.snp.makeConstraints { make in
            make.top.equalTo(CheckersWorldDescImageView.snp.top)
            make.right.equalTo(CheckersWorldDescImageView.snp.left).offset(-20)
            make.width.equalTo(225)
            make.height.equalTo(75)
        }

        let CheckersWorldDescYouImageView = UIImageView(image: UIImage(named: "CheckersWorldYou"))
        CheckersWorldDescYouImageView.contentMode = .scaleToFill
        CheckersWorldDescYouImageView.isUserInteractionEnabled = true
        view.addSubview(CheckersWorldDescYouImageView)
        CheckersWorldDescYouImageView.snp.makeConstraints { make in
            make.bottom.equalTo(CheckersWorldDescImageView.snp.bottom)
            make.right.equalTo(CheckersWorldDescImageView.snp.left).offset(-20)
            make.width.equalTo(225)
            make.height.equalTo(75)
        }

        for index in 0..<12 {
            let blackPieceImageView = UIImageView(image: UIImage(named: selectedImageSet["BlackPiece"] ?? "CheckersWorldBlack"))
            blackPieceImageView.contentMode = .scaleToFill
            blackPieceImageView.layer.zPosition = CGFloat(2 + index)
            CheckersWorldDescYouImageView.addSubview(blackPieceImageView)
            blackPieceImageView.snp.makeConstraints { make in
                make.width.height.equalTo(25)
                make.left.equalTo(CheckersWorldDescYouImageView.snp.left).offset(35 + (index * 15))
                make.centerY.equalToSuperview()
            }
        }

        blackCountLabel = UILabel()
        blackCountLabel.text = "x\(calculatePieceCount(for: selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"))"
        blackCountLabel.font = UIFont(name: "Joti One", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        blackCountLabel.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        CheckersWorldDescYouImageView.addSubview(blackCountLabel)
        blackCountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        let whiteCountStackView = UIStackView()
        whiteCountStackView.axis = .horizontal
        whiteCountStackView.alignment = .center
        whiteCountStackView.spacing = -5
        CheckersWorldDescYouImageView.addSubview(whiteCountStackView)
        whiteCountStackView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }

        whiteCountLabel = UILabel()
        whiteCountLabel.text = "x\(calculatePieceCount(for: selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"))"
        whiteCountLabel.font = UIFont(name: "Joti One", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        whiteCountLabel.textColor = UIColor(red: 1.0, green: 0.93, blue: 0.69, alpha: 1.0)
        CheckersWorldDescEnemyImageView.addSubview(whiteCountLabel)
        whiteCountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        for index in 0..<12 {
            let whitePieceImageView = UIImageView(image: UIImage(named: selectedImageSet["WhitePiece"] ?? "CheckersWorldWhite"))
            whitePieceImageView.contentMode = .scaleToFill
            whitePieceImageView.layer.zPosition = CGFloat(2 + index)
            CheckersWorldDescEnemyImageView.addSubview(whitePieceImageView)
            whitePieceImageView.snp.makeConstraints { make in
                make.width.height.equalTo(25)
                make.left.equalTo(CheckersWorldDescEnemyImageView.snp.left).offset(35 + (index * 15))
                make.centerY.equalToSuperview()
            }
        }

        blackCountLabel.text = "x\(calculatePieceCount(for: selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"))"
        whiteCountLabel.text = "x\(calculatePieceCount(for: selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"))"

    }
    
    @objc func handleButtonTap(_ sender: UIButton) {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        guard let row = buttonGrid.firstIndex(where: { $0.contains(sender) }),
              let column = buttonGrid[row].firstIndex(of: sender) else { return }
        
        let currentState = boardStates[row][column]
        
        switch currentState {
        case selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite",
            selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine":
            handlePlayerSelection(row: row, column: column)
        case selectedImageSet["GreenCell"] ?? "CheckersWorldGreenCell",
            selectedImageSet["GreenCellWhite"] ?? "CheckersWorldGreenCellWhite":
            handleMoveToHighlightedCell(row: row, column: column)
        default:
            return
        }
    }
    
    func handlePlayerSelection(row: Int, column: Int) {
        resetHighlightedMoves()
        selectedRow = row
        selectedColumn = column
        highlightValidMoves(row: row, column: column)
    }
    
    func handleMoveToHighlightedCell(row: Int, column: Int) {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        guard let fromRow = selectedRow, let fromColumn = selectedColumn else { return }
        
        if row == fromRow && column == fromColumn {
            return
        }
        
        if abs(fromRow - row) == 2 && abs(fromColumn - column) == 2 {
            let middleRow = (fromRow + row) / 2
            let middleColumn = (fromColumn + column) / 2
            
            if boardStates[middleRow][middleColumn] == (selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack") ||
                boardStates[middleRow][middleColumn] == (selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine") {
                boardStates[middleRow][middleColumn] = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
                updateButtonState(button: buttonGrid[middleRow][middleColumn], state: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell", row: middleRow, column: middleColumn)
            } else {
                return
            }
        }
        
        moveSelectedPiece(toRow: row, toColumn: column, fromRow: fromRow, fromColumn: fromColumn)
    }
    
    func moveSelectedPiece(toRow targetRow: Int, toColumn targetColumn: Int, fromRow row: Int, fromColumn column: Int) {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        saveCurrentBoardState()
        resetHighlightedMoves()
        
        let sourceButton = buttonGrid[row][column]
        let targetButton = buttonGrid[targetRow][targetColumn]
        
        if targetRow == 0 && boardStates[row][column] == (selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite") {
            boardStates[targetRow][targetColumn] = selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine"
            updateButtonState(button: targetButton, state: selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine", row: targetRow, column: targetColumn)
        } else if targetRow == 7 && boardStates[row][column] == (selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack") {
            boardStates[targetRow][targetColumn] = selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine"
            updateButtonState(button: targetButton, state: selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine", row: targetRow, column: targetColumn)
        } else {
            boardStates[targetRow][targetColumn] = boardStates[row][column]
            updateButtonState(button: targetButton, state: boardStates[row][column], row: targetRow, column: targetColumn)
        }
        
        boardStates[row][column] = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
        updateButtonState(button: sourceButton, state: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell", row: row, column: column)
        
        selectedButton = nil
        selectedRow = nil
        selectedColumn = nil
        
        func calculatePieceCount(for pieceType: String) -> Int {
            var count = 0
            for row in boardStates {
                for cell in row {
                    if cell == pieceType || cell == (selectedImageSet["\(pieceType)Quine"] ?? "\(pieceType)Quine") {
                        count += 1
                    }
                }
            }
            return count
        }
        blackCountLabel.text = "x\(calculatePieceCount(for: selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"))"
        whiteCountLabel.text = "x\(calculatePieceCount(for: selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"))"
        moveRandomBlackPiece()
    }
    
    func moveRandomBlackPiece() {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        for row in (0..<8).reversed() {
            for column in 0..<8 {
                if boardStates[row][column] == (selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack") {
                    let captureMoves = [
                        ((row + 1, column + 1), (row + 2, column + 2)),
                        ((row + 1, column - 1), (row + 2, column - 2))
                    ]
                    
                    for move in captureMoves {
                        let middleRow = move.0.0
                        let middleColumn = move.0.1
                        let targetRow = move.1.0
                        let targetColumn = move.1.1
                        
                        guard targetRow < 8, targetColumn >= 0, targetColumn < 8, middleRow < 8, middleColumn >= 0, middleColumn < 8 else { continue }
                        
                        if boardStates[middleRow][middleColumn] == (selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"),
                           boardStates[targetRow][targetColumn] == (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell") {
                            boardStates[row][column] = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
                            boardStates[middleRow][middleColumn] = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
                            boardStates[targetRow][targetColumn] = selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"
                            
                            let sourceButton = buttonGrid[row][column]
                            let middleButton = buttonGrid[middleRow][middleColumn]
                            let targetButton = buttonGrid[targetRow][targetColumn]
                            
                            updateButtonState(button: sourceButton, state: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell", row: row, column: column)
                            updateButtonState(button: middleButton, state: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell", row: middleRow, column: middleColumn)
                            updateButtonState(button: targetButton, state: selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack", row: targetRow, column: targetColumn)
                            
                            return
                        }
                    }
                    
                    let standardMoves = [
                        (row + 1, column + 1),
                        (row + 1, column - 1)
                    ]
                    
                    for move in standardMoves {
                        let targetRow = move.0
                        let targetColumn = move.1
                        
                        guard targetRow < 8, targetColumn >= 0, targetColumn < 8 else { continue }
                        
                        if boardStates[targetRow][targetColumn] == (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell") {
                            if targetRow == 7 {
                                boardStates[targetRow][targetColumn] = selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine"
                                let targetButton = buttonGrid[targetRow][targetColumn]
                                updateButtonState(button: targetButton, state: selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine", row: targetRow, column: targetColumn)
                            } else {
                                boardStates[targetRow][targetColumn] = selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"
                                let targetButton = buttonGrid[targetRow][targetColumn]
                                updateButtonState(button: targetButton, state: selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack", row: targetRow, column: targetColumn)
                            }
                            
                            boardStates[row][column] = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
                            let sourceButton = buttonGrid[row][column]
                            updateButtonState(button: sourceButton, state: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell", row: row, column: column)
                            
                            return
                        }
                    }
                }
            }
        }

        func calculatePieceCount(for pieceType: String) -> Int {
            var count = 0
            for row in boardStates {
                for cell in row {
                    if cell == pieceType || cell == "\(pieceType)Quine" {
                        count += 1
                    }
                }
            }
            return count
        }
        checkEndGame()
    
        blackCountLabel.text = "x\(calculatePieceCount(for: "CheckersWorldRedCellBlack"))"
        whiteCountLabel.text = "x\(calculatePieceCount(for: "CheckersWorldRedCellWhite"))"
    }

    func resetHighlightedMoves() {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        for row in 0..<8 {
            for column in 0..<8 {
                switch boardStates[row][column] {
                case selectedImageSet["GreenCell"] ?? "CheckersWorldGreenCell":
                    boardStates[row][column] = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
                    updateButtonState(button: buttonGrid[row][column], state: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell", row: row, column: column)
                case selectedImageSet["GreenCellWhite"] ?? "CheckersWorldGreenCellWhite":
                    boardStates[row][column] = selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"
                    updateButtonState(button: buttonGrid[row][column], state: selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite", row: row, column: column)
                case selectedImageSet["GreenCellQuine"] ?? "CheckersWorldGreenCellQuine":
                    if let selectedRow = selectedRow, let selectedColumn = selectedColumn {
                        if boardStates[selectedRow][selectedColumn] == selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine" {
                            boardStates[selectedRow][selectedColumn] = selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine"
                            updateButtonState(button: buttonGrid[selectedRow][selectedColumn], state: selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine", row: selectedRow, column: selectedColumn)
                        }
                    }
                default:
                    break
                }
            }
        }
    }

    func highlightValidMoves(row: Int, column: Int) {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        if boardStates[row][column] == (selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine") ||
           boardStates[row][column] == (selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine") {
            let directions = [(-1, -1), (-1, 1), (1, -1), (1, 1)]

            for direction in directions {
                var nextRow = row + direction.0
                var nextColumn = column + direction.1

                while nextRow >= 0, nextRow < 8, nextColumn >= 0, nextColumn < 8 {
                    if boardStates[nextRow][nextColumn] == (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell") {
                        updateButtonState(button: buttonGrid[nextRow][nextColumn], state: selectedImageSet["GreenCell"] ?? "CheckersWorldGreenCell", row: nextRow, column: nextColumn)
                    } else if boardStates[nextRow][nextColumn] == (selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack") ||
                              boardStates[nextRow][nextColumn] == (selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine") {
                        let captureRow = nextRow + direction.0
                        let captureColumn = nextColumn + direction.1

                        if captureRow >= 0, captureRow < 8, captureColumn >= 0, captureColumn < 8, boardStates[captureRow][captureColumn] == (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell") {
                            updateButtonState(button: buttonGrid[captureRow][captureColumn], state: selectedImageSet["GreenCell"] ?? "CheckersWorldGreenCell", row: captureRow, column: captureColumn)
                        }
                        break
                    } else {
                        break
                    }

                    nextRow += direction.0
                    nextColumn += direction.1
                }
            }
        } else if boardStates[row][column] == (selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite") {
            let directions = [(-1, -1), (-1, 1)]
            for direction in directions {
                let targetRow = row + direction.0
                let targetColumn = column + direction.1

                if targetRow >= 0, targetRow < 8, targetColumn >= 0, targetColumn < 8 {
                    if boardStates[targetRow][targetColumn] == (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell") {
                        updateButtonState(button: buttonGrid[targetRow][targetColumn], state: selectedImageSet["GreenCell"] ?? "CheckersWorldGreenCell", row: targetRow, column: targetColumn)
                    }
                }

                let jumpRow = row + direction.0 * 2
                let jumpColumn = column + direction.1 * 2
                let middleRow = row + direction.0
                let middleColumn = column + direction.1

                if jumpRow >= 0, jumpRow < 8, jumpColumn >= 0, jumpColumn < 8 {
                    if boardStates[middleRow][middleColumn] == (selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack") ||
                       boardStates[middleRow][middleColumn] == (selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine"),
                       boardStates[jumpRow][jumpColumn] == (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell") {
                        updateButtonState(button: buttonGrid[jumpRow][jumpColumn], state: selectedImageSet["GreenCell"] ?? "CheckersWorldGreenCell", row: jumpRow, column: jumpColumn)
                    }
                }
            }
        }
    }

    func updateButtonState(button: UIButton, state: String, row: Int, column: Int) {
        boardStates[row][column] = state
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        switch state {
        case selectedImageSet["RedCell"] ?? "CheckersWorldRedCell":
            button.setImage(UIImage(named: selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"), for: .normal)
        case selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite":
            button.setImage(UIImage(named: selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"), for: .normal)
        case selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine":
            button.setImage(UIImage(named: selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine"), for: .normal)
        case selectedImageSet["GreenCell"] ?? "CheckersWorldGreenCell":
            button.setImage(UIImage(named: selectedImageSet["GreenCell"] ?? "CheckersWorldGreenCell"), for: .normal)
        case selectedImageSet["GreenCellWhite"] ?? "CheckersWorldGreenCellWhite":
            button.setImage(UIImage(named: selectedImageSet["GreenCellWhite"] ?? "CheckersWorldGreenCellWhite"), for: .normal)
        case selectedImageSet["GreenCellQuine"] ?? "CheckersWorldGreenCellQuine":
            button.setImage(UIImage(named: selectedImageSet["GreenCellQuine"] ?? "CheckersWorldGreenCellQuine"), for: .normal)
        case selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack":
            button.setImage(UIImage(named: selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"), for: .normal)
        case selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine":
            button.setImage(UIImage(named: selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine"), for: .normal)
            self.showGameResult(result: "lose")
        case selectedImageSet["WhiteCell"] ?? "CheckersWorldWhiteCell":
            button.setImage(UIImage(named: selectedImageSet["WhiteCell"] ?? "CheckersWorldWhiteCell"), for: .normal)
            button.setImage(UIImage(named: selectedImageSet["WhiteCell"] ?? "CheckersWorldWhiteCell"), for: .disabled)
        default:
            break
        }
    }
    
    @objc func CheckersWorldBackTapped() { 
        let helpViewController = CheckersWorldHomeViewController()
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }

    func restartGame() {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        for row in 0..<8 {
            for column in 0..<8 {
                if (row + column) % 2 != 0 {
                    if row < 3 {
                        boardStates[row][column] = selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"
                    } else if row > 4 {
                        boardStates[row][column] = selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"
                    } else {
                        boardStates[row][column] = selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"
                    }
                } else {
                    boardStates[row][column] = ""
                }
                updateButtonState(button: buttonGrid[row][column], state: boardStates[row][column], row: row, column: column)
            }
        }
        selectedRow = nil
        selectedColumn = nil

        func calculatePieceCount(for pieceType: String) -> Int {
            var count = 0
            for row in boardStates {
                for cell in row {
                    if cell == pieceType || cell == (selectedImageSet["\(pieceType)Quine"] ?? "\(pieceType)Quine") {
                        count += 1
                    }
                }
            }
            checkEndGame()
            return count
        }

        blackCountLabel.text = "x\(calculatePieceCount(for: selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack"))"
        whiteCountLabel.text = "x\(calculatePieceCount(for: selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite"))"
    }

    func checkEndGame() {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        var whiteCount = 0
        var blackCount = 0
        var hasWhiteValidMove = false
        var hasBlackValidMove = false

        for row in 0..<8 {
            for column in 0..<8 {
                if boardStates[row][column] == (selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite") ||
                   boardStates[row][column] == (selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine") {
                    whiteCount += 1
                    if canPieceMove(row: row, column: column) {
                        hasWhiteValidMove = true
                    }
                } else if boardStates[row][column] == (selectedImageSet["RedCellBlack"] ?? "CheckersWorldRedCellBlack") ||
                          boardStates[row][column] == (selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine") {
                    blackCount += 1
                    if canPieceMove(row: row, column: column) {
                        hasBlackValidMove = true
                    }
                }
            }
        }

        if blackCount <= 0 {
            showGameResult(result: "win")
        } else if whiteCount <= 0 {
            showGameResult(result: "lose")
        } else if !hasBlackValidMove {
            showGameResult(result: "win")
        } else if !hasWhiteValidMove && !hasBlackValidMove {
            showGameResult(result: "draw")
        }
    }

    func canPieceMove(row: Int, column: Int) -> Bool {
        let selectedImageSet: [String: String] = imageSets[shopselected] ?? [:]
        let directions: [(Int, Int)] = boardStates[row][column] == (selectedImageSet["RedCellWhiteQuine"] ?? "CheckersWorldRedCellWhiteQuine") ||
                                       boardStates[row][column] == (selectedImageSet["RedCellBlackQuine"] ?? "CheckersWorldRedCellBlackQuine")
            ? [(1, -1), (1, 1)]
            : boardStates[row][column] == (selectedImageSet["RedCellWhite"] ?? "CheckersWorldRedCellWhite")
            ? [(-1, -1), (-1, 1)]
            : [(1, -1), (1, 1)]

        for direction in directions {
            let targetRow = row + direction.0
            let targetColumn = column + direction.1
            if targetRow >= 0, targetRow < 8, targetColumn >= 0, targetColumn < 8 {
                if boardStates[targetRow][targetColumn] == (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell") {
                    return true
                }
            }

            let jumpRow = row + direction.0 * 2
            let jumpColumn = column + direction.1 * 2
            let middleRow = row + direction.0
            let middleColumn = column + direction.1

            if jumpRow >= 0, jumpRow < 8, jumpColumn >= 0, jumpColumn < 8,
               boardStates[middleRow][middleColumn] != (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell"),
               boardStates[middleRow][middleColumn] != "",
               boardStates[jumpRow][jumpColumn] == (selectedImageSet["RedCell"] ?? "CheckersWorldRedCell") {
                return true
            }
        }

        return false
    }

    func showGameResult(result: String) {
        let helpViewController = CheckersWorldEndViewController()
        helpViewController.gameResult = result
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }

    
    @objc func handleGiveUp() {
        let helpViewController = CheckersWorldEndViewController()
        helpViewController.gameResult = "lose"
        self.navigationController?.setViewControllers([helpViewController], animated: true)
    }

    @objc func handleReset() {
        restartGame()
    }
    
    var boosterCheckersWorldCountLabels: [String: UILabel] = [:]
    var previousBoardState: [[String]] = []
    var previousSelectedState: (row: Int?, column: Int?) = (nil, nil)
    func saveCurrentBoardState() {
        previousBoardState = boardStates.map { $0 }
        previousSelectedState = (selectedRow, selectedColumn)
    }

    
    @objc func handleBackwards() {
        let boosterKey = "BackwardsBoosterCount"
        var currentCount = UserDefaults.standard.integer(forKey: boosterKey)
        if currentCount > 0 {
            currentCount -= 1
            UserDefaults.standard.set(currentCount, forKey: boosterKey)
            boosterCheckersWorldCountLabels[boosterKey]?.text = "\(currentCount)"
            restorePreviousBoardState()
        }
    }
    
    func restorePreviousBoardState() {
        if previousBoardState.isEmpty {
            return
        }

        for row in 0..<8 {
            for column in 0..<8 {
                boardStates[row][column] = previousBoardState[row][column]
                updateButtonState(button: buttonGrid[row][column], state: boardStates[row][column], row: row, column: column)
            }
        }

        selectedRow = previousSelectedState.row
        selectedColumn = previousSelectedState.column
    }

    @objc func handleClue() {
        let boosterKey = "ClueBoosterCount"
        var currentCount = UserDefaults.standard.integer(forKey: boosterKey)

        if currentCount > 0 {
            currentCount -= 1
            UserDefaults.standard.set(currentCount, forKey: boosterKey)
            boosterCheckersWorldCountLabels[boosterKey]?.text = "\(currentCount)"
            highlightFirstWhitePiece()
        }
    }

    func highlightFirstWhitePiece() {
        for row in 0..<8 {
            for column in 0..<8 {
                if boardStates[row][column] == "CheckersWorldRedCellWhite" || boardStates[row][column] == "CheckersWorldRedCellWhiteQuine" {
                    resetHighlightedMoves()
                    highlightValidMoves(row: row, column: column)
                    return
                }
            }
        }
    }


}
