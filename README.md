# Card Game App

## Step. 1
- Keywords
	- margin, frame, bounds, UIScreen, status bar
	- NSDirectionalEdgeInsets
		- iOS11 버전부터 지원하는 프로퍼티로 ViewController의 root view는 모두 0으로 되어있지만, UIView를 포함한 대부분의 뷰를 생성해보면 default 값으로 8임을 알 수 있다.
		- For the root view of a view controller, the default value of this property reflects the system minimum margins and safe area insets.
		- 이 값은 직접 설정할 수 있다.
		- preservesSuperviewLayoutMargins` 프로퍼티를 true를  할 경우 이 값들은 더 커질 수 있다.
- [Layout Guide, Margins, Insets and Safe Area demystified on iOS 10 & 11](https://blog.smartnsoft.com/layout-guide-margins-insets-and-safe-area-demystified-on-ios-10-11-d6e7246d7cb8)
- [directionalLayoutMargins](https://developer.apple.com/documentation/uikit/uiview/2865930-directionallayoutmargins)

## Step. 2

<img src="images/demo_step2.png" width="50%">

- [swift random unification](https://github.com/apple/swift-evolution/blob/master/proposals/0202-random-unification.md)

## Step. 3
- 객체설명
- Model
	- CardGame: 모든 모델의 최상위 모델
	- Card: 카드를 나타내기 위한 객체
	- CardDeck: 여러장의 카드를 나타내기 위한 객체 (처음 52장의 카드를 모아두는 카드덱)
	- CardStack: 필드에 놓여져있는 카드스택 하나
	- CardStackContainer: 7개의 카드스택을 관리하는 객체
	- WastePile: 카드덱에서 제거됐지만 아직 카드스택이나 Foundation에 속하지 않은 카드들을 모아두는 객체
- View( - ViewModel: 각 뷰의 1:1 뷰모델)
	- CardGameView: 카드게임 전체의 뷰. 최상위 뷰
	- CardView: 카드 하나를 나타나내는 뷰
	- CardStackView: 카드스택을 나타내기 위한 뷰
	- CardStackContainerView: CardStackView들을 담고 있는 뷰
	- CardDeckView: 카드덱에 있는 카드뷰들을 관리하는 뷰(카드뷰가 처음 생성되는 곳)
	- WastePileView: 카드덱뷰에서 open된 카드뷰들이 놓여지는 뷰
	- EmptyLayerView: 카드가 놓일자리의 테두리를 그리기 위한 뷰
	
- View > ViewModel > Model 방향으로의 이벤트는 항상 cardGameView > CardGameViewModel > CardGame(Model)로 전달되며 CardGame이 이벤트에 따라 필요한 모델에 변화를 준다.
- Model > ViewModel > View는 모두 NotificationCenter를 이용하며 일관성을 위해 위와 마찬가지로 최상위 객체들을 통해만 전달된다.
	- Model의 변화를 주고, CardGame이 Notificiation을 주고 CardGameViewModel이 받는다.
	- CardGameViewModel이 CardGameView에 Notification을 준다.

	<img src="images/demo_step3.gif" width="50%">
	
## Step. 4

<img src="images/demo_step4.gif" width="50%">


- keyword: Animation, Coordinate, Converting UIView Coordinate, Superview-Subview relationship, Ownership