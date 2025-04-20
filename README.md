# A biblioteca 'flutter_secure_storage' é realmente segura? [PT-BR]

Projeto elaborado para avaliar a segurança da biblioteca "flutter_secure_storage" em todas as suas plataformas (Android, iOS, Linux, macOS, WEB e Windows). A análise é salientada na tentativa de burlar a criptografia dos dados. Este projeto é educacional, distribuído sob a licença MIT, <u><b>os colaboradores não se responsabilizam por usos indevidos</b></u>.

## Versões

- <b>Flutter: 3.29.3
- Dart: 3.7.2
- flutter_secure_storage: 9.2.4</b>

## Instalação

Para instalar o projeto, você deve ter o Flutter instalado em sua máquina. Após isso, siga os passos abaixo:

1. Clone o repositório:

```bash
git clone https://github.com/GabrielTorelo/Secure_Storage_is_Really_Secure-Flutter.git
```

2. Navegue até o diretório do projeto:

```bash
cd Secure_Storage_is_Really_Secure-Flutter
```

3. Instale as dependências:

```bash
flutter pub get
```

## Executando o projeto

Para executar o projeto, você pode usar um emulador ou um dispositivo físico. Siga os passos abaixo para executar o projeto:

### Web (Chrome):

1. Certifique-se de que o Flutter está configurado para a web:

```bash
flutter config --enable-web
```

2. Verifique se o Chrome está instalado e configurado como navegador padrão:

```bash
flutter config --set-default-browser chrome
```

3. Inicie o servidor de desenvolvimento:

```bash
flutter run -d chrome --web-port=8080
```

4. O projeto será executado em seu navegador no endereço `http://localhost:8080`.

5. Para parar o servidor, pressione `Ctrl + C` no terminal.

## Análise da biblioteca

A biblioteca [flutter_secure_storage](https://github.com/juliansteenbakker/flutter_secure_storage) tem como intuito o armazenamento de dados confidenciais com segurança (usando soluções de armazenamento seguras específicas de cada plataforma) em um formato chave-valor. Em dispositivos móveis, ela utiliza o Keychain (iOS) e o Keystore (Android) para armazenar a chave de criptografia e os dados criptografados. A biblioteca é amplamente utilizada para armazenar informações sensíveis, como tokens de autenticação, senhas e outros dados críticos.

A análise realizada neste projeto tem como objetivo avaliar e tentar burlar a segurança da biblioteca em todas as suas plataformas (Android, iOS, Linux, macOS, WEB e Windows).

### Análise resumida:

- <b>Web - Vulnerabilidade Crítica</b>

### Análise detalhada:

- ### Web <b>[ Vulnerabilidade Crítica ]</b> :

  A versão web da biblioteca utiliza o Armazenamento Local (Local Storage) do navegador para armazenar a chave de criptografia e os dados criptografados. O Local Storage é uma forma de armazenamento persistente que permite armazenar dados no navegador do usuário. <b><u>Os dados armazenados no Local Storage podem ser ACESSADOS e ALTERADOS através do console do navegador</b></u>, o que torna essa forma de armazenamento vulnerável a ataques de XSS (Cross-Site Scripting).

  Veja abaixo como é simples acessar e editar os dados armazenados no Local Storage:

  - Acesse o console do navegador (F12 ou Ctrl + Shift + I)
  - Vá para a aba "Aplicativo" (ou Application em inglês)
  - No menu lateral, clique em "Armazenamento Local" (ou Local Storage em inglês)
  - Selecione o domínio do seu projeto (ex: http://localhost:8080)
  - Você verá os dados armazenados no Local Storage, incluindo a <b><u>CHAVE DE CRIPTOGRAFIA e os DADOS CRIPTOGRAFADOS</b></u>
  - Você pode editar ou excluir os dados diretamente do console do navegador

  #### Resultados da análise:

  - O fato dos dados armazenados estarem criprografados não impede que um atacante consiga acessá-los, descriptografá-los e alterá-los, uma vez que a chave de criptografia também está armazenada no Local Storage.
  - No projeto 'analysis_web', é simulado um sistema de login, onde o usuário pode inserir um nome de usuário e uma senha. Após o login, os dados são armazenados no Local Storage usando a biblioteca 'flutter_secure_storage'.
  - Os dados armazenados são exibidos na tela, juntamente com a chave de criptografia, na qual o usuário tem fácil acesso via console do navegador, demonstrando uma vulnerabilidade crítica na segurança dos dados.
  - O projeto também possui um botão para descriptografar os dados armazenados, permitindo que o usuário visualize os dados em texto claro. Isso demonstra que, mesmo que os dados estejam criptografados, eles podem ser facilmente acessados e manipulados por um atacante.
  - Após a descriptografia, o usuário pode editar os dados armazenados, permitindo a alteração de forma lúdica e simples, apenas para demonstração do que poderia ser feito por um atacante.
  - Após a edição dos dados, o usuário pode clicar no botão "SALVAR NO ARMAZENAMENTO LOCAL" para armazenar os dados editados no Local Storage, sobrescrevendo os dados originais. Isso demonstra que um atacante pode facilmente alterar os dados armazenados e salvá-los novamente, comprometendo a segurança do sistema.

  #### Conclusão:

  - <b><u>A VERSÃO WEB DA BIBLIOTECA 'flutter_secure_storage' NÃO É SEGURA</b></u>, pois os dados armazenados no Local Storage podem ser facilmente acessados e manipulados por um atacante. É recomendável não usar essa biblioteca para armazenar dados sensíveis em aplicações web, pois a segurança dos dados não é garantida.
