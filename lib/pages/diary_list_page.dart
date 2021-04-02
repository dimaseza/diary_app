part of 'pages.dart';

class DiaryListPage extends StatefulWidget {
  @override
  _DiaryListPageState createState() => _DiaryListPageState();
}

class _DiaryListPageState extends State<DiaryListPage> {
  // MORNING
  final morningStartTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    5,
    1,
  );
  final morningEndTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    11,
    0,
  );

  // AFTERNOON
  final afternoonStartTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    11,
    1,
  );
  final afternoonEndTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    14,
    0,
  );

  // EVENING
  final eveningStartTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    14,
    1,
  );
  final eveningEndTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    18,
    0,
  );

  final currentTime = DateTime.now();

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<DiaryProvider>(context, listen: false).fetchAndSetDiary();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: SizeConfig.heightMultiplier * 20,
                color: mainColor,
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: SizeConfig.heightMultiplier * 23, // 294
                          color: Colors.white,
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.infinity,
                            height: SizeConfig.heightMultiplier * 20,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.heightMultiplier * 3,
                          left: SizeConfig.widthMultiplier * 4,
                          child: Text(
                            (currentTime.isAfter(morningStartTime) &&
                                    currentTime.isBefore(morningEndTime))
                                ? "Selamat pagi,\nsemalam mimpi apa?\nCeritain yuk!"
                                : (currentTime.isAfter(afternoonStartTime) &&
                                        currentTime.isBefore(afternoonEndTime))
                                    ? "Abis makan siang,\nenaknya nulis cerita nih!"
                                    : (currentTime.isAfter(eveningStartTime) &&
                                            currentTime
                                                .isBefore(eveningEndTime))
                                        ? "Sore-sore gini enaknya\nngopi dan menulis sambil\nmenunggu senja!"
                                        : "Malam, hari ini banyak cerita\nyang terjadi ya? Saatnya nulis!",
                            style: whiteTextFont.copyWith(
                              fontSize: SizeConfig.textMultiplier * 2.5,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Positioned(
                          bottom: SizeConfig.widthMultiplier * 1,
                          left: SizeConfig.widthMultiplier * 20,
                          right: SizeConfig.widthMultiplier * 20,
                          child: Container(
                            width: SizeConfig.widthMultiplier * 10,
                            height: SizeConfig.heightMultiplier * 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400],
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "${DateFormat.yMMMMd().format(currentTime)}",
                                style: greenTextFont.copyWith(
                                  fontSize: SizeConfig.textMultiplier * 2.7,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      child: Text(
                        "Diaryku",
                        style: blackTextFont.copyWith(
                          fontSize: SizeConfig.textMultiplier * 2.8,
                          color: accentColor3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: Provider.of<DiaryProvider>(
                        context,
                        listen: false,
                      ).fetchAndSetDiary(),
                      builder: (ctx, snapshot) => snapshot.connectionState ==
                              ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Consumer<DiaryProvider>(
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: SizeConfig.heightMultiplier * 20,
                                      width: double.infinity,
                                      child: Image.asset(
                                        "assets/images/diary_book.gif",
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Belum ada diary nih,\ntulis diary yuk!",
                                      style: blackTextFont.copyWith(
                                        fontSize: SizeConfig.textMultiplier * 3,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              builder: (ctx, diary, ch) => diary.items.length <=
                                      0
                                  ? ch
                                  : Column(
                                      children: diary.items
                                          .map(
                                            (dia) => Dismissible(
                                              onDismissed: (direction) {
                                                setState(() {
                                                  diary.items.removeAt(
                                                      diary.items.indexOf(dia));
                                                  Provider.of<DiaryProvider>(
                                                    context,
                                                    listen: false,
                                                  ).deleteDiary(dia.id);
                                                });
                                              },
                                              secondaryBackground: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                color: Colors.red,
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.white,
                                                  size: 32,
                                                ),
                                              ),
                                              background: SizedBox.shrink(),
                                              confirmDismiss:
                                                  (direction) async {
                                                return await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        "Konfirmasi",
                                                        style: blackTextFont
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      content: Text(
                                                        "Yakin mau hapus diary kamu?",
                                                        style: blackTextFont
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      actions: [
                                                        FlatButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false),
                                                          child: Text("Batal"),
                                                        ),
                                                        FlatButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(true),
                                                          child: Text("Hapus"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              key: UniqueKey(),
                                              direction:
                                                  DismissDirection.endToStart,
                                              child: DiaryItem(
                                                dia,
                                                () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    DetailPage.routeName,
                                                    arguments: dia.id,
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                          .toList()
                                          .reversed
                                          .toList(),
                                    ),
                            ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: mainColor,
          size: 32,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed(AddDiaryPage.routeName);
        },
        elevation: 4,
        splashColor: mainColor,
        tooltip: "Tambah Diary",
      ),
    );
  }
}
