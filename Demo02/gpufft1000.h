#ifndef GPUFFT1000_H
#define GPUFFT1000_H

#include <QObject>
#include "gpuFFT.h"
#include "time.h"
#include <QList>
#include "math.h"
#include <QFile>
#include <QTextStream>
#include <QDateTime>
#include <nvml.h>
#include <QDebug>

struct FFtPoint
{
    QString time;
    QString index;
    QString value;
};

class GpuFFT1000 : public QObject
{
    Q_OBJECT
public:
    explicit GpuFFT1000(QObject *parent = 0);

    unsigned int gpu_count = 0;
    QList<double> GpuFFt;

    QList<FFtPoint> fftP[4];

    //初始化gpu接口 获取gpu数
    void GpuInitm();
    //计算获取GpuFFT
    double GetGpuFFT(int index);

    QStringList   WriteToData();


    Q_INVOKABLE void ReadFromData();
    Q_INVOKABLE void qmlGetDate();

    Q_INVOKABLE int getNum();
    Q_INVOKABLE int getCurrentLength(int num);
    Q_INVOKABLE QString getTime(int num ,int index);
    Q_INVOKABLE QString getValue(int num ,int index);

signals:
    void writeSuccess();
    void writeDefeated();
public slots:
     void GetData();
};

#endif // GPUFFT1000_H
