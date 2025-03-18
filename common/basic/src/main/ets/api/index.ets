import { request } from "../utils/Request";
import { LoginParams } from "../viewModel/UserModel";


export async function loginApi(data: LoginParams): Promise<string> {
  const res = await request<string, LoginParams>({
    url: '/employee/login',
    method: 'POST',
    data: data
  })
  return res
}