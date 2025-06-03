// 设计稿的宽度
const DRAFT_WIDTH:number = 360

// 真机的宽度 -- EntryAbility --onWindowStageCreate -- windowClass获取.当前未遇到问题暂不启用
const WINDOW_WIDTH:number = AppStorage.get('windowWidth') as number ||  DRAFT_WIDTH

const rvp = (val: number) => {
  /**
   * 计算真正的大小
   * 使用 设计稿上的具体值 / 设计稿的宽度 得到 占比
   * 占比 * 真机的宽度 得到 真正的大小
   */
  return val / DRAFT_WIDTH * WINDOW_WIDTH
}

export default rvp