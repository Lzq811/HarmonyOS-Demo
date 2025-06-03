import {IColor} from '../../models/HomeData'
import {window} from '@kit.ArkUI'

@Component
export default struct Index {
  @Builder defaultBuilder(){}
  @BuilderParam contentBuilder: () => void = this.defaultBuilder
  @BuilderParam navBuilder: ($$: IColor) => void = this.defaultBuilder

  avoidAreaTop:number = AppStorage.get('avoidAreaTop') || 0 // 页面顶部安全区域

  scrollY: number = 0
  @State headBgColor: string = 'rgba(255, 255, 255, 0)'
  @State headFontColor: string = 'rgb(255, 255, 255)'

  // 监听页面滚动事件
  handleScroll = (xOffset: number, yOffset: number) => {
    // yOffset 是每次页面滚动的变化距离
    this.scrollY += yOffset
    if (this.scrollY <=0 ) {
      this.scrollY = 0
    }
    this.calcColor()
  }
  // 计算头部栏样式
  calcColor = () => {
    if (this.scrollY > 10) {
      this.headBgColor = 'rgba(255, 255, 255, 1)'
      this.headFontColor = 'rgb(0, 0, 0)'
      this.setWindowStatusColor('black')
    } else {
      // 默认
      this.headBgColor = 'rgba(255, 255, 255, 0)'
      this.headFontColor = 'rgb(255, 255, 255)'
      this.setWindowStatusColor('white')
    }
  }

  // 设置状态里 页面最顶部 时间 信息 电池等的颜色
  setWindowStatusColor = async (colorType:string) => {
    const windowClass = await window.getLastWindow(getContext())
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: colorType === 'white' ? '#FFFFFF' : '#000000'
    })
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          // 主体内容插槽
          this.contentBuilder()
        }.align(Alignment.TopStart)
      }
      .height('100%')
      .scrollBar(BarState.Off)
      .onDidScroll(this.handleScroll)
      // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 使用了全屏模式
      Column(){
        // 页面顶部固定内容插槽
        this.navBuilder({bgColor: this.headBgColor, fontColor: this.headFontColor})
      }
      .backgroundColor(this.headBgColor)
      .padding({top: this.avoidAreaTop})

    }
    .alignContent(Alignment.TopStart)
  }
}