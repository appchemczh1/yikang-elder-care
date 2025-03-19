import picker from '@ohos.file.picker'
import cameraPicker from '@ohos.multimedia.cameraPicker';
import camera from '@ohos.multimedia.camera';
import common from '@ohos.app.ability.common';
import { BusinessError } from '@ohos.base';
import { ResManager } from '../utils/ResManager';
import { Log } from '@abner/log';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

@CustomDialog
export struct EcDialogUpload {
  // 控制器
  controller: CustomDialogController
  callback: (url: string) => void = (url: string) => {
  }

  //拍照
  async takePhoto() {
    let mContext = getContext(this) as common.Context;

    try {
      let pickerProfile: cameraPicker.PickerProfile = {
        cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
      };
      let pickerResult: cameraPicker.PickerResult = await cameraPicker.pick(mContext,
        [cameraPicker.PickerMediaType.PHOTO, cameraPicker.PickerMediaType.VIDEO], pickerProfile);
      Log.log("the pick pickerResult is:" + JSON.stringify(pickerResult));
      this.callback(pickerResult.resultUri)
    } catch (error) {
      let err = error as BusinessError;
      Log.error(`the pick call failed. error code: ${err.code}`);
    }
  }

  //相册选择
  async selectPicture() {
    let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
    PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
    PhotoSelectOptions.maxSelectNumber = 1;
    let photoPicker = new photoAccessHelper.PhotoViewPicker();
    const res = await photoPicker.select(PhotoSelectOptions)
    this.callback(res.photoUris[0]) //选取第0张图片

    Log.info('the pick photoPicker is:' + JSON.stringify(res))
  }

  build() {
    Column() {
      // 选项列表
      List() {
        ListItem() {
          Text('拍照')
            .fontColor(ResManager.EC_MAIN_COLOR)
            .fontSize(ResManager.EC_MODULE_TITLE_FS)
            .fontWeight(500)
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding(15)
            .onClick(() => {
              this.takePhoto()
            })
        }

        ListItem() {
          Text('从相册选择')
            .fontColor(ResManager.EC_MAIN_COLOR)
            .fontSize(ResManager.EC_MODULE_TITLE_FS)
            .fontWeight(500)
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding(15)
            .onClick(() => {
              this.selectPicture()
            })
        }

        ListItem() {
          Text('取消')
            .fontColor(ResManager.EC_MID_59)
            .fontSize(ResManager.EC_MODULE_TITLE_FS)
            .fontWeight(500)
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding(15)
        }
      }
      .width('100%')
      .height('auto')
      .divider({ strokeWidth: 0.5, color: ResManager.EC_MID_LINE })
      .padding(ResManager.EC_CONTENT_SPACE)
      .backgroundColor('#fff')
      .borderRadius(ResManager.EC_NORMAL_RD)

    }
  }
}
