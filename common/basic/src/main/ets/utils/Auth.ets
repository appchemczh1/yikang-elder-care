import { preferences } from '@kit.ArkData'
import { JSON } from '@kit.ArkTS'

class UserAuthStore {
  user_Key: string = 'user-store'
  context?: Context

  //获取仓库
  getStore() {
    return preferences.getPreferencesSync(this.context || getContext(), { name: this.user_Key })
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
    const user = await store.get(this.user_Key, '') as string
    if (user) {
      return JSON.parse(user) as User
    } else {
      return null
    }
  }

  //删除用户
  delUser() {
    const store = this.getStore()
    store.delete(this.user_Key)
    store.flush()
  }
}

export class User {
  token: string = ''
}

export const TokenManager = new UserAuthStore()