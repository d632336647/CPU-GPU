
#include "thriftlocal.h"

#if 1
ThriftLocal::ThriftLocal()
{
//    pCard = nullptr;
}




bool ThriftLocal::OpenCard()
{
    return true;
}

//thrift设置参数
void  ThriftLocal::SetParam(int triggerType,
    int clockType,
    double clockFreq,
    int ddcCoefType,
    int sourceType,
    int nCh,
    double DDCFreq,
    int nMultiple,
    int streamMode,
    time_t sTime,
    const std::string& fileName,
    double fileSize,
    const std::string& ipaddr,
    int port)
{


}


//////////////thrift调用/////////////////////////
//启动采集
bool  ThriftLocal::Start()
{

    return true;

}
//////////////thrift调用/////////////////////////
//获取硬盘、CPU、采集参数
std::string ThriftLocal::GetStatus()
{


    //QString xml_data;
    QByteArray xml_data;
    QXmlStreamWriter xmlWriter(&xml_data);
    xmlWriter.setAutoFormatting(true);
    xmlWriter.writeStartDocument();
    xmlWriter.writeStartElement(QString::fromLocal8Bit("系统信息"));
//        xmlWriter.writeTextElement(QString::fromLocal8Bit("磁盘状态"),QString::number(xmlSysInfo->getDiskCount()));
        xmlWriter.writeTextElement(QString::fromLocal8Bit("磁盘个数"),QString::number(xmlSysInfo->getDiskCount()));

        xmlWriter.writeStartElement(QString::fromLocal8Bit("磁盘使用信息"));
            for(int i=0;i<xmlSysInfo->getDiskCount();i++)
            {
            xmlWriter.writeTextElement(QString::fromLocal8Bit("磁盘标号"), xmlSysInfo->getDiskName(i));
            xmlWriter.writeTextElement(QString::fromLocal8Bit("磁盘容量"), xmlSysInfo->getDiskAll(i));
            xmlWriter.writeTextElement(QString::fromLocal8Bit("剩余空间"), xmlSysInfo->getDiskFree(i));
            }
        xmlWriter.writeEndElement();

        xmlWriter.writeStartElement(QString::fromLocal8Bit("资源使用"));
            xmlWriter.writeTextElement(QString::fromLocal8Bit("物理内存总数"), xmlSysInfo->getMemoryP());
            xmlWriter.writeTextElement(QString::fromLocal8Bit("虚拟内存总数"), xmlSysInfo->getMemoryV());
            xmlWriter.writeTextElement(QString::fromLocal8Bit("内存使用率"), QString::number(xmlSysInfo->getMemoryPercent()));
            xmlWriter.writeTextElement(QString::fromLocal8Bit("CPU使用率"), QString::number(xmlSysInfo->getCpuPercent()));
        xmlWriter.writeEndElement();

        xmlWriter.writeStartElement(QString::fromLocal8Bit("GPU信息"));
            xmlWriter.writeTextElement(QString::fromLocal8Bit("GPU个数"), QString::number(xmlSysInfo->getGpuCount()));
            for(int i=0;i<xmlSysInfo->getGpuCount();i++)
            {
            xmlWriter.writeTextElement(QString::fromLocal8Bit("GPU编号"), QString::number(i+1));
            xmlWriter.writeTextElement(QString::fromLocal8Bit("GPU使用率"), xmlSysInfo->getGpuPercent(i));
            xmlWriter.writeTextElement(QString::fromLocal8Bit("显存使用率"), xmlSysInfo->getGpuCache(i));
            }
        xmlWriter.writeEndElement();
    xmlWriter.writeEndElement();

//    xmlWriter.writeStartElement(QString::fromLocal8Bit("板卡信息"));
//        xmlWriter.writeTextElement(QString::fromLocal8Bit("采集状态"), "OK");
//        xmlWriter.writeTextElement(QString::fromLocal8Bit("时钟状态"), "OK");
//    xmlWriter.writeEndElement();


    xmlWriter.writeEndDocument();


    //写文件
    QFile writeFile("status.xml");
    writeFile.open(QIODevice::WriteOnly);
    QDataStream out(&writeFile);
    out.writeRawData(xml_data.data(), xml_data.size());
    writeFile.close();

    return xml_data.toStdString();
}
#endif
