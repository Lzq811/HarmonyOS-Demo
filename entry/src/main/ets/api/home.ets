import { http } from '../utils/http'
import type { IHomeData, INearbyHouseList } from '../models/HomeData'

// 获取首页数据
export const getHomeDataApi = (): Promise<IHomeData> => {
  return http.get<IHomeData>('/home/info')
}

// 附近房源
export const getNearbyHouseApi = (): Promise<INearbyHouseList> => {
  return http.get<INearbyHouseList>('/house/nearbyHouses')
}