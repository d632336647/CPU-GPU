#if 1

#ifndef THRIFTLOCAL_H
#define THRIFTLOCAL_H

#include <QObject>
#include <QXmlStreamWriter>
#include <QFile>
#include <QDataStream>

#include "getsysinfo.h"
#include "gpufft1000.h"

#if 1
class ThriftLocal : public QObject
{
    Q_OBJECT

public:
    ThriftLocal();

    GetSysInfo *xmlSysInfo;

    //////////////thrift调用/////////////////////////
    //打开板卡
    bool  OpenCard(void);
    //启动采集
    bool  Start();
    //
    // 参数设置
    // triggerType 触发模式   0:外触发 1:内触发
    // clockType   时钟模式	0:外时钟 1:内参考  2: 外参考
    // clockFreq   采样率 单位:兆.(比如 100.000)
    // ddcCoefType Fs/B系数 0: 1.25B.   1: 2.5B
    // sourceType 输出模式 0: DDC.   2: ADC
    // nCh 通道使能   1,2,3,4对应为1通道，2通道，3通道，4通道
    // DDCFreq DDC载频 单位:兆.(比如 70.000)
    // nMultiple 抽取倍数（抽取因子）抽取因子为2、4、8、16 大于16时为4的倍数
    // streamMode 落盘模式   0: 常规采集,以文件方式落盘，该模式下参数 cb不起作用
    //						1: udp方式采集传输，该模式下参数fileName、fileSize不起作用
    //						2: user.dll方式回传，乙方调用甲方提供的user.dll中的方法，该模式下参数fileName、fileSize不起作用
    // sTime 采集开始时间（相对于1970年1月1日的秒数）采用LTC记
    // fileName 文件名称 例：
    //        fileName="d:\data\test"    给定的文件名称没有后缀
    //        生成的实际文件名称为
    //			"d:\data\test.ch1.dat"
    //			"d:\data\test.ch2.dat"
    //			按通道号进行文件名补充，多通道按通道号扩展
    // fileSize 以文件方式落盘的文件大小
    // ipaddr udp方式采集下，服务器的ip地址,比如"192.168.0.1"
    // port udp方式采集下，服务器的端口
    //
    void  SetParam(int triggerType,
        int clockType,
        double clockFreq,
        int ddcCoefType,
        int sourceType,
        int nCh,
        double DDCFreq,
        int nMultiple,
        int streamMode,
        time_t sTime,
        const std::string &fileName,
        double fileSize,
        const std::string &ipaddr,
        int port);
    //获取硬盘、CPU、采集参数
    std::string GetStatus();

private:

};

#endif

#endif // THRIFTLOCAL_H



#endif
