import UIKit

class PokemonViewController: UIViewController {
    
    var url: String!
    private var favorite: Bool = false
    private var id: Int?
    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    @IBOutlet var favortieBtn: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionTextField: UITextView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nameLabel.text = ""
        numberLabel.text = ""
        type1Label.text = ""
        type2Label.text = ""

        loadPokemon()
        setFavoriteButton()
    }
    
    func loadPokemon() {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(PokemonResult.self, from: data)
                DispatchQueue.main.async { [unowned self] in
                    self.navigationItem.title = self.capitalize(text: result.name)
                    self.nameLabel.text = self.capitalize(text: result.name)
                    self.numberLabel.text = String(format: "#%03d", result.id)
                    self.id = result.id

                    for typeEntry in result.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                    
                    self.loadStatus()
                    self.setFavoriteButton()
                }
                
                
                if let url = result.sprites.front_default {
                    self.loadImage(urlStr: url)
                }
                
                if let url = result.species["url"] {
                    self.loadDescription(urlStr: url)
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    func loadImage(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        
        var image: UIImage?
        do {
            let data = try Data(contentsOf: url)
            image = UIImage(data: data)
        } catch let err {
            debugPrint(err)
        }
        
        if let img = image {
            DispatchQueue.main.async { [unowned self] in
                self.imageView.image = img
            }
        }
    }
    
    func loadDescription(urlStr: String) {
        URLSession.shared.dataTask(with: URL(string: urlStr)!) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(PokemonSpecies.self, from: data)
                
                for item in result.flavor_text_entries {
                    if item.language["name"] == "en" {
                        DispatchQueue.main.async { [unowned self] in
                            self.descriptionTextField.text = item.flavor_text
                        }
                        break
                    }
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    func loadStatus() {
        
        guard let num = id else {
            return
        }
        
        favorite = UserDefaults.standard.bool(forKey: "\(num)")
    }
    
    func saveStatus() {
        
        guard let num = id else {
            return
        }
        
        UserDefaults.standard.set(favorite, forKey: "\(num)")
    }
    
    func setFavoriteButton() {
        
        let title = favorite ? "Favorite" : "Not favorite"
        favortieBtn.setTitle(title, for: .normal)
    }
    
    @IBAction func toggleFavorite(sender: UIButton) {
        favorite = !favorite
        setFavoriteButton()
        saveStatus()
    }
}
