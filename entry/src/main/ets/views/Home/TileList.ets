import { ITileItem, ITileList } from "../../models/HomeData"

@Component
export default struct TileList {
  @Prop tileList:ITileList
  build() {
    Row({space: 20}){
      ForEach(this.tileList, (tile:ITileItem) => {
        Column({space: 8}){
          Image(tile.imageURL)
          Row({space: 5}){
            Text(tile.title).fontSize(10).fontColor($r('app.color.black'))
            Text(tile.sub_title).fontSize(10).fontColor($r('app.color.gray'))
          }
          .justifyContent(FlexAlign.Start)
          .width('100%')
        }
        .width('48%')
      }, (tile:ITileItem) => tile.id + '')
    }
    .width('100%')
    .height(80)
    .margin({top: 16})
    .justifyContent(FlexAlign.SpaceBetween)
  }
}