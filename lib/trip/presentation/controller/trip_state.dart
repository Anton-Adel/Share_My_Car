abstract class TripStates{}

class TripInitialState extends TripStates{}

class TripDisplayDateTimeState extends TripStates{}


class TripBookTripLoadingState extends TripStates{}
class TripBookTripSuccessState extends TripStates{}
class TripBookTripErrorState extends TripStates{}


class TripGetUserLoadingState extends TripStates{}
class TripGetUserSuccessState extends TripStates{}
class TripGetUserErrorState extends TripStates{}

class TripGetNumberOfSeatsState extends TripStates{}

class TripClearState extends TripStates{}



class TripGetAllTripsLoadingState extends TripStates{}
class TripGetAllTripsSuccessState extends TripStates{}
class TripGetAllTripsErrorState extends TripStates{}


class TripToLocationState extends TripStates{}