#include "gpufft1000.h"

GpuFFT1000::GpuFFT1000(QObject *parent) : QObject(parent)
{
    //初始化 获取GPU核心数
    GpuInitm();
    //从json获取定时统计的计划时间
    planTime = readJsonTime() != ""? readJsonTime() : "10:00";
    //定时器 60s触发一次
    QTimer *m_timer = new QTimer(this);
    connect(m_timer, SIGNAL(timeout()), this, SLOT(autoKeepSampleTimeOut()));
    m_timer->start(1000*60); //every 1 minutes
}
//对比当前是否为定时时间
void GpuFFT1000::autoKeepSampleTimeOut()
{
    QDateTime datetime = QDateTime::currentDateTime();
    planTime = readJsonTime() != ""? readJsonTime() : "10:00";
    if(datetime.toString("hh:mm") == planTime)
    {
        qDebug()<<datetime.toString("hh:mm");
        qmlGetDate();
    }
}
//读取json
QString GpuFFT1000::readJsonTime()
   {
    //qDebug()<<QDateTime::currentDateTime().toString("hh::mm::ss::zzz");
      QString val;
      QFile file("default.json");
      file.open(QIODevice::ReadOnly | QIODevice::Text);
      val = file.readAll();
      file.close();
      QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());
      QJsonObject sett2 = d.object();
      QJsonValue value = sett2.value("time");
      //qDebug()<< "value::::"<<value.toString();
      return value.toString();
   }

//GPU Init ---- To Get Gpu Count
void GpuFFT1000::GpuInitm()
{
    nvmlReturn_t result;
    result = nvmlInit();
    result = nvmlDeviceGetCount(&gpu_count);
}
//全局函数 用于开辟线程
void startCalc(GpuFFT1000 *calc)
{
    calc->GetData();//计算-写入文件-读取文件至表列-发送writeSuccess writeDefeated 信号
}
//qml及定时器的响应函数 计算的开始
void GpuFFT1000::qmlGetDate()
{
    if(!isRuning)
    {
    //创建一个新线程。
     isRuning= true;
     std::thread getThread(startCalc, this);
     getThread.detach();
    }
}
int GpuFFT1000::getNum()
{
    return gpu_count;
}
int GpuFFT1000::getCurrentLength(int num)
{
    return fftP[num].length();
}
QString GpuFFT1000::getTime(int num ,int index)
{
    return fftP[num].at(index).time;
}

QString GpuFFT1000::getValue(int num ,int index)
{
    return fftP[num].at(index).value;
}

void GpuFFT1000::GetData()
{
    GpuInitm();
    double temp;
    GpuFFt.clear();
    if(gpu_count != 0)
    {
        for(int index =0; index<(int)gpu_count ; index++)
        {
           temp = GetGpuFFT(index);
           GpuFFt.append(temp);
        }
        WriteToData();
        return;
    }
    isRuning = false;
    emit writeDefeated();
}
void GpuFFT1000::ReadFromData()
{
    QString strAll;
    QStringList strList;
    QFile readFile("FFTDATA.txt");
    if(readFile.open((QIODevice::ReadOnly|QIODevice::Text)))
    {
        QTextStream stream(&readFile);
        strAll=stream.readAll();
        strList=strAll.split("\n");
        if(strList.length() == 1)
        {
            strList.clear();
        }
        if(strList.length() > 0)
        {
            for(int ii=0;ii<defGpuCount;ii++)
            {
                fftP[ii].clear();
            }
            foreach (QString onedata, strList)
            {
                //QString onedata = strList.at(strList.length()-2);
                QString time = onedata.section(">",1,1);
                int num = onedata.count('>');
                num = num/2-1;
                if(num>0)
                {
                    for(int idx=0;idx<num;idx++)
                    {
                       QString gpuIndex = onedata.section(">",2+idx*2,2+idx*2);
                       QString gpuValue = onedata.section(">",3+idx*2,3+idx*2);
                       FFtPoint tempP;
                       tempP.time = time;
                       tempP.index = gpuIndex;
                       tempP.value = gpuValue;
                       fftP[idx].append(tempP);
                    }
                }
            }
            isRuning = false;
            emit writeSuccess();
            return;
        }
        isRuning = false;
        emit writeDefeated();
    }
}

