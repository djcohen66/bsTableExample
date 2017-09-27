import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:bsTableExample/src/admin/user_list_result.dart';
import 'package:bsTableExample/src/admin/account_managment_data_service.dart';
import 'package:ng_bootstrap/components/table/table_directives.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';
import 'package:ng_bootstrap/components/alert/alert.dart';

@Component(
  selector: 'account-management',
  styleUrls: const ['account_management_component.css'],
  templateUrl: 'account_management_component.html',
  directives: const [CORE_DIRECTIVES,
  materialDirectives,
  BsAlertComponent,
  BS_TABLE_DIRECTIVES,
  formDirectives,
  MaterialCheckboxComponent],
  providers: const [AccountManagementDataService],
)

class AccountManagementComponent implements OnInit{
  bool selectable;
  bool useMock = true;
  UserListResult userListResult = new UserListResult();
  Map config;

  AccountManagementComponent()  {
    config = {
      'filtering': {
        'filterString': '',
        'columnName': 'lastName'}
    };
  }

  AccountManagementDataService accountManagementDataService = new AccountManagementDataService();

  Future<Null> ngOnInit() async {
    userListResult = await accountManagementDataService.getUserList(true);
  }
}