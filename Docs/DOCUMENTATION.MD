# Documentação

## Arquitetura

![News App Architecture](NewsAppArchitecture.png)

### Presentation Layer (MVVM-C / MVC)

- **Views**:
  - **TabBar**:
    1. **Feed G1**: a tela exibe feed do g1 com *scroll infinito* e *pull-to-refresh*.
    2. **Feed Agronegócios**: a tela exibe feed do agro com *scroll infinito* e *pull-to-refresh*.
    3. **Menu**: atela exibe um menu com vários items.
  - **WebView**: a tela exibe o conteúdo de uma `URL`.
- **ViewModel**: recebe eventos da UI e aciona casos de uso
    (`loadFeed()`, `loadNextPage()`).
  - Mantém estados: `items`, `isLoading`, `errorMessage`.
  - Garante deduplicação e atualização incremental da lista.
- **Coordinatior**: o *Coordinator* gerencia rotas entre módulos e ciclo de vida dos *ViewControllers*.

#### Feed (MVVM-C)

    ViewController/View -> ViewModel <- FetchFeedPageUseCase/FetchFeedNextPageUseCase

- Fluxo reativo com Combine.
- A *view* observa as propriedades definidas com `@Published` na **ViewModel** para atualização da **UI**.

#### Menu (MVC-C)

    MenuViewController <- MenuRepository

- Responsável apenas por exibir conteúdo de um arquivo JSON, lógica mais simples de domínio.

#### WebView (MVC)

    WebViewController + WKWebView <- URL

- Responsável apenas por exibir conteúdo remoto, sem lógica de domínio.

------------------------------------------------------------------------

### Domain Layer (Use Cases / Entities)

- Contém a lógica de negócio pura e independente de frameworks.
- Entidades:
  - `FeedPage`,`FeedItem` (imutable).
  - `Menu`, `MenuItem` (imutable e decodable).
- Casos de uso:
  - FetchFeedPageUseCase
  - FetchFeedNextPageUseCase
- Define *Repository Contracts* (protocolos) para abstrair acesso a dados.

------------------------------------------------------------------------

### Data Layer (Repositories / Network / Persistence)

- Implementa os *Repositories* definidos na camada de domínio.
- Combina múltiplas fontes: **remota** (API) e **local** (cache).
- Mapeia **DTOs** para **Entities**, trata erros.
- **Cache**:
  - Persiste páginas e seus itens -- CoreData.

------------------------------------------------------------------------

### Infrastructure Layer / Network

- Cliente server utilizando  `URLSession` e Combine.
- Monta requests com `Endpoint` abstraindo *path*, *methods* e *headers*.
- Faz decodificação genérica de JSON em DTOs.
