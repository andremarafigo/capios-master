# Aula 14/06 - Exercícios e Treinos

A ideia da aula de hoje é continuar a exercitar R.swift e RxSwift pra vocês se acostumarem com as libs e também tirar dúvidas de problemas que possam ocorrer

Nosso P.O solicitou a correção e adequação de algumas coisas no app, para melhorar a experiência do usuário. 
A equipe de Release Management também deu uma analisada no código e viu alguns ajustes que são necessários para adequar o projeto ao padrão da empresa.

## Correções e Ajustes solicitadas pela equipe de Release Management

* Adicionar alertas com mensagem de erro para criações de conta e tentativa de login. - OK
* Colocar toda e qualquer string pra dentro de um arquivo .string - OK
* Fazer todas as transições de tela e chamadas de botões, usando RxSwift e R.swift - OK
* Imagens locais devem estar salvas no arquivo xcassets e devem ser consumidas através da lib R.swift - OK
* Fontes personalizadas devem ser instanciadas através da chamada R.font … e não usando UIFont(…

## Implementar a nova feature solicitada pelo P.O

Critérios de aceitação:
### * Criar uma tela de Menu pra ser exibida após o login efetuado com sucesso.
    * Essa tela deve conter: 
        1. Título da navbar contendo texto “Bem-Vindo ao seu App”. - OK
        2. Título “Menu”, na parte superior da tela, com margem de 20 pixels e centralizado horizontalmente. - OK
        3. Colocar fonte personalizada no título. - OK
        4. Botão centralizado na tela com texto “Contatos”. - OK
        5. Botão “Contatos”, quando pressionado, deve chamar a tela “Meus Contatos“. - OK

### * Criar Tela de Contatos
    * Essa tela deve conter:
        1. Título da navbar contendo texto “Meus Contatos”. - OK
        2. Tabela que irá conter todos os contatos salvos em nosso ambiente simulado (Mockar dados da tabela, exibir pelo menos 2 itens) - Mostrar a solução mockada e depois implementar a chamada do endpoint. - OK
        3. Utilizar célula personalizada já disponível (ContactTableViewCell) com:
            1. Imagem - Lado esquerdo, centralizado verticalmente na célula - OK
            2. Nome - Ao lado direito da imagem - OK
            3. Número de telefone - logo abaixo do nome do contato - OK
        4. Ao selecionar uma célula, chamar a tela “Detalhes do Contato” - 
        5. A equipe de testes mencionou que havia um problema de layout nessa célula, então ficamos encarregados de entender o problema e corrigi-lo (Não usar método delegate heightForRow, corrigir com autolayout).

### * Criar Tela de Detalhes do Contato
    * Essa tela deve conter:
        1. Título da navbar contendo texto “Detalhes de (Nome do contato)”
        2. Imagem centralizada e quadrada com tamanho de 150px
        3. Abaixo da imagem, ocupar o restante da tela com um TextView e preencher o componente com a informação do detalhe do contato

### * Integrações:
    * Tela de Contatos:
        * Chamada do endpoint ‘contactInfo’ presente no struct ContactAPI para recuperar a lista de contatos disponível
