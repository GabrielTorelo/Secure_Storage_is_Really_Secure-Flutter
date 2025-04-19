// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Aplicativo de \'Login\'';

  @override
  String get errorOccurred => 'Ocorreu um erro';

  @override
  String get unknownErrorOccurred => 'Ocorreu um erro desconhecido!\nTente novamente mais tarde.';

  @override
  String get errorLogin => 'Erro no Login';

  @override
  String get welcome => 'Bem-vindo';

  @override
  String get login => 'Entrar';

  @override
  String get logout => 'Sair';

  @override
  String get backToHome => 'Voltar ao Início';

  @override
  String get ok => 'ok';

  @override
  String get unavailable => 'Indisponível';

  @override
  String get copy => 'Copiar';

  @override
  String get users => 'Usuários';

  @override
  String get usersAvailable => 'Usuários disponíveis para entrar';

  @override
  String get usersAvailableDesc => 'Você pode usar os seguintes usuários para entrar:';

  @override
  String get name => 'Nome';

  @override
  String get username => 'Usuário';

  @override
  String get password => 'Senha';

  @override
  String get role => 'Função';

  @override
  String get insertDataAuto => 'Inserir dados automaticamente';

  @override
  String get userNotFound => 'Usuário não encontrado';

  @override
  String get incorrectPassword => 'Senha incorreta';

  @override
  String get pleaseEnterUsername => 'Por favor, insira um nome de usuário';

  @override
  String get pleaseEnterPassword => 'Por favor, insira uma senha';

  @override
  String get textCopied => 'Texto copiado';

  @override
  String get whereAccessInfo => 'Onde acessar essa informação?';

  @override
  String get decrypt => 'Descriptografar';

  @override
  String get encryptionKey => 'Chave de Criptografia';

  @override
  String get encryptedUserData => 'Dados do Usuário Criptografados';

  @override
  String get decryptedUserData => 'Dados do Usuário Descriptografados';

  @override
  String get savedLocalStorage => 'Seus dados foram salvos em \'Armazenamento Local\' usando o pacote \'flutter_secure_storage\'';

  @override
  String get toTheApp => 'ao Aplicativo de \'Login\'';

  @override
  String get whereUsersStored => 'Onde os usuários são armazenados?';

  @override
  String get whereUsersStoredDesc => 'Os usuários são armazenados no arquivo \'users.dart\' na pasta \'MOCK\'';

  @override
  String get howAccessBrowserLS => 'Como posso acessar essas informações através do navegador?';

  @override
  String get accessBrowserDevTools => 'Você pode acessar essas informações através do \'DevTools\' do seu navegador. O exemplo abaixo usa o';

  @override
  String get homeDialogStepOne => '1º Abra o DevTools (F12) do navegador e vá até a aba \'Aplicativo\'.';

  @override
  String get homeDialogStepTwo => '2º Na seção \'Armazenamento\', clique em \'Armazenamento Local\' e selecione o site que deseja inspecionar. Você verá as chaves e valores armazenados no \'Armazenamento Local\'.';
}
