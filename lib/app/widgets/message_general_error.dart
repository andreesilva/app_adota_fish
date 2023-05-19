import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MessageGeneralError {
  void showAlertErrorGeneral(QuickAlertType quickAlertType) {
    QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        title: "",
        text: "Houve um erro!",
        confirmBtnText: "Ok",
        type: quickAlertType);
  }
}
