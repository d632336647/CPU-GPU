#include "getsysinfo.h"

#define GB (1024 * 1024 * 1024)
#define MB (1024 * 1024)
#define KB (1024)
#define TIME 1000
GetSysInfo::GetSysInfo(QObject *parent) : QObject(parent)
{
    GetINFO();
//    GetSysMemory();
    //定时采集 TIME 秒
    timerCPU = new QTimer(this);
    connect(timerCPU, SIGNAL(timeout()), this, SLOT(GetINFO()));
    timerCPU->start(TIME);

}
GetSysInfo::~GetSysInfo()
{
    deleteLater();
}

//计算获取CPU使用率
void GetSysInfo::GetSysCpu()
{
#ifdef Q_OS_WIN
#if (QT_VERSION >= QT_VERSION_CHECK(4,8,7))

    static FILETIME preidleTime;
    static FILETIME prekernelTime;
    static FILETIME preuserTime;

    FILETIME idleTime;
    FILETIME kernelTime;
    FILETIME userTime;

    GetSystemTimes(&idleTime, &kernelTime, &userTime);

    quint64 a, b;
    int idle, kernel, user;

    a = (preidleTime.dwHighDateTime << 31) | preidleTime.dwLowDateTime;
    b = (idleTime.dwHighDateTime << 31) | idleTime.dwLowDateTime;
    idle = b - a;

    a = (prekernelTime.dwHighDateTime << 31) | prekernelTime.dwLowDateTime;
    b = (kernelTime.dwHighDateTime << 31) | kernelTime.dwLowDateTime;
    kernel = b - a;

    a = (preuserTime.dwHighDateTime << 31) | preuserTime.dwLowDateTime;
    b = (userTime.dwHighDateTime << 31) | userTime.dwLowDateTime;
    user = b - a;

    if (kernel + user == 0)
    {
        cpuPercent = 0;
        return;
    }
    cpuPercent = abs((kernel + user - idle) * 100 / (kernel + user));

    preidleTime = idleTime;
    prekernelTime = kernelTime;
    preuserTime = userTime ;

//    QString msg = QString("CPU : %1 % ").arg(cpuPercent);
//    qDebug() << msg;
#endif
#else
    if (process->state() == QProcess::NotRunning) {
        totalNew = idleNew = 0;
        process->start("cat /proc/stat");
    }
#endif
}
// 获取CPU温度
void GetSysInfo::GetCpuTemp()
{
//      HRESULT *temperatureProbe = GetObject("Winmgmts："
//        &"{impersonationLevel = impersonate}！\\"
//        &strComputer&"\ root \ cimv2");
//        InstancesOf("Win32_TemperatureProbe");
//        temperatureProbe

}
void GetSysInfo::GetINFO()
{
    GetSysCpu();
    GetSysMemory();
    GetSysDisk();
    int state =GetGpuUsedTotal();
    emit updateMes();
    if(state == 1 )
    {
        emit sendError();
    }
    emit sendError();
}
//GPU Init
void GetSysInfo::GpuInitm()
{
    nvmlReturn_t result;
    result = nvmlInit();
    result = nvmlDeviceGetCount(&gpu_count);
}

//获取GPU使用情况
int GetSysInfo::GetGpuUsedTotal()
{
    GpuInfoList.clear();                //清空数据
    nvmlReturn_t result;
    unsigned int device_count, i;
    QString GPUInfoStr = "";
    QString findoutGPUinfoStr = "";
    //First initialize NVML library
    result = nvmlInit();
    //QString errorInfoStr = "";
    if (NVML_SUCCESS != result)
    {
        errorInfoStr = "Failed to initialize NVML:" +QString (nvmlErrorString(result)) ;
        return 1;
    }

    result = nvmlDeviceGetCount(&device_count);
    qDebug()<<"QString::number(device_count):"<<QString::number(device_count);
    if (NVML_SUCCESS != result)
    {
        errorInfoStr = "Failed to query device count: %s\n" + QString (nvmlErrorString(result));
        return 1;
    }

    findoutGPUinfoStr = "GPU: "+QString::number(device_count)+"s";
    GPUInfoStr.append(findoutGPUinfoStr);

    for (i = 0; i < device_count; i++)
    {
        QString gpuPercent;
        QString gpuCaChe;
        nvmlDevice_t device;
        result = nvmlDeviceGetHandleByIndex(i, &device);
        if (NVML_SUCCESS != result)
        {
            errorInfoStr = "Failed to get handle for device"+QString::number(i)+":"+QString(nvmlErrorString(result));
            return 1;
        }
        //使用率
        nvmlUtilization_t utilization;
        result = nvmlDeviceGetUtilizationRates(device, &utilization);
        if (NVML_SUCCESS != result)
        {
            errorInfoStr = "device" + QString::number(i) + "Nvml get gpu use failed " + QString(nvmlErrorString(result));
            qDebug()<< errorInfoStr;
            return 1;
        }
        //printf("----- 使用率 ----- \n");
        //qDebug()<<"GPU" <<QString::number(i) << "使用率："  <<QString::number(utilization.gpu);
        GPUInfoStr.append(findoutGPUinfoStr);
        gpuPercent = QString::number(utilization.gpu);

//            //qDebug()<<"显存使用率：" <<QString::number(utilization.memory);
//            GPUInfoStr.append(findoutGPUinfoStr);
//            gpuCaChe = QString::number(utilization.memory);
        // 获取显存使用信息
        nvmlMemory_t memory;
        result = nvmlDeviceGetMemoryInfo(device, &memory);
        if (result != NVML_SUCCESS)
        {
            errorInfoStr = "device " + QString::number(i) + "nvml get gpu memory failed "+ QString(nvmlErrorString(result));
            return 1;
        }
        gpuCaChe = QString::number((int)(((double)memory.used/(double)memory.total)*100));
        //依次加入链表
        ListGpuInfo gpuListItem;
        gpuListItem = {gpuPercent,gpuCaChe};
        GpuInfoList.append(gpuListItem);

//        // 获取实时器件温度
//        unsigned int temperature_temp;
//        result = nvmlDeviceGetTemperature(device, NVML_TEMPERATURE_GPU, &temperature_temp);
//        if (result != NVML_SUCCESS)
//        {
//            errorInfoStr = "nvml获取设备温度失败！！\n";
//            return 1;
//        }
//        qDebug()<<"temperature_temp:"<<temperature_temp;

    }

    result = nvmlShutdown();
    if (NVML_SUCCESS != result)
    {
        errorInfoStr = "Failed to shutdown NVML:" +QString(nvmlErrorString(result));
//        qDebug()<<errorInfoStr;
        return 1;
    }
    errorInfoStr = "";
//    qDebug()<<errorInfoStr;
    return 0;

//Error:
//    result = nvmlShutdown();
//    if (NVML_SUCCESS != result)
//    {
//        errorInfoStr = "Failed to shutdown NVML:" +QString(nvmlErrorString(result));
//        qDebug()<<errorInfoStr;
//    }
//    return 1;
}
//计算GPU FFT
void GetSysInfo::getGpuFFT(int count)
{

}

