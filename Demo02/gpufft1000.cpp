#include "gpufft1000.h"

GpuFFT1000::GpuFFT1000(QObject *parent) : QObject(parent)
{
    GpuInitm();
}

//GPU Init ---- To Get Gpu Count
void GpuFFT1000::GpuInitm()
{
    nvmlReturn_t result;
    result = nvmlInit();
    result = nvmlDeviceGetCount(&gpu_count);
    qDebug()<<"gpu_count:::"<<gpu_count;
}
void GpuFFT1000::qmlGetDate()
{
    GetData();
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
//    ReadFromData();
    qDebug()<<"GetData";
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
    emit writeDefeated();
}
void GpuFFT1000::ReadFromData()
{
    qDebug()<<"h";
    QString strAll;
    QStringList strList;
    QFile readFile("FFTDATA.txt");
    if(readFile.open((QIODevice::ReadOnly|QIODevice::Text)))
    {
        qDebug()<<"h1";
        QTextStream stream(&readFile);
        strAll=stream.readAll();
        strList=strAll.split("\n");
        if(strList.length() == 1)
        {
            qDebug()<<"h11";
            strList.clear();
        }
        if(strList.length() > 0)
        {
            for(int ii=0;ii<4;ii++)
            {
                fftP[ii].clear();
            }
            qDebug()<<"h12";
            foreach (QString onedata, strList)
            {
                qDebug()<<"h121";
                //QString onedata = strList.at(strList.length()-2);
                QString time = onedata.section(">",1,1);
                int num = onedata.count('>');
                num = num/2-1;
                qDebug()<<"num::"<<num;
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
                       qDebug()<<"h1212: "<<time<<" "<<gpuValue<<" "<<gpuValue;
                       qDebug()<<"fftPlength::"<<fftP[idx].length();
                    }

                }
            }
            emit writeSuccess();
            return;
        }
        emit writeDefeated();
    }
}

QStringList GpuFFT1000::WriteToData()
{
    qDebug()<<"WriteToData";
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
            //qDebug()<<"strListonedata" <<onedata;
            QString lastTime = onedata.section(">",1,1);
            //判断是否已经有当天数据
            if(lastTime == time && lastTime != "")
            {
                hasData = true;
                qDebug()<<"hasData" <<hasData;
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
    qDebug()<<"GetGpuFFT";
    int nFFTorder = 20; //20阶FFT
    int nRepeatTimes = 1000; //重复运算次数
    unsigned int DeviceIdx = index; //GPU设备ID

    int nSignalLen = pow((double)2, nFFTorder);

    dat32fc* pSrc = (dat32fc *)malloc(nSignalLen * sizeof(dat32fc));
    if (NULL == pSrc)
    {
        printf("Fail to call Malloc(), for nSignalLen = %d\n", nSignalLen);
        emit writeDefeated();
        return 1;
    }
    dat32fc* pDst = (dat32fc *)malloc(nSignalLen * sizeof(dat32fc));
    if (NULL == pDst)
    {
        printf("Fail to call Malloc(), for nSignalLen = %d\n", nSignalLen);
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

    return duration;
    return 0;
}
