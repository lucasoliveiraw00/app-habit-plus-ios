//
//  ImageView.swift
//  HabitPlus
//
//  Created by Lucas De Oliveira Silva Firmino on 22/11/24.
//

import SwiftUI
import Combine

struct ImageView: View {
    @State private var image: UIImage = UIImage()
    @ObservedObject private var imageLoader = ImageLoader()
    
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .onReceive(imageLoader.$data) { data in
                if let uiImage = UIImage(data: data) {
                    self.image = uiImage
                }
            }
            .onAppear {
                if image.cgImage == nil {
                    imageLoader.load(url: url)
                }
            }
    }
}

class ImageLoader: ObservableObject {
    @Published var data = Data()
    
    func load(url: String) {
        guard let url = URL(string: url) else {
            print("URL da imagem inválida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Erro ao carregar imagem: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Nenhum dado recebido.")
                return
            }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

#Preview {
    ImageView(url: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_150x54dp.png")
}
