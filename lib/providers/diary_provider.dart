part of 'providers.dart';

class DiaryProvider with ChangeNotifier {
  List<Diary> _items = [];

  List<Diary> get items {
    return [..._items];
  }

  Diary findById(String id) {
    print(id);
    return _items.firstWhere((diary) => diary.id == id);
  }

  Future<void> addDiary(
    String pickedTitle,
    String pickedDesc,
    File pickedImage,
    String pickedDate,
  ) {
    final newDiary = Diary(
      id: DateTime.now().toString(),
      title: pickedTitle,
      description: pickedDesc,
      image: pickedImage,
      date: pickedDate,
    );
    _items.add(newDiary);
    notifyListeners();
    DBHelper.insert('diary_user', {
      'id': newDiary.id,
      'title': newDiary.title,
      'description': newDiary.description,
      'image': newDiary.image.path,
      'date': newDiary.date,
    });
  }

  Future<void> deleteDiary(String id) {
    DBHelper.delete('diary_user', id);
  }

  Future<void> fetchAndSetDiary() async {
    final dataList = await DBHelper.getData('diary_user');
    _items = dataList
        .map(
          (item) => Diary(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            image: File(item['image']),
            date: item['date'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
