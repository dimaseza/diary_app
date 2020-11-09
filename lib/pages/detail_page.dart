part of 'pages.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final diaryData = Provider.of<DiaryProvider>(
      context,
      listen: false,
    ).findById(id);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.heightMultiplier * 2,
                  left: SizeConfig.widthMultiplier * 2,
                ),
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
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.heightMultiplier * 4,
                  bottom: SizeConfig.heightMultiplier * 1,
                  left: SizeConfig.widthMultiplier * 2,
                ),
                child: Text(
                  diaryData.title,
                  style: blackTextFont.copyWith(
                    fontSize: SizeConfig.textMultiplier * 3.5,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.widthMultiplier * 2,
                  bottom: SizeConfig.heightMultiplier * 3,
                ),
                child: Text(
                  "${DateFormat.yMMMMd().format(DateTime.parse(diaryData.date))}",
                  style: blackTextFont.copyWith(
                    fontSize: SizeConfig.textMultiplier * 2,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.61),
                  ),
                ),
              ),
              Container(
                height: SizeConfig.heightMultiplier * 50,
                width: double.infinity,
                child: Image.file(
                  diaryData.image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 2,
                  vertical: SizeConfig.heightMultiplier * 3,
                ),
                child: Text(
                  diaryData.description,
                  style: blackTextFont.copyWith(
                    fontSize: SizeConfig.textMultiplier * 2.3,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
