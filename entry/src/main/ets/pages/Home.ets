import SwiperLayout from '../views/Home/SwiperLayout'
import SearchBar from '../views/Home/SearchBar'
import {getHomeDataApi} from '../api/home'
import type {IBannerList, INavList, IPlanList, ITileList, IColor} from '../models/HomeData'
import NavList from '../views/Home/NavList'
import { PADDING, SHADOW_RADIUS } from '../constants/size'
import TileList from '../views/Home/TileList'
import PlanList from '../views/Home/PlanList'
import NearbyHouse from '../views/Home/NearbyHouse'
import ScrollContainer from '../Components/ScrollContainer/Index'

@Component
export default struct Home {
  @State bannerList: IBannerList = []
  @State navList: INavList = []
  @State tileList: ITileList = []
  @State planList: IPlanList = []
  @State adPicture: string = ''

  aboutToAppear(): void {
    this.getHomeData()
  }

  async getHomeData() {
    const homeData = await getHomeDataApi()
    this.bannerList = homeData.bannerList || []
    this.navList = homeData.navList || []
    this.tileList = homeData.tileList || []
    this.planList = homeData.planList || []
    this.adPicture = homeData.adPicture || ''
  }

  @Builder
  contentBuilder() {
    SwiperLayout({ bannerList: this.bannerList })
    Column() {
      // 导航区域
      NavList({ navList: this.navList })
      // tile区域
      TileList({ tileList: this.tileList })
      // 计划
      PlanList({ planList: this.planList })
      // 广告图片
      Image(this.adPicture)
        .width('100%')
        .height(60)
        .margin({ top: 20 })
        .objectFit(ImageFit.Fill)
        .shadow({
          radius: SHADOW_RADIUS,
          color: $r('app.color.shadow'),
          offsetX: 0,
          offsetY: 0
        })
      NearbyHouse()
    }
    .padding({ left: PADDING, right: PADDING })
  }

  @Builder
  navBuilder($$:IColor) {
    SearchBar({bgColor: $$.bgColor, fontColor: $$.fontColor})
  }

  build() {
    ScrollContainer({
      contentBuilder: () => {
        // contentBuilder中使用的了 this 所以这里需要用箭头函数把this指向的实例传过去
        this.contentBuilder()
      },
      navBuilder: this.navBuilder
    })
  }
}