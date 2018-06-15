#include "gpufft1000.h"

GpuFFT1000::GpuFFT1000(QObject *parent) : QObject(parent)
{

}

double GpuFFT1000::GetGpuFFT(int index)
{
    int nFFTorder = 20; //20阶FFT
    int nRepeatTimes = 10000; //重复运算次数
    unsigned int DeviceIdx = index; //GPU设备ID

    int nSignalLen = pow((double)2, nFFTorder);

    dat32fc* pSrc = (dat32fc *)malloc(nSignalLen * sizeof(dat32fc));
    if (NULL == pSrc)
    {
        printf("Fail to call Malloc(), for nSignalLen = %d\n", nSignalLen);
        return 1;
    }
    dat32fc* pDst = (dat32fc *)malloc(nSignalLen * sizeof(dat32fc));
    if (NULL == pDst)
    {
        printf("Fail to call Malloc(), for nSignalLen = %d\n", nSignalLen);
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

//        printf("%f seconds\n", duration);
    return duration;
    return 0;
}
