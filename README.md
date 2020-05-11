# photojournalApp
A small app that utilizes Combine to replace existing Swift design patterns.
To run this project you will need to install CocoaPods.

## Main screen
The main screen is a collection view showing a simple image and a caption where users can create new entries, or edit and delete existing ones.

<img src="https://github.com/ahadislam1/photojournalApp/blob/master/mainScreen.png" width="300" align ="center">

## Create/Edit screen
The create/edit screen reuses the same UI elements but either updates existing entries or creates new ones depending on where the user is coming from.

<img src="https://github.com/ahadislam1/photojournalApp/blob/master/createScreen.png" width="300" align ="left">
<img src="https://github.com/ahadislam1/photojournalApp/blob/master/EditScreen.png" width="300">

---

## Implementing Combine
With Combine we have a chance to revisit existing APIs and design patterns.  For example one way we can communicate between a collection view cell and a controller was to do something like this:

```swift
protocol CollectionViewCellDelegate {
    func cellWasSelected()
}

class CollectionViewCell: UICollectionViewCell {
    weak var delegate: CollectionViewCellDelegate?
    
    // somewhere the delegate is called
}
```

However we can use basic publishers and subscribers to send data to where the cells are being called:
```swift
class JournalViewCell: UICollectionViewCell {
    public var cellPublisher: AnyPublisher<JournalViewCell, Never> {
        return cellSubject.eraseToAnyPublisher()
    }
    
    private let cellSubject = PassthroughSubject<JournalViewCell, Never>()
    
    @objc
    private func buttonPressed() {
        
        cellSubject.send(self)
    }
}

class ViewController: CombineViewController {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // ... creating cell
        cell.cellPublisher
            .sink(receiveValue: didPressCellButton(_:))
            .store(in: &subscriptions)
        return cell
    }

}
```

Instead of using a delegate, we subscribe to any information that publisher might send when we press on the more button on each cell.

Another example is handling UI events, in the create view controller we can handle edge casing 

```swift
class CreateViewController: CombineViewController {
    private lazy var imageView: UIImageView
    private lazy var textField: UITextField
    
    private let hasImageSubject = PassthroughSubject<Bool, Never>()
    private let hasTextSubject = PassthroughSubject<Bool, Never>()

    //...
    
    private func updateUI() {
        if page == nil {
            hasImageSubject
                .combineLatest(hasTextSubject)
                .map { $0 && $1 }
                .assign(to: \.isEnabled, on: barButton)
                .store(in: &subscriptions)
        } else {
            hasImageSubject
                .merge(with: hasTextSubject)
                .assign(to: \.isEnabled, on: barButton)
                .store(in: &subscriptions)
        }
    }
}
```

While there's still edge cases that need to be resolved, we can essentially subscribe to the state of each UIView, whether the textfield contains any text, or the image contains an image.  Anytime something changes between the two we change the state of the bar button; which replaces having helper functions that validate each time something happens.
