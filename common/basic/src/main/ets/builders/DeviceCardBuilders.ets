import { ResManager } from "../utils/ResManager"
import { router } from "@kit.ArkUI"

// 模块排列位置
enum Pos {
  x = 'x',
  y = 'y'
}

interface deviceItemParam {
  title: string,
  icon: ResourceStr,
  pos: Pos,
  url: string
}

// 模块item
@Builder
/**
 *
 * @param title
 * @param icon
 * @param pos
 * @param url
 */
function careItem(data: deviceItemParam) {
  if (data.pos === Pos.x) {
    // 护理工作台
    Row({ space: 10 }) {
      Image(data.icon)
        .width(48)
        .aspectRatio(1)
      Text(data.title)
        .fontColor(ResManager.EC_MID_19)
        .fontSize(ResManager.EC_NORMAL_FS)
    }
    .padding({
      top: 20,
      bottom: 23,
      left: 13,
      right: 13
    })
    // .borderRadius(8)
    // .layoutWeight(1)
    // .backgroundColor(ResManager.EC_MID_WHITE)
    .modStyle()
    .onClick(() => {
      router.pushUrl({
        url: data.url
      })
    })
  } else {
    // 设备管理
    Column({ space: 10 }) {
      Image(data.icon)
        .width(40)
        .aspectRatio(1)
      Text(data.title)
        .fontColor(ResManager.EC_MID_19)
        .fontSize(ResManager.EC_SMALL_FS)
    }
    .padding({ top: 23, bottom: 23 })
    // .borderRadius(8)
    // .layoutWeight(1)
    // .backgroundColor(ResManager.EC_MID_WHITE)
    .modStyle()
    .onClick(() => {
      router.pushUrl({
        url: data.url
      })
    })
  }
}

@Builder
export function DeviceManager() {
  Row({ space: 10 }) {
    careItem({
      title: '设备安装',
      icon: $r('app.media.icon_home_sbaz'),
      pos: Pos.y,
      url: 'pages/device/SetupDevicePage'
    })
    careItem({
      title: '设备绑定',
      icon: $r('app.media.icon_home_sbkz'),
      pos: Pos.y,
      url: 'pages/device/BindDevicePage'
    })
    careItem({
      title: '我的设备',
      icon: $r('app.media.icon_home_wdsb'),
      pos: Pos.y,
      url: 'pages/device/MyDevicePage'
    })
    careItem({
      title: '报警设备',
      icon: $r('app.media.icon_home_bjsb'),
      pos: Pos.y,
      url: 'pages/device/AlarmDevicePage'
    })

  }
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
}

@Builder
export function CareCard() {
  Row({ space: 10 }) {
    careItem({
      title: '护理任务',
      icon: $r('app.media.icon_home_hlrw'),
      pos: Pos.x,
      url: 'pages/duty/CareTaskPage'
    })
    careItem({
      title: '护理记录',
      icon: $r('app.media.icon_home_hljl'),
      pos: Pos.x,
      url: 'pages/stage/NurseRecordsPage'
    })

  }
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
}

// 可复用样式
@Styles
function modStyle() {
  .borderRadius(8)
  .layoutWeight(1)
  .backgroundColor(ResManager.EC_MID_WHITE)
}