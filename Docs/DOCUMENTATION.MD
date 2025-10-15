# Documentação

## Arquitetura

![News App Architecture](NewsAppArchitecture.png)

### Presentation (MVVM-C/MVC)

- Tab 1 e 2 exibem feeds com scroll infinito/pull-to-refresh.
- Tab 3 exibe um menu.
- ViewModel transforma eventos de UI em chamadas de caso de uso: `getFeedPage()`, `refreshFeedPage()`.
- Mantém estados: items, isLoading, errorMessage.

### Domain (Use Cases, Entities)

- Regra de negócio e contratos. Entidades puras: `FeedPage`, `FeedItem`.
- Casos de uso: `FetchFeedPage`.
- Define Repository como protocolo: `func fetchFeedPage(product: String) -> AnyPublisher<FeedPage, NetworkError>`.

### Data (Network, Persistence, Repositories)

- Implementa os repositórios. Orquestrar fontes: remoto + cache local.
- Mapeia DTO+Entity, trata erros e converte para tipos da **domain**.
- Estratégia de paginação: armazena **nextPage**, faz merge estável, evita chamadas paralelas duplicadas.
- Cache: salvar páginas do *feed* com os seus respectivos *items*.

### Infrastructure / Network

- Cliente HTTP (URLSession), construção de requests e decodificação JSON.
- Observa conectividade e limites de rate.
