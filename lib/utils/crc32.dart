

class CRC32{

  int crc;
  String mx;

  CRC32({mx}){
    crc = 0x00000000;
    _getCrc();
  }

  void _crc(var data){
    int point = 0x10000000;
    while(point > 0){
      if(((data & point) == point) ^ ((crc & 0x80000000) == 0x80000000)){
        crc = (crc << 1) ^ 0x04c11d87;
      }else{
        crc <<= 1;
      }
      point >>= 1;
    }
  }

  void _getCrc(){
    mx.codeUnits.forEach((item){
      _crc(item);
    });
  }
  String getCRCString(){
    print(crc);
    print("16 禁止 ${crc.toRadixString(16)}");
    return crc.toRadixString(16);
  }

}















