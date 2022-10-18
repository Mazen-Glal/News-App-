
abstract class AppStates {}

class InitState extends AppStates {}

class BottomNavState extends AppStates {}
class ChangeAppMode extends AppStates {}

class NewsGetBusinessLoadingState extends AppStates {}
class GetSuccessBusinessData extends AppStates {}
class GetFailedBusinessDataError extends AppStates {
  final String error ;
  GetFailedBusinessDataError(this.error);
}

class NewsGetSportsLoadingState extends AppStates {}
class GetSuccessSportsData extends AppStates {}
class GetFailedSportsDataError extends AppStates {
  final String error ;
  GetFailedSportsDataError(this.error);
}

class NewsGetScienceLoadingState extends AppStates {}
class GetSuccessScienceData extends AppStates {}
class GetFailedScienceDataError extends AppStates {
  final String error ;
  GetFailedScienceDataError(this.error);
}

class NewsGetSearchLoadingState extends AppStates {}
class GetSuccessSearchData extends AppStates {}
class GetFailedSearchDataError extends AppStates {
  final String error ;
  GetFailedSearchDataError(this.error);
}
