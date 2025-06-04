import { PADDING } from "../constants/size"
import {rcp} from '@kit.RemoteCommunicationKit'
import { AnyObject } from "../models/HttpModle"

@Component
export default struct See {
  @StorageProp('avoidAreaTop') avoidAreaTop:number = 0
  @State dogData:AnyObject = {}

  aboutToAppear(): void {
    this.getData()
  }

  getData() {
    const baseUrl = 'https://dog.ceo'
    const path = '/api/breeds/image/random'
    const request = new rcp.Request(`${baseUrl}${path}`, 'GET')
    request.headers = { 'Content-Type': 'application/json' }; // 设置请求头
    const session =  rcp.createSession()
    session.fetch(request).then((res:rcp.Response) => {
      console.log(`Response succeeded: ${res}`)
      this.dogData = JSON.parse(`${res}`)
    }).catch((err:rcp.Response) => {
      console.log(JSON.stringify(err) + 'err')
    })
  }

  build() {
    Column() {
      Row({space: 10}){
        Image($r('app.media.bag')).IconStyles().objectFit(ImageFit.Fill)
        Text('填写通勤地址').fontSize(12)
        Blank()
        Image($r('app.media.msg')).IconStyles().objectFit(ImageFit.Fill)
        Image($r('app.media.line')).IconStyles().objectFit(ImageFit.Fill)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Row(){
        Image($r('app.media.find_room')).objectFit(ImageFit.Fill).width(60).height(24)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({top: 50})
      Row(){
        Text('发现你想看的房子').fontColor($r('app.color.black')).fontSize(14)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({top: 30})
      Column({space: 10}){
        // Image($r('app.media.blank')).objectFit(ImageFit.Fill).width(234).height(222)
        Image(this.dogData.message).objectFit(ImageFit.Fill).width(234).height(222)
        Text('暂无想看房源，试试如下找房方式').fontColor($r('app.color.black')).fontSize(16).fontWeight(700)
      }
      .margin({top: 16})
      Row({space: 20}){
        Column(){

        }
      }
      .width(328)
      .height(80)
      .shadow({radius: 20, color: $r('app.color.gray_text')})
      .justifyContent(FlexAlign.Start)
      .margin({top: 30})
    }
    .height('100%')
    .width('100%')
    .padding({ top: this.avoidAreaTop, left: PADDING, right: PADDING })
    .linearGradient({
      direction: GradientDirection.Bottom, // 渐变方向
      repeating: false, // 渐变颜色是否重复
      colors: [['#DEFBE5', 0.0], ['#FFFFFF', 0.25]] // 数组末尾元素占比小于1时满足重复着色效果
    })
  }
}

@Styles
function IconStyles() {
  .width(16).height(16)
}