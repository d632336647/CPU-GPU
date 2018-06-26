#ifndef GETSYSINFO_H
#define GETSYSINFO_H
#include <QObject>
#include "windows.h"
#include <QDebug>
#include <QString>
#include <QTimer>
#include <QFileInfo>
#include <QDir>
#include <QList>

#include <nvml.h>
#include "gpufft1000.h"

//全局结构体---磁盘
struct ListFileInfo
{
    QString use;
    QString free;
    QString all;
    QString diskName;
    int diskPercent;
};
//全局结构体---GPU
struct ListGpuInfo
{
    QString gpuPercent;
    QString gpuCache;
};

class GetSysInfo : public QObject
{
    Q_OBJECT
public:
    explicit GetSysInfo(QObject *parent = 0);
    ~GetSysInfo();

    //CPU
//    QThread GpuCalculateThread;   //以后再放其他线程
    QTimer *timerCPU;       //定时器获取CPU信息
    int defGpuCount = 8;    //默认最高8个核
    void GetSysCpu() ;
    //GPU
    void GpuInitm();
    int GetGpuUsedTotal();
    GpuFFT1000 gpufft;
    QList<int> GpuFFt;
    unsigned int gpu_count = 0;
    //Temp
    void GetCpuTemp();
    //内存
    bool GetSysMemory();
    //磁盘
    bool GetSysDisk() ;


    //CPU变量
    int cpuPercent;
    //内存变量
    int memoryPercent;
    QString memoryP ;
    QString memoryV ;

    //GPU变量
    QList<ListGpuInfo> GpuInfoList;
    QString errorInfoStr = "";

    //磁盘变量
    QList<ListFileInfo> DiskInfoList;


    //QML接口
    Q_INVOKABLE int   getCpuPercent();
    Q_INVOKABLE int   getMemoryPercent();
    Q_INVOKABLE QString getMemoryP();
    Q_INVOKABLE QString getMemoryV();

    //填充GPU
    Q_INVOKABLE int     getGpuCount();
    Q_INVOKABLE QString getGpuPercent(int index);
    Q_INVOKABLE QString getGpuCache(int index);
    Q_INVOKABLE QString getGpuError();
    Q_INVOKABLE void getGpuFFT(int index);

    //填充列表函数
    Q_INVOKABLE int     getDiskCount();
    Q_INVOKABLE QString getDiskUse(int index);
    Q_INVOKABLE QString getDiskFree(int index);
    Q_INVOKABLE QString getDiskAll(int index);
    Q_INVOKABLE QString getDiskName(int index);
    Q_INVOKABLE int     getDiskPercent(int index);


signals:
    void updateMes();
    void sendError();

public slots:
    void GetINFO();


};

#endif // GETSYSINFO_H
