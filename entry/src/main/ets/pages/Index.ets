import Home from './Home';
import See from './See';
import Service from './Service';
import Discover from './Discover';
import My from './My';
import {window} from '@kit.ArkUI'

@Entry
@Component
struct Index {
  avoidAreaBottom:number = AppStorage.get('avoidAreaBottom') || 0
  // 当前 tab 高亮的下标
  @State currentIndex: number = 1;

  // 生成 tab 的函数
  @Builder TabBuilder(index: number, text: string, icon: Resource, activeIcon: Resource) {
    Column() {
      // 项目中常用的颜色、大小等会定义成常量，将来方便复用和统一调整。而不常用的大小颜色就不需要定义了，直接写死即可。
      Image(this.currentIndex === index ? activeIcon : icon).width(28)
      Text(text).fontSize(10).fontColor(this.currentIndex === index ? $r('app.color.black') : $r('app.color.gray_text')).height(15)
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }

  // 设置状态里 页面最顶部 时间 信息 电池等的颜色
  setWindowStatusColor = async (color:string) => {
    const windowClass = await window.getLastWindow(getContext())
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: color
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
        TabContent() {
          Home()
        }.tabBar(this.TabBuilder(0, '首页', $r('app.media.tabbar_home'), $r('app.media.tabbar_home_active')))

        TabContent() {
          See()
        }.tabBar(this.TabBuilder(1, '想看', $r('app.media.tabbar_see'), $r('app.media.tabbar_see_active')))

        TabContent() {
          Service()
        }.tabBar(this.TabBuilder(2, '服务', $r('app.media.tabbar_service'), $r('app.media.tabbar_service_active')))

        TabContent() {
          Discover()
        }.tabBar(this.TabBuilder(3, '发现', $r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active')))

        TabContent() {
          My()
        }.tabBar(this.TabBuilder(4, '我的', $r('app.media.tabbar_my'), $r('app.media.tabbar_my_active')))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentIndex = index
        // 不同tab页面展示不同的状态栏颜色
        if (index === 0) { // 首页
          this.setWindowStatusColor('#FFFFFF')
        } else if (index === 1) { // 想看
          this.setWindowStatusColor('#000000')
        }
      })
      .barHeight(50 + this.avoidAreaBottom) // 设置 tab 导航栏的高度，默认 56 避开安全区域
      .scrollable(false)
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.white'))
    }
    .height('100%')
  }
}
