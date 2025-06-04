
import {getNearbyHouseApi} from '../../api/home'
import { BORDER_RADIUS, PADDING } from '../../constants/size';
import { INearbyHouseItem, INearbyHouseList, INearbyHouseTagsItem } from '../../models/HomeData';

import NearbyHouseData from '../../jsonData/nearbyHouse.json'

@Component
export default struct NearbyHouse {
  @State nearbyHouseList: INearbyHouseList = []

  aboutToAppear(): void {
    this.getNearbyHouseData()
  }

  async getNearbyHouseData() {
    // const resData:INearbyHouseList = await getNearbyHouseApi()
    this.nearbyHouseList = NearbyHouseData
  }

  build() {
    Column() {
      Row() {
        Text() {
          Span('周边房源')
          Span('推荐').fontColor($r('app.color.primary'))
        }.fontColor($r('app.color.black')).fontSize(16).fontWeight(700)
        Blank()
        Text('查看更多').fontColor($r('app.color.gray')).fontSize(10)
        Image($r('app.media.right_arrow')).width(4).height(8).objectFit(ImageFit.Fill)
      }
      .width('100%')
      .height(44)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top: 30, bottom: 6})
      Grid() {
        ForEach(this.nearbyHouseList, (house:INearbyHouseItem) => {
          GridItem(){
            Column(){
              Stack({alignContent: Alignment.BottomStart}) {
                // 图片
                Image(house.housePicture).width('100%').height(120).objectFit(ImageFit.Fill)
                // mask
                Image($r('app.media.house_mask')).width('100%').height(120).objectFit(ImageFit.Fill)
                // 定位
                Row({space: 4}){
                  Image($r('app.media.location')).width(14).height(14).objectFit(ImageFit.Fill)
                  Text(house.address).fontColor($r('app.color.white')).fontSize(10)
                }.padding({left: 4, bottom: 4})
              }
              // 价格 单位 面积
              Row(){
                Text(){
                  Span(house.rentPriceListing)
                  Span(house.rentPriceUnit).fontSize(12)
                }.fontSize(14).fontColor($r('app.color.red'))
                Blank()
                Text(`${house.rentArea}m²`).fontSize(10).fontColor($r('app.color.gray_text'))
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({top: 8})
              // 房屋名称
              Row() {
                Text(house.houseTitle)
                  .fontSize(12)
                  .fontWeight(700)
                  .textOverflow({overflow: TextOverflow.Ellipsis})
                  .width('90%')
                  .maxLines(1)
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
              .margin({top: 6})
              // 房屋标签
              Row({space: 6}) {
                ForEach(house.tags, (tag: INearbyHouseTagsItem, index:number) => {
                  Text(tag.name)
                    .fontSize(10)
                    .padding(4)
                    .borderRadius(4)
                    .fontColor(index === 0 ? $r('app.color.white') : $r('app.color.gray_text'))
                    .backgroundColor(index === 0 ? $r('app.color.primary') : $r('app.color.bg_gray_second'))
                    .maxLines(2)
                    .textOverflow({overflow:TextOverflow.Ellipsis})
                }, (item:INearbyHouseTagsItem) => item.name + Math.random())
              }
              .width('96%')
              .justifyContent(FlexAlign.Start)
              .margin({top: 10, left: 'auto', right: 'auto', bottom: 0})
            }
            .height(210)
            .backgroundColor($r('app.color.white'))
            .borderRadius(BORDER_RADIUS)
            .clip(true)
          }
        }, (item:INearbyHouseItem) => item.id)
      }
      .width('100%')
      .rowsGap(10)
      .columnsGap(10)
      .columnsTemplate('1fr 1fr')
      .backgroundColor($r('app.color.bg_gray_second'))
      .padding({top: PADDING, bottom: PADDING})
      .margin({top: 10})
    }
  }
}