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