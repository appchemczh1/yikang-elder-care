import { FormData } from "@ohos/axios";
import { request } from "../utils/Request";
import { LoginParams, UserDataModel } from "../viewModel/UserModel";

/**
 * 登录
 * @param data
 * @returns token
 */
export async function loginApi(data: LoginParams): Promise<string> {
  const res = await request<string, LoginParams>({
    url: '/employee/login',
    method: 'POST',
    data: data
  })
  return res
}

/**
 * 获取登录用户信息
 * @returns
 */
export function getUserApi(): Promise<UserDataModel> {
  return request<UserDataModel>({ url: '/employee/user' })
}

export function uploadApi(data: FormData): Promise<string> {
  return request<string, FormData>({
    url: '/common/upload',
    method: 'POST',
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    data: data,
    context: getContext()
  })
}

//修改头像
export function uploadUserAvatar(avatar: string): Promise<null> {
  return request<null>({
    url: '/employee/user/updateAvatar',
    method: 'put',
    params: {
      avatar: avatar
    }
  })
}