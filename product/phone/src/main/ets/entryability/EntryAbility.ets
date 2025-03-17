import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction, window } from '@kit.ArkUI';
//引入之后会执行内部的逻辑
import '../utils/plugins'
import { Log } from '@abner/log';
import dayjs from 'dayjs';
import { instance, request } from '@hm/basic';

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    Log.info('Ability onCreate');
    // instance.get<null, string>('employee/user')
    //   .then((res) => {
    //     Log.info(JSON.stringify(res))
    //   })
    interface User {
      id: string
      username: string
      nickName: string
    }

    const res = await request<User>({
      url: '/employee/user',
    })
  }

  onDestroy(): void {
    Log.info('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Log.info('Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        Log.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Log.info('Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Log.info('Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    Log.info('Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    Log.info('Ability onBackground');
  }
}