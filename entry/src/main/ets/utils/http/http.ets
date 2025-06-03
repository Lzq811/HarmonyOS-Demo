import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import promptAction from '@ohos.promptAction';
import type {AnyObject} from '../../models/HttpModle'
const request = axios.create({
  baseURL: 'http://192.168.64.195:6060' // 通过 ipconfig 查询当前电脑的 ip，使用自己电脑的 ip 地址
})

request.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // 未来需要添加 token
    // config.headers.token = token;
    return config;
  }
)

request.interceptors.response.use(
  (response: AxiosResponse) => {
    if (response.data.code === 200) {
      return response.data.data;
    } else {
      // 错误提示
      promptAction.showToast({message: response.data.message, duration: 1000})
      return Promise.reject(response.data.message);
    }
  },
  (error: AxiosError) => {
    // 错误提示
    promptAction.showToast({message: error.message, duration: 1000})
    return Promise.reject(error.message);
  }
)

export default class Http {
  get<T>(url: string, params?: AnyObject) {
    return request.get<null, T>(url, {
      params
    })
  }

  post<T>(url: string, data?: AnyObject) {
    return request.post<null, T>(url, data)
  }

  put<T>(url: string, data?: AnyObject) {
    return request.put<null, T>(url, data)
  }

  delete<T>(url: string, params?: AnyObject) {
    return request.delete<null, T>(url, {
      params
    })
  }
};