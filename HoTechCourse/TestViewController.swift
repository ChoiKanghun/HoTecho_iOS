import UIKit

extension JustViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.testTableView.dequeueReusableCell(withIdentifier: "testTableViewCell")
        else {return UITableViewCell()}
        
        cell.backgroundColor = .gray
        
        return cell
    }
}