QStringList GpuFFT1000::WriteToData()
{
    bool hasData = false;
    QString strAll;
    QStringList strList;
    QFile readFile("FFTDATA.txt");
    QString time = QDateTime::currentDateTime().toString("yyyy.MM.dd");
    if(readFile.open((QIODevice::ReadWrite|QIODevice::Text)))
    {
        QTextStream stream(&readFile);
        strAll=stream.readAll();
        strList=strAll.split("\n");
        if(strList.length() == 1)
        {
            strList.clear();
        }
        //判断获取到的list 不为空
        if(strList.length() > 0)
        {
            QString onedata = strList.at(strList.length()-2);
            QString lastTime = onedata.section(">",1,1);
            //判断是否已经有当天数据
            if(lastTime == time && lastTime != "")
            {
                hasData = true;
            }
            //如果有当天数据
            if(hasData)
            {
                if(GpuFFt.length() != 0)
                {
                    strList[strList.length()-2] = "";
                    QString temp ="Data >"+ time+">";
                    for(int ind=0 ; ind<GpuFFt.length() ; ind++)
                    {
                        temp = temp + QString::number(ind) +">"+ QString::number(GpuFFt.at(ind)) +">";
                    }
                    strList[strList.length()-2] = temp;
                }
            }
            else
            {
                if(GpuFFt.length() != 0)
                {
                    QString temp ="Data >"+ time+">";
                    for(int ind=0 ; ind<GpuFFt.length() ; ind++)
                    {
                        temp = temp + QString::number(ind) +">"+ QString::number(GpuFFt.at(ind)) +">";
                    }
                    strList.append(temp);
                }
            }
        }
        //如果获取到的list为空
        else
        {
            if(GpuFFt.length() != 0)
            {
                QString temp ="Data >"+ time+">";
                for(int ind=0 ; ind<GpuFFt.length() ; ind++)
                {
                    temp = temp + QString::number(ind) +">"+ QString::number(GpuFFt.at(ind)) +">";
                }
                strList.append(temp);
            }
        }
        readFile.close();
        //重新写入
        if(readFile.open((QIODevice::ReadWrite|QIODevice::Truncate)))
        {
            strAll ="";
            int current = 0;
            foreach (QString s, strList) {
                current++;
                //每行添加换行
                if(current != strList.length()-1)
                {
                    s += "\r\n";
                }
                strAll +=s;
            }
            stream<<strAll;
           readFile.close();
        }
        ReadFromData();
    }
    return strList;
}
double GpuFFT1000::GetGpuFFT(int index)
{
    int nFFTorder = 20; //20阶FFT
    int nRepeatTimes = 1000; //重复运算次数
    unsigned int DeviceIdx = index; //GPU设备ID

    int nSignalLen = pow((double)2, nFFTorder);

    dat32fc* pSrc = (dat32fc *)malloc(nSignalLen * sizeof(dat32fc));
    if (NULL == pSrc)
    {
        printf("Fail to call Malloc(), for nSignalLen = %d\n", nSignalLen);
        isRuning = false;
        emit writeDefeated();
        return 1;
    }
    dat32fc* pDst = (dat32fc *)malloc(nSignalLen * sizeof(dat32fc));
    if (NULL == pDst)
    {
        printf("Fail to call Malloc(), for nSignalLen = %d\n", nSignalLen);
        isRuning = false;
        emit writeDefeated();
        return 1;
    }

    //产生随机信号
    for (int i = 0; i < nSignalLen; i++)
    {
        pSrc[i].re = rand() * 1.0f / RAND_MAX;
        pSrc[i].im = rand() * 1.0f / RAND_MAX;
    }

    DoFFTuseGPU(pSrc, pDst, nFFTorder, 1, DeviceIdx); // 首先试跑一次GPU

    clock_t startTime, finishTime;
    startTime = clock();

    DoFFTuseGPU(pSrc, pDst, nFFTorder, nRepeatTimes, DeviceIdx); // 重复运算1000次

    finishTime = clock();

    double duration = (double)(finishTime - startTime) / CLOCKS_PER_SEC;

    free(pSrc);
    free(pDst);
    return duration;
    return 0;
}
