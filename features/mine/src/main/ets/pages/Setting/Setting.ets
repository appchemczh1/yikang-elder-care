import router from '@ohos.router'
import {
  EcDialogUpload,
  getUserApi,
  ResManager,
  RouterConfig,
  uploadApi,
  uploadUserAvatar,
  UserData,
  UserDataModel
} from '@hm/basic/Index'
import { fileIo } from '@kit.CoreFileKit'
import { FormData } from '@ohos/axios'
import { Log } from '@abner/log'
import { EcLoading } from '@itheima/wing-care'
import { emitter } from '@kit.BasicServicesKit'

interface CellParam {
  title: string
  rightContent: string
  isAvatar: boolean
}

@Entry
@Component
struct Setting {
  @StorageProp('topHeight')
  topHeight: number = 0
  //loading加载弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: EcLoading(),
    customStyle: true,
    autoCancel: false,
    alignment: DialogAlignment.Center
  })
  // 上传弹层控制
  uploadDialog: CustomDialogController = new CustomDialogController({
    // 使用自定义弹层组件
    builder: EcDialogUpload({
      callback: async (url: string) => {
        this.dialogController.open()
        await this.uploadImage(url)
        this.dialogController.close()
      }
    }),
    alignment: DialogAlignment.Bottom
  })

  //上传方法
  async uploadImage(url: string) {
    //拷贝
    //首选要将图片进行沙箱文件处理，因为上传接口只能接受沙箱文件的内容
    const file = fileIo.openSync(url, fileIo.OpenMode.READ_ONLY) //获取媒体文件信息
    const filePath = getContext().cacheDir + '/' + file.name //获取沙箱路径
    fileIo.copyFileSync(file.fd, filePath)
    const data = new FormData
    data.append('file', `internal://cache/${file.name}`)
    //上传
    const urlRes = await uploadApi(data)
    Log.info('urlRes:' + JSON.stringify(urlRes))
    //更换用户头像
    await uploadUserAvatar(urlRes)
    this.aboutToAppear()
  }

  @State
  user: UserDataModel = new UserDataModel({} as UserData)

  async getUser() {
    const data = await getUserApi()
    this.user = data
  }

  aboutToAppear(): void {
    this.getUser()

    emitter.on('updateUser', () => {
      this.getUser()
    })
  }

  @Builder
  cellItem(cellParam: CellParam) {
    Row() {
      Text(cellParam.title)
        .fontColor(ResManager.EC_MID_19)
        .fontSize(ResManager.EC_MODULE_TITLE_FS)
        .fontWeight(500)
      Row({ space: 10 }) {
        if (!cellParam.isAvatar) {
          // 昵称修改
          Text(cellParam.rightContent)
            .fontColor(ResManager.EC_MID_59)
            .fontSize(ResManager.EC_NORMAL_FS)
            .onClick(() => {
              router.pushUrl({
                url: RouterConfig.USER_NAME_URL,
                params: {
                  nickName: cellParam.rightContent
                }
              })
            })
        } else {
          // 上传
          Image(cellParam.rightContent)
            .width(34)
            .aspectRatio(1)
            .borderRadius(17)
            .onClick(() => {
              this.uploadDialog.open()
            })
        }
        Image($r('app.media.ic_arrow_black'))
          .width(7)
          .height(16)
      }
    }
    .width('100%')
    .padding({ top: 14, bottom: 14 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Navigation() {
      Column() {
        Column() {
          List() {
            ListItem() {
              this.cellItem({ title: '头像', rightContent: this.user.avatar!, isAvatar: true })
            }

            ListItem() {
              this.cellItem({ title: '昵称', rightContent: this.user.nickName!, isAvatar: false })
            }
          }
          .width('100%')
          .height('auto')
          .padding({ left: 14, right: 18, })
          .divider({ strokeWidth: 1, color: ResManager.EC_MID_LINE })
        }
        .margin({
          top: ResManager.EC_CONTENT_SPACE,
          left: ResManager.EC_CONTENT_SPACE,
          right: ResManager.EC_CONTENT_SPACE
        })
        // .width('100%')
        .backgroundColor('#fff')
        .borderRadius(ResManager.EC_NORMAL_RD)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ResManager.EC_MID_BG)
    }
    .title('个人设置')
    .padding({ top: this.topHeight })
    .titleMode(NavigationTitleMode.Mini)
  }
}