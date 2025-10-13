# Documentação

## Arquitetura

![News App Architecture](NewsAppArchitecture.png)

### Presentation (MVVM-C/MVC)

- Tab 1 e 2 exibem feeds com scroll infinito/pull-to-refresh.
- ViewModel transforma eventos de UI em chamadas de caso de uso: `loadNextPage()`, `refresh()`.
- Mantém estados: items, isLoading, error, isEndReached.

### Domain (Use Cases, Entities)

- Regra de negócio e contratos. Entidades puras: `Article`, `Page<T>`, `FeedQuery`.
- Casos de uso: FetchFeedPage, RefreshFeed.
- Define Repository como protocolo: `FeedRepository.fetch(pageToken:) -> Page<Article>`.
- Política de paginação: tamanho da página, deduplicação, detecção de fim ``(nextPage == nil)`.

### Data (Network, Persistence, Repositories)

- Implementa os repositórios. Orquestra fontes: remoto + cache local.
- Mapeia DTO+Entity, trata erros e converte para tipos da **domain**.
- Estratégia de paginação: guarda nextPage/offset, faz merge estável, evita chamadas paralelas duplicadas.
- Cache: salvar páginas de artigos.

### Infrastructure / Network

- Cliente HTTP (URLSession), construção de requests e decodificação JSON.
- Observa conectividade e limites de rate.
