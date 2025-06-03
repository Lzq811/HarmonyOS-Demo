import { INavItem, INavList } from "../../models/HomeData";

@Component
export default struct NavList {
  @Prop navList:INavList
  build() {
    Grid() {
      ForEach(this.navList, (nav: INavItem) => {
        GridItem(){
          Column(){
            Image(nav.imageURL).width(56).height(56).objectFit(ImageFit.Fill).margin({bottom: 8})
            Text(nav.title).fontSize(12).fontColor($r('app.color.black'))
          }
        }
      }, (item: INavItem) => item.id + '')
    }
    .width('100%')
    .height(170)
    .rowsGap(16)
    .columnsGap(32)
    .rowsTemplate('1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .margin({top: 24})
  }
}