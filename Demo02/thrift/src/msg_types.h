﻿#if 1

/**
 * Autogenerated by Thrift Compiler (0.11.0)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
#ifndef msg_TYPES_H
#define msg_TYPES_H

#include <iosfwd>

#include <thrift/Thrift.h>
#include <thrift/TApplicationException.h>
#include <thrift/TBase.h>
#include <thrift/protocol/TProtocol.h>
#include <thrift/transport/TTransport.h>

#include <thrift/stdcxx.h>




class Message;

typedef struct _Message__isset {
  _Message__isset() : type(false), tag(false), group(false), chan(false), index(false), param0(false), param1(false), param2(false), param3(false), param4(false), param5(false), msg(false), bmsg(false) {}
  bool type :1;
  bool tag :1;
  bool group :1;
  bool chan :1;
  bool index :1;
  bool param0 :1;
  bool param1 :1;
  bool param2 :1;
  bool param3 :1;
  bool param4 :1;
  bool param5 :1;
  bool msg :1;
  bool bmsg :1;
} _Message__isset;

class Message : public virtual ::apache::thrift::TBase {
 public:

  Message(const Message&);
  Message& operator=(const Message&);
  Message() : type(0), tag(), group(0), chan(0), index(0), param0(0), param1(0), param2(0), param3(0), param4(0), param5(0), msg(), bmsg() {
  }

  virtual ~Message() throw();
  int32_t type;
  std::string tag;
  int32_t group;
  int32_t chan;
  int32_t index;
  int32_t param0;
  int32_t param1;
  int32_t param2;
  int32_t param3;
  int32_t param4;
  int32_t param5;
  std::string msg;
  std::string bmsg;

  _Message__isset __isset;

  void __set_type(const int32_t val);

  void __set_tag(const std::string& val);

  void __set_group(const int32_t val);

  void __set_chan(const int32_t val);

  void __set_index(const int32_t val);

  void __set_param0(const int32_t val);

  void __set_param1(const int32_t val);

  void __set_param2(const int32_t val);

  void __set_param3(const int32_t val);

  void __set_param4(const int32_t val);

  void __set_param5(const int32_t val);

  void __set_msg(const std::string& val);

  void __set_bmsg(const std::string& val);

  bool operator == (const Message & rhs) const
  {
    if (!(type == rhs.type))
      return false;
    if (!(tag == rhs.tag))
      return false;
    if (!(group == rhs.group))
      return false;
    if (!(chan == rhs.chan))
      return false;
    if (!(index == rhs.index))
      return false;
    if (!(param0 == rhs.param0))
      return false;
    if (!(param1 == rhs.param1))
      return false;
    if (!(param2 == rhs.param2))
      return false;
    if (!(param3 == rhs.param3))
      return false;
    if (!(param4 == rhs.param4))
      return false;
    if (!(param5 == rhs.param5))
      return false;
    if (!(msg == rhs.msg))
      return false;
    if (!(bmsg == rhs.bmsg))
      return false;
    return true;
  }
  bool operator != (const Message &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const Message & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

  virtual void printTo(std::ostream& out) const;
};

void swap(Message &a, Message &b);

std::ostream& operator<<(std::ostream& out, const Message& obj);

#endif

#endif
