# Calculator 프로젝트

## MVC 패턴

*   Model-View-Controller의 줄임말
*   객체지향 앱에 있는 모든 클래스를 역할별로 그룹을 나눔
*   Model
    *   프로그램이 하는 일 자체를 의미함
    *   UI와는 독립적인 역할을 함
*   View
    *   사용자와 상호작용하는 User Interface
    *   버튼이나 디스플레이같은 것들이 해당됨
    *   보통 버튼과 같이 일반화된 UI요소를 사용해 만들어짐
*   Controller
    *   Model과 View를 연결하는 역할을 함
    *   UI에서 어떤 이벤트를 감지하고 Model을 변동시키며, 다시 UI를 업데이트함
    *   인터페이스를 관장하는 역할

## 모듈

*   스위프트에서 클래스 여러개를 묶어 그룹으로 만든 것을 의미함
*   모듈의 한 종류인 UIKit은 모든 UI가 포함되어 있음

## `Main.storyboard`

*   MVC에서 View 역할을 하는 파일
*   앱을 시각적으로 보여주는 역할을 함

## Action

*   UI에 무슨 일이 생겼을 때 Controller 안에 있는 Method를 호출하도록 하는 것을 의미

## 초기값

*   스위프트에서 모든 속성들은 초기값을 가져야만 함
*   초기화 함수를 사용하는 방법
*   초기값을 주는 방법

## struct

*   enum처럼 값이 전달됨
    *   전달할때 값을 복사하여 전달함
    *   값 형식으로 복사하여 전달할때 모두가 복사되는 것이 아니고, 접근할 때만 복사함
    *   구조체는 
    *   cf) class는 참조가 전달됨
        *   heap메모리 어딘가에 있다가 메소드나 어딘가로 전달되면 pointer를 전달함

## 인상깊은 코드

### 열거형의 연관값을 활용

```swift
private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(Double.pi), // Double.pi,
        "e": Operation.Constant(M_E), // M_E,
        "√": Operation.UnaryOperation(sqrt), // sqrt,
        "cos": Operation.UnaryOperation(cos), // cos
        "±": Operation.UnaryOperation({ -$0 }),
        "×": Operation.BinaryOpertion({ $0 * $1}),
        "+": Operation.BinaryOpertion({ $0 + $1}),
        "−": Operation.BinaryOpertion({ $0 - $1}),
        "÷": Operation.BinaryOpertion({ $0 / $1}),
        "=": Operation.Equals
]

private enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> Double)
    case BinaryOpertion((Double, Double) -> Double)
    case Equals
}

func performOperation(symbol: String) {
    if let operation  = operations[symbol] {
        switch operation {
            case .Constant(let value):
            accumulator = value
            case .UnaryOperation(let function):
            accumulator = function(accumulator)
            case .BinaryOpertion(let function):
            excutePendingBinaryOperation()
            pending = pendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
            excutePendingBinaryOperation()
        }
    }
}
```



