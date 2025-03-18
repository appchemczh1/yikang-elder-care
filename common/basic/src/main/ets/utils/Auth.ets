import { preferences } from '@kit.ArkData'
import { JSON } from '@kit.ArkTS'

class UserAuthStore {
  user_Key: string = 'user-store'
  context?: Context

  //获取仓库
  getStore() {
    return preferences.getPreferencesSync(this.context || getContext(), { name: 'userStore' })
  }

  //添加用户
  async setUser(data: User) {
    const store = this.getStore()
    await store.put(this.user_Key, JSON.stringify(data))
    store.flush()
  }

  //获取用户
  async getUser() {
    const store = this.getStore()
    const user = await store.get(this.user_Key, '{}') as string
    return JSON.parse(user) as User
  }

  //删除用户
  async delUser() {
    const store = this.getStore()
    await store.delete(this.user_Key)
    await store.flush()
  }
}

export class User {
  token: string = ''
}

export const TokenManager = new UserAuthStore()