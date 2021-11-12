import UIKit

class PokemonListViewController: UITableViewController, UISearchBarDelegate {
    
    var urlStr = "https://pokeapi.co/api/v2/pokemon?limit=50"
    var fetchingMore = false
    var pokemon: [PokemonListResult] = []
    var matchData: [PokemonListResult] = []
    @IBOutlet var searchBar: UISearchBar!
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        fetchData()
    }
    
    func fetchData() {
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let entries = try JSONDecoder().decode(PokemonListResults.self, from: data)
                self.pokemon.append(contentsOf: entries.results)
                self.urlStr = entries.next
                
                DispatchQueue.main.async {
                    self.fetchingMore = false
                    self.tableView.reloadData()
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let filterText = searchBar.text else {
            matchData = pokemon
            return matchData.count
        }
        
        if !filterText.isEmpty {
            matchData = pokemon.filter {
                $0.name.contains(filterText.lowercased())
            }
        } else {
            matchData = pokemon
        }
        
        return matchData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = capitalize(text: matchData[indexPath.row].name)
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height && !fetchingMore {
            fetchingMore = true
            fetchData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonSegue",
                let destination = segue.destination as? PokemonViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            destination.url = matchData[index].url
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
}
