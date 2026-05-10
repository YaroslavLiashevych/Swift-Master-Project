import Foundation

class DetailViewController: UIViewController {
    var completionHandler: (() -> Void)?
    var name2: String?

    func setup() {
        completionHandler = {
            print(self.name2!)
        }
        let upperName = name2!.uppercased()
        print(upperName)
    }
}
// triggering ai review
