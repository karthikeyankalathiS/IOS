import UIKit

class KeyboardViewController: UIInputViewController {

    var letterButtons = [UIButton]()
    var isUpperCase = false
    var isNumeric = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardView = UIView()
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardView)
        view.heightAnchor.constraint(equalToConstant: 160).isActive = true

        NSLayoutConstraint.activate([
            keyboardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let letters = "abcdefghijklmnopqrst◄⇧uvwxyz⌫►"
        let numbers = "1234567890-/:;()₹&@<⌫>"

        let buttonWidth = 30
        let buttonHeight = 30
        let spacing = 10
        let rowCount = 4
        let colCount = 10

        for row in 0..<rowCount {
            for col in 0..<colCount {
                let index = row * colCount + col
                if index < letters.count {
                    let letterIndex = letters.index(letters.startIndex, offsetBy: index)
                    let letter = letters[letterIndex]

                    let button = UIButton(type: .system)
                    button.backgroundColor = UIColor.white
                    button.setTitle(String(letter), for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                    button.layer.cornerRadius = 5
                    button.clipsToBounds = true
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)

                    let x = col * (buttonWidth + spacing)
                    var y = row * (buttonHeight + spacing)

                    if row == rowCount - 1 {
                        y = (rowCount - 1) * (buttonHeight + spacing)
                    }

                    let frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
                    button.frame = frame
                    keyboardView.addSubview(button)
                    letterButtons.append(button)
                }
            }
        }

        let spaceButton = UIButton(type: .system)
        spaceButton.backgroundColor = UIColor.white
        spaceButton.setTitle(" ", for: .normal)
        spaceButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        spaceButton.layer.cornerRadius = 5
        spaceButton.clipsToBounds = true
        spaceButton.translatesAutoresizingMaskIntoConstraints = false
        spaceButton.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(spaceButtonDoubleTapped(_:)))
                doubleTapGesture.numberOfTapsRequired = 2
                spaceButton.addGestureRecognizer(doubleTapGesture)
        let x = 0
        let y = (rowCount - 1) * (buttonHeight + spacing)
        let frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
        spaceButton.frame = frame
        keyboardView.addSubview(spaceButton)
        letterButtons.append(spaceButton)

        NSLayoutConstraint.activate([
            spaceButton.centerXAnchor.constraint(equalTo: keyboardView.centerXAnchor),
            spaceButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonWidth)),
            spaceButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
            spaceButton.topAnchor.constraint(equalTo: keyboardView.topAnchor, constant: CGFloat(frame.origin.y)),
        ])

        for button in letterButtons {
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: CGFloat(buttonWidth)),
                button.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
                button.topAnchor.constraint(equalTo: keyboardView.topAnchor, constant: CGFloat(button.frame.origin.y)),
                button.leadingAnchor.constraint(equalTo: keyboardView.leadingAnchor, constant: CGFloat(button.frame.origin.x)),
            ])
        }
    }

    @objc func letterButtonTapped(_ sender: UIButton) {
        if let letter = sender.title(for: .normal) {
            switch letter {
            case "⌫":
                textDocumentProxy.deleteBackward()
            case "►":
                textDocumentProxy.adjustTextPosition(byCharacterOffset: 1)
            case "◄":
                textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
            case "⇧":
                isUpperCase = !isUpperCase
                updateLetterButtonCase()
            default:
                let letterToAdd = isUpperCase ? letter.uppercased() : letter.lowercased()
                textDocumentProxy.insertText(letterToAdd)
            }
        }
    }
    
    @objc func spaceButtonTapped(_ sender: UIButton) {
            textDocumentProxy.insertText(" ")
        }

    @objc func spaceButtonDoubleTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .recognized {
            isNumeric = !isNumeric
            numericButton()
        }
    }
    
    func numericButton() {
        let numericLayout = "1234567890+-*/()₹&@.◄,?!`':;⌫►"
        let alphabeticLayout = "abcdefghijklmnopqrst◄⇧uvwxyz⌫►"

        for (index, button) in letterButtons.enumerated() {
            if index < numericLayout.count {
                if isNumeric {
                    let numericIndex = numericLayout.index(numericLayout.startIndex, offsetBy: index)
                    let numericCharacter = numericLayout[numericIndex]
                    button.setTitle(String(numericCharacter), for: .normal)
                } else {
                    let alphabeticIndex = alphabeticLayout.index(alphabeticLayout.startIndex, offsetBy: index)
                    let alphabeticCharacter = alphabeticLayout[alphabeticIndex]
                    let updatedTitle = isUpperCase ? alphabeticCharacter.uppercased() : alphabeticCharacter.lowercased()
                    button.setTitle(String(updatedTitle), for: .normal)
                }
            }
        }
    }


    func updateLetterButtonCase() {
        for button in letterButtons {
            if let currentTitle = button.title(for: .normal) {
                let updatedTitle = isUpperCase ? currentTitle.uppercased() : currentTitle.lowercased()
                button.setTitle(updatedTitle, for: .normal)
            }
        }
    }
}
