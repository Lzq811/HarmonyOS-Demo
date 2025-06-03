import type { IBannerItem, IBannerList } from '../../models/HomeData'

@Component
export default struct SwiperLayout {
  @Prop bannerList: IBannerList

  build() {
    Swiper() {
      ForEach(this.bannerList, (banner: IBannerItem) => {
        Image(banner.imageURL).width('100%').height('100%').objectFit(ImageFit.Fill)
      }, (item: IBannerItem) => item.id + '')
    }
    .width('100%')
    .height(211) // 减去顶部的安全区域
    .loop(true)
    .autoPlay(true)
    .indicator(
      Indicator.dot()// 设置圆形导航点样式
        .color('#CCCBCB')
        .selectedColor($r('app.color.primary'))
    )
  }
}