
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ImagePicker _imagePicker = ImagePicker();

  HomeBloc() : super(ImageInitial()){
    on<HomeEvent>((event, emit) async {
      if (event is ImagePicked) {
        emit(ImageLoadInProgress());
        try {
          final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            emit(ImageLoadSuccess(pickedFile.path));
          } else {
            emit(ImageLoadFailure());
          }
        } catch (e) {
          emit(ImageLoadFailure());
        }
      }else if(event is RadioClicked){
        emit(RadioState(event.selectedValue));
      }else if(event is AgreeCheckClicked){
        emit(AgreeState(event.selectedValue));
      }
    });
  }

}
