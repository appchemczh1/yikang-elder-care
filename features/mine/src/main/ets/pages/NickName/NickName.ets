import { request, ResManager, updateNickName } from '@hm/basic/Index';
import { promptAction, router } from '@kit.ArkUI';
import { emitter } from '@kit.BasicServicesKit';

@Entry
@Component
struct NickName {
  @StorageProp('topHeight')
  topHeight: number = 0
  @State
  nickName: string = ''

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, string>
    this.nickName = params['nickName']
  }

  // 提交
  async save() {
    await updateNickName(this.nickName)
    promptAction.showToast({
      message: '修改成功',
      duration: 2000,
    })
    router.back()

    emitter.emit('updateUser')
  }

  build() {
    Navigation() {
      Column() {
        // Text(this.nickname)
        TextInput({ text: $$this.nickName, placeholder: '请输入昵称' })
          .height(50)
          .borderRadius(ResManager.EC_NORMAL_RD)
          .backgroundColor('#fff')
          .placeholderColor(ResManager.EC_MID_99)
        //   提交
        Button('保存', { type: ButtonType.Capsule })
          .margin({ top: 50 })
          .width(230)
          .enabled(this.nickName !== '')
          .onClick(() => {
            this.save()
          })
      }
      .margin({ left: 15, right: 15 })

    }
    .title('昵称')
    .padding({ top: this.topHeight })
    .titleMode(NavigationTitleMode.Mini)
    .backgroundColor(ResManager.EC_MID_BG)
  }
}