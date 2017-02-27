setScreenScale(720,1280) 
init("0", 1); --以当前应用 Home 键在右初始化
--点击
function tap(x,y)
  touchDown(0,x,y)
  mSleep(500)
  touchUp(0,x,y)
end

function putcolor(x,y)
  mSleep(1000)
  f=getColor(x,y)
  sysLog(f)
end
--打开章节
function OpenYaoGuan(Sec)
  SectionMove()
  Sec=tonumber(Sec)
  if Sec==1 then
    sysLog(Sec)
    tap(1189,197)
    mSleep(1000)
  elseif Sec==2 then
    sysLog(Sec)
    tap(1189,310)
    mSleep(1000)
  elseif Sec==3 then
    sysLog(Sec)
    tap(1189,441)
    mSleep(1000)
  elseif Sec==4 then
    sysLog(Sec)
    tap(1189,559)
    mSleep(1000)
  elseif Sec>=5 then
    for i=Sec,4,-1 do
      MoveOne()--移动一次
    end
    sysLog(Sec)
    tap(1189,559)
    mSleep(1000)
  else
    dialog("打开章节失败")
  end
end

--点击准备按钮
function Ready()
  mSleep(6000)
  while true do 
    x, y = findColorInRegionFuzzy(14075299, 80, 1063, 461, 1257, 643); 
    if x ~= -1 and y ~= -1 then  
      tap(x,y)
      mSleep(500)
      tap(x,y)
      sysLog("点击了准备")
      break
    end
  end
end

--胜利后点击奖励退出
function Victory()
  while true do
    mSleep(3000)
    x, y = findColorInRegionFuzzy(13549483, 100, 427, 155,523,213); 
    if x ~= -1 and y ~= -1 then  --如指定区域找到符合条件的某点
      mSleep(3000)
      tap(488,432)
      sysLog("点击退出")
      mSleep(2000)
      tap(488,432)
      sysLog("点击退出")
      mSleep(4000)
      tap(488,432)
      sysLog("点击退出")
      mSleep(10000)
      break
    else
    end
  end
end

function walk()
  while true do 
    --向右走
    tap(1200,700)
    mSleep(3000)
    tap(1200,700)
    mSleep(3000)
    tap(1200,700)
    mSleep(3000)
    while true do
      x, y = findColorInRegionFuzzy(4728599 or 3941395, 100, 0, 100, 1280, 450); 
      if x ~= -1 and y ~= -1 then  --如指定区域找到符合条件的某点
        sysLog("发现了新妖怪")
        find()
        break
      else
        --向左走
        tap(200,700)
        mSleep(3000)
        tap(200,700)
        mSleep(3000)
        tap(200,700)
        mSleep(3000)
        while true do
          x, y = findColorInRegionFuzzy(4728599 or 3941395, 100, 0, 100, 1280, 450); 
          if x ~= -1 and y ~= -1 then  --如指定区域找到符合条件的某点
            sysLog("发现了新妖怪")
            find()
            break
          else
            break
          end
        end
      end
    end
  end
  
end
--点击奖励盒子
function Box()
  mSleep(3000)
  while true do
    x, y = findColorInRegionFuzzy(16774355, 100, 452, 251, 875, 510); 
    if x ~= -1 and y ~= -1 then  --如指定区域找到符合条件的某点
      sysLog("发现奖励盒子")
      tap(x,y)
      mSleep(3000)
      tap(1200,700)
      mSleep(3000)
      tap(x,y)
      Box()
    else
      sysLog("结束一章")
      break
      
    end
  end
end


--初始化选择关卡条
function SectionMove()
  touchDown(1, 1203, 218)
  mSleep(50)
  touchMove(1, 1203, 583)
  mSleep(50)
  touchUp(1, 1203, 583)
  --再拉一次
  mSleep(100)
   touchDown(1, 1203, 218)
  mSleep(50)
  touchMove(1, 1203, 583)
  mSleep(50)
  touchUp(1, 1203, 583)
end
--移动一个章节
function MoveOne()
  touchDown(1, 1203, 263)
  mSleep(50)
  touchMove(1, 1203, 143)
  mSleep(50)
  touchUp(1, 1203, 143)
end

--发现妖怪
function find()
  --开始寻找怪物
  mSleep(10000)
  tap(1000,700)
  while true do
    x1, y1 = findMultiColorInRegionFuzzy2(0x3c3b67, {{x=40, y=0, color=0x89521e},{x=0,y=-40,color=0x866d5d},{x=40,y=-40,color=0x162f46}}, 95, 0, 0, 639, 959) --boss
    x0, y0 = findColorInRegionFuzzy(3941395, 100, 0, 200, 1280, 450); --普通怪物
    --优先打boss
    if x1 ~= -1 and y1~=-1 then
      sysLog("发现boss")
      x=x1
      y=y1
      tap(x,y)
      Ready()
      Victory()
      Box()
      break
    end
    --打一般怪物
    if x0 ~= -1 and y0~=-1 then
      sysLog("发现一般怪物")
      x=x0
      y=y0
      tap(x,y)
      Ready()
      Victory()
      find()
    end
    if x0==-1 or x1==-1 then
      --判断是否退打完了回到出发界面
      a=getColor(582,34)
      if a~=3217680 then
        sysLog("走路")
        walk()
      else
        break
      end
    end
    break
  end
end








--探索函数
function TanSuo(Sec)
  --打开妖怪发现
  OpenYaoGuan(Sec)
  --点击探索
  tap(948,531)
  --发现妖怪
  find()
end




--探索循环
function Tan_Cyc(Num,Sec)
  if Num~=0 then
    for a=Num,1,-1 do
      TanSuo(Sec)
    end
  end
end



--主函数

--弹出对话框

ret,results=showUI("ui.json")
TanNum=results["Tan"]
TanSec=results["Tan_section"]

--GUI确定返回值1后运行程序
if ret==1 then
  mSleep(2000)
  Tan_Cyc(TanNum,TanSec)
  
  
end
