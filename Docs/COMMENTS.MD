# Comentários

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

## Notas

nonisolated em Swift indica que uma função, propriedade ou método não é isolado por um actor ou global actor.

nonisolated serve para liberar funções que não dependem do estado protegido do actor, tornando-as seguras e acessíveis de qualquer contexto concorrente.
