part of 'pages.dart';

class AddDiaryPage extends StatefulWidget {
  static const routeName = '/add-diary';

  @override
  _AddDiaryPageState createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  File _storedImage;

  final _globalKey = GlobalKey<ScaffoldState>();

  Future<void> _takePictureCamera() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    await File(imageFile.path).copy('${appDir.path}/$fileName');
  }

  Future<void> _getPictureGallery() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    await File(imageFile.path).copy('${appDir.path}/$fileName');
  }

  void _saveDiary() {
    if (_titleController.text.isEmpty ||
        _descController.text.isEmpty ||
        _storedImage == null) {
      final snackbar = SnackBar(
        content: Text(
          "Isi judul dan cerita mu ya, dan jangan lupa foto nya...",
          style: whiteTextFont,
        ),
      );
      _globalKey.currentState.hideCurrentSnackBar();
      _globalKey.currentState.showSnackBar(snackbar);
    } else {
      Provider.of<DiaryProvider>(
        context,
        listen: false,
      ).addDiary(
        _titleController.text,
        _descController.text,
        _storedImage,
        DateTime.now().toIso8601String(),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalKey,
      body: ListView(
        children: <Widget>[
          Container(
            // height: height,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 2,
                    bottom: SizeConfig.heightMultiplier * 2,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: accentColor3,
                            size: SizeConfig.imageSizeMultiplier * 6,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Diaryku",
                          style: blackTextFont.copyWith(
                            fontSize: width * 0.05,
                            color: accentColor3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                _storedImage != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: SizeConfig.widthMultiplier * 100,
                                width: double.infinity,
                                child: Image.file(
                                  _storedImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                left: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _storedImage = null;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(0.7),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width * 0.02,
                          ),
                          SizedBox(
                            height: width * 0.03,
                          ),
                        ],
                      )
                    : Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                Text(
                  "Judul",
                  style: blackTextFont.copyWith(
                    fontSize: SizeConfig.widthMultiplier * 4.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.0052,
                ),
                TextField(
                  controller: _titleController,
                  style: blackTextFont.copyWith(
                    fontSize: SizeConfig.textMultiplier * 2,
                  ),
                  decoration: InputDecoration(
                    hintText: "Masukkan judul...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Cerita",
                  style: blackTextFont.copyWith(
                    fontSize: SizeConfig.widthMultiplier * 4.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.0052,
                ),
                TextField(
                  controller: _descController,
                  style: blackTextFont.copyWith(
                    fontSize: SizeConfig.textMultiplier * 2,
                  ),
                  decoration: InputDecoration(
                    hintText: "Ceritakan disini...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  maxLength: 500,
                  textInputAction: TextInputAction.newline,
                  maxLines: 18,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: SizeConfig.imageSizeMultiplier * 6,
                        ),
                        onPressed: _takePictureCamera,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.photo_library,
                          size: SizeConfig.imageSizeMultiplier * 6,
                        ),
                        onPressed: _getPictureGallery,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 6,
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: SizeConfig.widthMultiplier * 3,
                        height: SizeConfig.heightMultiplier * 5,
                        child: RaisedButton(
                          child: Text(
                            "Submit",
                            style: whiteTextFont.copyWith(
                              fontSize: SizeConfig.textMultiplier * 2.8,
                            ),
                          ),
                          onPressed: _saveDiary,
                          color: mainColor,
                          splashColor: mainColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
