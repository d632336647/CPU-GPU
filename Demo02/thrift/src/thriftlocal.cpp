
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

    xmlWriter.writeStartElement("Status");
    xmlWriter.writeAttribute("name", "QF_PCIE_K7");

//    xmlWriter.writeStartElement(QString::fromLocal8Bit("系统信息"));
    xmlWriter.writeStartElement("p");
    xmlWriter.writeAttribute("key", QString::fromLocal8Bit("系统信息"));
    xmlWriter.writeAttribute("value", "");

        xmlWriter.writeStartElement("p");
        xmlWriter.writeAttribute("key", QString::fromLocal8Bit("磁盘个数"));
        xmlWriter.writeAttribute("value", QString::number(xmlSysInfo->getDiskCount()));
        xmlWriter.writeEndElement();

//        xmlWriter.writeStartElement(QString::fromLocal8Bit("磁盘使用信息"));
        xmlWriter.writeStartElement("p");
        xmlWriter.writeAttribute("key", QString::fromLocal8Bit("磁盘使用信息"));
        xmlWriter.writeAttribute("value", "");
            for(int i=0;i<xmlSysInfo->getDiskCount();i++)
            {
            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("磁盘标号"));
            xmlWriter.writeAttribute("value", xmlSysInfo->getDiskName(i));

            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("磁盘容量"));
            xmlWriter.writeAttribute("value", xmlSysInfo->getDiskAll(i));
            xmlWriter.writeEndElement();

            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("剩余空间"));
            xmlWriter.writeAttribute("value", xmlSysInfo->getDiskFree(i));
            xmlWriter.writeEndElement();
            xmlWriter.writeEndElement();
            }
        xmlWriter.writeEndElement();


//        xmlWriter.writeStartElement(QString::fromLocal8Bit("资源使用"));
        xmlWriter.writeStartElement("p");
        xmlWriter.writeAttribute("key", QString::fromLocal8Bit("资源使用"));
        xmlWriter.writeAttribute("value", "");

            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("物理内存总数"));
            xmlWriter.writeAttribute("value", xmlSysInfo->getMemoryP());
            xmlWriter.writeEndElement();

            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("虚拟内存总数"));
            xmlWriter.writeAttribute("value", xmlSysInfo->getMemoryV());
            xmlWriter.writeEndElement();

            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("内存使用率"));
            xmlWriter.writeAttribute("value", QString::number(xmlSysInfo->getMemoryPercent())+"%");
            xmlWriter.writeEndElement();

            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("CPU使用率"));
            xmlWriter.writeAttribute("value", QString::number(xmlSysInfo->getCpuPercent())+"%");
            xmlWriter.writeEndElement();

        xmlWriter.writeEndElement();

        xmlWriter.writeStartElement("p");
        xmlWriter.writeAttribute("key", QString::fromLocal8Bit("GPU信息"));
        xmlWriter.writeAttribute("value", "");

            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("GPU个数"));
            xmlWriter.writeAttribute("value", QString::number(xmlSysInfo->getGpuCount()));
            xmlWriter.writeEndElement();

            for(int i=0;i<xmlSysInfo->getGpuCount();i++)
            {
            xmlWriter.writeStartElement("p");
            xmlWriter.writeAttribute("key", QString::fromLocal8Bit("GPU编号"));
            xmlWriter.writeAttribute("value",  QString::number(i+1));


                xmlWriter.writeStartElement("p");
                xmlWriter.writeAttribute("key", QString::fromLocal8Bit("GPU使用率"));
                xmlWriter.writeAttribute("value", xmlSysInfo->getGpuPercent(i)+"%");
                xmlWriter.writeEndElement();

                xmlWriter.writeStartElement("p");
                xmlWriter.writeAttribute("key", QString::fromLocal8Bit("显存使用率"));
                xmlWriter.writeAttribute("value", xmlSysInfo->getGpuCache(i)+"%");
                xmlWriter.writeEndElement();
            xmlWriter.writeEndElement();

            }
        xmlWriter.writeEndElement();

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
