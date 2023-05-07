import '../enums/enums.dart';

class Translator {
  Translator._init();

  static TypeReason translateIssue(String reason) {
    switch (reason) {
      case "sensitiveContent":
        return TypeReason.sensitiveContent;
      case "spam":
        return TypeReason.spam;
      case "appCrashed":
        return TypeReason.appCrashed;
      case "appException":
        return TypeReason.appException;
      case "errorToChargeContent":
        return TypeReason.errorToChargeContent;
      case "errorToCreateOrUpdateSomething":
        return TypeReason.errorToCreateOrUpdateSomething;
      default:
        return TypeReason.error;
    }
  }

  static TypeUser translationTypeUser(String type) {
    switch (type) {
      case 'user':
        return TypeUser.user;
      case 'admin':
        return TypeUser.admin;
      case 'guess':
        return TypeUser.guess;
      default:
        return TypeUser.unknown;
    }
  }

  static List<TypeBan>? translationTypeBan(List<String> reasonList) {
    List<TypeBan>? bans = null;
    reasonList.forEach((whyBanned) {
      switch (whyBanned) {
        case 'perPublishSensitiveContent':
          bans?.add(TypeBan.perPublicSensitiveContent);
          break;
        case 'perRobTemplates':
          bans?.add(TypeBan.perRobTemplates);
          break;
        default:
          bans?.add(TypeBan.nothing);
      }
    });
    return bans;
  }

}
