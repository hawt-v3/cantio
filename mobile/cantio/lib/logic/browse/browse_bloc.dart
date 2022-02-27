import 'package:bloc/bloc.dart';
import 'package:cantio/data/providers/browse_provider.dart';
import 'package:cantio/data/repositories/browse_repository.dart';
import 'package:cantio/logic/browse/browse_event.dart';
import 'package:cantio/logic/browse/browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final BrowseRepository _browseRepository;

  BrowseBloc(BrowseRepository browseRepository)
      : _browseRepository = browseRepository,
        super(InitalBrowseEvent());

  @override
  Stream<BrowseState> mapEventToState(BrowseEvent event) async* {
    if (event is GetAllSongs) {
      final spotlight = await _browseRepository.getSpotlightSong();
      final popularitySongs = await _browseRepository.getMostPopular();
      final pop = await _browseRepository.getSongByGenre("Pop");
      final indie = await _browseRepository.getSongByGenre("Indie");
      final hiphop = await _browseRepository.getSongByGenre("Hip Hop");
      final metal = await _browseRepository.getSongByGenre("Metal");
      final blues = await _browseRepository.getSongByGenre("Blues");
      final rock = await _browseRepository.getSongByGenre("Rock");
      final chill = await _browseRepository.getSongByGenre("Chill");
      yield RetirevedSongs(
          spotlightPost: spotlight,
          popularity: popularitySongs,
          pop: pop,
          indie: indie,
          hiphop: hiphop,
          metal: metal,
          blues: blues,
          rock: rock,
          chill: chill);
    }
  }
}
