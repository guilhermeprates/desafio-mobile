# Comentários

## Bibliotecas usadas no projeto

### [SnapKit](https://github.com/SnapKit/SnapKit)

Motivações para uso do **SnapKit** no projeto:

- Reduz *boilerplate* ao criar *constraints* programaticamente.
- Facilita leitura e manutenção da interface em *view code*.

## App Flow

![App Flow](AppFlow.png)

## Feed (MVVM)

ViewController/View -> ViewModel -> FetchFeedPageUseCase

## Mapeamento do Response

Extrair os dados necessários e mapear para classes da **domain**.

```swift
import Foundation

struct FeedPageResponseDTO: Decodable {
  struct Falkor: Decodable {
    var items: [FeedItemDTO]
    var nextPage: Int
  }
  
  var oferta: String
  var falkor: Falkor
}

extension FeedResponseDTO {
  
  func toDomain() -> FeedPage {
    return FeedPage(
      items: self.falkor.items.map { $0.toDomain() },
      nextPage: self.falkor.nextPage,
      oferta: self.oferta
    )
  }
}

struct FeedItemDTO: Decodable {
  struct Content: Decodable {
    var title: String
    var summary: String?
    var chapeu: Chapeu
    var image: Image
  }

  struct Chapeu: Decodable {
    var label: String
  }
  
  struct Image: Decodable {
    var url: String
  }
  
  var type: String
  var content: Content
  var metadata: String
}

extension FeedItemDTO {
  
  func toDomain() -> FeedItem {
    return FeedItem(
      type: self.type,
      title: self.content.title,
      summary: self.content.summary,
      chapeu: self.content.chapeu.label,
      image: URL(string: self.content.image.url),
      metadata: self.metadata)
  }
}
```

## Notas

nonisolated em Swift indica que uma função, propriedade ou método não é isolado por um actor ou global actor.
