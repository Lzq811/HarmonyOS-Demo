/**
 * 统一封装rcp请求方式
 */
import { AnyObject } from '../../models/HttpModle'
import {rcp} from '@kit.RemoteCommunicationKit'
import { BusinessError } from '@kit.BasicServicesKit'
import promptAction from '@ohos.promptAction';

enum httpType {
  GET = 'GET',
  POST = 'POST'
}

const BASE_URL:string = 'http://192.168.64.196:6060'

const RcpRequest = (url:string, params?:AnyObject, method:httpType = httpType.GET): Promise<string> => {
  const headers:rcp.RequestHeaders = {'accept': 'application/json'} // 配置headers
  const session = rcp.createSession()
  const req = new rcp.Request(`${BASE_URL}${url}`, method, headers, params)

  return session.fetch(req).then((response) => {
    if (response) {
      return JSON.stringify(response) // 原始数据需手动解析
    } else {
      // 错误提示
      promptAction.showToast({message: '获取信息失败', duration: 1000})
      return Promise.reject(response);
    }
  }).catch((error:BusinessError) => {
    // 错误提示
    promptAction.showToast({message: error.message, duration: 1000})
    return Promise.reject(error.message);
  })
}