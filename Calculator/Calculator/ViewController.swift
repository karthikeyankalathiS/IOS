import UIKit

class ViewController: UIViewController {
    var firstnum: String = ""
    var secnum: String = ""
    var operation: String = ""
    var isresult: Bool = false
    var result: String = ""
    
    @IBOutlet var output: UILabel!
    @IBOutlet weak var Input: UILabel!
    
    @IBAction func clear(_ sender: Any) {
        resetCalculator()
    }
    
    @IBAction func backSpace(_ sender: Any) {
        backSpace()
    }
    
    @IBAction func dot(_ sender: Any) {
        handleDotInput()
    }
    
    @IBAction func modulus(_ sender: Any) {
        handleOperation("%")
    }
    
    @IBAction func multiplication(_ sender: Any) {
        handleOperation("*")
    }

    @IBAction func divide(_ sender: Any) {
        handleOperation("/")
    }

    @IBAction func add(_ sender: Any) {
        handleOperation("+")
    }

    @IBAction func sub(_ sender: Any) {
        handleOperation("-")
    }

    @IBAction func equal(_ sender: Any) {
        result = String(calculation())
        output.text = result
        firstnum = result
        secnum = ""
        isresult = true
    }

    @IBOutlet var Button: [UIButton]!

    @IBAction func Numaction(_ sender: Any) {
        handleNumericInput(sender as! UIButton)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        for button in Button {
            button.layer.cornerRadius = button.frame.size.height / 2
        }
    }

    func resetCalculator() {
        firstnum = ""
        secnum = ""
        operation = ""
        isresult = false
        result = ""
        output.text = ""
        Input.text = "0"
    }
    
    func handleOperation(_ op: String) {
        if !isresult {
            if operation.isEmpty {
                operation = op
            } else {
                result = String(calculation())
                firstnum = result
                secnum = ""
                operation = op
                output.text = result
            }
        } else {
            firstnum = result
            secnum = ""
            operation = op
            isresult = false
        }
    }
    
    func handleNumericInput(_ sender: UIButton) {
        let input = String(sender.tag)

        if operation.isEmpty {
            handleNumericInputForFirstNum(input)
        } else if !isresult {
            handleNumericInputForSecondNum(input)
        } else {
            resetCalculator()
            handleNumericInputForFirstNum(input)
        }
    }

    func handleDotInput() {
        if operation.isEmpty {
            if !firstnum.contains(".") {
                firstnum += "."
                Input.text = firstnum
            }
        } else if !isresult {
            if !secnum.contains(".") {
                secnum += "."
                Input.text = secnum
            }
        } else {
            resetCalculator()
            handleDotInput()
        }
    }

    func handleNumericInputForFirstNum(_ input: String) {
        if input == "." && !firstnum.contains(".") {
            firstnum += input
        } else if input != "." {
            firstnum += input
        }
        Input.text = firstnum
    }

    func handleNumericInputForSecondNum(_ input: String) {
        if input == "." && !secnum.contains(".") {
            secnum += input
        } else if input != "." {
            secnum += input
        }
        Input.text = secnum
    }
    
    func backSpace() {
        if operation.isEmpty {
            if !firstnum.isEmpty {
                firstnum.removeLast()
                Input.text = firstnum
            }
        } else {
            if !secnum.isEmpty {
                secnum.removeLast()
                Input.text = secnum
            } else {
                operation = ""
                Input.text = firstnum
            }
        }
    }


    func calculation() -> Double {
        switch operation {
        case "+":
            return addNumbers()
        case "-":
            return subtractNumbers()
        case "*":
            return multiplyNumbers()
        case "/":
            return divideNumbers()
        case "%":
            return modulusNumbers()
        default:
            return 0.0
        }
    }

    func handleCalculationError() {
        output.text = "Error"
    }

    func addNumbers() -> Double {
        guard let first = Double(firstnum), let second = Double(secnum) else {
            handleCalculationError()
            return 0.0
        }
        return first + second
    }

    func subtractNumbers() -> Double {
        guard let first = Double(firstnum), let second = Double(secnum) else {
            handleCalculationError()
            return 0.0
        }
        return first - second
    }

    func multiplyNumbers() -> Double {
        guard let first = Double(firstnum), let second = Double(secnum) else {
            handleCalculationError()
            return 0.0
        }
        return first * second
    }

    func divideNumbers() -> Double {
        guard let first = Double(firstnum), let second = Double(secnum), second != 0 else {
            handleCalculationError()
            return Double.nan
        }
        return first / second
    }
    
    func modulusNumbers() -> Double {
        guard let first = Double(firstnum), let second = Double(secnum), second != 0 else {
            handleCalculationError()
            return 0.0
        }
        return first / 100 * second
    }
}
