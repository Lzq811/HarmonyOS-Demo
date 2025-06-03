本文旨在HarmonyOS开发中使用`axios`来做数据请求。

### 1. 安装依赖

```basic
# 安装
ohpm install @ohos/axios
```

然后可以在 `oh_modules\.ohpm\@ohos+axios@2.2.6` 目录下看到下载的依赖内容。

### 2. 封装

创建目录`entry\src\main\ets\utils\http`用来封装axios调用。

- `entry\src\main\ets\utils\http\http.ets`  封装

  ```tsx
  import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
  import promptAction from '@ohos.promptAction';
  import type {AnyObject} from '../../models/HttpModle'
  const request = axios.create({
    baseURL: 'http://192.168.64.195:6060' // 服务器网关地址
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
        // 返回的已经是校验过code的具体内容了
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
  ```

  

- `entry\src\main\ets\utils\http\index.ets` 用来暴露请求方法。

  ```tsx
  import Http from './http';
  export const http = new Http();
  ```

  

### 3. 调用

1.  接口封装

   创建目录文件 `entry\src\main\ets\api\home.ets`表示 `homepage`用的接口

   ```tsx
   import { http } from '../utils/http'
   import type { IHomeData } from '../models/HomeData' // ets/models目录放置类型对象数据
   
   // 获取首页数据
   export const getHomeDataApi = (): Promise<IHomeData> => {
     return http.get<IHomeData>('/home/info') // 没有参数是可以不传
   }
   ```

   

2. 接口调用，在对应的组件中调用接口

   ```tsx
   import {getHomeDataApi} from '../api/home'
   
   @State bannerList = []
   
   aboutToAppear(): void {
     this.getHomeData()
   }
   
   async getHomeData() {
     /**
     * 只有返回值正常时候才能 homeData。 否则已经在 响应拦截拦截中做了提示处理。
     */
     const homeData = await getHomeDataApi()
     this.bannerList = homeData.bannerList || []
   }
   ```



### 4. 具体代码参考

	[具体实现代码](https://github.com/Lzq811/HarmonyOS-Demo/tree/release-axios-20250603)
