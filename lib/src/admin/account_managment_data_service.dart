import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:bsTableExample/src/admin/user_list_result.dart';

@Injectable()
class AccountManagementDataService{

  Map userList;

  final BrowserClient _browserClient = new BrowserClient();
  AccountManagementDataService();

  final String _mockUserList = r'''{"hits": [{"_source":    
    {
      "lastName": "Smith",
      "firstName": "Jane",
      "email": "jsmith@email.com",
      "status": "Active",
      "role1": "true",
      "role2": "false",
      "role3": "false",
      "role4": "false",
      "role5": "false",
      "role6": "false"
    }},
    {"_source":    {
      "lastName": "Schaffer",
      "firstName": "Peter",
      "email": "pschaffer@email.com",
      "status": "Active",
      "role1": "false",
      "role2": "false",
      "role3": "false",
      "role4": "true",
      "role5": "false",
      "role6": "false"
    }},
    {"_source":    {
      "lastName": "Heller",
      "firstName": "Rachel",
      "email": "rheller@email.com",
      "status": "Active",
      "role1": "false",
      "role2": "false",
      "role3": "false",
      "role4": "false",
      "role5": "true",
      "role6": "false"
    }},
    {"_source":    {
      "lastName": "Ross",
      "firstName": "Robert",
      "email": "rross@email.com",
      "status": "Active",
      "role1": "false",
      "role2": "true",
      "role3": "true",
      "role4": "false",
      "role5": "false",
      "role6": "false"
    }},
    {"_source":    {
      "lastName": "Rogers",
      "firstName": "Michael",
      "email": "mrogers@email.com",
      "status": "Inactive",
      "role1": "false",
      "role2": "false",
      "role3": "false",
      "role4": "false",
      "role5": "false",
      "role6": "true"
    }}
  ]}''';

  UserListResult _userListResult;

  Future<UserListResult> getUserList(bool useMock) async {
    _userListResult = new UserListResult();

    if(!useMock) {
      try {
        final resp = await _browserClient.get("http://cdtssql445d:8082/suppliers",
          headers: {'supplierid': 'sup_1'},);
        _userListResult.message = "Got Data from API";
        _userListResult.hasError = false;
        _userListResult.users = handleResponse(parseResponse(resp));
        return _userListResult;
      } catch(e) {
        print("Caught Error: " + e.toString());
        _userListResult.hasError = true;
        _userListResult.message = r'API Exception encountered: XMLHttpRequest' + e.toString();
        return _userListResult;
      }
    } else {
      print('Got data from mock service.');
      _userListResult.message = "Mock data.";
      _userListResult.hasError = false;
      _userListResult.users = JSON.decode(_mockUserList)['hits'];
      return _userListResult;
    }
  }

  parseResponse(http.Response resp) {
    var jsonResult = JSON.decode(resp.body);

    if (resp.statusCode == 500) {
      return "Error 500";
    } else {
      return jsonResult;
    }
  }

  Map handleResponse(Map<String, dynamic> jsonResult) {
    return jsonResult['hits'];
  }

  Future<Null> updateUser() async {

  }
}