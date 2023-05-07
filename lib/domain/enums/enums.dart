enum TypeUser {
  admin,
  guess,
  user,
  unknown,
}

enum TypeBan {
  perRobTemplates,
  perPublicSensitiveContent,
  nothing,
}

enum TypeReason {
  sensitiveContent,
  spam,
  unknownContent,
  appException,
  appCrashed,
  errorToChargeContent,
  error,
  errorToCreateOrUpdateSomething,
}

enum TypeSort {
  title,
  creation,
  modification,
  recent,
  suggested,
  anything,
}

enum AppTheme {
  darkTheme,
  lightTheme,
}
