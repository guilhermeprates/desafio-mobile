# Comentários

Desenvolvimento seguiu *Clean Architecture*, separando responsabilidades em camadas de *Domain*, *Data* e *Presentation*.
As camada de apresentação:

- Feed de notícias implementado com **MVVM-C**, combinando `ViewModel` para lógica de estado e `Coordinator` para navegação.
- Menu estruturado em **MVC-C**, dados exibidos em uma `UITableView` de forma simple e direta, e navegação via `Coordinator`.
- WebView seguiu **MVC** simples, recebe a url por parametro para exibir direto o conteúdo.

O app utiliza Combine para reatividade, DiffableDataSource para listas mais complexas, e segue princípios de modularidade, testabilidade e escalabilidade.

A camada de persistência não foi incluída, mas seria adicionada usando `CoreData` para armazenar e recuperar feeds offline, com uma validação feita dentros dos repositório responsáveis por trazer os dados do feeed.


## Arquitetura

Documento com explicação da [Arquitetura](/Docs/DOCUMENTATION.md).

## App Flow

![App Flow](AppFlow.png)

## Bibliotecas usadas no projeto

### [SnapKit](https://github.com/SnapKit/SnapKit)

Motivações para uso do **SnapKit** no projeto:

- Reduz *boilerplate* ao criar *constraints* programaticamente.
- Facilita leitura e manutenção da interface em *view code*.

### [Kingfisher](https://github.com/onevcat/Kingfisher)

Motivações para uso do **Kingfisher** no projeto:

- Melhora na eficiência no carregamento e exibição de imagens, reduzindo tempo de desenvolvimento e uso de rede.