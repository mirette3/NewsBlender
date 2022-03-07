abstract class NewsStates{}
class NewsInitialState extends NewsStates{}
class NewsChangeBarBottomState extends NewsStates{}
class GetBusinessLoadingState extends NewsStates{}
class GetBusinessSuccessState extends NewsStates{}
class GetBusinessErrorState extends NewsStates{
  final String error;
  GetBusinessErrorState(this.error);
}
class GetSportsLoadingState extends NewsStates{}
class GetSportsSuccessState extends NewsStates{}
class GetSportsErrorState extends NewsStates{
  final String error;
  GetSportsErrorState(this.error);
}
class GetScienceLoadingState extends NewsStates{}
class GetScienceSuccessState extends NewsStates{}
class GetScienceErrorState extends NewsStates{
  final String error;
  GetScienceErrorState(this.error);
}

class GetSearchLoadingState extends NewsStates{}
class GetSearchSuccessState extends NewsStates{}
class GetSearchErrorState extends NewsStates{
  final String error;
  GetSearchErrorState(this.error);
}
class ChangeAppMode extends NewsStates{}

