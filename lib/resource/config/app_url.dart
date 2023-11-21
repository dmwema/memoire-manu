class AppUrl {
  static var domainName = 'https://api.quickdep.ca';
  // static var domainName = 'http://10.0.2.2:8000';
  static var baseUrl = "$domainName/api";

  static var loginEndPoint = '$baseUrl/login';
  static var registerEndPoint = '$baseUrl/register';

  static var contractEndpoint = '$baseUrl/contracts';

  static var jobsEndpoint = '$baseUrl/jobs';

  static var userEndPoint = '$baseUrl/users';

  static var documentsTypeEndPoint = '$baseUrl/document_types';

  static var accountsEndPoint = '$baseUrl/accounts';

  static var documentsEndPoint = '$baseUrl/documents';

  static var shiftsEndPoint = '$baseUrl/shifts';

  static var appliesEndPoint = '$baseUrl/applies';

  static var confirmationsEndPoint = '$baseUrl/shift-confirmations';

  static var timeSheetEndPoint = '$baseUrl/time_sheets';

  static var invoicesEndPoint = '$baseUrl/invoices';

  static var enterpriseEndPoint = '$baseUrl/enterprises';

  static var workerEndPoint = '$baseUrl/workers';

  static var townsEndPoint = '$baseUrl/towns';

  static var passwordReset = '$baseUrl/password-reset';

}