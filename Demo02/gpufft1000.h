#ifndef GPUFFT1000_H
#define GPUFFT1000_H

#include <QObject>
#include"./LIB/gpuFFTdll_v8.0/gpuFFT.cuh"
#include "time.h"
#include <QList>
#include "math.h"
class GpuFFT1000 : public QObject
{
    Q_OBJECT
public:
    explicit GpuFFT1000(QObject *parent = 0);

    double GetGpuFFT(int index);
signals:

public slots:
};

#endif // GPUFFT1000_H
