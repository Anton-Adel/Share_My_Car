abstract class RegisterState {}



class RegisterInitialState extends RegisterState{}

class RegisterSuccessState extends RegisterState{}

class RegisterLoadingState extends RegisterState{}

class RegisterErrorState extends RegisterState{}

class RegisterChangeGender extends RegisterState{}

class RegisterHaveCar extends RegisterState{}

class RegisterGetDate extends RegisterState{}



class RegisterImageController extends RegisterState{}

class RegisterQuestion extends RegisterState{}
class RegisterQuestionLoading extends RegisterState{}





class RegisterSendCodeSuccessState extends RegisterState{}

class RegisterSendCodeLoadingState extends RegisterState{}

class RegisterSendCodeErrorState extends RegisterState{}
