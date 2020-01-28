//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

class Pessoa {
    var nome: String
    var idade: Int
    
    init(nome: String, idade: Int) {
        self.nome = nome
        self.idade = idade
    }
}

protocol MyViewControllerManagerDelegate {
    func didUpdateNome()
    func didUpdateIdade()
}

class MyViewControllerManager {
    private weak var viewController: MyViewController?
    var delegate: MyViewControllerManagerDelegate?
    
    init(_ viewController: MyViewController) {
        self.viewController = viewController
        /* ARC
        * MyViewController 0xXPTO0001 References Count: 2
        */
    }
    
    func imprimePessoa() {
        if let viewController = viewController {
            print("\(viewController.pessoa.nome), \(viewController.pessoa.idade)")
        }
        
    }
    
    func getNome() -> String? {
        guard let viewController = viewController else {
            return nil
        }
        
        return viewController.pessoa.nome
    }
    
    func getIdade() -> Int? {
        guard let viewController = viewController else {
            return nil
        }
        
        return viewController.pessoa.idade
    }
    
    func alteraNome(novoNome: String) {
        if let viewController = viewController {
            viewController.pessoa.nome = novoNome
            delegate?.didUpdateNome()
        }
        
    }
    
    func alteraIdade(novaIdade: Int) {
        if let viewController = viewController {
            viewController.pessoa.idade = novaIdade
            delegate?.didUpdateIdade()
        }
    }    
}

/* ARC
 *
 */

class MyViewController {
    var pessoa: Pessoa = Pessoa(nome: "Pessoa Legal", idade: 25)
    lazy var manager: MyViewControllerManager = MyViewControllerManager(self)
    /* ARC
    * MyViewControllerManager 0xXPTO0002 References Count: 1
    */
    
    var nomeLabel: String = ""
    var idadeLabel: String = ""
    
    func viewDidLoad() {
        manager.delegate = self
    }
    
    func alteraIdade() {
        self.manager.alteraIdade(novaIdade: 30)
    }
    
    func imprime() {
        self.manager.imprimePessoa()
    }
}

extension MyViewController: MyViewControllerManagerDelegate {
    func didUpdateNome() {
        print("didUpdateNome")
    }
    
    func didUpdateIdade() {
        print("didUpdateIdade")
    }
}


var myViewController: MyViewController? = MyViewController()
/* ARC
* MyViewController 0xXPTO0000 References Count: 1
*/
myViewController?.viewDidLoad()
myViewController?.alteraIdade()
myViewController?.imprime()

myViewController = nil

//manager?.alteraIdade(novaIdade: 30)

/* ARC
 * 0xXPTO -> 1
 */

/* ARC
 * 0xXPTO -> 2
*/

//manager?.imprimePessoa()

//manager = nil

/* ARC
 * 0xXPTO -> 0
*/

//: [Next](@next)
