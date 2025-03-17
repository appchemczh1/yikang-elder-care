import { window } from '@kit.ArkUI';

@Entry
@Component
struct AdPage {
  @State message: string = '测试页';

  aboutToAppear(): void {
    setTimeout(() => {
      window.findWindow('ad_win').destroyWindow()
    }, 2000)
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('AdPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .backgroundColor(Color.Pink)
    .height('100%')
    .width('100%')
  }
}