//获取内存使用率 物理内存 虚拟内存分页文件大小
bool GetSysInfo::GetSysMemory()
{
    MEMORYSTATUSEX statex;
    statex.dwLength = sizeof (statex);
    GlobalMemoryStatusEx (&statex);
    //内存使用率
    memoryPercent = statex.dwMemoryLoad;

    //物理内存
    float pgb = statex.ullTotalPhys/(double)GB;
    QString pstr = QString::number(pgb, 'f', 1);
    memoryP = pstr;

    //虚拟内存
    float vgb = statex.ullTotalPageFile/(double)GB - pgb;
    QString vstr = QString::number(vgb, 'f', 1);
    memoryV = vstr;

    return true;
}
//获取磁盘 使用 空闲 总 使用率 盘符
bool GetSysInfo::GetSysDisk()
{
#ifdef Q_OS_WIN
    QFileInfoList list = QDir::drives();
    DiskInfoList.clear();
    foreach (QFileInfo dir, list) {
        QString dirName = dir.absolutePath();
        if(GetDriveType((LPCWSTR)dirName.utf16()) == DRIVE_FIXED)
        {
            QString use ="";
            QString free ="";
            QString all ="";
            int percent =0;
            LPCWSTR lpcwstrDriver = (LPCWSTR)dirName.utf16();
            ULARGE_INTEGER liFreeBytesAvailable, liTotalBytes, liTotalFreeBytes;
            if(GetDiskFreeSpaceEx(lpcwstrDriver, &liFreeBytesAvailable, &liTotalBytes, &liTotalFreeBytes) )
            {
                use = QString::number((double) (liTotalBytes.QuadPart - liTotalFreeBytes.QuadPart) / GB, 'f', 1)+"G";
                free = QString::number((double) liTotalFreeBytes.QuadPart / GB, 'f', 1)+"G";
                all = QString::number((double) liTotalBytes.QuadPart / GB, 'f', 1)+"G";
                percent = 100 - ((double)liTotalFreeBytes.QuadPart / liTotalBytes.QuadPart) * 100;
            }
            //依次加入链表
            ListFileInfo fileListItem;
            fileListItem = {use,free,all,dirName,percent};
    //        qDebug() <<QString::number(fileListItem.diskPercent);
            DiskInfoList.append(fileListItem);
        }
    }
#else
    process->start("df -h");
#endif
    return true;
}



//QML接口函数************************//

//CPU使用率qml接口
int GetSysInfo::getCpuPercent()
{
    return cpuPercent;
}
//内存使用率qml接口
int GetSysInfo::getMemoryPercent()
{
//    qDebug()<<"memoryPercent"<<memoryPercent;
    return memoryPercent;
}
//物理内存qml接口
QString GetSysInfo::getMemoryP()
{
    return memoryP;
}
//虚拟内存qml接口
QString GetSysInfo::getMemoryV()
{
    return memoryV;
}

//GPUqml接口
int GetSysInfo::getGpuCount()
{
//    qDebug()<<"GSI_getGpuCount"<<GpuInfoList.length();
    return GpuInfoList.length();

}
QString GetSysInfo::getGpuPercent(int index)
{
    return GpuInfoList.at(index).gpuPercent;
}
QString GetSysInfo::getGpuCache(int index)
{
    return GpuInfoList.at(index).gpuCache;
}
QString GetSysInfo::getGpuError()
{
    return errorInfoStr;
}

//磁盘qml接口
int GetSysInfo::getDiskCount()
{
    return DiskInfoList.length();
}
QString GetSysInfo::getDiskUse(int index)
{
    return DiskInfoList.at(index).use;
}
QString GetSysInfo::getDiskFree(int index)
{
    return DiskInfoList.at(index).free;
}
QString GetSysInfo::getDiskAll(int index)
{
    return DiskInfoList.at(index).all;
}
QString GetSysInfo::getDiskName(int index)
{
    return DiskInfoList.at(index).diskName;
}
int GetSysInfo::getDiskPercent(int index)
{
    return DiskInfoList.at(index).diskPercent;
}
