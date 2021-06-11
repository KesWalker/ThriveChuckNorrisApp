// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:thrive_chuck_norris_kw/repo/chuckRepo.dart';

void main() {
  test('Random joke should be retrieved', () async {
    final repo = ChuckRepo();

    var joke = await repo.getJoke({'exclude':''});

    expect(joke.joke != null, true);
  });

  test('Joke id should be more than or equal to 0', () async {
    final repo = ChuckRepo();

    var joke = await repo.getJoke({'exclude':''});

    expect(joke.id >= 0, true);
  });

  test('Passing page 3 should return 60 jokes', () async {
    final repo = ChuckRepo();

    var jokes = await repo.getJokes(3);

    expect(jokes.length, 60);
  });
}
