part of 'widgets.dart';

class DiaryItem extends StatelessWidget {
  final Diary diary;
  // final String title;
  // final String description;
  // final File image;
  // final String date;
  final Function onTap;

  DiaryItem(
    this.diary,
    // this.title,
    // this.description,
    // this.image,
    // this.date,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 2,
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: SizeConfig.imageSizeMultiplier * 6.2,
              backgroundColor: mainColor,
              child: CircleAvatar(
                radius: SizeConfig.imageSizeMultiplier * 6,
                backgroundImage: FileImage(
                  diary.image,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      diary.title,
                      style: blackTextFont.copyWith(
                        fontSize: SizeConfig.textMultiplier * 2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      diary.description,
                      style: blackTextFont.copyWith(
                        fontSize: SizeConfig.textMultiplier * 2,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              DateFormatter().getVerboseDateTimeRepresentation(
                DateTime.parse(diary.date),
              ),
              style: blackTextFont.copyWith(
                fontSize: SizeConfig.textMultiplier * 1.6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
