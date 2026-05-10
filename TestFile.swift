import Foundation

class DetailViewController: UIViewController {
    var completionHandler: (() -> Void)?
    var name: String?

    func setup() {
        completionHandler = {
            print(self.name!)
        }
        let upperName = name!.uppercased()
        print(upperName)
    }
}
